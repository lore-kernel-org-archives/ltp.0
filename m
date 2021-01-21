From: Leo Liang <ycliang@andestech.com>
Date: Thu, 21 Jan 2021 10:19:23 +0800
Subject: [LTP] [PATCH 1/1] fzsync: Add sched_yield for single core
 machine
In-Reply-To: <87sg6w9bdd.fsf@suse.de>
References: <20210120070053.11490-1-ycliang@andestech.com>
 <87sg6w9bdd.fsf@suse.de>
Message-ID: <20210121021923.GA2366@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 20, 2021 at 06:00:14PM +0800, Richard Palethorpe wrote:
> Hello Leo,
> 
> Leo Yu-Chi Liang <ycliang@andestech.com> writes:
> 
> > Fuzzy sync library uses spin waiting mechanism
> > to implement thread barrier behavior, which would
> > cause this test to be time-consuming on single core machine.
> >
> > Fix this by adding sched_yield in the spin waiting loop,
> > so that the thread yields cpu as soon as it enters the waiting loop.
> 
> Thanks for sending this in. Comments below.
> 
> >
> > Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > ---
> >  include/tst_fuzzy_sync.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> > index 4141f5c64..64d172681 100644
> > --- a/include/tst_fuzzy_sync.h
> > +++ b/include/tst_fuzzy_sync.h
> > @@ -59,9 +59,11 @@
> >   * @sa tst_fzsync_pair
> >   */
> >  
> > +#include <sys/sysinfo.h>
> >  #include <sys/time.h>
> >  #include <time.h>
> >  #include <math.h>
> > +#include <sched.h>
> >  #include <stdlib.h>
> >  #include <pthread.h>
> >  #include "tst_atomic.h"
> > @@ -564,6 +566,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
> >  		       && tst_atomic_load(our_cntr) < INT_MAX) {
> >  			if (spins)
> >  				(*spins)++;
> > +			if(get_nprocs() == 1)
> 
> We should use tst_ncpus() and then cache the value so we are not making
> a function call within the loop. It is probably best to avoid calling
> this function inside tst_fzsync_pair_wait, it may even result in a
> system call.
> 
> We should probably cache the value in tst_fzsync_pair, maybe as a
> boolean e.g. "yield_in_wait". This can be set/checked in the
> tst_fzsync_pair_init function. Also this will allow the user to handle
> CPUs being offlined if the test itself can cause that.
> 

Got it! Thanks for reviewing the patch and all the heads-ups!
I will refine it and send a v2.

> > +				sched_yield();
> >  		}
> >  
> >  		tst_atomic_store(0, other_cntr);
> > @@ -581,6 +585,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
> >  		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
> >  			if (spins)
> >  				(*spins)++;
> > +			if(get_nprocs() == 1)
> > +				sched_yield();
> >  		}
> >  	}
> >  }
> 
> Everyone please note that we will have to test this extensively to
> ensure it does break existing reproducers.
>

Got it as well, will try to reproduce the cve with this patch applied.

Thanks again,
Leo

> Alternatively to this approach we could create seperate implementations
> of pair_wait and use a function pointer. I am thinking it may be best to
> do it both ways and perform some measurements.
>
> -- 
> Thank you,
> Richard.
