From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 1 Jun 2021 11:52:18 +0200
Subject: [LTP] [PATCH 0/3] CI: Move from Travis to GitHub Actions
In-Reply-To: <20210531165052.8731-1-pvorel@suse.cz>
References: <20210531165052.8731-1-pvorel@suse.cz>
Message-ID: <CAASaF6zQt38sSkA7PDNZL53J7gbOXTCgC54Xbwb6qe=7-_wpWg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 31, 2021 at 6:51 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> Travis often false positive due "pull rate limit" issue [1],
> thus I decided to finally switch to GitHub Actions.
>
> Also using GitHub native CI allows more advanced features
> (e.g. update wiki with doc/*.txt, nightly build docparser doc).
>
> Whole thing is tested [2].
>
> I rewritten build.sh, added -r step.
> It's ugly, using commands in yaml would be more readable. But I'd prefer
> 1) not writting shell in yaml 2) have build script for local use.
>
> Please comment, test.
>

We should update docs too, but series looks OK, ACK.



>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/issues/761
> [2] https://github.com/pevik/ltp/actions/runs/893331703
>
> Petr Vorel (3):
>   build.sh: Rewrite to allow running certain step
>   CI: Rename travis script directory
>   CI: Move from Travis to GitHub Actions
>
>  .github/workflows/ci.yml               | 154 +++++++++++++++++++
>  .travis.yml                            | 131 ----------------
>  build.sh                               | 198 ++++++++++++++-----------
>  {travis => ci}/alpine.sh               |   0
>  {travis => ci}/centos.sh               |   0
>  {travis => ci}/debian.cross-compile.sh |   0
>  {travis => ci}/debian.i386.sh          |   0
>  {travis => ci}/debian.minimal.sh       |   0
>  {travis => ci}/debian.sh               |   0
>  {travis => ci}/fedora.sh               |   0
>  {travis => ci}/opensuse.sh             |   0
>  {travis => ci}/tumbleweed.sh           |   0
>  {travis => ci}/ubuntu.sh               |   0
>  13 files changed, 262 insertions(+), 221 deletions(-)
>  create mode 100644 .github/workflows/ci.yml
>  delete mode 100644 .travis.yml
>  rename {travis => ci}/alpine.sh (100%)
>  rename {travis => ci}/centos.sh (100%)
>  rename {travis => ci}/debian.cross-compile.sh (100%)
>  rename {travis => ci}/debian.i386.sh (100%)
>  rename {travis => ci}/debian.minimal.sh (100%)
>  rename {travis => ci}/debian.sh (100%)
>  rename {travis => ci}/fedora.sh (100%)
>  rename {travis => ci}/opensuse.sh (100%)
>  rename {travis => ci}/tumbleweed.sh (100%)
>  rename {travis => ci}/ubuntu.sh (100%)
>
> --
> 2.31.1
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210601/7ce8f7a5/attachment.htm>
