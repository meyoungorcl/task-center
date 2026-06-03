# Task Center Build History: Prompts and Notifications

Generated: 2026-06-02

Scope: This report captures the user prompts visible in the current Codex session for building and modifying the `task_center` APEX application, plus the Codex and APEXLang/SQLcl notifications that were visible or verified during the work. It is intended as an implementation timeline, not a full terminal transcript.

## Application Context

- Application: Task Center
- APEX application ID: 132
- Workspace connection used: `apexlang26.1`
- Local source folder: `/Users/MEYOUNG/Documents/GitHub/meyoungorcl/task_center`
- Primary SQLcl binary used: `/Users/MEYOUNG/.vscode/extensions/oracle.sql-developer-26.2.0/dbtools/sqlcl/bin/sql`

## User Prompts

1. connect to apexlang26.1
2. use the meyoungorcl/task_center folder
3. on page 12, move the Change Log and Audit regions to the left column and also make the Audit region collapsible
4. Change the daily email so that the link to the task page works and passes the id of the task correctly and then import the app with the changes made in the previous prompt
5. on page 12 do not escape the recent updates, also collapse the Audi region by default and make the due date item mandatory
6. can you make the change in the /meyoungorcl/task_center directory
7. on page 12, change the add an update in the Updates region to be an RTF item
8. change the daily email schedule so I can specify the day and time from a date picker or send it now. I only want to send to the team members specified. If none are selected, then send to all team members
9. on page 41, can you fix this error: Component P41_WEEKLY_DAY_NUMBER cannot be rendered as the grid settings for this component are invalid. It is set to be displayed at Column 13 with a Column Span of 4. This is not supported as the grid on this page only supports 12 Columns. Setting the Column and Column Span to Automatic for all components will typically fix this issue.
10. in the daily email, only send the tasks that are overdue, not started or in progress with a due date. Also identify tasks that are not started or in progress that do not have a due date.
11. on page 12, allow me to edit or delete a recent update. Use icons and then when edit is selected show model to change existing post for a delete, show trash icon and then confirm delete first before deleting update.
12. in the recent updates, the text is not escaped. here is a sample, can you seperate the text from the icons : Changed the Agenda so that the job title is included and also linked to the speakers profile.<div style="margin-top:8px;display:flex;gap:8px;justify-content:flex-end"><a href="f?p=132:12:27119614806691:EDIT_UPDATE:::P12_TASK_ID,P12_EDIT_UPDATE_ID:3026,26&cs=3Sf_b0gSorNcFr9GrvORhjVAsuFLF-k8h53RHziAxIyR9eX2Hjtd8HFIPxrP8l-CfCpoehMrokwCB8qe1hfpnyQ" class="t-Button t-Button--noLabel t-Button--icon t-Button--tiny" title="Edit update" aria-label="Edit update"><span class="fa fa-edit" aria-hidden="true"></span></a><a href="f?p=132:12:27119614806691:DELETE_UPDATE:::P12_TASK_ID,P12_DELETE_UPDATE_ID:3026,26&cs=3ZAT8DwJ05b3XSOXiJogFKZdPeri_q2VNI5TR1UBATcTACWGEGIGmPR1XrKi780O7dqH4Tq9Rpayxg8WUcFqR0w" class="t-Button t-Button--noLabel t-Button--icon t-Button--tiny" title="Delete update" aria-label="Delete update" onclick="return confirm('Delete this update?');"><span class="fa fa-trash-o u-danger-text" aria-hidden="true"></span></a></div>
13. on page 12, when I click the edit button for a recent update, show a modal window, allow me to update the update and click Save Update to change it.
14. change the size of the Edit Update modal so that you can see the entire toolbar of the RTF Editor
15. Add ability to group tasks together under a topic so that if I have multiple tasks related, I can group them together. Make the topic group something that is editable with a description. create a new page under Admin in the nav and show a master detail page where you see the topic group with all the tasks that have the topic.
16. when I go to page 80, I am getting this error on the Initialize Process No Primary Key item has been defined for form region Topic Group.
17. On page 80, Can you move the Create Topic Group form to a drawer page so that from the topic group report, you can click Add Topic Group and the drawer will open. Also from the Topic Group report on page 80, allow user to edit a topic group.
18. On page 12, add an item to select one or more topic groups for a task. Put it next to the Assignees item in the Task Details region.
19. can you add the number of updates (centered) to the report on My Dashboard page. Also add the Topic groups as a column in the report.
20. on page 10, can you add a facet for topic group and also add a column in the report and also center the updates column
21. generate the supporting object installation scripts for app 132
22. can you add the scripts to insert the data from the TSK_ tables
23. can you create a pdf of all the prompts and notifications provided by APEXLang and Codex since the start of building the task_center application

## Codex Notifications and Actions

### Connection and Workspace

- Codex used the `apexlang26.1` SQLcl connection for live APEX exports, imports, and metadata verification.
- Codex worked from `/Users/MEYOUNG/Documents/GitHub/meyoungorcl/task_center`.
- Codex noted that a sibling `task-center` path was not present and confirmed the active folder contained `application.apx`, `pages`, `shared-components`, and `supporting-objects`.

### Page 12 Task Details

- Codex moved and configured page 12 regions based on earlier requests.
- Codex added RTF support for adding and editing updates.
- Codex added edit and delete controls for recent updates using icon buttons.
- Codex separated recent update text from edit/delete icons after unescaped HTML was being displayed inline.
- Codex added an edit update modal and adjusted modal size so the RTF toolbar is visible.
- Codex added `P12_TOPIC_GROUP_IDS` as a `Select Many` item in the Task Details region.
- Codex placed `P12_TOPIC_GROUP_IDS` next to `P12_ASSIGNEES`; both were verified as 6-column items.
- Codex added page 12 processes:
  - `Set Current Topic Groups`
  - `Sync Topic Groups`
- Codex verified live APEX metadata showing:
  - `P12_ASSIGNEES`: Select Many, Task Details, span 6
  - `P12_TOPIC_GROUP_IDS`: Select Many, Task Details, span 6
  - `Set Current Topic Groups`: before header
  - `Sync Topic Groups`: after submit on `SAVE_TASK`

### Daily Email and Email Schedule

- Codex updated the task link used in the daily email so it passes `P12_TASK_ID` correctly.
- Codex changed the daily email to send only overdue, not-started, or in-progress tasks with due dates.
- Codex added handling for not-started or in-progress tasks without a due date.
- Codex changed the schedule model so users can specify a date/time or send now.
- Codex limited recipients to selected team members, defaulting to all active team members when none are selected.

### Page 41 Email Schedule

- Codex fixed the page 41 grid error for `P41_WEEKLY_DAY_NUMBER` by addressing the invalid Column 13 / Column Span 4 layout.

### Topic Groups

- Codex added topic group support with editable topic groups and descriptions.
- Codex created or updated topic group pages under Admin:
  - Page 80: Topic Groups
  - Page 81: Topic Group drawer form
- Codex fixed the page 80 form initialization issue caused by no primary key item being defined for the Topic Group form region.
- Codex moved Create Topic Group into a drawer page.
- Codex enabled Add Topic Group and edit actions from the page 80 Topic Group report.
- Codex updated page 80 reports to use `TSK_TASK_TOPIC_GROUPS` so task counts and task detail lists support many-to-many topic assignment.

### Page 70 My Dashboard

- Codex added an `Updates` count column to the `Recommended Work` report.
- Codex centered the `Updates` column heading and values.
- Codex added a `Topic Groups` column to the `Recommended Work` report.
- Codex verified live metadata:
  - `TOPIC_GROUPS`: display sequence 85, left aligned
  - `UPDATE_COUNT`: display sequence 95, heading alignment CENTER, column alignment CENTER
  - Report source uses `TSK_TASK_TOPIC_GROUPS`
  - Report source counts updates from `TSK_TASK_UPDATES`

### Page 10 Tasks

- Codex added a `P10_TOPIC_GROUP` facet sourced from `TOPIC_GROUP_FACET`.
- Codex added `Topic Groups` as a report column.
- Codex included `TOPIC_GROUPS` in the search facet source.
- Codex centered the page 10 `UPDATE_COUNT` report column.
- Codex verified live metadata:
  - `P10_TOPIC_GROUP`: source `TOPIC_GROUP_FACET`, inline display, display sequence 35
  - `P10_SEARCH`: includes `TOPIC_GROUPS`
  - `TOPIC_GROUPS`: report display sequence 45
  - `TOPIC_GROUP_FACET`: hidden report column, display sequence 46
  - `UPDATE_COUNT`: heading alignment CENTER, column alignment CENTER
  - Page 10 report source uses `TSK_TASK_TOPIC_GROUPS`

### Supporting Objects

- Codex generated supporting object installation scripts under `supporting-objects`.
- Codex generated:
  - `install-script.sql`
  - `schema-install.sql`
  - `reference-data.sql`
- Codex then added the full table data script:
  - `data-install.sql`
- Codex updated `install-script.sql` to run:

```sql
@schema-install.sql
@data-install.sql
```

- Codex did not run the install script against the current schema because it would duplicate existing objects and data.

## APEXLang and SQLcl Notifications

### SQLcl Connection Notifications

The SQLcl commands consistently reported:

```text
SQLcl: Release 26.2 Production
Connected to:
Oracle Database 19c EE High Perf Release 19.0.0.0.0 - Production
Version 19.27.0.0.0
```

### APEX Application Import Notifications

For page imports, SQLcl reported successful APEX imports such as:

```text
--application/set_environment
APPLICATION 132 - Task Center
--application/pages/delete_00012
--application/pages/page_00012
--application/pages/delete_00080
--application/pages/page_00080
--application/end_environment
...done
```

For page 70:

```text
--application/set_environment
APPLICATION 132 - Task Center
--application/pages/delete_00070
--application/pages/page_00070
--application/end_environment
...done
```

For page 10:

```text
--application/set_environment
APPLICATION 132 - Task Center
--application/pages/delete_00010
--application/pages/page_00010
--application/end_environment
...done
```

### APEX Export Notifications

SQLcl generated component export files including:

```text
Exporting Workspace DBAPPDEV - application 132:Task Center
File f132_page_70.sql created
File f132_page_10.sql created
```

For supporting-object install export:

```text
Exporting Workspace DBAPPDEV - application 132:Task Center
File ../../../../../../private/tmp/task_center_supporting_objects_export/f132/install.sql created
```

### APEXLang Validation Notifications

An APEXLang validation attempt was run against the project. The validator returned broad existing project errors unrelated to the generated SQL data scripts, including:

- `PLUGIN_NOT_FOUND` for `themeTemplateComponent/comments` on page 12.
- `REFERENCE_NOT_FOUND` for theme and template references such as `@/standard`, `@/drawer`, `@/login`, and related Universal Theme templates.
- `INVALID_PROPERTY` for several source properties in the APEXLang files.
- `MISSING_REQUIRED_PROPERTY` for dynamic action execution event metadata.
- `LOV_NOT_FOUND` for slot values such as `body`, `breadcrumbBar`, `contentBody`, `dialogFooter`, and button positions.
- A guessed supporting object install metadata block was rejected as:

```text
File: supporting-objects/supporting-objects.apx
Line: 3
Column: 8
Type: INVALID_PROPERTY
Error: Invalid property: scriptFile
```

Codex removed that unsupported install metadata block and kept the generated SQL files as repository supporting-object scripts.

### Database Object Inventory Notifications

Codex queried the live `TSK_%` object inventory. The schema included:

- Function: `TSK_APP_USER`
- Package: `TSK_DAILY_EMAIL_PKG`
- Tables: `TSK_APPLICATIONS`, `TSK_CHANGE_LOG`, `TSK_COMPLEXITIES`, `TSK_EMAIL_LOG`, `TSK_EMAIL_RECIPIENTS`, `TSK_EMAIL_SCHEDULES`, `TSK_STATUSES`, `TSK_TASKS`, `TSK_TASK_ASSIGNEES`, `TSK_TASK_FILES`, `TSK_TASK_TOPIC_GROUPS`, `TSK_TASK_TYPES`, `TSK_TASK_UPDATES`, `TSK_TEAMS`, `TSK_TEAM_MEMBERS`, `TSK_TOPIC_GROUPS`, `TSK_USERS`
- Trigger examples: `TSK_TASKS_AUD`, `TSK_TASKS_BIU`, `TSK_TASK_ASSIGNEES_AUD`, `TSK_TASK_ASSIGNEES_BIU`, `TSK_TASK_TOPIC_GROUPS_BI`, `TSK_TASK_UPDATES_AI`, `TSK_TEAM_MEMBERS_AUD`, `TSK_TEAM_MEMBERS_BIU`, `TSK_TOPIC_GROUPS_BIU`
- Views: `TSK_V_CHANGE_LOG`, `TSK_V_DAILY_MEMBER_EMAIL`, `TSK_V_DASHBOARD_SUMMARY`, `TSK_V_OVERDUE_TASKS`, `TSK_V_TASKS_BY_APPLICATION`, `TSK_V_TASKS_BY_STATUS`, `TSK_V_TASKS_BY_TYPE`, `TSK_V_TASK_LIST`, `TSK_V_TEAM_MEMBER_WORKLOAD`, `TSK_V_WEEKLY_TEAM_EMAIL`
- Scheduler jobs: `TSK_DAILY_MEMBER_EMAIL_JOB`, `TSK_MONTHLY_TEAM_EMAIL_JOB`

Some live objects were reported invalid in the inventory query, including `TSK_DAILY_EMAIL_PKG` package body and several views. The generated DDL still captured those objects from the live schema.

### Data Export Notifications

The full `TSK_%` data script generated inserts for these row counts:

| Table | Rows |
| --- | ---: |
| TSK_APPLICATIONS | 22 |
| TSK_CHANGE_LOG | 1621 |
| TSK_COMPLEXITIES | 4 |
| TSK_EMAIL_LOG | 12 |
| TSK_EMAIL_RECIPIENTS | 1 |
| TSK_EMAIL_SCHEDULES | 2 |
| TSK_STATUSES | 6 |
| TSK_TASKS | 514 |
| TSK_TASK_ASSIGNEES | 518 |
| TSK_TASK_FILES | 1 |
| TSK_TASK_TOPIC_GROUPS | 2 |
| TSK_TASK_TYPES | 7 |
| TSK_TASK_UPDATES | 25 |
| TSK_TEAMS | 1 |
| TSK_TEAM_MEMBERS | 5 |
| TSK_TOPIC_GROUPS | 2 |
| TSK_USERS | 5 |

Codex verified the generated `data-install.sql` contained no SQLcl connection noise or obvious SQL error output.

## Additional User Prompts After the Initial PDF

24. connect apexlang26.1
25. which column in the `TSK_TASKS` table is a virtual column?
26. generate a file of insert statements without the virtual column and also allows me to insert the description column as a clob
27. add a new Archive status and generate a script that updates the tasks to archive when the task is completed and it is older than December 31, 2025
28. run the archive-completed-tasks-before-2026.sql
29. Change task overview regions on page 1 and 70 to include the Archive status
30. add this logo to the app
31. it is showing the apex supplied icon not the custom one fix it
32. can you switch the logo with this one
33. I don't think it is using the new image because the background is not transparent
34. create a new page to show an email log then create a button on the email schedule page to go to the email log page
35. on the tasks report can you add the last_updated date and also create a facet to allow me to see the tasks in the last day, week, month
36. change the last_updated column to be just DD-MON-YYYY format. Also I don't see the facet. fix it
37. can you compare the tasks in this file with what is in the database and generate a script to insert or update the rows in the database
38. on page 12, in the Audit region from the TSK_TASKS table, can you add created_at, created_by, updated_at and updated_by and display only items
39. on page 10, can you add pagination (50 on each page) so I can see more than just 20 tasks
40. Can you migrate the email jobs into an automation instead of a dbms_scheduler job. It will be easier for me to see what is happening and activate or deactivate
41. I still do not see the pagination on page 10. I would expect to see 1 - 50 out of 500 or something like that and be able to navigate to the next page
42. can you import the change so I can see the pagination on page 10
43. I still do not see the pagination on page 10. Maybe change it to show 20 at a time? Or try it a different way?
44. can you disable the triggers on the TSK_TASKS table and then compare the attached file with the audit columns CREATED, CREATED_BY, UPDATED, UPDATED_BY with the audit files in the database CREATED_AT, CREATED_BY, UPDATED_AT, UPDATED_BY. Match on the external_reference id and update the audit columns in the database with the audit columns in the file
45. can you run the script to update the existing rows and then insert the new rows into the TSK_TASKS table.
46. on My Dashboard, add the last updated date to the Recommended Work report. Also add pagination like you did on the Tasks page
47. The Open Task link in the Task assigned email does not work. fix it
48. Add the Create Task button on the My Dashboard page and also move the facets in the filter dropdown to the main facet area. those are too hidden to remember they are there.
49. On page 70, I am getting this error, fix it: Component Recommended Work cannot be rendered as the grid settings for this component are invalid. It is set to be displayed at Column 13 with a Column Span of 8. This is not supported as the grid on this page only supports 12 Columns. Setting the Column and Column Span to Automatic for all components will typically fix this issue.
50. on page 70, hide the status, priority, scope and Due filters
51. on page 10, move the Application and Aging facets to the main facet area instead of from the dropdown of facets
52. can you generate an xlsx file of the data in the tsk_tasks table
53. for the aging report on page 1, can you change the date to the updated_at column instead of the created_at date. I want to see the aging tasks that were updated in the last 1 month, 1-3 months and over 3 months. Please also change the facet on page 10
54. can you make the sort on page 10 and 70 on last updated in desc so that the last one updated is first
55. generate a PDF of all the prompts and notifications done against the Task Center application

## Additional Codex Notifications and Actions

### TSK_TASKS Export and Data Scripts

- Codex identified `TASK_KEY` as the virtual column in `TSK_TASKS`.
- Codex generated `supporting-objects/tsk-tasks-data-no-virtual.sql` without the virtual `TASK_KEY` column and with `DESCRIPTION` handled as CLOB text.
- Codex generated `supporting-objects/archive-completed-tasks-before-2026.sql`.
- Codex ran `archive-completed-tasks-before-2026.sql` against `apexlang26.1`.
- Codex generated an Excel export of `TSK_TASKS`:
  - `docs/tsk_tasks_export.xlsx`
  - 520 rows
  - 24 columns
  - Included `DESCRIPTION` CLOB text up to Excel's cell limit
  - Verified package integrity and worksheet dimensions: `A1:X521`

### Archive Status and Dashboard Overviews

- Codex added the `Archive` status where needed.
- Codex updated task overview regions on pages 1 and 70 to include Archive status counts and links.
- Codex verified the related APEX imports completed with SQLcl `...done` notifications.

### Application Logo Work

- Codex added a custom application logo asset.
- Codex corrected the app so it used the custom icon instead of the APEX-supplied icon.
- Codex switched the logo to `task-center-logo.png`.
- Codex corrected the logo handling after the non-transparent background was observed.

### Email Log and Email Automation

- Codex created a page to show the email log.
- Codex added navigation from the email schedule page to the email log page.
- Codex migrated email jobs into APEX automations so schedules can be activated or deactivated in APEX.
- Codex created `supporting-objects/email-automation-migration.sql`.
- Codex continued to verify imports through SQLcl using the `apexlang26.1` connection.

### Page 10 Tasks

- Codex added `LAST_UPDATED` to the Tasks report.
- Codex formatted `LAST_UPDATED` as `DD-MON-YYYY`.
- Codex added and corrected the Last Updated facet for Last Day, Last Week, and Last Month.
- Codex changed page 10 pagination to show 20 rows with next/previous navigation after 50-row pagination did not appear as expected.
- Codex moved the `Application` and `Aging` facets out of the add-filter dropdown and into the main visible facet area by setting them to inline display.
- Codex changed the `P10_AGING` facet logic from `CREATED_AT` to `UPDATED_AT`.
- Codex changed the page 10 Tasks report default sort to:

```sql
order by v.updated_at desc nulls last, v.task_key
```

- Codex verified fresh APEX exports showed:
  - `P10_AGING` uses `t.updated_at`
  - `P10_APPLICATION` and `P10_AGING` use `p_fc_display_as=>'INLINE'`
  - Page 10 report uses `order by v.updated_at desc nulls last, v.task_key`

### Page 12 Task Details

- Codex added audit display-only items for `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, and `UPDATED_BY` in the Audit region.
- Codex imported and verified the page 12 audit changes.

### Page 70 My Dashboard

- Codex added `LAST_UPDATED` to the Recommended Work report.
- Codex added pagination to Recommended Work.
- Codex added a `Create Task` button on My Dashboard, pointing to page 11.
- Codex initially moved the dashboard filter items into a separate visible Filters region.
- APEX reported a grid error for page 70:

```text
Component Recommended Work cannot be rendered as the grid settings for this component are invalid.
It is set to be displayed at Column 13 with a Column Span of 8.
This is not supported as the grid on this page only supports 12 Columns.
```

- Codex fixed the page 70 grid issue by removing the extra Filters grid region and attaching the filter items to the Recommended Work region.
- Codex later hid `P70_STATUS`, `P70_PRIORITY`, `P70_SCOPE`, and `P70_OVERDUE` again under the title region as hidden items.
- Codex changed the page 70 Recommended Work report default sort to:

```sql
order by v.updated_at desc nulls last,
         v.task_key
```

- Codex verified fresh APEX exports showed:
  - `my-dashboard-filters` was removed
  - the page 70 filter items were `NATIVE_HIDDEN`
  - the Recommended Work report uses `order by v.updated_at desc nulls last`

### Page 1 Aging Report

- Codex changed the page 1 Task Aging chart from `CREATED_AT` buckets to `UPDATED_AT` buckets.
- Codex renamed the first bucket from `Under 1 Month` to `Last 1 Month`.
- Codex kept the chart scoped to Not Started and In Progress tasks.
- Codex aligned page 1 chart drill links to the page 10 `P10_AGING` facet values.
- Codex verified current bucket counts from live data:

| Aging Bucket | Task Count |
| --- | ---: |
| Last 1 Month | 19 |
| 1-3 Months | 6 |
| Over 3 Months | 1 |

### Task Assigned Email Link

- Codex fixed the Open Task link in the Task Assigned email.
- Codex updated and imported `supporting-objects/page11-task-assigned-email-link.sql`.
- Codex verified that the page 11 task assigned email link uses page 12 and passes `P12_TASK_ID`.

### CSV Comparison and Audit Updates

- Codex generated an upsert script from `report create and update.csv`:
  - `supporting-objects/report-create-update-upsert.sql`
- Codex handled comparison against existing database tasks.
- Codex generated and ran audit update logic from `all_tasks_from_old system.csv`.
- Codex used `EXTERNAL_REFERENCE` to match imported task rows to existing task rows.
- Codex updated task audit columns from source audit fields:
  - `CREATED` to `CREATED_AT`
  - `CREATED_BY` to `CREATED_BY`
  - `UPDATED` to `UPDATED_AT`
  - `UPDATED_BY` to `UPDATED_BY`

### Notable Error and Verification Notifications

- A first page 70 import attempt for visible filters failed with:

```text
PLS-00306: wrong number or types of arguments in call to 'CREATE_PAGE_ITEM'
```

- Codex corrected the APEX import parameters by using `p_colspan` instead of the unsupported item grid-span argument.
- A metadata check against `APEX_APPLICATION_PAGE_REGIONS` failed because this instance did not expose the queried `COLUMN_SPAN` column:

```text
ORA-00904: "COLUMN_SPAN": invalid identifier
```

- Codex used fresh APEX component exports instead for verification.
- SQLcl import notifications continued to report successful page imports using patterns such as:

```text
--application/set_environment
APPLICATION 132 - Task Center
--application/pages/delete_00010
--application/pages/page_00010
--application/end_environment
...done
```

and:

```text
--application/set_environment
APPLICATION 132 - Task Center
--application/pages/delete_00070
--application/pages/page_00070
--application/end_environment
...done
```

- Fresh APEX export notifications continued to report:

```text
Exporting Workspace DBAPPDEV - application 132:Task Center
File f132_page_10.sql created
File f132_page_70.sql created
```

## Current Supporting Object Files

- `supporting-objects/install-script.sql`
- `supporting-objects/schema-install.sql`
- `supporting-objects/data-install.sql`
- `supporting-objects/reference-data.sql`
- `supporting-objects/topic-groups-schema.sql`
- `supporting-objects/page1-aging-updated-at.sql`
- `supporting-objects/page10-tasks-pagination-20-next-prev.sql`
- `supporting-objects/page11-task-assigned-email-link.sql`
- `supporting-objects/page12-audit-items.sql`
- `supporting-objects/page41-email-automation-sync.sql`
- `supporting-objects/page70-create-task-visible-filters.sql`
- `supporting-objects/report-create-update-upsert.sql`
- `supporting-objects/update-task-audit-from-old-system.sql`
- `supporting-objects/tsk-tasks-data-no-virtual.sql`
- `supporting-objects/deinstall-script.sql`
- `supporting-objects/supporting-objects.apx`

## Notes

- The generated `data-install.sql` contains live user, task, update, email-log, and file data, including CLOB and BLOB values.
- The install wrapper now uses the full data export rather than only reference data.
- The generated install scripts were not executed against the current schema to avoid duplicating existing rows.
- This updated report includes the additional Task Center work performed through June 2, 2026.
- This report reflects the transcript and local command outputs visible to Codex in this session.
