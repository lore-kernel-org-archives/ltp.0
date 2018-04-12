From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Apr 2018 11:20:17 +0200
Subject: [LTP] [RFC PATCH] include: add two exponential backoff macros
In-Reply-To: <1523444204-12870-1-git-send-email-liwang@redhat.com>
References: <1523444204-12870-1-git-send-email-liwang@redhat.com>
Message-ID: <20180412092017.GA27415@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Exponential backoff usleep for function repeat
> + * @FUNC: the function() which will be retried
> + * @ERET: an expected return value from the FUNC
> + */
> +#define TST_RETRY_FUNC(FUNC, ERET) \
> +	TST_RETRY_FUNC_WITH_EXPONENTIAL_BACKOFF(FUNC, ERET, 1)
> +
> +#define TST_RETRY_FUNC_WITH_EXPONENTIAL_BACKOFF(FUNC, ERET, MAX_DELAY) \

That is quite a long name, I guess that we can shorten it a bit without
loosing too much clarity. Something as TST_RETRY_FN_EXP_BACKOFF()
carries all the information and is a bit shorter.

> +do {	int delay = 1;						\

We should at least prefix the delay with tst_ to make sure that it will
not alias with anything that has been passed to the FUNC, e.g. if the
FUNC is defined as foo_func(delay); the delay variable will be aliased
and the function will do something very unexpected.

> +	for (;;) {						\
> +		typeof(FUNC) ret = FUNC;			\
> +		if (ret == (typeof(FUNC))ERET)			\
> +			break;					\

Do we really need the (typeof(FUNC)) cast here?

> +		if (delay < MAX_DELAY * 1000000) {		\
> +			usleep(delay);				\
> +			delay *= 2;				\

Maybe we can be a bit more verbose and say something as:

tst_res(TINFO, #FUNC" returned %i, retrying in %ius", ret, delay);

> +		} else {					\
> +			tst_brk_(__FILE__, __LINE__,		\
> +			TBROK | TERRNO, #FUNC " failed");	\

As far as I can tell we can just use the plain tst_brk() in macros since
the __LINE__ will be a constant in the whole macro and will represent
the line where the macro is called.

Also I'm not sure that adding the TERRNO here is a good idea, I suppose
that there may be a retry functions that are not seting it on a failure.
Maybe we can pass additional tst_res/tst_brk flags to the macro itself.

> +		}						\
> +	}							\
> +} while(0)
> +
> +/*
> + * Exponential backoff usleep for wating a varible change
> + * @VAR: the variable will be changed in other place
> + * @EXP: an expected value which VAR should be equal to
> + */
> +#define TST_WAIT_ON_VAR(VAR, EXP)	\
> +	TST_WAIT_WITH_EXPONENTIAL_BACKOFF(VAR, EXP, 1)
> +
> +#define TST_WAIT_WITH_EXPONENTIAL_BACKOFF(VAR, EXP, MAX_DELAY)	\
> +do {	int delay = 1; 						\
                      ^
		      Trailing whitespace.
> +	for (;;) {						\
> +		if (VAR == (typeof(VAR)) EXP)			\
> +			break;					\
> +		if (delay < MAX_DELAY * 1000000) {		\
> +			usleep(delay);				\
> +			delay *= 2;				\
> +		} else {					\
> +			tst_brk_(__FILE__, __LINE__,		\
> +			TBROK | TERRNO, #VAR " is not expected");	\
> +		}						\
> +	}							\
> +} while(0)

I would refrain from adding this function unless we have a use-case
already. Do you have a test in mind that could use this?

>  #endif /* TST_COMMON_H__ */
> -- 
> 1.9.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz
