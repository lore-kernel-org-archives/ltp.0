From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 2 Jun 2020 14:12:33 +0200
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
References: <20200601100459.32511-1-liwang@redhat.com>
 <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
 <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
Message-ID: <20200602121232.GA22599@janakin.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

>Why we need this? Because, if a testcase(i.e oom05.c) needs more than one
>cgroup
>subsystem(memory, cpuset) on RHEL7(cgroup-v1), it should mount two
>different
>directories and do some knob setting.

Mounting with different controllers is fine, I meant do we have a case for mounting
same controller multiple times? We might have, because current design allows
only for single directory (tst_cgroup_new_path), that's automatically created on mount.
(This is your example 4)

>
>
>>
>> > +
>> > +static void tst_cgroup_set_path(const char *cgroup_dir)
>> > +{
>> > +     struct tst_cgroup_path *tst_cgroup_path, *a;
>> > +
>> > +     if (!cgroup_dir)
>> > +             tst_brk(TBROK, "Invalid cgroup dir, plese check
>> cgroup_dir");
>> > +
>> > +     sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
>> > +     sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
>> > +
>> > +     /* To store cgroup path in the shared 'path' list */
>> > +     tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct tst_cgroup_path)),
>> > +                     PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
>> MAP_SHARED, -1, 0);
>>
>> I'm not sure I understand what is the reason to have tst_cgroup_path. Is
>> it expected,
>> that mount and umount are called by different processes? It might be easier
>>
>
>The shared 'tst_cgroup_path' is necessary especially for mounting
>different cgoups in setup(). Otherwise, it would be easy to get lost
>which directory for kind of cgroup type.

But why is it shared? Is cleanup going to run in different process context?
Which one of your examples needs shared memory?

>
>And the worth to say, the random directory name for same cgroup
>mounting is also on purpose, though we mount same(i.e memory)
>cgroup in two places it still belongs to the one hierarchy, and create
>the same name of the new directory will be hit an error in EEXIST.
>
>static void tst_cgroup_set_path(const char *cgroup_dir)
>{
>    ...
>    sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
>    sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());

I see why you are tracking this in list, but this exchange of state through
global variables does seem bit unclear.

Could we leave "new_path" creation to testcase itself? It would give
us more flexibility and we don't have to worry about name collisions.
It also avoids need to mount same controller multiple times
(example 4 in your reply).

Let's assume this is API:

#include "tst_cgroup.h"
#define MEM_MNT  "/tmp/cgroup1"
#define CPUSET_MNT  "/tmp/cgroup2"
#define DIR1 "ltp_test_blah_dir1"
#define DIR2 "ltp_test_blah_dir2"
#define DIR3 "ltp_test_blah_dir3"

static void run(void)
{
    if (fork() == 0) {
        tst_cgroup_move_current(MEM_MNT, DIR2);
        // do your test
        exit(0);
    }
    tst_cgroup_move_current(MEM_MNT, DIR1);
    // do your test
}

static void setup(void)
{
    tst_cgroup_mount(TST_CGROUP_MEMCG, MEM_MNT);
    tst_cgroup_mkdir(MEM_MNT, DIR1);
    tst_cgroup_mem_set_maxbytes(MEM_MNT, DIR1, 1*1024*1024);
    tst_cgroup_mkdir(MEM_MNT, DIR2);
    tst_cgroup_mem_set_maxbytes(MEM_MNT, DIR2, 2*1024*1024);
    
    tst_cgroup_mount(TST_CGROUP_CPUSET, CPUSET_MNT);
    tst_cgroup_mkdir(CPUSET_MNT, DIR3);
    tst_cgroup_move_current(CPUSET_MNT, DIR3);
}

static void cleanup(void)
{
    tst_cgroup_umount(MEM_MNT);
    tst_cgroup_umount(CPUSET_MNT);
}

static struct tst_test test = {
    ...
    .test_all = run,
};

On library side we would have a list that tracks all mounts. And every mount
record would have list that tracks all mkdir() operations, so we can
cleanup anything that test creates. I think tracking per-process would be sufficient.

(without spinning v3) What are your thoughts?

Regards,
Jan

