From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Jun 2021 10:22:47 +0200
Subject: [LTP] [PATCH 2/2] network/busy_poll: Remove unnecessary driver
 check
In-Reply-To: <20210531135314.5067-2-mdoucha@suse.cz>
References: <20210531135314.5067-1-mdoucha@suse.cz>
 <20210531135314.5067-2-mdoucha@suse.cz>
Message-ID: <YLXuV//RKGTO2Ics@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Kernel v4.5 extended the busy_poll functionality to all network drivers.
> Limiting the test only to drivers which implemented busy_poll as internal
> feature on older kernels does not make sense.

Ah, you mean 85c72ba1ed0c ("Merge branch 'net-generic-busy-polling'")
Good catch, thx!!

Fixes: ead28f929 ("busy_poll: skip busy_poll flag test on kernels 4.5+")

Kind regards,
Petr

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/network/busy_poll/busy_poll_lib.sh | 4 ----
>  1 file changed, 4 deletions(-)

> diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
> index 5270a1bbd..d17504466 100755
> --- a/testcases/network/busy_poll/busy_poll_lib.sh
> +++ b/testcases/network/busy_poll/busy_poll_lib.sh
> @@ -25,9 +25,5 @@ busy_poll_check_config()
>  		ethtool --show-features $(tst_iface) | \
>  			grep -q 'busy-poll.*on' || \
>  			tst_brk TCONF "busy poll not supported by driver"
> -	else
> -		drvs="bnx2x|bnxt|cxgb4|enic|benet|ixgbe|ixgbevf|mlx4|mlx5|myri10ge|sfc|virtio"
> -		ethtool -i $(tst_iface) | grep -qE "driver: ($drvs)" || \
> -			tst_brk TCONF "busy poll not supported"
>  	fi
>  }
