From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Sat, 28 Apr 2018 18:19:59 +0300
Subject: [LTP] [PATCH 2/2] network/vxlan: Fix getopts parameters passed
 from vxlan03 to virt_lib.sh
In-Reply-To: <20180428135921.9622-3-pvorel@suse.cz>
References: <20180428135921.9622-1-pvorel@suse.cz>
 <20180428135921.9622-3-pvorel@suse.cz>
Message-ID: <09e656ed-db47-a1dc-33ec-77d795f81555@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/28/2018 04:59 PM, Petr Vorel wrote:
> * shift parameters and add getopts handling of -6 parameter in vxlan03.sh
> * move loading tst_net.sh from vxlan03.sh and other virt_lib.sh users to
> virt_lib.sh itself
> 
> vxlan03.sh pass getopts parameter to virt_lib.sh (other than -6 which is
> handled by tst_net.sh), which causes getopts error:
> 
> vxlan03.sh -d uni
> /opt/ltp/testcases/bin/vxlan03.sh: illegal option -- d
> /opt/ltp/testcases/bin/tst_net.sh: line 37: ?: command not found
> 
> These parameters must be processed and shifted before loading
> tst_net.sh. Move loading tst_net.sh from vxlan03.sh and other
> virt_lib.sh users to virt_lib.sh itself solve it. -6 parameter must be
> handled the same way as in tst_net.sh (which leads to duplicity but it
> cannot be avoided atm) The approach of handling tst_net.sh is now the
> same as in ipsec_lib.sh.
> 
> Fixes: ba53eb04e tst_net.sh: Support both new and legacy APIs + rename
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reported-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---

Hi Petr,

...

>  options="mode private,mode vepa,mode bridge,mode passthru"
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index c99004b85..4db49010e 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -28,18 +28,6 @@
>  #          them in cleanup function. See "start_vni" variable which can
>  #          solve it.
>  
> -ip_local=$(tst_ipaddr)
> -ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
> -ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
> -
> -ip_remote=$(tst_ipaddr rhost)
> -ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
> -ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
> -
> -# Max performance loss (%) for virtual devices during network load
> -VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
> -vxlan_dstport=0
> -
>  while getopts :hi:d:6 opt; do
>  	case "$opt" in
>  	h)
> @@ -52,14 +40,30 @@ while getopts :hi:d:6 opt; do
>  	;;
>  	i) start_id=$OPTARG ;;
>  	d) vxlan_dst_addr=$OPTARG ;;
> -	6) # skip, test_net library already processed it
> -	;;
> +	6) TST_IPV6=6 ;;
>  	*)
>  		tst_brkm TBROK "unknown option: $opt"
>  	;;
>  	esac
>  done
>  
> +shift $(($OPTIND - 1))
> +


What about using TST_OPTS and TST_PARSE_ARGS here, instead of 'while getopts...'
and 'shift'?

virt_parse_args()
{
        case "$1" in
        h)
           ...
        ;;
        i) start_id=$OPTARG ;;
        d) vxlan_dst_addr=$OPTARG ;;
        esac
}

TST_OPTS="hi:d:"
TST_PARSE_ARGS=virt_parse_args
