From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 Jul 2017 14:36:18 +0200
Subject: [LTP] [PATCH] tst_timer.h: Cosmetic fix
In-Reply-To: <20170726032953.23646-1-fenggw-fnst@cn.fujitsu.com>
References: <20170726032953.23646-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170726123618.7wqtaqe2bzvynnli@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  /*
>   * Converts ms to struct timespec
>   */
> -static inline struct timespec tst_ms_to_timespec(long long us)
> +static inline struct timespec tst_ms_to_timespec(long long ms)
>  {
>  	struct timespec ret;

> -	ret.tv_sec = us / 1000;
> -	ret.tv_nsec = (us % 1000) * 1000000;
> +	ret.tv_sec = ms / 1000;
> +	ret.tv_nsec = (ms % 1000) * 1000000;

Oh yes, us was a bit confusing :-).


Kind regards,
Petr
