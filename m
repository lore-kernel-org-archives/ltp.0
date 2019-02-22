From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 22 Feb 2019 15:41:18 +0300
Subject: [LTP] [PATCH 1/1] net/virt: Introduce MIN_VIRT_PERF_THRESHOLD
	variable
In-Reply-To: <20190222090109.19824-1-pvorel@suse.cz>
References: <20190222090109.19824-1-pvorel@suse.cz>
Message-ID: <954c744c-62c2-58d8-1b2c-09c0e7734b28@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 2/22/19 12:01 PM, Petr Vorel wrote:
> to reduce duplicity in VIRT_PERF_THRESHOLD checks
>
...
>  cleanup_vifaces()
>  {
> diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
> index 9708e8e5d..d8ced5fda 100755
> --- a/testcases/network/virt/vxlan03.sh
> +++ b/testcases/network/virt/vxlan03.sh
> @@ -31,11 +31,9 @@ TST_CLEANUP=virt_cleanup
>  # by 10-30%. If hosts are too close to each other, e.g. connected to the same
>  # switch, VxLAN can be much slower when comparing to the performance without
>  # any encapsulation.
> -VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
> +MIN_VIRT_PERF_THRESHOLD=160

Looks good, except may be add "MIN" to the end so it is closer to 'threshold'?
