From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Apr 2018 18:53:24 +0800
Subject: [LTP] [PATCH v3 1/2] include: add an exponential backoff macro
 for function repeat
In-Reply-To: <20180423095855.GA24481@rei>
References: <20180421021600.17549-1-liwang@redhat.com>
 <20180423095855.GA24481@rei>
Message-ID: <20180423105324.GA13013@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis wrote:

> hi!
> > +#define tst_retry_fn_exp_backoff(func, eret, max_delay)	\
> > +({	int tst_delay = 1;					\
> > +	for (;;) {						\
> > +		typeof(FUNC) ret = FUNC;			\
>                               ^
> 		I prefixed this variable with tst_ and even added _
> 		suffix to make sure that it will not alias either.

Good catch.

> 
> > +		if (ret == ERET)				\
> > +			break;					\
> > +		if (tst_delay < MAX_DELAY * 1000000) {		\
> > +			tst_res(TINFO,				\
> > +				#FUNC" returned %i, retrying"	\
> > +				" in %ius", ret, tst_delay);	\
> > +			usleep(tst_delay);			\
> > +			tst_delay *= 2;				\
> > +		} else {					\
> > +			tst_brk(TBROK, #FUNC" failed");		\
> > +		}						\
> > +	}							\
> > +	ERET;							\
> > +})
> 
> And pushed, thanks.
> 
> I know that the documentation is there in the comment but we should
> probably add a note about the macro into the test-writing-guidelines.txt
> as well...

Yes, we should. I will do that when I'm free. Thanks for reviewing.

Li Wang
