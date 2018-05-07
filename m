From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 May 2018 08:44:44 +0200
Subject: [LTP] [PATCH 2/3] net/tcp_fastopen_run.sh: Cleanup in
 TST_PARSE_ARGS functions for legacy API
In-Reply-To: <1525663451-32016-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1525663451-32016-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180507064444.vft5titc7uur4nvk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> 1) Process getopts parameters by TST_OPTS and TST_PARSE_ARGS
> 2) Pass $OPTARG as $2 to TST_PARSE_ARGS functions

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/network/tcp_fastopen/tcp_fastopen_run.sh | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

> diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
> index 5cc9804..865b3d4 100755
> --- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
> +++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
> @@ -20,8 +20,9 @@

>  TST_NETLOAD_MAX_SRV_REPLIES=3

> -while getopts :hr:n:R:6 opt; do
> -	case "$opt" in
> +tcp_fastopen_parse_args()
> +{
> +	case "$1" in
>  	h)
>  		echo "Usage:"
>  		echo "h        help"
> @@ -29,17 +30,18 @@ while getopts :hr:n:R:6 opt; do
>  		echo "6        run over IPv6"
>  		exit 0
>  	;;
> -	R) TST_NETLOAD_MAX_SRV_REPLIES=$OPTARG ;;
> -	6) TST_IPV6=6 ;;
> -	*) tst_brkm TBROK "unknown option: $opt" ;;
> +	R) TST_NETLOAD_MAX_SRV_REPLIES=$2 ;;
> +	*) tst_brkm TBROK "unknown option: $1" ;;
>  	esac
> -done
> -shift $(($OPTIND - 1))
> +}

>  TST_TOTAL=1
>  TCID="tcp_fastopen"
>  TST_NEEDS_TMPDIR=1

> +TST_OPTS=":hr:n:R:"
> +TST_PARSE_ARGS=tcp_fastopen_parse_args
> +
>  TST_USE_LEGACY_API=1
>  . tst_net.sh

Acked-by: Petr Vorel <pvorel@suse.cz>

NOTE: I propose to merge this patch-set after release (as it's not a bugfix, we should respect git freeze).


Kind regards,
Petr
