---
title: "One tracker, zero status files: why I run all my projects on GitHub Issues"
description: "Every tracker that needed a second edit after the real work went stale within weeks. Git history did not, so GitHub Issues became the only tracker."
date: 2026-09-19
categories: [Development workflow]
tags: [github issues, project management, ai agents, claude code, git]
author: "Admin"
read_time: 6
permalink: /blog/one-tracker-github-issues/
twin: /blogi/yksi-tracker-github-issues/
lang: en
---

In July 2026 I audited four of my personal product repos to see how work was tracked in each. The GitHub side of the result was short: zero issues and zero pull requests, in every repo. Work had been committed straight to main.

That did not mean nothing was being tracked. There was a lot of tracking, all of it in files. That turned out to be the problem.

## What the repos contained

Each repo had its own system for recording what was done and what came next. A sprint-status file from the BMAD method. A roadmap in YAML. Numbered session logs. Status tables inside CLAUDE.md, the instruction file my coding agent reads at the start of a session. All of them had been adopted on purpose, and all of them went stale within one to three weeks.

Some specifics from the audit:

- One sprint-status file was frozen while roughly 40 later commits went untracked. A separate roadmap file in the same repo was fresher, but it lagged too.
- In another repo the session logs stopped at number 32. Sessions 33 to 45 exist only in a rolling handoff note and in commit messages.
- One CLAUDE.md described the project as "pre-code". The repo at that point had CI and deployed pages.
- In a fourth, the planning was done and the execution loop was never started. No sprint file, no story files.

The one record that stayed current in all four repos was git history. The commit messages were consistent. Some of them referenced story IDs that pointed at a tracker which no longer matched reality.

The planning documents themselves were fine. PRDs and epics with acceptance criteria were some of the better material in those repos. What was missing was a tracker that stayed true.

## Why they drifted

The failure mode is dual-write. You do the work, and then you make a separate edit to record that you did the work. Any tracker that needs that second edit will eventually not get it. When one person works with coding agents, the work moves faster than the bookkeeping, so the gap opens quickly.

Once a status file is wrong in one place, it is not a status file anymore. It is a document you have to verify against the code, and at that point it has no job left.

## What I run now

GitHub Issues is the only tracker. The rules around it are few:

1. One issue, one branch, one pull request.
2. The pull request description contains `Closes #n`. When the pull request is merged, GitHub closes the issue.
3. Settled decisions are appended as numbered entries (D-001, D-002 and so on) in the pull request that implements them. The decision and the code arrive together, and the history shows when.
4. CLAUDE.md is orientation only: what the project is, how to run it, where things live. No status, no current phase.
5. Facts that can be derived from the repo are not written down. How many source files exist, whether CI is set up, which pages are deployed: the repo already says so. The "pre-code" line was a derivable fact that someone wrote down and nobody updated.

The point of rule 2 is that closing an issue is a side effect of a git event I already had to perform. There is no separate step to skip. An open issue normally means unmerged work, and a closed one means the pull request landed.

## Removing the old tooling

The same audit found the same agent tooling installed in three of the repos: about 80 skills per repo, from BMAD and related packs. The planning phase had produced good documents. The execution loop was either never used or died early.

In September 2026 I removed it. In one repo that deleted 3,225 files, about 31 MB. The planning documents stayed, as plain Markdown. The working principle is a durable repo and a disposable harness: what has to last lives in the repo in formats any tool can read, and the agent tooling around it can be swapped without losing anything.

## What didn't work, and what I would still change

**CI checks are advisory.** GitHub branch protection is not available on private repos on the Free plan. A failing check does not block a merge, and merging is a manual action by me as the owner. "One issue, one branch, one pull request" is therefore a habit I keep, not a rule GitHub enforces.

**The track record is short.** The old systems also looked fine in their first weeks. A few weeks of clean history proves little about how this one behaves at month six.

**Issues live on GitHub, not in the repo.** The old Markdown files were at least portable. The task list is now a platform dependency. Decisions and planning documents stay in the repo for that reason, and the task list is the part I accept renting.

**A tracker does not fix everything the audit found.** It also turned up production code that lived outside version control: a data pipeline in a workflow tool that was not under git, and a local repo with no remote. Choosing where tasks live does not put that code somewhere safe. That is separate work.

## The test I use

When I look at a tracking scheme now, I ask what it needs me to write after the work is finished. If the answer is anything at all, I expect it to be out of date within a few weeks.
