From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Mar 2021 10:23:45 +0100
Subject: [LTP] [PATCH v2 2/2] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <20210318181641.2062-3-pvorel@suse.cz>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-3-pvorel@suse.cz>
Message-ID: <YFRtoRtRFVFYeXkn@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  doc/maintainer-patch-review-checklist.txt | 53 +++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 doc/maintainer-patch-review-checklist.txt
> 
> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> new file mode 100644
> index 000000000..2587287aa
> --- /dev/null
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -0,0 +1,53 @@
> +# Maintainer Patch Review Checklist
> +
> +Patchset should be tested locally and ideally also in maintainer's fork in
> +https://travis-ci.org/[Travis CI].
> +
> +NOTE: Travis does only build testing, passing the CI means only that the
> +      test compiles fine on variety of different distributions and
> +      releases.
> +
> +The test should be executed at least once locally and should PASS as well.
> +
> +Commit messages should have
> +
> +* Author's `Signed-off-by` tag
> +* Committer's `Reviewed-by` or `Signed-off-by` tag
> +* Check also mailing lists for other reviewers / testers
> +* `Fixes: hash` if it fixes particular commit
                                         ^
					 LTP

Let's add this here so that is clear what we mean.

> +* `Fixes: #N` if it fixes N github issue, so it's automatically closed
                              ^
			 This wording is not clear it should be:

	... if it fixes github issue number N ...

Or just:

	.. if it fixed github issue N ...

> +After patch is accepted or rejected, set correct state and archive in
> +https://patchwork.ozlabs.org/project/ltp/list/[LTP patchwork instance].
> +
> +Also update LTP WIKI (git URL https://github.com/linux-test-project/ltp.wiki.git)
> +if touch 'doc/*.txt'.
> +
> +## New tests
> +New test should
> +
> +* Have a record in runtest file
> +* Test should work fine with more than one iteration
> +  (e.g. run with `-i 100`)
> +* Have a brief description
> +
> +### C tests
> +* Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
> +* Test files are added into corresponding '.gitignore' files
          ^
	  binaries?

> +* Check coding style with
> +  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
> +  (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style[C coding style])
> +* Docparse documentation
> +* If a test is a regression test it should include tags
> +  (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2238-test-tags[Test tags])
> +
> +### Shell tests
> +* Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
> +* Check coding style with
> +  https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl[checkbashism.pl]
> +  (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style[Shell coding style])
> +* If a test is a regression test it should include related kernel or glibc commits as a comment
> +
> +## LTP library
> +For patchset touching library please check also
> +https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].

Other than these minor comments it looks great.

-- 
Cyril Hrubis
chrubis@suse.cz
