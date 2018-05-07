From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 May 2018 09:18:51 +0200
Subject: [LTP] [PATCH 3/3] net/nfs_lib.sh: Cleanup for legacy API
In-Reply-To: <1525663451-32016-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1525663451-32016-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180507071851.z2nuun4atbrh2sfz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> 1) Move common tst_net.sh to nfs_lib.sh itself
> 2) Pass $OPTARG as $2 to TST_PARSE_ARGS functions

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/network/nfs/fsx-linux/fsx.sh      |  2 --
>  testcases/network/nfs/nfs_stress/nfs01      |  2 --
>  testcases/network/nfs/nfs_stress/nfs02      |  2 --
>  testcases/network/nfs/nfs_stress/nfs03      |  2 --
>  testcases/network/nfs/nfs_stress/nfs04      |  2 --
>  testcases/network/nfs/nfs_stress/nfs05      |  2 --
>  testcases/network/nfs/nfs_stress/nfs06      |  2 --
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 13 ++++++++-----
>  testcases/network/nfs/nfslock01/nfslock01   |  2 --
>  testcases/network/nfs/nfsstat01/nfsstat01   |  2 --
>  10 files changed, 8 insertions(+), 23 deletions(-)

> diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
> index 84ad0e2..3f82d18 100755
> --- a/testcases/network/nfs/fsx-linux/fsx.sh
> +++ b/testcases/network/nfs/fsx-linux/fsx.sh
> @@ -26,8 +26,6 @@ TST_TOTAL=1
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  do_test()
>  {
> diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
> index 93bf088..efaa215 100755
> --- a/testcases/network/nfs/nfs_stress/nfs01
> +++ b/testcases/network/nfs/nfs_stress/nfs01
> @@ -25,8 +25,6 @@ TST_TOTAL=1
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  do_test()
>  {
> diff --git a/testcases/network/nfs/nfs_stress/nfs02 b/testcases/network/nfs/nfs_stress/nfs02
> index 74aa3d8..5cbe771 100755
> --- a/testcases/network/nfs/nfs_stress/nfs02
> +++ b/testcases/network/nfs/nfs_stress/nfs02
> @@ -25,8 +25,6 @@ TST_TOTAL=3
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  do_test1()
>  {
> diff --git a/testcases/network/nfs/nfs_stress/nfs03 b/testcases/network/nfs/nfs_stress/nfs03
> index 3279a22..2de7622 100755
> --- a/testcases/network/nfs/nfs_stress/nfs03
> +++ b/testcases/network/nfs/nfs_stress/nfs03
> @@ -25,8 +25,6 @@ TST_TOTAL=1
>  TST_CLEANUP="nfs03_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  DIR_NUM=${DIR_NUM:-"100"}
>  FILE_NUM=${FILE_NUM:-"100"}
> diff --git a/testcases/network/nfs/nfs_stress/nfs04 b/testcases/network/nfs/nfs_stress/nfs04
> index 254c987..ccadbb1 100755
> --- a/testcases/network/nfs/nfs_stress/nfs04
> +++ b/testcases/network/nfs/nfs_stress/nfs04
> @@ -28,8 +28,6 @@ TST_TOTAL=1
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  nfs_setup

> diff --git a/testcases/network/nfs/nfs_stress/nfs05 b/testcases/network/nfs/nfs_stress/nfs05
> index 8c39cde..8435181 100755
> --- a/testcases/network/nfs/nfs_stress/nfs05
> +++ b/testcases/network/nfs/nfs_stress/nfs05
> @@ -29,8 +29,6 @@ FILE_NUM=${FILE_NUM:-"50"}
>  THREAD_NUM=${THREAD_NUM:-"8"}

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  tst_check_cmds make gcc

> diff --git a/testcases/network/nfs/nfs_stress/nfs06 b/testcases/network/nfs/nfs_stress/nfs06
> index 628271a..0048190 100755
> --- a/testcases/network/nfs/nfs_stress/nfs06
> +++ b/testcases/network/nfs/nfs_stress/nfs06
> @@ -25,8 +25,6 @@ TST_TOTAL=1
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  do_test()
>  {
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 28c43ba..7aed718 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -20,9 +20,6 @@ NFILES=${NFILES:=1000}
>  SOCKET_TYPE="${SOCKET_TYPE:-udp}"
>  NFS_TYPE=${NFS_TYPE:=nfs}

> -TST_OPTS=":hv:t:"
> -TST_PARSE_ARGS=nfs_parse_args
> -
>  nfs_parse_args()
>  {
>  	case "$1" in
> @@ -34,12 +31,18 @@ nfs_parse_args()
>  		echo "6        run over IPv6"
>  		exit 0
>  	;;
> -	v) VERSION=$OPTARG;;
> -	t) SOCKET_TYPE=$OPTARG;;
> +	v) VERSION=$2;;
> +	t) SOCKET_TYPE=$2;;
>  	*) tst_brkm TBROK "unknown option: $1"
>  	esac
>  }

> +TST_OPTS=":hv:t:"
> +TST_PARSE_ARGS=nfs_parse_args
> +
> +TST_USE_LEGACY_API=1
> +. tst_net.sh
> +
>  get_socket_type()
>  {
>  	local t
> diff --git a/testcases/network/nfs/nfslock01/nfslock01 b/testcases/network/nfs/nfslock01/nfslock01
> index a545fa0..bf406e6 100755
> --- a/testcases/network/nfs/nfslock01/nfslock01
> +++ b/testcases/network/nfs/nfslock01/nfslock01
> @@ -26,8 +26,6 @@ TST_TOTAL=1
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  LUSER=${LUSER:=root}

> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
> index afd239f..9212518 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01
> @@ -22,8 +22,6 @@ TST_TOTAL=4
>  TST_CLEANUP="nfs_cleanup"

>  . nfs_lib.sh
> -TST_USE_LEGACY_API=1
> -. tst_net.sh

>  setup()
>  {

Acked-by: Petr Vorel <pvorel@suse.cz>

NOTE: I propose to merge this patch-set after release (as it's not a bugfix, we should respect git freeze).

Kind regards,
Petr
