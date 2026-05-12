# Fitness Tracker V1 Upgrade Plan

## File
`advanced_interactive_workout_nutrition_tracker_html.html`

---

## Phase 1 — Foundation
- [x] Add `--red` CSS variable to `:root`
- [x] Add modal overlay CSS
- [x] Add 4 tab buttons (`Daily Tracker`, `Routines`, `Workout`, `Calendar`) with IDs
- [x] Add skeleton `<section>` elements for each new tab
- [x] Add storage helpers: `getFolders/getRoutines/getDailyLogs/getDailyMeta()` + savers + `genId()` + `todayDateStr()`
- [x] Modify `showSection` to trigger tab init on open (init calls for each new tab)

## Phase 2 — Daily Tracker
- [x] Date picker (default today) + Today button
- [x] Morning routine checkbox
- [x] Routine select (grouped by folder with `<optgroup>`)
- [x] Workout status select (planned / in_progress / completed / skipped)
- [x] Vitals grid: calories, protein, carbs, fat, water, sleep, bodyWeight, pushups, pullups
- [x] Rest day checkbox
- [x] Notes textarea
- [x] Save button with feedback flash
- [x] JS: `initDailyTracker()`, `renderTrackerRoutineOptions()`, `loadTrackerForDate()`, `saveTrackerData()`, `trackerGoToToday()`

## Phase 3 — Routines Tab
- [x] Folder accordion list with collapse/expand (`toggleFolder`)
- [x] New Folder modal
- [x] New Routine modal (creates blank routine then opens editor)
- [x] Routine Editor modal — full exercise builder
  - [x] Per-exercise type selector changes set fields shown
  - [x] Add/remove sets per exercise
  - [x] Add/remove exercises
  - [x] Cardio block (duration, speed, incline, resistance, distance, calories)
- [x] JS: `renderFolders()`, `createFolder()`, `deleteFolder()`, `toggleFolder()`, `createRoutine()`, `deleteRoutine()`, `openRoutineEditor()`, `renderRoutineEditor()`, `buildExerciseEditorHTML()`, `addExerciseToEditor()`, `saveRoutineEdits()`, `editorSetChange()`, `editorExChangeType()`

## Phase 4 — Workout Session
- [x] 5-step wizard with step indicator dots + connecting lines
- [x] Step 1: Date selection
- [x] Step 2: Routine select (grouped by folder) + inline preview
- [x] Step 3: Full routine preview (exercise list) + Start button
- [x] Step 4: Active session — `setInterval` MM:SS timer, exercises with per-set checkboxes (`data-session="true"`), Finish button
- [x] Step 5: Summary (date, routine, duration, exercises, sets completed)
- [x] `startWorkout()` writes `status:'in_progress'` to `ft_dailyLogs`
- [x] `finishWorkout()` writes `status:'completed'` + `endTime` to `ft_dailyLogs`
- [x] `sessionReset()` for new workout
- [x] In-memory `sessionState` — survives tab switching while session is active

## Phase 5 — Calendar
- [x] Month grid (7 columns Mon–Sun), prev/next month navigation
- [x] Color dot classes: `cal-green` (completed), `cal-yellow` (in_progress), `cal-red` (past+no log), `cal-blue` (rest day)
- [x] `.today` border highlight
- [x] Clicking a day switches to Daily Tracker tab + loads that date
- [x] Legend below grid
- [x] JS: `initCalendar()`, `calendarPrevMonth()`, `calendarNextMonth()`, `renderCalendar()`, `getCalendarDayClass()`, `calendarOpenDay()`

## Phase 6 — Polish
- [x] Mobile CSS fixes at 650px breakpoint
- [x] Empty state messages (no folders, no routines, no exercises)
- [x] Progress bar fix: `updateProgress()` and `loadState()` use `input[type="checkbox"]:not([data-session])`
- [x] Session checkboxes use `data-session="true"` — excluded from plan progress bar
- [x] `escH()` utility for HTML-safe rendering

---

## Data Model (new localStorage keys — never touches `workoutPlanState`)
```
ft_folders:   [{id, name}]
ft_routines:  [{id, folderId, name, exercises:[...]}]
ft_dailyLogs: {"YYYY-MM-DD": {date, routineId, routineName, status, startTime, endTime, exercises}}
ft_dailyMeta: {"YYYY-MM-DD": {morningDone, calories, protein, carbs, fat, water, sleep, bodyWeight, pushupsMax, pullupsMax, isRestDay, notes}}
```

## Exercise Types
| Type | Set Fields |
|------|-----------|
| `weight_training` | reps + weight |
| `bodyweight` | reps |
| `assisted_bodyweight` | reps + assistWeight |
| `timed` | duration (s) |
| `mobility` | duration (s) |
| `cardio` | single block: duration, speed, incline, resistance, distance, calories |

---

## End-to-End Verification Checklist
> Static checks passed: 9 sections present, JS syntax clean, storage keys isolated
- [ ] All 9 tabs open, existing 5 tabs work normally (checkboxes + progress bar)
- [ ] Routines: create folder → create routine → add exercises of all 6 types → save → reload → persists
- [ ] Daily Tracker: fill fields → save → reload → persists
- [ ] Workout Session: pick date → select routine → start → timer runs → check sets → finish → summary shown
- [ ] Calendar: today shows on grid → clicking a day redirects to Daily Tracker with correct date
- [ ] Progress bar excludes session checkboxes
