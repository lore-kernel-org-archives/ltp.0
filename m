From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 10:36:25 +0100
Subject: [LTP] [PATCH] Define SIGRTMIN and SIGRTMAX for musl
In-Reply-To: <20190219221053.458-1-rafael.tinoco@linaro.org>
References: <20190219221053.458-1-rafael.tinoco@linaro.org>
Message-ID: <20190220093625.GA2171@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Rafael,

> Although unsupported, musl enablement is always good to pursue.
> Defining __SIGRTMIN and __SIGRTMAX is needed for musl enablement.

> Signed-off-by: Daniel Diaz <daniel.diaz@linaro.org>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  include/old/test.h | 7 +++++++
Good catch, thanks :). But could you please create include/lapi/signal.h and add
it there?  (+ load <signal.h> before). And then include it in all 4 missing
places? In this case it can be used also in the future.


Kind regards,
Petr

>  1 file changed, 7 insertions(+)

> diff --git a/include/old/test.h b/include/old/test.h
> index 0738237e9..01b0bd4de 100644
> --- a/include/old/test.h
> +++ b/include/old/test.h
> @@ -50,6 +50,13 @@
>  #define NUMSIGS NSIG
>  #endif

> +#ifndef __SIGRTMIN
> +#define __SIGRTMIN 32
> +#endif
> +
> +#ifndef __SIGRTMAX
> +#define __SIGRTMAX (_NSIG - 1)
> +#endif

>  /* defines for unexpected signal setup routine (set_usig.c) */
>  #define FORK    1		/* SIGCHLD is to be ignored */
