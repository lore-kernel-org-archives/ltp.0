From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jul 2019 15:41:27 +0800
Subject: [LTP] [PATCH v2] syscalls/mbind0{2,3,4}: Add basic mbind tests
In-Reply-To: <20190722150316.27395-1-chrubis@suse.cz>
References: <20190722150316.27395-1-chrubis@suse.cz>
Message-ID: <CAEemH2dapin31=WrPsA97wgX=2d5rzQy8+D7LVta6nr6BwFN5A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Mon, Jul 22, 2019 at 11:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> ...
>  create mode 100644 testcases/kernel/syscalls/mbind/mbind.h
>  create mode 100644 testcases/kernel/syscalls/mbind/mbind02.c
>  create mode 100644 testcases/kernel/syscalls/mbind/mbind03.c
>  create mode 100644 testcases/kernel/syscalls/mbind/mbind04.c

Ad Petr commented in the patch V1, Makefile needs updating after
adding libltpnuma, otherwise, these test cases won't build
successfully.

LDFLAGS += -L$(top_builddir)/libs/libltpnuma
LDLIBS  += $(NUMA_LIBS) -lltpnuma

> diff --git a/testcases/kernel/syscalls/mbind/mbind02.c
> b/testcases/kernel/syscalls/mbind/mbind02.c
> ...
> +       TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, MPOL_MF_STRICT));
> +
> +       if (TST_RET) {

I think we'd better check if the TST_RET is EIO before getting TPASS?
Otherwise, it will miss the failure with any other errno.

if (TST_ERR == EIO) {
        tst_res(TPASS | TTERRNO,
                        "mbind(%s, MPOL_MF_STRICT) node %u",
                         tst_numa_mode_name(mode), node);
} else {
         tst_res(TFAIL | TTERRNO, "mbind(%s, MPOL_MF_STRICT) node %u
failed unexpcted",
                         tst_numa_mode_name(mode), node);
}

> +               tst_res(TPASS | TTERRNO,
> +                       "mbind(%s, MPOL_MF_STRICT) node %u",
> +                       tst_numa_mode_name(mode), node);
> +       } else {
> +               tst_res(TFAIL, "mbind(%s, MPOL_MF_STRICT) node %u succeded",
> +                       tst_numa_mode_name(mode), node);
> +       }
> +
> +       tst_numa_unmap(ptr, size);
> +       numa_free_nodemask(bm);
> +}
> +
> +static void verify_mbind(unsigned int n)
> +{
> +       int mode = n ? MPOL_PREFERRED : MPOL_BIND;

Why not test MPOL_INTERLEAVE for mbind02? I guess it also makes sense
to add here.

> +       .forks_child = 1,

.forks_child is redundant?

> diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
> new file mode 100644
> index 000000000..f0622b07f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mbind/mbind03.c
> ...
> +
> +void verify_mbind(unsigned int n)
> +{
> +       int mode = n ? MPOL_PREFERRED : MPOL_BIND;

Adding MPOL_INTERLEAVE?

> +       .forks_child = 1,

remove .forks_child.

> diff --git a/testcases/kernel/syscalls/mbind/mbind04.c
> +++ b/testcases/kernel/syscalls/mbind/mbind04.c
> ...
> +
> +static void verify_policy(unsigned int node, int mode, unsigned flag)
> +{
> +       struct bitmask *bm = numa_allocate_nodemask();
> +       unsigned int i;
> +       void *ptr;
> +       unsigned long size = PAGES_ALLOCATED * page_size;
> +
> +       numa_bitmask_setbit(bm, node);
> +
> +       ptr = tst_numa_map(NULL, size);
> +
> +       TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, flag));
> +
> +       if (TST_RET) {
> +               tst_res(TFAIL | TTERRNO,
> +                       "mbind(%s, %s) node %u",
> +                       tst_numa_mode_name(mode), mbind_flag_name(flag), node);

Do numa_free_nodemask(bm) before return?

> +static void verify_mbind(unsigned int n)
> +{
> +       unsigned int i;
> +       int mode = n ? MPOL_PREFERRED : MPOL_BIND;
> +
> +       for (i = 0; i < nodes->cnt; i++) {

I remember there are some ppc64le which have non-continuous numa nodes
in hardware configuration. I'm not sure if that special config will
break the mbind04 test, will update details to you after I run this
test on such a system.

    lscpu
    -----
    Architecture:        ppc64le
    ...
    CPU(s):              128
    Core(s) per socket:  16
    Socket(s):           2
    NUMA node(s):        2
    Model name:          POWER9, altivec supported
    ...
    NUMA node0 CPU(s):   0-63
    NUMA node8 CPU(s):   64-127

--
Regards,
Li Wang
