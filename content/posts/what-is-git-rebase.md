+++ 
draft = false
date = 2025-01-06
title = "What is Git Rebase?"
description = "Explainer and tutorial on using Git Rebase"
slug = ""
authors = []
tags = []
categories = []
externalLink = ""
series = []
+++
# What is git rebase?
Git rebase is a powerful command that rewrites a branch’s commit history. Before using it, it’s important to understand how it works, especially to avoid unintended changes on your main branch.
When working with feature branches, frequent merges into the main branch can lead to a cluttered commit history filled with merge commits. Git rebase helps clean this up by rearranging the commits from your feature branch to appear as if they were made directly on the main branch.
Unlike merging, rebasing avoids creating merge commits, keeping your repository history linear and much easier to follow.

# When shouldn’t we rebase?
It’s probably best to avoid rebasing if you’re using a shared or public branch. Re-writing history can cause confusion.

# A typical merge strategy
![A Typical merge strategy](/images/rebase_1.png)

# A rebase merge strategy
![A Typical rebase strategy](/images/rebase_2.png)

When we rebase, in this instance we would run
```bash
git checkout feature
git rebase main
```
Notice how this doesn’t create a merge commit, it simply replays our commits on the main branch. This keeps the main branch clear and easy to understand how it has changed over time.


# Git rebase interactive, and squashing commits.
So during my development, I’ve created lots of commits. They might not necessarily be ones I want to concern my team with, maybe I just committed what I was doing before lunch, or I made a mistake and created a commit to fix it.
My git log may look like this:

![rebase interactive](/images/rebase_3.png)

I could ‘squash’ these all into a single commit using
```bash
git rebase HEAD~4
```

Remember the HEAD just refers to the latest commit, and tilde 4 means the 4 previous commits. You could also provide a git hash in place of this if you prefer.
It opens up a vim window like this:

![vim](/images/rebase_4.png)

There is a quirk here that the commits are in reverse order, so the most recent commit is last in the list which might not be what you expected.
If you’ve not used vim before this may be frustrating, but use ‘i’ to enter INSERT mode and edit the document how you would like, I’ve opted to squash them all like so. Once you’re done hit ESC to exit INSERT mode and type :wq to save and quit.

![git log](/images/rebase_5.png)

# Final thoughts
Git rebase is a powerful tool that helps maintain a clean and linear commit history, making it easier to understand and track changes over time. By using rebase, you can eliminate unnecessary merge commits and streamline your repository’s history, especially when working with feature branches.
However, it’s important to use rebase responsibly. Avoid rebasing shared or public branches to prevent disrupting others’ work and causing confusion. Always ensure you’re working on a local or private branch before rewriting history.
Interactive rebasing adds even more flexibility, allowing you to clean up your commits, squash unnecessary changes, and present a polished history to your team. With these techniques, you can enhance collaboration and make code reviews more efficient.
Mastering Git rebase not only improves your workflow but also demonstrates your attention to maintaining clean, professional repositories. With careful use, it can be a valuable addition to your version control toolkit.