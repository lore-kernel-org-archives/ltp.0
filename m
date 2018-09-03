From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Sep 2018 12:33:47 +0200
Subject: [LTP] [PATCH] runltp: change the default cmdfile to exec when
 exec runltp -N
In-Reply-To: <1536022690-17612-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1536022690-17612-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180903103347.GA29129@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sun,


> From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>

> when exec "runltp -N" and no command files were provided, the 
> command file of "$LTPROOT/scenario_groups/network" should execute,
> not the "$LTPROOT/scenario_groups/default".

> Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
> ---
>  runltp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/runltp b/runltp
> index 24ea94fe5..1810c9384 100755
> --- a/runltp
> +++ b/runltp
> @@ -609,7 +609,7 @@ main()

>  	SCENARIO_LISTS="$LTPROOT/scenario_groups/default"
>          if [ "$RUN_NETEST" -eq 1 ]; then
> -            SCENARIO_LISTS="$SCENARIO_LISTS $LTPROOT/scenario_groups/network"
> +            SCENARIO_LISTS="$LTPROOT/scenario_groups/network"
>          fi

>      # DO NOT INDENT/DEDENT!

Applied, thanks!

Using network.sh is the preferred way for running networking tests.
FYI runltp is somehow broken, we have long term goal to replace it with some
modern tool.


Kind regards,
Petr
