From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 31 Aug 2021 08:30:41 +0200
Subject: [LTP] [PATCH] broken_ip: Fix runtest for broken_ip4-plen
In-Reply-To: <20210831054557.944172-1-lkml@jv-coder.de>
References: <20210831054557.944172-1-lkml@jv-coder.de>
Message-ID: <f05a5719-e568-ac53-5694-fc970e796d53@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry Richard, I wanted to add Petr, not you...

On 8/31/2021 7:45 AM, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Fixes: 5d8f9dfd6b8 ("broken_ip: Remove duplicate broken_ip-totlen")
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>   runtest/net_stress.broken_ip | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/runtest/net_stress.broken_ip b/runtest/net_stress.broken_ip
> index 75791986e..a5536c0c2 100644
> --- a/runtest/net_stress.broken_ip
> +++ b/runtest/net_stress.broken_ip
> @@ -6,7 +6,7 @@
>   broken_ip4-version broken_ip-version.sh
>   broken_ip4-ihl broken_ip-ihl.sh
>   broken_ip4-fragment broken_ip-fragment.sh
> -broken_ip6-plen broken_ip-plen.sh
> +broken_ip4-plen broken_ip-plen.sh
>   broken_ip4-protcol broken_ip-protcol.sh
>   broken_ip4-checksum broken_ip-checksum.sh
>   broken_ip4-dstaddr broken_ip-dstaddr.sh

