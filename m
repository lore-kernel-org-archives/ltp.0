From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Dec 2020 11:21:24 +0800
Subject: [LTP] [PATCH 1/2] libnewipc: Add get_ipc_timestamp()
In-Reply-To: <20201203152804.846-2-chrubis@suse.cz>
References: <20201203152804.846-1-chrubis@suse.cz>
 <20201203152804.846-2-chrubis@suse.cz>
Message-ID: <CAEemH2dY2ZJhJ6iqA7mUDSyPO5t+i06rC4iZ6HJhs33DxXM74Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Thu, Dec 3, 2020 at 11:27 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> That returns timestamps that should return values comparable to the
> stime/rtime/ctime.
>
> From Thomas Gleixner:
>
> > Due to the internal implementation of ktime_get_real_seconds(), which is
> > a 2038 safe replacement for the former get_seconds() function, this
> > accumulation issue can be observed. (time(2) via syscall and newer
> > versions of VDSO use the same mechanism).
> >
> >      clock_gettime(CLOCK_REALTIME, &ts);
> >      sec = time();
> >      assert(sec >= ts.tv_sec);
> >
> > That assert can trigger for two reasons:
> >
> >  1) Clock was set between the clock_gettime() and time().
> >
> >  2) The clock has advanced far enough that:
> >
> >     timekeeper.tv_nsec + (clock_now_ns() - last_update_ns) > NSEC_PER_SEC
> > The same problem exists for CLOCK_XXX vs. CLOCK_XXX_COARSE
> >
> >      clock_gettime(CLOCK_XXX, &ts);
> >      clock_gettime(CLOCK_XXX_COARSE, &tc);
> >      assert(tc.tv_sec >= ts.tv_sec);
> >
> > The _COARSE variants return their associated timekeeper.tv_sec,tv_nsec
> > pair without reading the clock. Same as #2 above just extended to clock
> > MONOTONIC.
>
> Which means the timestamps in the structure we get from msg* calls can
> be 1 second smaller that timestamps returned from realtime timers.
>
> However it also means that the _COARSE timers should be the same as the
> SysV timestamps and could be used for these tests instead. Also these
> timers should be available since 2.6.32 which is old enough to assume
> that they are present.
>

Sounds reasonable. From Thomas's analysis, it seems the *_COARSE
can work for us, so I'm OK to go with this way to fix.

For series:
Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201204/2ce56e3c/attachment.htm>
