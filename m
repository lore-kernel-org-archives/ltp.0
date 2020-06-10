From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 10 Jun 2020 08:56:46 +0530
Subject: [LTP] [PATCH V4 01/17] syscalls/timer_gettime: Add support for
 time64 tests
In-Reply-To: <CAEemH2eLNKKCdVvNFRFdU2-PDsXLZZmrh1gLH6bgMMFbrXi_Lg@mail.gmail.com>
References: <cover.1590144577.git.viresh.kumar@linaro.org>
 <a4a628a637a6eeeed4249656836bd217f5cbb9ac.1590144577.git.viresh.kumar@linaro.org>
 <CAEemH2eLNKKCdVvNFRFdU2-PDsXLZZmrh1gLH6bgMMFbrXi_Lg@mail.gmail.com>
Message-ID: <20200610032646.aucl5k7s7ssaqqpd@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09-06-20, 20:32, Li Wang wrote:
> On Fri, May 22, 2020 at 6:52 PM Viresh Kumar <viresh.kumar@linaro.org>
> wrote:
> 
> > This adds support for time64 tests to the existing timer_gettime()
> > syscall tests.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/tst_timer.h                           |  45 +++++++
> >  .../syscalls/timer_gettime/timer_gettime01.c  | 124 ++++++++----------
> >  2 files changed, 97 insertions(+), 72 deletions(-)
> >
> > diff --git a/include/tst_timer.h b/include/tst_timer.h
> > index 256e1d71e1bc..d9afbe0ece71 100644
> > --- a/include/tst_timer.h
> > +++ b/include/tst_timer.h
> > @@ -15,6 +15,7 @@
> >  #include <sys/time.h>
> >  #include <time.h>
> >  #include "tst_test.h"
> > +#include "lapi/common_timers.h"
> >  #include "lapi/syscalls.h"
> >
> >  /*
> > @@ -112,6 +113,16 @@ struct __kernel_timespec {
> >         __kernel_time64_t       tv_sec;                 /* seconds */
> >         long long               tv_nsec;                /* nanoseconds */
> >  };
> > +
> > +struct __kernel_old_itimerspec {
> > +       struct __kernel_old_timespec it_interval;    /* timer period */
> > +       struct __kernel_old_timespec it_value;       /* timer expiration */
> > +};
> > +
> > +struct __kernel_itimerspec {
> > +       struct __kernel_timespec it_interval;    /* timer period */
> > +       struct __kernel_timespec it_value;       /* timer expiration */
> > +};
> >  #endif
> >
> >  enum tst_ts_type {
> > @@ -129,6 +140,14 @@ struct tst_ts {
> >         } ts;
> >  };
> >
> > +struct tst_its {
> > +       enum tst_ts_type type;
> > +       union {
> > +               struct __kernel_itimerspec kern_old_its;
> >
> 
> I guess this line should be used 'struct __kernel_old_itimerspec', right?

Thanks for spotting this.

-- 
viresh
