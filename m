From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jul 2019 11:33:11 +0200
Subject: [LTP] [PATCH v2] syscalls/mbind0{2,3,4}: Add basic mbind tests
In-Reply-To: <CAEemH2dapin31=WrPsA97wgX=2d5rzQy8+D7LVta6nr6BwFN5A@mail.gmail.com>
References: <20190722150316.27395-1-chrubis@suse.cz>
 <CAEemH2dapin31=WrPsA97wgX=2d5rzQy8+D7LVta6nr6BwFN5A@mail.gmail.com>
Message-ID: <20190723093310.GA22630@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > ...
> >  create mode 100644 testcases/kernel/syscalls/mbind/mbind.h
> >  create mode 100644 testcases/kernel/syscalls/mbind/mbind02.c
> >  create mode 100644 testcases/kernel/syscalls/mbind/mbind03.c
> >  create mode 100644 testcases/kernel/syscalls/mbind/mbind04.c
> 
> Ad Petr commented in the patch V1, Makefile needs updating after
> adding libltpnuma, otherwise, these test cases won't build
> successfully.
> 
> LDFLAGS += -L$(top_builddir)/libs/libltpnuma
> LDLIBS  += $(NUMA_LIBS) -lltpnuma

My bad, I had outdated LTP tree on my NUMA machine, will fix.

> > diff --git a/testcases/kernel/syscalls/mbind/mbind02.c
> > b/testcases/kernel/syscalls/mbind/mbind02.c
> > ...
> > +       TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, MPOL_MF_STRICT));
> > +
> > +       if (TST_RET) {
> 
> I think we'd better check if the TST_RET is EIO before getting TPASS?
> Otherwise, it will miss the failure with any other errno.
> 
> if (TST_ERR == EIO) {
>         tst_res(TPASS | TTERRNO,
>                         "mbind(%s, MPOL_MF_STRICT) node %u",
>                          tst_numa_mode_name(mode), node);
> } else {
>          tst_res(TFAIL | TTERRNO, "mbind(%s, MPOL_MF_STRICT) node %u
> failed unexpcted",
>                          tst_numa_mode_name(mode), node);
> }

Of course, thanks for catching that.

> > +               tst_res(TPASS | TTERRNO,
> > +                       "mbind(%s, MPOL_MF_STRICT) node %u",
> > +                       tst_numa_mode_name(mode), node);
> > +       } else {
> > +               tst_res(TFAIL, "mbind(%s, MPOL_MF_STRICT) node %u succeded",
> > +                       tst_numa_mode_name(mode), node);
> > +       }
> > +
> > +       tst_numa_unmap(ptr, size);
> > +       numa_free_nodemask(bm);
> > +}
> > +
> > +static void verify_mbind(unsigned int n)
> > +{
> > +       int mode = n ? MPOL_PREFERRED : MPOL_BIND;
> 
> Why not test MPOL_INTERLEAVE for mbind02? I guess it also makes sense
> to add here.

Good catch, we have a bitmask with a single node, so I guess that this
would work as well. Have you tested it?

> > +       .forks_child = 1,
> 
> .forks_child is redundant?

Sure.

> > diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
> > new file mode 100644
> > index 000000000..f0622b07f
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/mbind/mbind03.c
> > ...
> > +
> > +void verify_mbind(unsigned int n)
> > +{
> > +       int mode = n ? MPOL_PREFERRED : MPOL_BIND;
> 
> Adding MPOL_INTERLEAVE?

Here as well, I guess that it should work fine.

> > +       .forks_child = 1,
> 
> remove .forks_child.
> 
> > diff --git a/testcases/kernel/syscalls/mbind/mbind04.c
> > +++ b/testcases/kernel/syscalls/mbind/mbind04.c
> > ...
> > +
> > +static void verify_policy(unsigned int node, int mode, unsigned flag)
> > +{
> > +       struct bitmask *bm = numa_allocate_nodemask();
> > +       unsigned int i;
> > +       void *ptr;
> > +       unsigned long size = PAGES_ALLOCATED * page_size;
> > +
> > +       numa_bitmask_setbit(bm, node);
> > +
> > +       ptr = tst_numa_map(NULL, size);
> > +
> > +       TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, flag));
> > +
> > +       if (TST_RET) {
> > +               tst_res(TFAIL | TTERRNO,
> > +                       "mbind(%s, %s) node %u",
> > +                       tst_numa_mode_name(mode), mbind_flag_name(flag), node);
> 
> Do numa_free_nodemask(bm) before return?

Will move the numa_free_nodemask(bm) before the if.

> > +static void verify_mbind(unsigned int n)
> > +{
> > +       unsigned int i;
> > +       int mode = n ? MPOL_PREFERRED : MPOL_BIND;
> > +
> > +       for (i = 0; i < nodes->cnt; i++) {
> 
> I remember there are some ppc64le which have non-continuous numa nodes
> in hardware configuration. I'm not sure if that special config will
> break the mbind04 test, will update details to you after I run this
> test on such a system.

The LTP NUMA library should handle that, the nodes->cnt is the
lenght of the NUMA map and the actual node ids are in the nodes->map[]
array.

-- 
Cyril Hrubis
chrubis@suse.cz
