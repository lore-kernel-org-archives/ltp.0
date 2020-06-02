From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jun 2020 12:42:34 +0800
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
References: <20200601100459.32511-1-liwang@redhat.com>
 <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Mon, Jun 1, 2020 at 9:57 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > +
> > +[source,c]
> >
> +-------------------------------------------------------------------------------
> > +#include "tst_test.h"
> > +
> > +static void run(void)
> > +{
> > +     ...
> > +
> > +     tst_cgroup_move_current(PATH_TMP_CG1_MEM);
> > +     tst_cgroup_mem_set_maxbytes(PATH_TMP_CG1_MEM, MEMSIZE);
>
> Goal for API is to hide differences between cgroup 1/2, but example above
> is passing cgroup specific directory.
>

Sorry for the misleading info, actually that's no different to use any
directory whatever you pass via parameter, it will recognize cgroup
version to be mounted intelligently.

Here as I commented in the last email. the specific dir are typos which
inherent from patch v1. We should fix them.


>
> My suggestion was to have directory parameter relative to cgroup mount,
>

Patch v2 is already achieved this even includes more functions(i.e mount
many same cgroup).



> I didn't consider there would be need for mounting cgroup more than once
> from single process. Is there such need?
>

Yes right, the test21.c mounting many cgroups in a single process is just a
test
 to verify these APIs works fine, it meaningless in real situations.


>
> Since there's only one global 'tst_cgroup_mnt_path', is there need to have
> paths absolute? If we assume that single process will mount cgroup only
> once,
> then all paths could be relative to 'tst_cgroup_mnt_path', and test doesn't
> need to even use 'tst_cgroup_mnt_path'.
>

No, the global 'tst_cgroup_mnt_path' is not only to pass mount directory but
also for storing path when searching from get_cgroup_get_path().

Why we need this? Because, if a testcase(i.e oom05.c) needs more than one
cgroup
subsystem(memory, cpuset) on RHEL7(cgroup-v1), it should mount two
different
directories and do some knob setting.


>
> > +
> > +static void tst_cgroup_set_path(const char *cgroup_dir)
> > +{
> > +     struct tst_cgroup_path *tst_cgroup_path, *a;
> > +
> > +     if (!cgroup_dir)
> > +             tst_brk(TBROK, "Invalid cgroup dir, plese check
> cgroup_dir");
> > +
> > +     sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
> > +     sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
> > +
> > +     /* To store cgroup path in the shared 'path' list */
> > +     tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct tst_cgroup_path)),
> > +                     PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
> MAP_SHARED, -1, 0);
>
> I'm not sure I understand what is the reason to have tst_cgroup_path. Is
> it expected,
> that mount and umount are called by different processes? It might be easier
>

The shared 'tst_cgroup_path' is necessary especially for mounting
different cgoups in setup(). Otherwise, it would be easy to get lost
which directory for kind of cgroup type.

And the worth to say, the random directory name for same cgroup
mounting is also on purpose, though we mount same(i.e memory)
cgroup in two places it still belongs to the one hierarchy, and create
the same name of the new directory will be hit an error in EEXIST.

static void tst_cgroup_set_path(const char *cgroup_dir)
{
    ...
    sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
    sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
}



> to define API as per-process and require same process to call mount and
> umount.
>
> > +     tst_cgroup_path->mnt_path =
> SAFE_MALLOC(strlen(tst_cgroup_mnt_path));
> > +     tst_cgroup_path->new_path =
> SAFE_MALLOC(strlen(tst_cgroup_new_path));
>
> Pointers are in shared memory, but content they point to is not, so it's
> accessible
> only from process that called tst_cgroup_set_path().
>

Good catch. This should be also use shared memory.


>
> Can you describe all different scenarios you wanted to support?
>

Sure, we have to consider many scenarios:

1. mount only one cgroup in a single process on the system support cgroup
v1 or v2 (i.e ksm03.c)

#include "tst_cgroup.h"
#define PATH_CGROUP  /tmp/cgroup

static void run(void)
{
    tst_cgroup_move_current(PATH_CGROUP);
    tst_cgroup_mem_set_maxbytes(PATH_CGROUP, 1024*1024*1024);
    // do your test
}

static void setup(void)
{
    tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP);
}

static void cleanup(void)
{
    tst_cgroup_umount(PATH_CGROUP);
}

static struct tst_test test = {
    ...
    .test_all = run,
};


2. mount different cgroups in a single process on the system only support
cgroup-v1 (i.e ksm04.c, oom05.c)

#include "tst_cgroup.h"
#define PATH_CGROUP1  /tmp/cgroup1
#define PATH_CGROUP2  /tmp/cgroup2

static void run(void)
{
    tst_cgroup_move_current(PATH_CGROUP1);
    tst_cgroup_move_current(PATH_CGROUP2);

    // we have to recognize the correct cgroup path if we
    // mount two or more cgroup subsystems in a single
    // process, in case we get lost in knob setting

    // the tst_cgroup_get_path() helps to find and get
    // correct path in tst_cgroup_mnt_path, tst_cgroup_new_path

    // that's also the reason why we need a shared list to
    // store many cgoup pathes. And, this is extendible for
    // mounting more cgroup subsystems in the future.

    tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, 1024*1024*1024);
    // some cpuset configration
}

static void setup(void)
{
    tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
    tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
}

static void cleanup(void)
{
    tst_cgroup_umount(PATH_CGROUP1);
    tst_cgroup_umount(PATH_CGROUP2);
}

static struct tst_test test = {
    ...
    .test_all = run,
};


3. mount different cgroups in different process on the system support v1 or
v2

#include "tst_cgroup.h"
#define PATH_CGROUP1  /tmp/cgroup1
#define PATH_CGROUP2  /tmp/cgroup2

static void run(void)
{
    if (fork() == 0) {
        tst_cgroup_move_current(PATH_CGROUP1);
        tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, 1024*1024*1024);
        // test code
    }

    tst_cgroup_move_current(PATH_CGROUP2);
    // some cpuset configuration
    // and test code
}

static void setup(void)
{
    // we do cgroup mount work unified in setup()
    // whatever the cgroup is being used in the parent
    // or children, there is also no need to care about the
    // details of cgroup v1 or v2.

    tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
    tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
}

static void cleanup(void)
{
    tst_cgroup_umount(PATH_CGROUP1);
    tst_cgroup_umount(PATH_CGROUP2);
}

static struct tst_test test = {
    ...
    .test_all = run,
};


4. mount same cgroup in different process on the system support v1 or v2

#include "tst_cgroup.h"
#define PATH_CGROUP1  /tmp/cgroup1
#define PATH_CGROUP2  /tmp/cgroup2

static void run(void)
{
    if (fork() == 0) {
        tst_cgroup_move_current(PATH_CGROUP1);
        tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, 1024*1024*1024);
        // test code1
    }

        tst_cgroup_move_current(PATH_CGROUP2);
        tst_cgroup_mem_set_maxbytes(PATH_CGROUP2, 2048*2048);
        // test code2
}

static void setup(void)
{
    // we mount two memory cgroup in the parent
    // but setting different value in corresponding
    // knob for different process to test more configration

    tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
    tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP2);
}

static void cleanup(void)
{
    tst_cgroup_umount(PATH_CGROUP1);
    tst_cgroup_umount(PATH_CGROUP2);
}

static struct tst_test test = {
    ...
    .test_all = run,
};


5. mount many cgroups on different process for future extendible work
i.e.

// tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
// tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
// tst_cgroup_mount(TST_CGROUP_CPUACT, PATH_CGROUP3);
// tst_cgroup_mount(TST_CGROUP_PIDSCG,  PATH_CGROUP4);
// tst_cgroup_mount(TST_CGROUP_HUGTLB, PATH_CGROUP5);
// ...


Btw, I attach the patch v2.1 for better readable.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200602/9e622499/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-lib-add-new-cgroup-test-API.patch
Type: text/x-patch
Size: 15933 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200602/9e622499/attachment-0001.bin>
