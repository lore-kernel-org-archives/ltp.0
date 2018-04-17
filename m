From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Apr 2018 11:05:04 +0800
Subject: [LTP] [PATCH v2] include: add an exponential backoff macro for
	function repeat
In-Reply-To: <87efjfxqqg.fsf@rpws.prws.suse.cz>
References: <20180413111956.15837-1-liwang@redhat.com>
 <87efjfxqqg.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2dLhAbxr-SNpa162YUkcYN9MLK8t_zUq9450ZZkBKAN-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:

How about:
>
> /**
>  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
>  * @FUNC - The function which will be retried
>  * @ERET - The value returned from @FUNC on success
>  *
>  * This macro will call @FUNC in a loop with a delay between retries. If
> @FUNC
>  * returns @ERET then the loop exits. The delay between retries starts at
> one
>  * micro second and is then doubled each iteration until it exceeds one
> second
>  * (the total time sleeping will be aproximately one second as well). When
> the
>  * delay exceeds one second tst_brk() is called.
>  */
>
​
I like this description.
​

>
> > + * @FUNC: the function which will be retried
> > + * @ERET: an expected return value from the FUNC
> > + */
> > +#define TST_RETRY_FUNC(FUNC, ERET) \
> > +     TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, 1)
> > +
> > +#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)      \
> > +do { int tst_delay = 1;                                      \
> > +     for (;;) {                                              \
> > +             typeof(FUNC) ret = FUNC;                        \
> > +             if (ret == ERET)                                \
> > +                     break;                                  \
>
> Maybe it should return ret somehow?
>

​Maybe yes!

And, if we do that, the macro should probably be rewritten ​as:

​#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)    \
({    int tst_delay = 1;                    \
    for (;;) {                        \
        typeof(FUNC) ret = FUNC;            \
        if (ret == ERET)                \
            break;                    \
        if (tst_delay < MAX_DELAY * 1000000) {        \
            tst_res(TINFO,                \
                #FUNC" returned %i, retrying"    \
                " in %ius", ret, tst_delay);    \
            usleep(tst_delay);            \
            tst_delay *= 2;                \
        } else {                    \
            tst_brk(TBROK, #FUNC" failed");        \
        }                        \
    }                            \
    ERET;                            \
})
​



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180417/29a46f38/attachment-0001.html>
