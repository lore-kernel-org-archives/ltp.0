From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Jun 2020 09:38:53 +0800
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <20200602121232.GA22599@janakin.usersys.redhat.com>
References: <20200601100459.32511-1-liwang@redhat.com>
 <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
 <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
 <20200602121232.GA22599@janakin.usersys.redhat.com>
Message-ID: <CAEemH2d7OzG6jBZ15bYGRHm7ry-gVjzuwJYhbHp3yitB3_928w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 2, 2020 at 8:12 PM Jan Stancek <jstancek@redhat.com> wrote:

> Hi Li,
>
> >Why we need this? Because, if a testcase(i.e oom05.c) needs more than one
> >cgroup
> >subsystem(memory, cpuset) on RHEL7(cgroup-v1), it should mount two
> >different
> >directories and do some knob setting.
>
> Mounting with different controllers is fine, I meant do we have a case for
> mounting
> same controller multiple times? We might have, because current design
> allows
> only for single directory (tst_cgroup_new_path), that's automatically
> created on mount.
> (This is your example 4)
>
> >
> >
> >>
> >> > +
> >> > +static void tst_cgroup_set_path(const char *cgroup_dir)
> >> > +{
> >> > +     struct tst_cgroup_path *tst_cgroup_path, *a;
> >> > +
> >> > +     if (!cgroup_dir)
> >> > +             tst_brk(TBROK, "Invalid cgroup dir, plese check
> >> cgroup_dir");
> >> > +
> >> > +     sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
> >> > +     sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
> >> > +
> >> > +     /* To store cgroup path in the shared 'path' list */
> >> > +     tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct
> tst_cgroup_path)),
> >> > +                     PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
> >> MAP_SHARED, -1, 0);
> >>
> >> I'm not sure I understand what is the reason to have tst_cgroup_path. Is
> >> it expected,
> >> that mount and umount are called by different processes? It might be
> easier
> >>
> >
> >The shared 'tst_cgroup_path' is necessary especially for mounting
> >different cgoups in setup(). Otherwise, it would be easy to get lost
> >which directory for kind of cgroup type.
>
> But why is it shared? Is cleanup going to run in different process context?
> Which one of your examples needs shared memory?
>

My original thought was that if children want to remove some paths
from the list, so this shared memory was made sense. But in the
signed-off patch v2, it seems we only do the deletion in cleanup(),
so private memory is enough.

Another slight reason to keep using share memory is to avoid the
children have a new copy of the list, that will allocate more memory
in testing, but that's fine, I have no objection to using private memory.


>
> >
> >And the worth to say, the random directory name for same cgroup
> >mounting is also on purpose, though we mount same(i.e memory)
> >cgroup in two places it still belongs to the one hierarchy, and create
> >the same name of the new directory will be hit an error in EEXIST.
> >
> >static void tst_cgroup_set_path(const char *cgroup_dir)
> >{
> >    ...
> >    sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
> >    sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
>
> I see why you are tracking this in list, but this exchange of state through
> global variables does seem bit unclear.
>

Yes, that's a compromise to support more usage of the APIs.


>
> Could we leave "new_path" creation to testcase itself? It would give
> us more flexibility and we don't have to worry about name collisions.
>

Hmm, more flexibility sometimes means more complicated to use, I don't
want these APIs to become difficult for newbies of LTP.


> It also avoids need to mount same controller multiple times
> (example 4 in your reply).
>

To be honest, most situations we have are examples 1 and 2, the
others(ex3,4,5) might rarely happen in our test. So maybe leave too
much work(i.e "new_path" creation) in testcase is not wise, and I don't
want to make usage complicated just for ingratiating the rare situations.


>
> Let's assume this is API:
>
> #include "tst_cgroup.h"
> #define MEM_MNT  "/tmp/cgroup1"
> #define CPUSET_MNT  "/tmp/cgroup2"
> #define DIR1 "ltp_test_blah_dir1"
> #define DIR2 "ltp_test_blah_dir2"
> #define DIR3 "ltp_test_blah_dir3"
>
> static void run(void)
> {
>     if (fork() == 0) {
>         tst_cgroup_move_current(MEM_MNT, DIR2);
>         // do your test
>         exit(0);
>     }
>     tst_cgroup_move_current(MEM_MNT, DIR1);
>     // do your test
> }
>
> static void setup(void)
> {
>     tst_cgroup_mount(TST_CGROUP_MEMCG, MEM_MNT);
>     tst_cgroup_mkdir(MEM_MNT, DIR1);
>     tst_cgroup_mem_set_maxbytes(MEM_MNT, DIR1, 1*1024*1024);
>     tst_cgroup_mkdir(MEM_MNT, DIR2);
>     tst_cgroup_mem_set_maxbytes(MEM_MNT, DIR2, 2*1024*1024);
>
>     tst_cgroup_mount(TST_CGROUP_CPUSET, CPUSET_MNT);
>     tst_cgroup_mkdir(CPUSET_MNT, DIR3);
>     tst_cgroup_move_current(CPUSET_MNT, DIR3);

}
>
> static void cleanup(void)
> {
>     tst_cgroup_umount(MEM_MNT);
>     tst_cgroup_umount(CPUSET_MNT);
> }
>
> static struct tst_test test = {
>     ...
>     .test_all = run,
> };
>
> On library side we would have a list that tracks all mounts. And every
> mount
> record would have list that tracks all mkdir() operations, so we can
> cleanup anything that test creates. I think tracking per-process would be
> sufficient.
>

To compare with my v2, this design leaves simple code in lib, and flexible
in usage. The only disadvantage is that people need to define more macros
and mkdir() by themself.

I have no strong preference to shift from v2 to this method, or maybe we
can try
to combine together and do more optimize work in the lib side.


>
> (without spinning v3) What are your thoughts?
>
> Regards,
> Jan
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200603/83db11d8/attachment.htm>
