# Developer guide

- [Technical preconditions](#technical-preconditions)
- [Developer Certificate of Origin](#developer-certificate-of-origin)
- [Commits, changelog, release note, versioning](#commits-changelog-release-note-versioning)
  * [About commits](#about-commits)
  * [About release note and changelog](#about-release-note-and-changelog)
- [Linter](#linter)
- [Formater](#formater)
- [Dead code](#dead-code)
- [Update of dependencies](#update-of-dependencies)
- [CI/CD](#cicd)
- [Use of GenAI](#use-of-genai)
- [Use of robots](#use-of-robots)

## Technical preconditions

> [!IMPORTANT]
> You must have an iOS-ready environment to contribute to the project or at least build it.
> Thus macOS is mandatory and Xcode 26.

> [!IMPORTANT]
> You should check wether or not you have the tools in use in the project like Fastlane, SwiftLint, SwiftFormat, etc.

> [!TIP]
> If some tools are missing, pick the suitable command line below and check versions

```bash
# Get updated RubyGems
gem update --system 3.6.7

# Install bundler (at least 2.6.7)
gem install bundler

# Install rbenv (at least 1.3.2)
brew install rbenv

# Use Bundler to install a major part of dependencies (thanks to Gemfile and Gemfile.lock files)
bundle install

# Update your references
brew update

# For SwiftFormat (at least 0.58.5)
brew install swiftformat
# or `brew upgrade swiftformat` to get updates if old version installed

# For SwiftLint (at least 0.62.2)
brew install swiftlint
# or `brew upgrade swiftlint` to get updates if old version installed

# For Periphery (https://github.com/peripheryapp/periphery) for dead code hunt (at least 3.1.0)
# If you used Periphery V2 before, follow their migration guide: https://github.com/peripheryapp/periphery/wiki/3.0-Migration-Guide
brew install periphery

# For git-cliff (at least 2.8.0)
brew install git-cliff
```

Ensure you have the suitable _Ruby_ version. We recommend the use of [rbenv](https://github.com/rbenv/rbenv) to load the suitable version of ruby.

> [!TIP]
> We use here Ruby 3 (>= 3.4).

If you are not used to this tool:

```shell
# List available local versions of Ruby
rbenv install --list

# Apply the expected x.y.z version of Ruby (if listed previously with the command above)
rbenv global 3.4.0

# If you don't have the expected x.y.z version of Ruby, run:
# >  brew update && brew upgrade ruby-build
# >  rbenv install x.y.z
# then 
# >  rbenv global x.y.z

# Apple commends using ZSH as shell instead of Bash, so to will need to add the magic line in the end of your shell configuration
echo 'eval "$(rbenv init -)"' >> ~/.zshrc

# Then
source ~/.zshrc

# Check Ruby version
ruby --version
```

## Developer Certificate of Origin

A [GitHub Action bot](https://probot.github.io/apps/dco/) has been plugged in the repository so as to check wether or not the DCO is applied for commits.

## Commits, changelog, release note, versioning

### About commits

#### Convention commits rules

Try as best as possible to apply [conventional commits rules](https://www.conventionalcommits.org/en/v1.0.0/).
Keep in mind to have your commits well prefixed, and with the issue number between parenthesis at the end, and also if needed the pull request issue number.
If your commits embed contributions for other people, do not forget to [add them as co-authors](https://docs.github.com/fr/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors).
All of you should also comply to DCO.

Your commit message should be prefixed by keywords [you can find in the specification](https://www.conventionalcommits.org/en/v1.0.0/#specification):
- `fix:`
- `feat:`
- `build:`
- `chore:`
- `ci:`
- `docs:`
- `style:`
- `refactor:`
- `perf:`
- `test:`

You can add also ! after the keyword to say a breaking change occurs, and also add a scope between parenthesis like:
- `feat!:` breaking change because..
- `feat:` add something in the API...

A *Git commit-msg hook* is also defined in the project. It will run *Shell* codes to check if rules defined in the hook are respected before commit being pushed.
The hook is degined in **.git-hook/commit-msg**.

To apply it, run in your project (e.g. once cloned):

```shell
git config --local --add core.hooksPath .git-hooks
```

#### Chain of responsability

We can add metafields picked from [this good guideline](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n525) in the commit messages.
This is not mandatory (yet) but a good practice and quite interesting to know who reviewed and validated what.
You must mention *co-authors* (*Co-authored-by*). You should add who are code reviewers (*Reviewed-by*), evolutions testers (*Tested-by*) and if needed ackers (*Acked-by*).
Because feedbacks of our users are important, you can also mention people who suggested issues to thanks them (*Suggested-by*).

For example, for issue n°123 and its pull request n°456, tested by Foo, reviewed by Bar, authored by Wizz and Wazz, acked by John and suggested by Jane, precise it with their first name, last name and emails:
```text
refactor: improve code architecture (#123) (#456)

Some things have been refactored to make incredible things.

Suggested-by: Jane <jane@orange.com>
Tested-by: Foo <foo@orange.com>
Acked-by: John <john@orange.com>
Reviewed-by: Bar <bar@orange.com>
Co-authored-by: Wizz <wizz@orange.com>
Co-authored-by: Wazz <wazz@orange.com>
```

> [!TIP]
> Keep things clear and sorted. If people worked on your commits, mention them if relevant.

#### Verifying commits cryptographic signatures

Some core maintainers in the project can use GPG so cryptographically sign their commits.
You can check the commits status with the commands below:
```shell
# Of course we suppose you are a bit used to GPG and have it installed
# Update your keychain of GPG keys and getthe online the ones for the maintainers
# For example GPG key identifier of @pylapp is "8030BBE06B4F48F95BD082DA7D5AE4DCFF3A3435"

# This command can take a lot of time, maybe try the next one
gpg --refresh-keys
gpg --keyserver https://key.openpgp.org --recv-keys 8030BBE06B4F48F95BD082DA7D5AE4DCFF3A3435

# If none of this command works, contact the maintainers to get their public key to add in your keychain and run
gpg --import path/to/asc/key/file

# Then check if the key is in your keychain
gpg --list-keys --keyid-format=short

# If you run "gpg --check-sigs" you may notice they keys are not signed (unknown trust), that's not unexpected

# Then run the command to verify the commit status using for example its hash
git verify-commit the-commit-hash
# Or get more logs
git log --show-signature
```

In addition, GitHub also provides a feature of commits veritification named [Vigilant mode](https://docs.github.com/en/authentication/managing-commit-signature-verification/displaying-verification-statuses-for-all-of-your-commits).
In few words, if the commit was signed with the committer's verified signature, the commit is *verified*.

> [!CAUTION]
> Some maintainers do not use GPG or SSH signing for commits, so the documentation commits can be seen as "unverified"
> and some commits can have empty status because GitHub Vigilant Mode is not enabled for everyone
> and some commits can be unsigned.

### About release note and changelog

We try also to apply [keep a changelog](https://keepachangelog.com/en/1.0.0/), and [semantic versioning](https://semver.org/spec/v2.0.0.html) both with [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

We can generate a `RELEASE_NOTE.md` file using the Git history and [git cliff](https://git-cliff.org/) tool.

To generate a release note:
```shell
git-cliff --config .github/cliff.toml --output RELEASE_NOTE.md X..Y
```

## Linter

We use _SwiftLint_ in this project so as to be sure the source code follows defined guidelines for the syntax and other points.
You must run _SwiftLint_ in CLI or using _Xcode_ to be sure you don't keep and submit warnings.

We provide a command to run _SwiftLint_:
```shell
cd scripts
./lint.sh
```

## Formater

We use [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) to format sources and keep them clean. This tool is use in Xcode build phase.
You can run *SwiftFormat* in CLI:

```shell
cd scripts
./format.sh
```

A *Git pre-commit hook* is also defined in the project. It will run *SwifFormat* before the commit so as to be sure the sources will be well formatted before being pushed.
The hook is degined in **.git-hook/pre-commit**.
To apply it, run in your project (e.g. once cloned):

```shell
git config --local --add core.hooksPath .git-hooks
```

*SwiftFormat* is not used in GitHub Actions CI/CD because sources should be formatted before beeing pushed, not after.

## Dead code

We use `Periphery` to look for dead code and help developers to track it and remove it. This tool should be run locally.

```shell
cd scripts
./dead-code.sh
```

## CI/CD

### GitHub Action

We use *GitHub Actions* so as to define several workflows with some actions to build, test, check, documentation and audit the library.

Workflows are the following:
- [Check translations](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/blob/master/.github/workflows/check-wordings.yml) to check if there are localizations troubles
- [Run SwiftLint](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/blob/master/.github/workflows/swiftlint.yml) to check if sources are clean
- [Gitleaks](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/blob/master/.github/workflows/gitleaks.yml) to look for secrets leaks

## Use of GenAI

The use of generative artifical intelligence (in short "GenAI") is not forbidden, but must be used with care.
However, to keep records of this new usage, contributors and maintainers must add inside the commit body if they use GenAI, which model and how (when possible).
Indeed GenAI can be used to generate source code and also review pull requests or process issues.
In all cases, the field *Assisted-by* must be added with the Large Language Model ("LLM") name and product.

For example, if the Orange tool named _Dinootoo_ has been used with GPT-4o-mini as LLM to generate some code:

```text
Assisted-by: GPT-4o-mini (Orange Dinootoo)
```

Or if the [Codex (OpenAI product)](https://chatgpt.com/codex) product has been used to make some pull request reviews or to work on issues, 
using the GitHub Connector (see [here for LLM for Codex cloud details](https://openai.com/fr-FR/index/introducing-codex/)):

```text
Assisted-by: codex-1 (OpenAI Codex)
```

If otherwise you use the GitHub Copilot agent, which does not precise every time which LLM is used:

```text
Assisted-by: GitHub Copilot
```

Or if it is mentioned:
```text
Assisted-by: Claude 3.7 Sonnet (GitHub Copilot)
```

The main things to note are the LLM in use and the products behind with, if relevant, company name to have no doubt.

> [!CAUTION]
> Always review the source code
> and avoid use of GenAI if possible.
> GenAI has a real environmental footprint and is based on predatory and colonialist techniques (theft, exploitation, stifling of producers).

> [!TIP]
> If you use [OpenAI Codex](https://developers.openai.com/codex/quickstart), you can mention @codex to "review" of "fix the issue".
> If you use [GitHub Copilot Coding Agent](https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent), assign the issue or the PR, or tag @copilot

## Use of robots

Bots accounts can be used, e.g. to update dependencies with *Dependabot*, *Snyk* or *Renovate*, etc.
It could be interesting to keep traces of what they did, e.g. review pull requests or provide source code.
The suitable field must be used and also the bot name and associated email.

For example:
```text
Co-authored-by: StepSecurity Bot <bot@stepsecurity.io>
Reviewed-by: Copilot <198982749+Copilot@users.noreply.github.com>
Signed-off-by: StepSecurity Bot <bot@stepsecurity.io>
```