From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 May 2018 08:57:29 +0200
Subject: [LTP] [PATCH 1/1] lib/tst_net.sh: Add checks for awk
In-Reply-To: <20180517093159.16517-1-pvorel@suse.cz>
References: <20180517093159.16517-1-pvorel@suse.cz>
Message-ID: <20180523065729.axw454lgiwuypnhs@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index b0a78e14b..e675d9b2e 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -255,6 +255,8 @@ tst_get_hwaddrs()
>  # LINK: link number starting from 0. Default value is '0'.
>  tst_hwaddr()
>  {
> +	tst_check_cmds awk
> +
>  	local type="${1:-lhost}"
>  	local link_num="${2:-0}"
>  	local hwaddrs=
> @@ -269,6 +271,8 @@ tst_hwaddr()
>  # LINK: link number starting from 0. Default value is '0'.
>  tst_iface()
>  {
> +	tst_check_cmds awk
> +
>  	local type="${1:-lhost}"
>  	local link_num="${2:-0}"
>  	link_num="$(( $link_num + 1 ))"

Pushed.


Kind regards,
Petr
