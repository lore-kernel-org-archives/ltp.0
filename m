From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jul 2019 11:15:19 +0200
Subject: [LTP] [PATCH 2/2] c: Use $LTP_TIMEOUT_MUL also in retry
 functions
In-Reply-To: <CAEemH2e6PmPYWWQg+NgSR=6Qc4BZpEswbcc4Y+n3B_pFqnQJDQ@mail.gmail.com>
References: <20190718083943.7687-1-pvorel@suse.cz>
 <20190718083943.7687-2-pvorel@suse.cz>
 <CAEemH2e6PmPYWWQg+NgSR=6Qc4BZpEswbcc4Y+n3B_pFqnQJDQ@mail.gmail.com>
Message-ID: <20190719091519.GC30204@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

thanks for your review!

> On Thu, Jul 18, 2019 at 4:40 PM Petr Vorel <pvorel@suse.cz> wrote:
> >...
> >  #ifndef TST_COMMON_H__
> > @@ -51,15 +40,22 @@

> >  #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)        \
> >  ({     int tst_delay_ = 1;                                             \
> > +       float m = 1;    \
> > +       char *mul = getenv("LTP_TIMEOUT_MUL");  \

> We also need a prefix/suffix in the variable definition to make sure
> that it will
> not alias with anything that has been passed to the FUNC, just like what we do
> for the tst_delay_.

> e.g. if the FUNC is defined as foo_func(m); the m variable will be aliased and
> the function will do something very unexpected.
Good point, I'll fix it in v3.

> > +       if (mul) {      \
> > +               m = atof(mul); \
> > +               if (m < 1) \
> > +                       tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul); \

> If we reverse some code order in tst_set_timeout() function, then here
> we have no need to check if m < 1 again, since the LTP_TIMEOUT_MUL
> valid check will be finished in setup() early phase.
> (This comment is just FYI, and I also think it's OK to check twice.)
Good point. I'd probably check twice in case the logic changes one day.

> --------------------------------------
> void tst_set_timeout(int timeout)
> {
>         float m = 1;
>         char *mul = getenv("LTP_TIMEOUT_MUL");

>         if (mul) {
>                 m = atof(mul);
>                 if (m < 1)
>                         tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
>         }

>         if (timeout == -1) {
>                 tst_res(TINFO, "Timeout per run is disabled");
>                 return;
>         }

>         results->timeout = timeout * m + 0.5;

>         tst_res(TINFO, "Timeout per run is %uh %02um %02us",
>                 results->timeout/3600, (results->timeout%3600)/60,
>                 results->timeout % 60);

>         if (getpid() == lib_pid)
>                 alarm(results->timeout);
>         else
>                 heartbeat();
> }


Kind regards,
Petr
