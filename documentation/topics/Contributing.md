# Contributing

## Contributing to PurpurAsync

PurpurAsync is happy you're willing to contribute to our projects. We are usually
very lenient with all submitted PRs, but there are still some guidelines you
can follow to make the approval process go more smoothly.

## Use a Personal Fork and not an Organization

PurpurAsyncAsync will routinely modify your PR, whether it's a quick rebase or to take care
of any minor nitpicks we might have. Often, it's better for us to solve these
problems for you than make you go back and forth trying to fix them yourself.

Unfortunately, if you use an organization for your PR, it prevents PurpurAsync from
modifying it. This requires us to manually merge your PR, resulting in us
closing the PR instead of marking it as merged.

We much prefer to have PRs show as merged, so please do not use repositories
on organizations for PRs.

See <https://github.com/isaacs/github/issues/1681> for more information on the
issue.

## Requirements

To get started with PRing changes, you'll need the following software, most of
which can be obtained in (most) package managers such as `apt` (Debian / Ubuntu;
you will most likely use this for WSL), `homebrew` (macOS / Linux), and more:

- `git` (package `git` everywhere);
- A Java 21 or later JDK (packages vary, use Google/DuckDuckGo/etc.).
    - [Adoptium](https://adoptium.net/) has builds for most operating systems.
    - PurpurAsync requires JDK 21 to build, however, makes use of Gradle's
      [Toolchains](https://docs.gradle.org/current/userguide/toolchains.html)
      feature to allow building with only JRE 11 or later installed. (Gradle will
      automatically provision JDK 21 for compilation if it cannot find an existing
      install).

## Understanding Patches

Paper is mostly patches and extensions to Spigot. These patches/extensions are
split into different directories which target certain parts of the code. These
directories are:

- `PurpurAsync-API` - Modifications to `Paper-API`;
- `PurpurAsync-Server` - Modifications to `Paper-Server`.

Because the entire structure is based on patches and git, a basic understanding
of how to use git is required. A basic tutorial can be found [here](https://git-scm.com/docs/gittutorial)

Assuming you have already forked the repository:

1. Clone your fork to your local machine;
2. Type `./gradlew applyPatches` in a terminal to apply the changes from upstream.
   On Windows, replace the `./` with `.\` at the beginning for all `gradlew` commands;
3. cd into `PurpurAsync-Server` for server changes, and `PurpurAsync-API` for API changes.

`PurpurAsync-Server` and `PurpurAsync-API` aren't git repositories in the traditional sense:

- `base` points to the unmodified source before PurpurAsync patches have been applied.
- Each commit after `base` is a patch.

## Adding Patches

Adding patches to PurpurAsync is very simple:

1. Modify `PurpurAsync-Server` and/or `PurpurAsync-API` with the appropriate changes;
2. Type `git add .` inside these directories to add your changes;
3. Run `git commit` with the desired patch message;
4. Run `./gradlew rebuildPatches` in the main directory to convert your commit into a new
   patch;
5. PR the generated patch file(s) back to this repository.

Your commit will be converted into a patch that you can then PR into PurpurAsync.

> ❗ Please note that if you have some specific implementation detail you'd like
> to document, you should do so in the patch message *or* in comments.
{style="warning"}

## Modifying Patches

#### Manual method

1. Make your change while at HEAD;
2. Make a temporary commit. You don't need to make a message for this;
3. Type `git rebase -i base`, move (cut) your temporary commit and
   move it under the line of the patch you wish to modify;
4. Change the `pick` to the appropriate action:
    1. `f`/`fixup`: Merge your changes into the patch without touching the
       message.
    2. `s`/`squash`: Merge your changes into the patch and use your commit message
       and subject.
5. Type `./gradlew rebuildPatches` in the root directory;
    - This will modify the appropriate patches based on your commits.
6. PR your modified patch file(s) back to this repository.

#### Automatic method (Recommended)

1. Make your change while at HEAD;
2. Make a fixup commit. `git commit -a --fixup <hashOfPatchToFix>`;
    - You can also use `--squash` instead of `--fixup` if you want the commit
      message to also be changed.
    - You can get the hash by looking at `git log` or `git blame`; your IDE can
      assist you too.
    - Alternatively, if you only know the name of the patch, you can do
      `git commit -a --fixup "Subject of Patch name"`.
3. Rebase with autosquash: `git rebase -i --autosquash base`.
   This will automatically move your fixup commit to the right place, and you just
   need to "save" the changes.
4. Type `./gradlew rebuildPatches` in the root directory;
    - This will modify the appropriate patches based on your commits.
5. PR your modified patch file(s) back to this repository.

## Rebasing PRs

Steps to rebase a PR to include the latest changes from `master`.  
These steps assume the `origin` remote is your fork of this repository and `upstream` is the official PurpurAsync repository.

1. Pull the latest changes from upstreams master: `git checkout master && git pull upstream master`.
2. Checkout feature/fix branch and rebase on master: `git checkout patch-branch && git rebase master`.
3. Apply updated patches: `./gradlew applyPatches`.
4. If there are conflicts, fix them.
5. If your PR creates new patches instead of modifying existing ones, in both the `PurpurAsync-Server` and `PurpurAsync-API` directories, ensure your newly-created patch is the last commit by either:
    * Renaming the patch file with a large 4-digit number in front (e.g. 9999-Patch-to-add-some-new-stuff.patch), and re-applying patches.
    * Running `git rebase --interactive base` and moving the commits to the end.
6. Rebuild patches: `./gradlew rebuildPatches`.
7. Commit modified patches.
8. Force push changes: `git push --force`.

## Formatting

All modifications to non-PurpurAsync files should be marked. The one exception to this is
when modifying javadoc comments, which should not have these markers.

- You need to add a comment with a short and identifiable description of the patch:
  `// PurpurAsync start - <COMMIT DESCRIPTION>`
    - The comments should generally be about the reason the change was made, what
      it was before, or what the change is.
    - After the general commit description, you can add additional information either
      after a `;` or in the next line.
- Multi-line changes start with `// PurpurAsync start - <COMMIT DESCRIPTION>` and end
  with `// PurpurAsync end - <COMMIT DESCRIPTION>`.
- One-line changes should have `// PurpurAsync - <COMMIT DESCRIPTION>` at the end of the line.

Here's an example of how to mark changes by PurpurAsync:

```Java
entity.getWorld().dontBeStupid(); // PurpurAsync - Was beStupid(), which is bad
entity.getFriends().forEach(Entity::explode);
entity.updateFriends();

// PurpurAsync start - Use plugin-set spawn
// entity.getWorld().explode(entity.getWorld().getSpawn());
Location spawnLocation = ((CraftWorld)entity.getWorld()).getSpawnLocation();
entity.getWorld().explode(new BlockPosition(spawnLocation.getX(), spawnLocation.getY(), spawnLocation.getZ()));
// PurpurAsync end - Use plugin-set spawn
```

We generally follow the usual Java style (aka. Oracle style), or what is programmed
into most IDEs and formatters by default. There are a few notes, however:
- It is fine to go over 80 lines as long as it doesn't hurt readability.  
  There are exceptions, especially in Spigot-related files
- When in doubt or the code around your change is in a clearly different style,
  use the same style as the surrounding code.
- `var` usage is heavily discouraged, as it makes reading patch files a lot harder
  and can lead to confusion during updates due to changed return types. The only
  exception to this is if a line would otherwise be way too long/filled with hard
  to parse generics in a case where the base type itself is already obvious

## Testing API changes

### Using the PurpurAsync Test Plugin

The PurpurAsync project has a `test-plugin` module for easily testing out API changes
and additions. To use the test plugin, enable it in `test-plugin.settings.gradle.kts`,
which will be generated after running Gradle at least once. After this, you can edit
the test plugin, and run a server with the plugin using `./gradlew runDev` (or any
of the other PurpurAsync run tasks).

### Publishing to Maven local (use in external plugins)

To build and install the PurpurAsync APIs and Server to your local Maven repository, do the following:

- Run `./gradlew publishToMavenLocal` in the base directory.

If you use Gradle to build your plugin:
- Add `mavenLocal()` as a repository. Gradle checks repositories in the order they are declared,
  so if you also have the PurpurAsync repository added, put the local repository above PurpurAsync's.
- Make sure to remove `mavenLocal()` when you are done testing, see the [Gradle docs](https://docs.gradle.org/current/userguide/declaring_repositories.html#sec:case-for-maven-local)
  for more details.

If you use Maven to build your plugin:
- If you later need to use the PurpurAsync-API, you might want to remove the jar
  from your local Maven repository.  
  If you use Windows and don't usually build using WSL, you might not need to
  do this.