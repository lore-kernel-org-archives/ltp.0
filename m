From: Li Wang <liwang@redhat.com>
Date: Fri, 13 Apr 2018 17:27:16 +0800
Subject: [LTP] [RFC PATCH] include: add two exponential backoff macros
In-Reply-To: <20180412092017.GA27415@rei>
References: <1523444204-12870-1-git-send-email-liwang@redhat.com>
 <20180412092017.GA27415@rei>
Message-ID: <CAEemH2dr+binbFFpLk+6Lr2EyTY6-55GYH5oMqZoG7ojZhWgyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

> +#define TST_RETRY_FUNC_WITH_EXPONENTIAL_BACKOFF(FUNC, ERET, MAX_DELAY) \
>
> That is quite a long name, I guess that we can shorten it a bit without
> loosing too much clarity. Something as TST_RETRY_FN_EXP_BACKOFF()
> carries all the information and is a bit shorter.
>
​
Yes, and we can also take use this directly for looping more seconds.


> > +do { int delay = 1;                                          \
>
> We should at least prefix the delay with tst_ to make sure that it will
> not alias with anything that has been passed to the FUNC, e.g. if the
> FUNC is defined as foo_func(delay); the delay variable will be aliased
> and the function will do something very unexpected.
>
​
You are right, I missed this problem.


> > +     for (;;) {                                              \
> > +             typeof(FUNC) ret = FUNC;                        \
> > +             if (ret == (typeof(FUNC))ERET)                  \
> > +                     break;                                  \
>
> Do we really need the (typeof(FUNC)) cast here?
>
​
I set the type cast to ensure more safe in comparing, but it seems no
needed.
Will remove this.


> > +             if (delay < MAX_DELAY * 1000000) {              \
> > +                     usleep(delay);                          \
> > +                     delay *= 2;                             \
>
> Maybe we can be a bit more verbose and say something as:
>
> tst_res(TINFO, #FUNC" returned %i, retrying in %ius", ret, delay);
>

Agree​.


> > +             } else {                                        \
> > +                     tst_brk_(__FILE__, __LINE__,            \
> > +                     TBROK | TERRNO, #FUNC " failed");       \
>
> As far as I can tell we can just use the plain tst_brk() in macros since
> the __LINE__ will be a constant in the whole macro and will represent
> the line where the macro is called.
>
> Also I'm not sure that adding the TERRNO here is a good idea, I suppose
> that there may be a retry functions that are not seting it on a failure.
> Maybe we can pass additional tst_res/tst_brk flags to the macro itself.
>
>
​Hmm, yes! But I don't want to add more flags to the macro since that will
make things more complicated for user. So, let's just abandon the TERRNO
to see how thing going on.
​


> > +             }                                               \
> > +     }                                                       \
> > +} while(0)
> > +
> > +/*
> > + * Exponential backoff usleep for wating a varible change
> > + * @VAR: the variable will be changed in other place
> > + * @EXP: an expected value which VAR should be equal to
> > + */
> > +#define TST_WAIT_ON_VAR(VAR, EXP)    \
> > +     TST_WAIT_WITH_EXPONENTIAL_BACKOFF(VAR, EXP, 1)
> > +
> > +#define TST_WAIT_WITH_EXPONENTIAL_BACKOFF(VAR, EXP, MAX_DELAY)       \
> > +do { int delay = 1;                                          \
>                       ^
>                       Trailing whitespace.
> > +     for (;;) {                                              \
> > +             if (VAR == (typeof(VAR)) EXP)                   \
> > +                     break;                                  \
> > +             if (delay < MAX_DELAY * 1000000) {              \
> > +                     usleep(delay);                          \
> > +                     delay *= 2;                             \
> > +             } else {                                        \
> > +                     tst_brk_(__FILE__, __LINE__,            \
> > +                     TBROK | TERRNO, #VAR " is not expected");       \
> > +             }                                               \
> > +     }                                                       \
> > +} while(0)
>
> I would refrain from adding this function unless we have a use-case
> already. Do you have a test in mind that could use this?
>

No, I don't have any test so far, this is just came to my mind
for one situation. We could re-add it if necessary next time.​



> >  #endif /* TST_COMMON_H__ */
> > --
> > 1.9.3
> >
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180413/972e83a6/attachment-0001.html>
