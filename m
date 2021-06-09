From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed, 9 Jun 2021 11:22:09 -0300
Subject: [LTP] [PATCH] futex_wake04: avoid tst_ts_from_ns overflow on
 32-bit platforms
In-Reply-To: <YMDEPYSWZG5FzUTi@yuki>
References: <20210608132723.255996-1-cascardo@canonical.com>
 <YMB6aoVvTKJQ6wif@yuki> <YMCkB/iS54OJaby4@mussarela>
 <YMDEPYSWZG5FzUTi@yuki>
Message-ID: <YMDOkVaCIWEA6Etl@mussarela>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 09, 2021 at 03:38:05PM +0200, Cyril Hrubis wrote:
> Hi!
> > > Good catch, I guess that it would be slightly cleaner to fix the
> > > NSEC_PER_SEC size instead with:
> > > 
> > > diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
> > > index b783beff4..e50f698d6 100644
> > > --- a/include/lapi/common_timers.h
> > > +++ b/include/lapi/common_timers.h
> > > @@ -12,7 +12,7 @@
> > >  #include "lapi/posix_clocks.h"
> > > 
> > >  #ifndef NSEC_PER_SEC
> > > -#define NSEC_PER_SEC (1000000000L)
> > > +#define NSEC_PER_SEC (1000000000LL)
> > >  #endif
> > > 
> > >  static const clock_t clock_list[] = {
> > > 
> > > 
> > > What do you think?
> > > 
> > > -- 
> > > Cyril Hrubis
> > > chrubis@suse.cz
> > 
> > Yeah, I even wrote and tested that it would build, but I wasn't able to go
> > through any build logs or run complete tests.
> > 
> > But maybe I am just overthinking this, and any promotions due to this would
> > only fix issues and not introduce any new ones.
> 
> That would be my expectation.
> 
> > Well, on second thought, on 32-bit, in cases like variadic functions, it could
> > cause a problem. So, I am just afraid that applying this fix without looking
> > for every use of NSEC_PER_SEC might lead to new bugs.
> 
> Having a look at 'git grep NSEC_PER_SEC' there are five uses of
> NSEC_PER_SEC and all of these should be, as far as I can tell, safe.
> 

Yes, there are even uses where NSEC_PER_SEC is redefined.

I am fine with this other change. I had already tested that it fixes the
problem just the same.

How about the commit below?

Cascardo.

> -- 
> Cyril Hrubis
> chrubis@suse.cz

From 3c248cd5e6fc1dd967787249857fd310e688d89f Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue, 8 Jun 2021 10:21:48 -0300
Subject: [PATCH] common_timers: define NSEC_PER_SEC as long long to avoid
 overflow on 32-bit

When multiplying 30 with NSEC_PER_SEC, the result would overflow on 32-bit
platforms, unless there was promotion to long long, which is what
tst_ts_from_ns expects.

futex_wake04, which uses that, would end up getting EINVAL when calling futex,
because timespec_valid would fail, as tv_nsec would have an invalid value.

After this change, futex_wake04 passes on i386.

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 include/lapi/common_timers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index 8da3abec24b2..953741d73810 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -12,7 +12,7 @@
 #include "lapi/posix_clocks.h"
 
 #ifndef NSEC_PER_SEC
-#define NSEC_PER_SEC (1000000000L)
+#define NSEC_PER_SEC (1000000000LL)
 #endif
 
 static const clock_t clock_list[] = {
-- 
2.30.2

