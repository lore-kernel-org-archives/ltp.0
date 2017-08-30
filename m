From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Aug 2017 15:39:28 +0200
Subject: [LTP] [PATCH v2 1/7] tst_atomic: Add load,
 store and use __atomic builtins
In-Reply-To: <87y3q1b5qx.fsf@our.domain.is.not.set>
References: <20170828110241.30453-1-rpalethorpe@suse.com>
 <00e8fd78-6cc0-6e5d-4055-b255fc317aa1@redhat.com>
 <87y3q1b5qx.fsf@our.domain.is.not.set>
Message-ID: <20170830133928.GA22607@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I gave this patch a go on number of old/new distros, x86_64, ppc64le
> > and s390 and I haven't ran into issues. My review is mostly only
> > comparison against kernel sources as much of inline assembly is beyond me.
> >
> > I think we could use a comment about what sort of ordering do we expect
> > from tst_atomic.h. I always assumed we care only for compiler barriers,
> > and when we use __sync_* functions, it's more for convenience (not
> > because we wanted full memory barrier).
> 
> I think that is a good idea, I will write some justification and
> explanation in the header.
> 
> In my particular use case (tst_fuzzy_sync), I need atleast an
> "acquire-release" memory barrier to ensure that some non-atomic updates
> to shared data between threads are globally visible after a given
> point. I could probably remove them and it would work on most machines
> most of the time. However if a bug does occure due to stale data, I
> think it would be extremely difficult for someone to diagnose.

When I added the atomic add functions I only cared about incrementing
the number of PASS/FAIL/ETC counters in the piece of shared memory used
for test results. So all I cared about was that the value is fetched,
incremented and written atomically.

I guess that we need more than compiler barriers then, since competing
threads may race for the increment we need the value to be coherent
across different CPU caches as well.

> > The rest of fallback functions looks good to me (at least for architectures
> > I checked). I expect fallback is used only by very small fringe of users
> > and their numbers will only go down in future.
> >
> > Regards,
> > Jan
> 
> Yes I think so, GCC has had the sync intrinsics for a long time and
> Clang. If anyone is using a compiler without these intrinsics it would
> be interesting to know about it.

Just be vary that some less common architectures got the support much
later than x86.

-- 
Cyril Hrubis
chrubis@suse.cz
