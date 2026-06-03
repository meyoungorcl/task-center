from __future__ import annotations

import re
import textwrap
from pathlib import Path


ROOT = Path(__file__).resolve().parent
SOURCE = ROOT / "task_center_prompts_notifications.md"
OUTPUT = ROOT / "task_center_prompts_notifications.pdf"

PAGE_WIDTH = 612
PAGE_HEIGHT = 792
MARGIN_LEFT = 54
MARGIN_RIGHT = 54
MARGIN_TOP = 54
MARGIN_BOTTOM = 54
CONTENT_WIDTH = PAGE_WIDTH - MARGIN_LEFT - MARGIN_RIGHT


def pdf_escape(text: str) -> str:
    text = text.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")
    return text


def normalize(text: str) -> str:
    replacements = {
        "\u2018": "'",
        "\u2019": "'",
        "\u201c": '"',
        "\u201d": '"',
        "\u2013": "-",
        "\u2014": "-",
        "\u00a0": " ",
        "\u2022": "*",
    }
    for old, new in replacements.items():
        text = text.replace(old, new)
    return text.encode("latin-1", "replace").decode("latin-1")


class PdfBuilder:
    def __init__(self) -> None:
        self.pages: list[list[str]] = []
        self.current: list[str] = []
        self.y = PAGE_HEIGHT - MARGIN_TOP
        self.page_number = 0
        self.in_code = False

    def new_page(self) -> None:
        if self.current:
            self._footer()
            self.pages.append(self.current)
        self.current = []
        self.page_number += 1
        self.y = PAGE_HEIGHT - MARGIN_TOP
        if self.page_number > 1:
            self.current.append("BT /F3 9 Tf 0.35 0.35 0.35 rg")
            self.current.append(f"1 0 0 1 {MARGIN_LEFT} {self.y:.2f} Tm ({pdf_escape('Task Center Build History')}) Tj")
            self.current.append("ET")
            self.y -= 28

    def ensure_space(self, needed: float) -> None:
        if self.page_number == 0:
            self.new_page()
        if self.y - needed < MARGIN_BOTTOM:
            self.new_page()

    def _footer(self) -> None:
        self.current.append("BT /F1 8 Tf 0.45 0.45 0.45 rg")
        self.current.append(f"1 0 0 1 {MARGIN_LEFT} 30 Tm ({pdf_escape('Generated 2026-06-02')}) Tj")
        page_text = f"Page {self.page_number}"
        self.current.append(f"1 0 0 1 {PAGE_WIDTH - MARGIN_RIGHT - 45} 30 Tm ({pdf_escape(page_text)}) Tj")
        self.current.append("ET")

    def add_rule(self, after: float = 14) -> None:
        self.ensure_space(12)
        y = self.y - 3
        self.current.append(f"0.72 0.77 0.82 RG 0.75 w {MARGIN_LEFT} {y:.2f} m {PAGE_WIDTH - MARGIN_RIGHT} {y:.2f} l S")
        self.y -= after

    def add_text(
        self,
        text: str,
        *,
        size: int = 10,
        font: str = "Helvetica",
        indent: int = 0,
        after: float = 4,
        leading: float | None = None,
        color: tuple[int, int, int] = (20, 27, 39),
    ) -> None:
        text = normalize(text)
        leading = leading or size + 3
        max_chars = max(18, int((CONTENT_WIDTH - indent) / (size * 0.48)))
        lines = []
        for part in text.splitlines() or [""]:
            if not part:
                lines.append("")
            else:
                lines.extend(textwrap.wrap(part, width=max_chars, break_long_words=True, replace_whitespace=False))
        self.ensure_space(max(leading, len(lines) * leading + after))
        font_name = {"Helvetica": "F1", "Helvetica-Bold": "F2", "Helvetica-Oblique": "F3", "Courier": "F4"}.get(font, "F1")
        r, g, b = [c / 255 for c in color]
        self.current.append(f"BT /{font_name} {size} Tf {r:.3f} {g:.3f} {b:.3f} rg")
        for line in lines:
            self.current.append(f"1 0 0 1 {MARGIN_LEFT + indent} {self.y:.2f} Tm ({pdf_escape(line)}) Tj")
            self.y -= leading
        self.current.append("ET")
        self.y -= after

    def finish(self) -> None:
        if self.current:
            self._footer()
            self.pages.append(self.current)
            self.current = []


def render_markdown(markdown: str) -> PdfBuilder:
    pdf = PdfBuilder()
    pdf.new_page()
    in_code = False
    in_table = False

    for raw in markdown.splitlines():
        line = raw.rstrip()
        stripped = line.strip()

        if stripped.startswith("```"):
            in_code = not in_code
            if in_code:
                pdf.ensure_space(12)
                pdf.current.append(f"0.96 0.97 0.98 rg {MARGIN_LEFT - 4} {pdf.y - 6:.2f} {CONTENT_WIDTH + 8} 14 re f")
            else:
                pdf.y -= 4
            continue

        if in_code:
            pdf.add_text(line, size=8, font="Courier", indent=10, after=0, leading=10, color=(35, 45, 60))
            continue

        if not stripped:
            if in_table:
                in_table = False
                pdf.y -= 3
            else:
                pdf.y -= 5
            continue

        if stripped.startswith("# "):
            pdf.add_text(stripped[2:], size=22, font="Helvetica-Bold", after=8, leading=26, color=(18, 52, 86))
            pdf.add_rule(after=16)
        elif stripped.startswith("## "):
            pdf.ensure_space(34)
            pdf.add_text(stripped[3:], size=15, font="Helvetica-Bold", after=6, leading=18, color=(18, 52, 86))
        elif stripped.startswith("### "):
            pdf.ensure_space(28)
            pdf.add_text(stripped[4:], size=12, font="Helvetica-Bold", after=4, leading=15, color=(42, 74, 110))
        elif stripped.startswith("- "):
            pdf.add_text("* " + stripped[2:], size=9, indent=12, after=2, leading=12)
        elif re.match(r"^\d+\. ", stripped):
            pdf.add_text(stripped, size=9, indent=10, after=2, leading=12)
        elif stripped.startswith("|"):
            if re.match(r"^\|\s*-", stripped):
                continue
            in_table = True
            cells = [c.strip() for c in stripped.strip("|").split("|")]
            row = "  |  ".join(cells)
            pdf.add_text(row, size=8, font="Courier", indent=8, after=1, leading=10)
        else:
            pdf.add_text(stripped, size=9, after=4, leading=12)

    pdf.finish()
    return pdf


def write_pdf(builder: PdfBuilder, path: Path) -> None:
    objects: list[bytes] = []

    def add_object(data: bytes) -> int:
        objects.append(data)
        return len(objects)

    font1 = add_object(b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>")
    font2 = add_object(b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>")
    font3 = add_object(b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Oblique >>")
    font4 = add_object(b"<< /Type /Font /Subtype /Type1 /BaseFont /Courier >>")

    page_ids: list[int] = []
    content_ids: list[int] = []
    pages_id_placeholder = 0

    for page in builder.pages:
        stream = "\n".join(page).encode("latin-1", "replace")
        content_id = add_object(b"<< /Length " + str(len(stream)).encode() + b" >>\nstream\n" + stream + b"\nendstream")
        content_ids.append(content_id)
        page_id = add_object(b"")
        page_ids.append(page_id)

    kids = " ".join(f"{pid} 0 R" for pid in page_ids).encode()
    pages_id = add_object(b"<< /Type /Pages /Kids [ " + kids + b" ] /Count " + str(len(page_ids)).encode() + b" >>")

    catalog_id = add_object(b"<< /Type /Catalog /Pages " + str(pages_id).encode() + b" 0 R >>")

    font_dict = (
        f"<< /F1 {font1} 0 R /F2 {font2} 0 R /F3 {font3} 0 R /F4 {font4} 0 R >>"
    ).encode()
    for idx, page_id in enumerate(page_ids):
        objects[page_id - 1] = (
            b"<< /Type /Page /Parent "
            + str(pages_id).encode()
            + b" 0 R /MediaBox [0 0 612 792] /Resources << /Font "
            + font_dict
            + b" >> /Contents "
            + str(content_ids[idx]).encode()
            + b" 0 R >>"
        )

    out = bytearray(b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n")
    offsets = [0]
    for i, obj in enumerate(objects, start=1):
        offsets.append(len(out))
        out.extend(f"{i} 0 obj\n".encode())
        out.extend(obj)
        out.extend(b"\nendobj\n")

    xref_offset = len(out)
    out.extend(f"xref\n0 {len(objects) + 1}\n".encode())
    out.extend(b"0000000000 65535 f \n")
    for offset in offsets[1:]:
        out.extend(f"{offset:010d} 00000 n \n".encode())
    out.extend(
        b"trailer\n<< /Size "
        + str(len(objects) + 1).encode()
        + b" /Root "
        + str(catalog_id).encode()
        + b" 0 R >>\nstartxref\n"
        + str(xref_offset).encode()
        + b"\n%%EOF\n"
    )
    path.write_bytes(out)


def main() -> None:
    markdown = SOURCE.read_text(encoding="utf-8")
    builder = render_markdown(markdown)
    write_pdf(builder, OUTPUT)
    print(f"Wrote {OUTPUT}")
    print(f"Pages: {len(builder.pages)}")


if __name__ == "__main__":
    main()
