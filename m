From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 8 Apr 2018 22:47:27 +0200
Subject: [LTP] [RFC PATCH v6 3/7] network.sh: Migrate to new shell API
In-Reply-To: <20180406123118.21309-4-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <20180406123118.21309-4-pvorel@suse.cz>
Message-ID: <20180408204727.c4up5zsf5jho2dyv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testscripts/network.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testscripts/network.sh b/testscripts/network.sh
> index cc2b2de72..b18f202d5 100755
> --- a/testscripts/network.sh
> +++ b/testscripts/network.sh
> @@ -89,7 +89,7 @@ shift $(($OPTIND - 1))
>  TST_TOTAL=1
>  TCID="network_settings"

> -TST_USE_LEGACY_API=1
> +TST_NO_DEFAULT_RUN=1
>  . tst_net.sh

>  # Reset variables.

Here I need to reset TST_NO_DEFAULT_RUN:
-unset TCID TST_LIB_LOADED TST_USE_LEGACY_API
+unset TCID TST_LIB_LOADED TST_NO_DEFAULT_RUN


Kind regards,
Petr
