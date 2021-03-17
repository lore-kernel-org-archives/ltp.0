From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Mar 2021 10:44:12 +0100
Subject: [LTP] [RFC PATCH 1/1] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <20210317083347.9791-1-pvorel@suse.cz>
References: <20210317083347.9791-1-pvorel@suse.cz>
Message-ID: <YFHPbD132yWLMqK8@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  doc/maintainer-patch-review-checklist.txt | 32 +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 doc/maintainer-patch-review-checklist.txt

Overall this is a good idea, a few notes below.

> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> new file mode 100644
> index 000000000..cfe3918c1
> --- /dev/null
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -0,0 +1,32 @@
> +# Maintainer Patch Review Checklist
> +
> +Patchset should be tested locally and ideally also in maintainer's fork in
> +https://travis-ci.org/[Travis CI].

We should add something like this here:


Note: Travis does only build testing, passing the CI means only that the
      test compiles fine on variety of different distributions and
      releases.

The test should be executed at least once locally and should PASS as well.

> +Commit messages should have
> +
> +* author's `Signed-off-by` tag
> +* committer's `Reviewed-by` or `Signed-off-by` tag
> +* check also mailing lists for other reviewers / testers
> +
> +## New tests
> +New test should have
> +
> +* record in runtest file

> +* test run with more iteration (`-i 100`)

This is slightly confusing, it should probably be:

* Tests should work fine with more than one iteration
  (e.g. run with `-i 100`)

> +### C tests
> +* use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
> +* record in `.gitignore`
> +* check coding style with `checkpatch.pl`

Checkpatch is distributed with linux kernel source code, please also use
reasonably recent one.

> +(more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style[C coding style])
> +* docparse documentation

+ proper documentation comment
  -- this should be explained somewhere and linked here

+ If a test is a regression test it should include tags
  -- this should be explained somewhere as well and linked here

> +### Shell tests
> +* use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
> +* check coding style with `checkbashism.pl`

I guess that we should add the link to debian devscripts here

> +(more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style[Shell coding style])
> +
> +## LTP library
> +For patchset touching library please check also
> +https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].

-- 
Cyril Hrubis
chrubis@suse.cz
