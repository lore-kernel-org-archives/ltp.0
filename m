From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jun 2018 16:48:02 +0800
Subject: [LTP] [PATCH v2 2/2] testcases: Replace "getconf" by
	"tst_getconf"
In-Reply-To: <20180614072206.23393-3-mylene.josserand@bootlin.com>
References: <20180614072206.23393-1-mylene.josserand@bootlin.com>
 <20180614072206.23393-3-mylene.josserand@bootlin.com>
Message-ID: <CAEemH2fDRE-Jvv0JCdJ5tCWcGDnmSwiTphh6F90yXE-zwy1xLw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Jun 14, 2018 at 3:22 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> Now that tst_getconf is available to use "sysconf()" function
> instead of relying on the application "getconf", let's convert
> all the tests to it.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/commands/du/du01.sh                                    | 2 +-
>  testcases/commands/mkswap/mkswap01.sh                            | 2 +-
>  testcases/kernel/controllers/cpuset/cpuset_regression_test.sh    | 2 +-
>  testcases/kernel/controllers/memcg/control/memcg_control_test.sh | 2 +-
>  testcases/kernel/controllers/memcg/functional/memcg_lib.sh       | 4 ++--
>  testcases/kernel/numa/numa01.sh                                  | 2 +-
>  testcases/lib/test.sh                                            | 4 ++--
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
> index ed1df568f..c75068255 100755
> --- a/testcases/commands/du/du01.sh
> +++ b/testcases/commands/du/du01.sh
> @@ -73,7 +73,7 @@ du_test()
>  }
>
>  block_size=512
> -page_size=$(getconf PAGESIZE)
> +page_size=$(tst_getconf PAGESIZE)
>  if [ "$page_size" -lt 1024 ]; then
>         tst_brk TBROK "Page size < 1024"
>  fi
> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
> index 1c01c86b2..035eb7cf9 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -29,7 +29,7 @@ setup()
>  {
>         UUID=`uuidgen`
>
> -       PAGE_SIZE=`getconf PAGE_SIZE`
> +       PAGE_SIZE=`tst_getconf PAGESIZE`
>
>         # Here get the size of the device and align it down to be the
>         # multiple of $PAGE_SIZE and use that as the size for testing.
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index 4a104a3ad..72a2a944c 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -34,7 +34,7 @@ setup()
>                 tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
>         fi
>
> -       local cpu_num=$(getconf _NPROCESSORS_ONLN)
> +       local cpu_num=$(tst_getconf _NPROCESSORS_ONLN)
>         if [ $cpu_num -lt 2 ]; then
>                 tst_brkm TCONF "We need 2 cpus at least to have test"
>         fi
> diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> index 1d158729c..4d9f1bb5d 100644
> --- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> +++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> @@ -41,7 +41,7 @@ export TST_COUNT=0
>  export TMP=${TMP:-/tmp}
>  cd $TMP
>
> -PAGE_SIZE=$(getconf PAGESIZE)
> +PAGE_SIZE=$(tst_getconf PAGESIZE)
>
>  TOT_MEM_LIMIT=$PAGE_SIZE
>  ACTIVE_MEM_LIMIT=$PAGE_SIZE
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index 6a6af853b..cd16dc685 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -29,9 +29,9 @@ if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
>         tst_brkm TCONF "Kernel does not support the memory resource controller"
>  fi
>
> -PAGESIZE=$(getconf PAGESIZE)
> +PAGESIZE=$(tst_getconf PAGESIZE)
>  if [ $? -ne 0 ]; then
> -       tst_brkm TBROK "getconf PAGESIZE failed"
> +       tst_brkm TBROK "tst_getconf PAGESIZE failed"
>  fi
>
>  HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
> index 27a2f2f7c..b58cf9d56 100755
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -83,7 +83,7 @@ wait_for_support_numa()
>  setup()
>  {
>         export MB=$((1024*1024))
> -       export PAGE_SIZE=$(getconf PAGE_SIZE)
> +       export PAGE_SIZE=$(tst_getconf PAGESIZE)
>         export HPAGE_SIZE=$(awk '/Hugepagesize:/ {print $2}' /proc/meminfo)
>
>         total_nodes=0
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index bce9893a9..650712181 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -421,9 +421,9 @@ fi
>  if [ "$TST_NEEDS_CHECKPOINTS" = "1" ]; then
>         LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
>
> -       LTP_IPC_SIZE=$(getconf PAGESIZE)
> +       LTP_IPC_SIZE=$(tst_getconf PAGESIZE)
>         if [ $? -ne 0 ]; then
> -               tst_brkm TBROK "getconf PAGESIZE failed"
> +               tst_brkm TBROK "tst_getconf PAGESIZE failed"
>         fi
>
>         ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$LTP_IPC_SIZE" count=1
> --
> 2.11.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Regards,
Li Wang
