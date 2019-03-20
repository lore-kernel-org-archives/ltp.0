From: Enji Cooper (yaneurabeya) <yaneurabeya@gmail.com>
Date: Wed, 20 Mar 2019 12:38:45 -0700
Subject: [LTP] [PATCH] lib: Add include guard to tst_safe_clocks.h
In-Reply-To: <20190320193718.2320-1-rafael.tinoco@linaro.org>
References: <20190320193718.2320-1-rafael.tinoco@linaro.org>
Message-ID: <BF5C9C51-760B-4DD7-B616-EB9146C200BE@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Mar 20, 2019, at 12:37, Rafael David Tinoco <rafael.tinoco@linaro.org> wrote:
> 
> When adding a common header to my tests I missed this include guard when
> accidentally including tst_safe_clocks.h from .c and .h files. Since
> other tst_safe_*.h files have guards I thought it would be good to add
> to this one as well.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
> include/tst_safe_clocks.h | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
> index a952be4bf..0f642148e 100644
> --- a/include/tst_safe_clocks.h
> +++ b/include/tst_safe_clocks.h
> @@ -5,6 +5,9 @@
>  * Email : code@zilogic.com
>  */
> 
> +#ifndef TST_SAFE_CLOCK_H__
> +#define TST_SAFE_CLOCK_H__
> +
> #include <time.h>
> #include <sys/timex.h>
> #include "tst_test.h"
> @@ -69,3 +72,5 @@ static inline void safe_clock_adjtime(const char *file, const int lineno,
> 
> #define SAFE_CLOCK_ADJTIME(clk_id, txc)\
> 	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
> +
> +#endif /* SAFE_CLOCK_H__ */
> -- 
> 2.20.1


Ack.

Reviewed-by: Enji Cooper <yaneurabeya@gmail.com <mailto:yaneurabeya@gmail.com>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190320/9f805ecc/attachment-0001.html>
