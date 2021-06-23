From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Jun 2021 10:10:54 +0800
Subject: [LTP] [PATCH v2 1/3] mem: child alloc memory should larger than
 memory.max + memory.swap.max if lite==1
In-Reply-To: <877dim56go.fsf@suse.de>
References: <20210622122538.402907-1-liwang@redhat.com>
 <877dim56go.fsf@suse.de>
Message-ID: <CAEemH2d-XeK48WftdyYCiLhBWTnM=8X7Dd+abCa3894123N8TQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Thanks for the review.

On Tue, Jun 22, 2021 at 10:17 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> > oom03 often gets fail while setting 'memory.swap.max = TESTMEM' in
> CGroup V2,
> > as in that scenario (lite == 1), child_alloc only start a single process
> to
> > dirty 'TESTMEM + MB' anonymous memory for testing:
> >
> > testoom(, lite == 1, ,)
> >   oom(, lite == 1, ,)
> >     child_alloc(, lite == 1,)
> >         alloc_mem(TESTMEM + MB, )
> >
> >   mem.c:224: TINFO: start normal OOM testing.
> >   mem.c:146: TINFO: expected victim is 80466.
> >   mem.c:38: TINFO: thread (7f411c69d740), allocating 1074790400 bytes.
> >   mem.c:64: TINFO: swapped is 25546752 bytes.     <------- swap occuring
> -----
> >   mem.c:164: TFAIL: victim unexpectedly ended with retcode: 0, expected:
> 12
> >
> > TBH, this can not really test the 'memory.swap.max' as expected, since
> in the
> > kernel side mem_cgroup_out_of_memory split OOM margin into two-part, one
> for
> > memory.max limit, another for memory.swap.max, if any of them get
> overflow,
> > then invoke out_of_memory to kill victim-process.
> >
> > Theoretically, alloc_mem(TESTMEM + MB, ) should work while 'memory.max'
> is equal
> > to TESTMEM, but Cgroup v2 tracks memory and swap in separate, which
> splits memory
> > and swap counter. So with swappiness enable (default value is 60 on
> RHEL), it
> > likely has part of memory swapping out during the allocating, upon that
> the two
> > limit loss effect at the same time. Unless disable swap completely then
> memory.max
> > will take effect in precisely.
> >
> > To get more opportunities to reach the swap limitation, let's scale down
> the
> > value of 'memory.swap.max' to only 1MB for CGroup v2.
> >
> > But for CGroup v1, the memory.memsw.limit_in_bytes disallow to less than
> > memory.limit_in_bytes, so we'd better raise the child_alloc to the
> > twifold
>   ^twofold
> > of TESTMEM.
>
> Ah, this means "memory.swap.x" and "memory.memsw.x" are not really the
> same thing. This seems to be common pattern, so maybe we could translate
> V2 values to V1 in the library.
>

+1
We can consider doing that in a new separate patch. And better to check
more parameters to guarantee we have the correct understanding in use it:).


> If I understand correctly `memory.swap.max = memory.memsw.limit_in_bytes
> - memory.limit_in_bytes`? Also "max" can be mapped to ~0UL or maybe
> ~0ULL when -m32 is used.
>

From the definition, yes, the memory.memsw.limit_in_bytes parameter
represents the sum of memory and swap.


>
> This is not important for the current patch.
>
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >
> > Notes:
> >     v1 --> v2
> >        * add comments for explaining why set 'memory.swap.max' to 1MB
> >        * Scale down the value of 'memory.swap.max' to only 1MB for
> CGroup v2.
> >
> >  testcases/kernel/mem/lib/mem.c   |  2 +-
> >  testcases/kernel/mem/oom/oom03.c | 17 ++++++++++++++++-
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/mem/lib/mem.c
> b/testcases/kernel/mem/lib/mem.c
> > index 9f946b5c9..ac890491c 100644
> > --- a/testcases/kernel/mem/lib/mem.c
> > +++ b/testcases/kernel/mem/lib/mem.c
> > @@ -78,7 +78,7 @@ static void child_alloc(int testcase, int lite, int
> threads)
> >       pthread_t *th;
> >
> >       if (lite) {
> > -             int ret = alloc_mem(TESTMEM + MB, testcase);
> > +             int ret = alloc_mem(TESTMEM * 2 + MB, testcase);
> >               exit(ret);
> >       }
> >
> > diff --git a/testcases/kernel/mem/oom/oom03.c
> b/testcases/kernel/mem/oom/oom03.c
> > index 939413744..89d7711a5 100644
> > --- a/testcases/kernel/mem/oom/oom03.c
> > +++ b/testcases/kernel/mem/oom/oom03.c
> > @@ -46,7 +46,22 @@ static void verify_oom(void)
> >       testoom(0, 0, ENOMEM, 1);
> >
> >       if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
> > -             SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
> > +             /*
> > +              * Cgroup v2 tracks memory and swap in separate, which
> splits
> > +              * memory and swap counter. So with swappiness enable
> (default
> > +              * value is 60 on RHEL), it likely has part of memory
> swapping
> > +              * out during the allocating, upon that the two limit loss
> > +              * effect at the same time.
> > +              *
> > +              * To get more opportunities to reach the swap limitation,
> > +              * let's scale down the value of 'memory.swap.max' to only
> > +              * 1MB for CGroup v2.
> > +              */
> > +             if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
> > +                     SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu",
> MB);
> > +             else
> > +                     SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu",
> TESTMEM);
> > +
>
> To be consistent with V2; should this be TESTMEM + MB?
>

Yes, that should be better.


> >               testoom(0, 1, ENOMEM, 1);
> >       }
> >
> > --
> > 2.31.1
>
>
> --
> Thank you,
> Richard.
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210623/087d0ef6/attachment-0001.htm>
