From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 3 May 2018 14:14:30 +0300
Subject: [LTP] [PATCH v2 2/3] network/virt_lib.sh: Process getopts
 parameters with TST_OPTS and TST_PARSE_ARGS
In-Reply-To: <20180430062343.5582-2-pvorel@suse.cz>
References: <20180430062343.5582-1-pvorel@suse.cz>
 <20180430062343.5582-2-pvorel@suse.cz>
Message-ID: <b6bfc407-9ba0-1d78-da66-570096cd1e1c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/30/2018 09:23 AM, Petr Vorel wrote:
...
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
> -while getopts :hi:d:6 opt; do
> +virt_lib_parse_args()
> +{
>  	case "$opt" in

Hi Petr,

Here we should use the first argument instead of the global $opt, otherwise
it depends on how the library function implemented.

And the same in ipsec_lib.sh library.

Other than that, the patch-set looks good.

Thanks,
Alexey
