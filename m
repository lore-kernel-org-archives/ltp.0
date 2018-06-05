From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Jun 2018 12:05:29 +0800
Subject: [LTP] [PATCH] move_pages: Remove redundant move_pages.sh
In-Reply-To: <1527642555-20424-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1527642555-20424-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eLpnncBi497z=q9vajKRt+QLNXP7BmQkHkV8nP2X+P6Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, May 30, 2018 at 9:09 AM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Use move_pages[1-12] binaries directly instead of move_pages.sh
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>

​Reviewed-by: Li Wang <liwang@redhat.com>

​


> ---
>  runtest/numa                                       | 22
> +++++++++++-----------
>  runtest/syscalls                                   | 22
> +++++++++++-----------
>  testcases/kernel/syscalls/move_pages/Makefile      |  2 --
>  testcases/kernel/syscalls/move_pages/move_pages.sh | 18
> ------------------
>  4 files changed, 22 insertions(+), 42 deletions(-)
>  delete mode 100755 testcases/kernel/syscalls/move_pages/move_pages.sh
>
> diff --git a/runtest/numa b/runtest/numa
> index dcf4948..12aedbb 100644
> --- a/runtest/numa
> +++ b/runtest/numa
> @@ -1,13 +1,13 @@
>  Numa-testcases numa01.sh
> -move_pages01 move_pages.sh 01
> -move_pages02 move_pages.sh 02
> -move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 &&
> chmod 04755 move_pages03 && move_pages.sh 03
> -move_pages04 move_pages.sh 04
> -move_pages05 move_pages.sh 05
> -move_pages06 move_pages.sh 06
> -move_pages07 move_pages.sh 07
> -move_pages08 move_pages.sh 08
> -move_pages09 move_pages.sh 09
> -move_pages10 move_pages.sh 10
> -move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 &&
> chmod 04755 move_pages11 && move_pages.sh 11
> +move_pages01 move_pages01
> +move_pages02 move_pages02
> +move_pages03 move_pages03
> +move_pages04 move_pages04
> +move_pages05 move_pages05
> +move_pages06 move_pages06
> +move_pages07 move_pages07
> +move_pages08 move_pages08
> +move_pages09 move_pages09
> +move_pages10 move_pages10
> +move_pages11 move_pages11
>  move_pages12 move_pages12
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 738d224..f3ed2fb 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -655,17 +655,17 @@ mount04 mount04
>  mount05 mount05
>  mount06 mount06
>
> -move_pages01 move_pages.sh 01
> -move_pages02 move_pages.sh 02
> -move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 &&
> chmod 04755 move_pages03 && move_pages.sh 03
> -move_pages04 move_pages.sh 04
> -move_pages05 move_pages.sh 05
> -move_pages06 move_pages.sh 06
> -move_pages07 move_pages.sh 07
> -move_pages08 move_pages.sh 08
> -move_pages09 move_pages.sh 09
> -move_pages10 move_pages.sh 10
> -move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 &&
> chmod 04755 move_pages11 && move_pages.sh 11
> +move_pages01 move_pages01
> +move_pages02 move_pages02
> +move_pages03 move_pages03
> +move_pages04 move_pages04
> +move_pages05 move_pages05
> +move_pages06 move_pages06
> +move_pages07 move_pages07
> +move_pages08 move_pages08
> +move_pages09 move_pages09
> +move_pages10 move_pages10
> +move_pages11 move_pages11
>  move_pages12 move_pages12
>
>  mprotect01 mprotect01
> diff --git a/testcases/kernel/syscalls/move_pages/Makefile
> b/testcases/kernel/syscalls/move_pages/Makefile
> index 9892770..27cf0f7 100644
> --- a/testcases/kernel/syscalls/move_pages/Makefile
> +++ b/testcases/kernel/syscalls/move_pages/Makefile
> @@ -22,8 +22,6 @@ include $(top_srcdir)/include/mk/testcases.mk
>
>  CPPFLAGS               += -I$(abs_srcdir)/../utils
>
> -INSTALL_TARGETS                := move_pages.sh
> -
>  MAKE_TARGETS           := $(patsubst $(abs_srcdir)/%.c,%,$(wildcard
> $(abs_srcdir)/*[0-9].c))
>
>  $(MAKE_TARGETS): %: %.o move_pages_support.o
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages.sh
> b/testcases/kernel/syscalls/move_pages/move_pages.sh
> deleted file mode 100755
> index 516d088..0000000
> --- a/testcases/kernel/syscalls/move_pages/move_pages.sh
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -#!/bin/sh
> -
> -if [ -z "$1" ]; then
> -    echo "Usage: move_pages.sh <test-number>"
> -    exit 1
> -fi
> -
> -testprog=move_pages${1}
> -
> -if [ -f $LTPROOT/testcases/bin/${testprog} ]; then
> -    exec $testprog
> -else
> -    export TCID=$testprog
> -    export TST_TOTAL=1
> -    export TST_COUNT=0
> -    tst_resm TCONF "libnuma and NUMA support is required for this
> testcase"
> -    tst_exit
> -fi
> --
> 1.8.3.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180605/ec77d51a/attachment.html>
