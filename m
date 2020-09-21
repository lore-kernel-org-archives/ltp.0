From: Bird, Tim <Tim.Bird@sony.com>
Date: Mon, 21 Sep 2020 17:56:04 +0000
Subject: [LTP] [PATCH 2/2] runtest/quickhit: Remove
In-Reply-To: <20200921114026.11184-2-chrubis@suse.cz>
References: <20200921114026.11184-1-chrubis@suse.cz>
 <20200921114026.11184-2-chrubis@suse.cz>
Message-ID: <CY4PR13MB1175AC20849F3C4AD8AB9C78FD3A0@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -----Original Message-----
> From: Cyril Hrubis <chrubis@suse.cz>
> 
> The file wasn't properly maintained for last ten years, 99% of the
> patches touching it were only removing removed tests. We should stop
> pretending that it's useful anyhow it clearly does not contain well
> selected set of tests for quick testrun anymore.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: "Bird, Tim" <Tim.Bird@sony.com>
> CC: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/quickhit | 316 -----------------------------------------------
>  1 file changed, 316 deletions(-)
>  delete mode 100644 runtest/quickhit

Reviewed-by: Tim Bird <tim.bird@sony.com>

Thanks for holding off on this until we got the smoketest replacement.
I'm fine with this now!
 -- Tim

