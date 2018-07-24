From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 24 Jul 2018 16:32:12 +0800
Subject: [LTP] [PATCH] add testcases/lib/tst_supported_fs to .gititnore
In-Reply-To: <20180724082530.18646-1-mmoese@suse.de>
References: <20180724082530.18646-1-mmoese@suse.de>
Message-ID: <5B56E40C.5090605@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michael,

Good catch.  It looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks,
Xiao Yang
On 2018/07/24 16:25, Michael Moese wrote:
> The binary tst_supported_fs was missing in the .gitinore file
> in testcases/lib, so it should be added.
>
> Signed-off-by: Michael Moese<mmoese@suse.de>
> ---
>   testcases/lib/.gitignore | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index 997940006..a9034e401 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -7,4 +7,5 @@
>   /tst_net_iface_prefix
>   /tst_net_ip_prefix
>   /tst_net_vars
> -/tst_getconf
> \ No newline at end of file
> +/tst_getconf
> +/tst_supported_fs



