From: Enji Cooper <yaneurabeya@gmail.com>
Date: Tue, 17 Mar 2020 04:30:23 -0700
Subject: [LTP] [PATCH] open_posix_testsuite: Fix compilation issues
In-Reply-To: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
References: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
Message-ID: <9A4A80BA-97B7-4057-B988-E0A53EE9EC16@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NAK.

This should use LDLIBS, as others have pointed out, not LDFLAGS.

This also spams these libraries on all tests, instead of the ones that need it.

I can see there?s a desire to build/make open posix testsuite by default. I?ll look into making it so soon because the current model is a PITA to maintain and doesn?t integrate well into CI/CD.

Cheers,
-Enji

> On Mar 17, 2020, at 00:20, Zou Wei <zou_wei@huawei.com> wrote:
> 
> ?Fix compilation issues:
> 1. Add the '-lpthread -lrt -lm' config into LDFLAGS
> 2. Update makefile and locate-test script
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
> testcases/open_posix_testsuite/LDFLAGS             | 1 +
> testcases/open_posix_testsuite/functional/Makefile | 2 +-
> testcases/open_posix_testsuite/scripts/locate-test | 2 +-
> testcases/open_posix_testsuite/stress/Makefile     | 2 +-
> 4 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/LDFLAGS b/testcases/open_posix_testsuite/LDFLAGS
> index e69de29..6c112d3 100644
> --- a/testcases/open_posix_testsuite/LDFLAGS
> +++ b/testcases/open_posix_testsuite/LDFLAGS
> @@ -0,0 +1 @@
> +-lpthread -lrt -lm
> diff --git a/testcases/open_posix_testsuite/functional/Makefile b/testcases/open_posix_testsuite/functional/Makefile
> index 3b22c89..50e03aa 100644
> --- a/testcases/open_posix_testsuite/functional/Makefile
> +++ b/testcases/open_posix_testsuite/functional/Makefile
> @@ -5,7 +5,7 @@
> #
> 
> all clean install test:
> -    @for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
> +    @for dir in `find . -name *Makefile | egrep -v '^./Makefile' | sed -e 's,/Makefile$$,,g'`; do \
>        $(MAKE) -C $$dir $@;                           \
>    done
> 
> diff --git a/testcases/open_posix_testsuite/scripts/locate-test b/testcases/open_posix_testsuite/scripts/locate-test
> index 27f0bb5..e4ef994 100755
> --- a/testcases/open_posix_testsuite/scripts/locate-test
> +++ b/testcases/open_posix_testsuite/scripts/locate-test
> @@ -92,7 +92,7 @@ runnable)
>    # waltz down the tools directory and try and build t0 (which doesn't
>    # make sense as it's a tool, not a test). Better criterion needs to
>    # be established for this file.
> -    find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools'
> +    find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9a-z].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools' | grep -v 'testfrmw.c$'
>    find "$WHERE/functional" -type f -name '*.c'
>    ;;
> test-tools)
> diff --git a/testcases/open_posix_testsuite/stress/Makefile b/testcases/open_posix_testsuite/stress/Makefile
> index b09527f..d6872a9 100644
> --- a/testcases/open_posix_testsuite/stress/Makefile
> +++ b/testcases/open_posix_testsuite/stress/Makefile
> @@ -5,7 +5,7 @@
> #
> 
> all clean install test:
> -    @for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
> +    @for dir in `find . -name *Makefile | egrep -v '^./Makefile' | sed -e 's,/Makefile$$,,g'`; do \
>        $(MAKE) -C $$dir $@;                          \
>    done
> 
> --
> 2.6.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
