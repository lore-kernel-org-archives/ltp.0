From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Sep 2018 00:18:44 +0200
Subject: [LTP] [PATCH v2 1/4] tst_timer: Add nano second conversions
In-Reply-To: <20180910084442.17720-2-rpalethorpe@suse.com>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-2-rpalethorpe@suse.com>
Message-ID: <20180910221843.GA28616@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

It'd be nice to add doc into doc/test-writing-guidelines.txt.
(I know the docs isn't complete, at least tst_timeval_diff_ms() is not
mentioned.

> ---
>  include/tst_timer.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index 0fd7ed6cf..577bc88ef 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -34,6 +34,11 @@
>  #include <sys/time.h>
>  #include <time.h>

> +static inline long long tst_timespec_to_ns(struct timespec t)
> +{
> +	return t.tv_sec * 1000000000 + t.tv_nsec;
> +}
> +
>  /*
>   * Converts timespec to microseconds.
>   */
> @@ -166,6 +171,12 @@ static inline struct timespec tst_timespec_diff(struct timespec t1,
>  	return res;
>  }

> +static inline long long tst_timespec_diff_ns(struct timespec t1,
> +					     struct timespec t2)
> +{
> +	return t1.tv_nsec - t2.tv_nsec + 1000000000LL * (t1.tv_sec - t2.tv_sec);
I guess this can be just 1000000000 (nitpicking).

> +}
> +
>  static inline long long tst_timespec_diff_us(struct timespec t1,
>                                               struct timespec t2)
>  {


Kind regards,
Petr
