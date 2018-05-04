From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 4 May 2018 14:31:02 +0300
Subject: [LTP] [RFC PATCH 2/3] net/ipsec_lib.sh: Use positional
 parameters in TST_PARSE_ARGS function
In-Reply-To: <20180503122222.2996-3-pvorel@suse.cz>
References: <20180503122222.2996-1-pvorel@suse.cz>
 <20180503122222.2996-3-pvorel@suse.cz>
Message-ID: <265c414b-6109-0aa1-8f84-0c2d1747dd72@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.05.2018 15:22, Petr Vorel wrote:
> as it's now supported also for legacy API.
> 
> Major problem was with using global $opt instead of $1 (dependency on
> how the library function implemented), but avoiding using $OPTARG
> directly is also preferable.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/stress/ipsec/ipsec_lib.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> index 4b9b473cf..cc1295873 100644
> --- a/testcases/network/stress/ipsec/ipsec_lib.sh
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -34,7 +34,7 @@ IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-10 100 1000 2000 10000 65000}"
>  
>  ipsec_lib_parse_args()
>  {
> -	case "$opt" in
> +	case "$1" in
>  	h)
>  		echo "Usage:"
>  		echo "h        help"
> @@ -52,17 +52,17 @@ ipsec_lib_parse_args()
>  		echo "6        run over IPv6"
>  		exit 0
>  	;;
> -	l) LINK_NUM=$OPTARG ;;
> -	m) IPSEC_MODE=$OPTARG ;;
> -	p) IPSEC_PROTO=$OPTARG ;;
> -	s) IPSEC_SIZE_ARRAY="$OPTARG" ;;
> -	S) SPI=$OPTARG ;;
> -	k) VTI_KEY=$OPTARG ;;
> -	A) AEALGO=$OPTARG ;;
> -	e) EALGO=$OPTARG ;;
> -	a) AALGO=$OPTARG ;;
> -	c) CALGO=$OPTARG ;;
> -	r) IPSEC_REQUESTS="$OPTARG" ;;
> +	l) LINK_NUM=$2 ;;
> +	m) IPSEC_MODE=$2 ;;
> +	p) IPSEC_PROTO=$2 ;;
> +	s) IPSEC_SIZE_ARRAY="$2" ;;
> +	S) SPI=$2 ;;
> +	k) VTI_KEY=$2 ;;
> +	A) AEALGO=$2 ;;
> +	e) EALGO=$2 ;;
> +	a) AALGO=$2 ;;
> +	c) CALGO=$2 ;;
> +	r) IPSEC_REQUESTS="$2" ;;
>  	*) tst_brkm TBROK "unknown option: $opt" ;;

                                            ^
In virt_lib.sh and this one here:           $1

Otherwise looks good.
