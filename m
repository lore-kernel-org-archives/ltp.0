From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 28 Apr 2017 18:24:56 +0300
Subject: [LTP] [PATCH] runtest/net.nfs: fix version typo
In-Reply-To: <1489575310-3488-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1489575310-3488-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <ede2fc8b-4486-ce87-4742-92ad4ea00d28@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 15.03.2017 13:55, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  runtest/net.nfs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index f5984c0..a0781a5 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -12,7 +12,7 @@ nfs41_ipv6_01 nfs01 -6 -v 4.1 -t tcp
>  nfs42_ipv6_01 nfs01 -6 -v 4.2 -t tcp
>  
>  nfs3_02 nfs02 -v 3 -t udp
> -nfs4_02 nfs02 -v 3 -t tcp
> +nfs4_02 nfs02 -v 4 -t tcp

I wonder if we should add back test-cases with NFSv3 over TCP,
something like this:
nfs3t_02  nfs01 -v 3 -t tcp
...

Thanks,
Alexey
