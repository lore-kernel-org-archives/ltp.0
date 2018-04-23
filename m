From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Apr 2018 11:58:55 +0200
Subject: [LTP] [PATCH v3 1/2] include: add an exponential backoff macro
 for function repeat
In-Reply-To: <20180421021600.17549-1-liwang@redhat.com>
References: <20180421021600.17549-1-liwang@redhat.com>
Message-ID: <20180423095855.GA24481@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)	\
> +({	int tst_delay = 1;					\
> +	for (;;) {						\
> +		typeof(FUNC) ret = FUNC;			\
                              ^
		I prefixed this variable with tst_ and even added _
		suffix to make sure that it will not alias either.

> +		if (ret == ERET)				\
> +			break;					\
> +		if (tst_delay < MAX_DELAY * 1000000) {		\
> +			tst_res(TINFO,				\
> +				#FUNC" returned %i, retrying"	\
> +				" in %ius", ret, tst_delay);	\
> +			usleep(tst_delay);			\
> +			tst_delay *= 2;				\
> +		} else {					\
> +			tst_brk(TBROK, #FUNC" failed");		\
> +		}						\
> +	}							\
> +	ERET;							\
> +})

And pushed, thanks.

I know that the documentation is there in the comment but we should
probably add a note about the macro into the test-writing-guidelines.txt
as well...

-- 
Cyril Hrubis
chrubis@suse.cz
