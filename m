From: Li Wang <liwang@redhat.com>
Date: Wed, 27 May 2020 18:10:47 +0800
Subject: [LTP] [PATCH v1 2/4] mem: take use of new cgroup API
In-Reply-To: <396532423.13763181.1590565518615.JavaMail.zimbra@redhat.com>
References: <20200527031430.22144-1-liwang@redhat.com>
 <20200527031430.22144-2-liwang@redhat.com>
 <396532423.13763181.1590565518615.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cdS9OX6HvGPOwULMTkjfbNSbnz6ZF27rsZrsjcJ6r3AQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 27, 2020 at 3:45 PM Jan Stancek <jstancek@redhat.com> wrote:

> > diff --git a/testcases/kernel/mem/cpuset/cpuset01.c
> > b/testcases/kernel/mem/cpuset/cpuset01.c
> > index 853f7fe55..cecc4ba86 100644
> > --- a/testcases/kernel/mem/cpuset/cpuset01.c
> > +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> > @@ -51,11 +51,11 @@ static void test_cpuset(void)
> >       unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
> >       char mems[BUFSIZ], buf[BUFSIZ];
> >
> > -     read_cpuset_files(CPATH, "cpus", buf);
> > -     write_cpuset_files(CPATH_NEW, "cpus", buf);
> > -     read_cpuset_files(CPATH, "mems", mems);
> > -     write_cpuset_files(CPATH_NEW, "mems", mems);
> > -     SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
> > +     read_cpuset_files(PATH_TMP_CG1_CST, "cpus", buf);
> > +     write_cpuset_files(PATH_CG1_CST_LTP, "cpus", buf);
> > +     read_cpuset_files(PATH_TMP_CG1_CST, "mems", mems);
> > +     write_cpuset_files(PATH_CG1_CST_LTP, "mems", mems);
>
> This mixes generic api with cgroup1. It currently relies on implementation
> detail of tst_cgroup_mount(), which isn't visible just by looking at this
> test.
>

Yes, here just uses many path macros, which makes things easy since mem/lib
achieved many functions for cpuset files, I don't want to break the struct
so keep it similar as previous. Anyway, we can reconstruct that but that is
not the intention of this patchset.

Btw, the test has no chance to go there because in setup() the
tst_cgroup_mount(TST_CGROUP_CPUSET)
will get TCONF if the system uses cgroup-v2.

>
> We should make it generic or make it clear that test is for cgroup1 only:
>

But sure, we can add this, it makes code clear to readers.


>
> setup()
>   if (tst_cgroup_version() != TST_CGROUP_V1)
>     TCONF
>
>
> > diff --git a/testcases/kernel/mem/oom/oom03.c
> > b/testcases/kernel/mem/oom/oom03.c
> > index ce0b34c31..af3a565ce 100644
> > --- a/testcases/kernel/mem/oom/oom03.c
> > +++ b/testcases/kernel/mem/oom/oom03.c
> > @@ -36,27 +36,26 @@
> >
> >  #ifdef HAVE_NUMA_V2
> >
> > -static int memcg_mounted;
> > -
> >  static void verify_oom(void)
> >  {
> >  #ifdef TST_ABI32
> >       tst_brk(TCONF, "test is not designed for 32-bit system.");
> >  #endif
> >
> > -     SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
> > -     SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
> > +     tst_cgroup_mem_set_maxbytes(TESTMEM);
> >
> >       testoom(0, 0, ENOMEM, 1);
> >
> > -     if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
> > +     if ((access(PATH_MEMORY_SW_LIMIT, F_OK) == -1) ||
> > +                     (access(PATH_MEMORY_SW_MAX, F_OK) == -1)) {
>
> This could be tst_cgroup_mem_swapacct_enabled(), without need for test
> to probe specific cgroup[12] files.
>

Sounds good. I will have a try.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200527/068c1d55/attachment.htm>
