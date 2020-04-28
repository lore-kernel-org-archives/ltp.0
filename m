From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 28 Apr 2020 10:31:35 +0530
Subject: [LTP] [PATCH 1/4] syscalls/timer_gettime: Add support for
 time64 tests
In-Reply-To: <20200427145212.GA5678@dell5510>
References: <41a72155effacaf3b58e6e50bfadddbd4dca188b.1587987802.git.viresh.kumar@linaro.org>
 <20200427145212.GA5678@dell5510>
Message-ID: <20200428050135.x2xggdaxe3yhmjq2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27-04-20, 16:52, Petr Vorel wrote:
> Hi Viresh,
> 
> > This adds support for time64 tests to the existing timer_gettime()
> > syscall tests.
> 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/tst_timer.h                           |  40 +++++++
> >  .../syscalls/timer_gettime/timer_gettime01.c  | 112 +++++++++---------
> >  2 files changed, 98 insertions(+), 54 deletions(-)
> 
> > diff --git a/include/tst_timer.h b/include/tst_timer.h
> > index 256e1d71e1bc..601f934da670 100644
> > --- a/include/tst_timer.h
> > +++ b/include/tst_timer.h
> > @@ -15,6 +15,7 @@
> >  #include <sys/time.h>
> >  #include <time.h>
> >  #include "tst_test.h"
> > +#include "lapi/common_timers.h"
> 
> Thanks for your patch. Unfortunately, the build got broken by this commit, I
> suspect this must be changed
> https://travis-ci.org/github/pevik/ltp/builds/680061434

I have sent a patch to fix this and that patch should be applied
before this series.

I didn't get this build error until the time I did a make clean,
followed by a fresh build. And so never caught this :(

-- 
viresh
