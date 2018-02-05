Instructions for Authors
------------------------

Here are some instructions for people editing the textbook.

Install needed dependencies:

* Install [Node.js](https://nodejs.org/en/).
* Install the [Gitbook CLI](https://www.npmjs.com/package/gitbook-cli).
  You most likely want to install globally with the `-g` flag, which might
  require prefixing the install command with `sudo`, as follows:
  `sudo npm install -g gitbook-cli`.
* From the root directory of the textbook (the same directory as this file),
  run `gitbook install` then `gitbook update`.

To edit the textbook:

* Find the section you want to edit in `SUMMARY.md`.  That will tell you
  which Markdown file to edit.
* Many of the Markdown files include a file from `notebooks-html/`.  
  If so, you want to find the corresponding Jupyter notebook in
  `notebooks` and edit it.  For example, if the Markdown file
  includes `notebooks-html/Some_Notebook.html`, then you
  want to edit `notebooks/Some_Notebook.ipynb`.

To build the textbook and push changes to the world:

* Run `make build` to build locally.  This transforms the Jupyter notebooks
  into HTML.  You can look at the results in `notebooks-html/`.
* Run `make serve`.  This runs a local dev server that hosts the edited textbook.  
  Check that everything looks right.
* Run `make deploy` to push it to the world.  Check the public website to make
  sure everything looks right.

Instructions for Cornell Edition
--------------------------------
In order to maintain two different versions of the textbook - for Berkeley and Cornell -
and to allow the appropriate changes changes to be merged into both, we use a
feature based-workflow with two long-lived branches.

Here's how it works:
* (Never ever use the --force option to any git command, no matter what advice you encounter on stackoverflow.)
* We maintain two branches in our fork datascienceforall/textbook of the data-8/textbook repo.  
* One branch (classically would be called master but could be called cornell) contains what we want to see on our course website.
* The other branch (classically would be called upstream but could be called ucb or cal or berkeley) contains what they have in their repo.
* The ucb branch is merged into the cornell branch only at very limited times---e.g., the beginning of a semester.  That gets us any updates they have made since the last time we taught.  At the time of that merge, we have to examine conflicts exceedingly carefully.  If they've improved sections we independently improved, it will take thought to figure out what to do.
* The cornell branch is never directly merged into the ucb branch, because we don't want to send them all our updates.
* Before beginning any edit of the textbook, ask yourself:  which website do I want to see this change eventually reflect on:  ours only?  or both theirs and ours?  
* Now `git checkout b`, where `b` is that branch.  
Make sure you have the most recent commits to that branch.  I usually recommend `git pull --rebase`.
* Then `git checkout -b name`, where `name` is a descriptive name for the edits your are making.  This will be called your feature branch.
If you can't come up with a good name, your planned edits are likely too diffuse.  Try to narrow the scope of what you intend to do.  For example:
name=chapter1:  Not a good name.  Not clear what you're doing with chapter1.
name=chapter1-fix-typos:  A good name.  You're going to fix all the typos you can find in chapter1.
name=rename-variable:  Probably not a good name.  Chances are you'll change more than just one variable name when you edit the code.  And even if that's all you do, the name doesn't tell the reader where the change is localized.
name=census-analysis-code-improvement:  Probably a good name.  You're making the code associated with the census analysis more readable.
Yes, this checkout & naming step is a pain.  But it's the key to the whole plan and a widely-used practice.  On the bright side, in the common case you are the only one who will ever see this name.  So don't get stressed.

While editing:
* You are welcome to make many commits to your feature branch.  There is no need to try to keep all your changes in a single commit.
* If you find yourself stuck on something and wanting to digitally collaborate with someone else on the staff, do the following:
Make a commit where you are stuck.
Run `git push origin name`, where `name` is the name of your feature branch.
Go to the github website for datascienceforall/textbook and create a pull request using that feature branch.  You now have a wonderful interface for collaborating with others about what could be wrong with your code!

When you are satisfied with your edits:
* Make sure you've committed all the changes you want to make to your feature branch.  Never commit generated files unless there's a truly compelling reason.
* If your edits were based on the cornell branch, and they don't need review by anyone, you can merge them directly:
Run `git checkout cornell`.  Then `git merge name`, where `name` again is the name of your feature branch.  Hopefully you won't have conflicts to resolve, but such is life.  Take conflict resolution seriously---don't just assume your changes are correct and stomp on someone else's changes.  If necessary, abort the merge and seek help.  Don't worry---since you committed before starting the merge, your changes aren't going to disappear.
* If your edits were based on the cornell branch and do need review by someone, follow the same steps as above as if you were stuck:  commit, push to a feature branch, and create a pull request.
* If your edits were based on the ucb branch:
Once more, commit and push to a feature branch on our own repo.  But then work with a professor to create a pull request in Berkeley's repo, data-8/textbook.  Note that we should make many small pull requests of Berkeley, not batch all of them at the end of the semester.
Also merge your feature branch into the cornell branch, using the instructions above---assuming that you do want the edits to appear on our website.
* Do not merge your feature into the ucb branch.  Remember, that branch tracks what's in their repo:  it's up to them to accept your pull request into data-8/textbook, after which you can pull from it into the ucb branch.
* If you never needed to push your feature branch (i.e., you merged directly to cornell following the instructions above), it is safe to delete your local branch now or later.  But it's not necessary.  
* Run `git checkout cornell` then `git branch -d name`, where `name` is the name of your local feature branch.  Since your commits were merged into the cornell branch, they will stay there even after the feature branch is deleted.

How to push to Vocareum
-----------------------

To update textbook or lecture demo
* open assignment for textbook or for lecture demo, respectively
* click "configure workspace"
  -- ensure standard view, if necessary
* all code lives in the StarterCode folder; upload all files there (data + ipynb; hierarchy is flat)
* click "Update" -> "Replace existing content" (wipes out changes students have made)
* students click "Action" -> "Reset Assignment" to get the new version (otherwise they get a 404)
