From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Jun 2020 18:12:40 +0800
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <1111554317.15300411.1591699362992.JavaMail.zimbra@redhat.com>
References: <20200609095102.21153-1-liwang@redhat.com>
 <1111554317.15300411.1591699362992.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fkUX2KA+dPqgjqrBftxAZ722k9B7i3fi8eSxEmzSLk6w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 9, 2020 at 6:42 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > Many of our LTP tests need Control Group in the configuration,
> > this patch makes cgroup unified mounting at setup phase to be
> > possible. The method is extracted from mem.h with the purpose
> > of extendible for further developing, and trying to compatible
> > the current two versions of cgroup,
> >
> > It's hard to make all APIs be strictly consistent because there
> > are many differences between v1 and v2. But it capsulate the detail
> > of cgroup mounting in high-level functions, which will be easier
> > to use cgroup without considering too much technical thing.
> >
> > Btw, test get passed on RHEL7(x86_64), RHEL8(ppc64le), Fedora32(x86_64).
> >
>
> No strong objections to v4, couple comments below (if you spin v5 because
> of other reviews).
>

Thanks for review!
Ok, I agree to keep patchv4 posts for more days in case other people have
comments.


>
> > +2.2.36 Using Control Group
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Would be nice if there was short description of each function.
>

I'd add some code comments in the tst_cgroup.h header file. Which something
maybe like:

/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
void tst_cgroup_umount(const char *cgroup_dir);

/* To move current process PID to the mounted cgroup tasks */
void tst_cgroup_move_current(const char *cgroup_dir);

/* To set cgroup controller knob with new value */
void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long
value);

/* Set of functions to set knobs under the memory controller */
void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);

/* Set of functions to read/write cpuset controller files content */
void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char
*filename, char *retbuf);
void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char
*filename, const char *buf);



>
> > +static void tst_cgroup_set_path(const char *cgroup_dir)
> > +{
> > +     char cgroup_new_dir[PATH_MAX];
> > +     struct tst_cgroup_path *tst_cgroup_path, *a;
> > +
> > +     if (!cgroup_dir)
> > +             tst_brk(TBROK, "Invalid cgroup dir, plese check
> cgroup_dir");
> > +
> > +     sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
> > +
> > +     /* To store cgroup path in the 'path' list */
> > +     tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct tst_cgroup_path)),
> > +                     PROT_READ | PROT_WRITE, MAP_PRIVATE |
> MAP_ANONYMOUS, -1, 0);
>
> This looks like it could use just SAFE_MALLOC/SAFE_FREE.
>

Agree.

And btw, seems we have to set cgroup.clone_children as 1, otherwise, we
can't write anything to the cpuset subsystem files.

    BROK: Failed to close FILE '/tmp/cgroup_cst/ltp_1804289383/tasks' at
tst_cgroup.c:296: ENOSPC (28)

So these lines will be add in to library as neccesary:

--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -251,6 +251,16 @@ void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const
char *cgroup_dir)
                break;
                case TST_CGROUP_CPUSET:
                        tst_cgroup1_mount("cpusetcg", "cpuset", cgroup_dir,
cgroup_new_dir);
+                       /*
+                        * we should assign one or more memory nodes to
cpuset.mems
+                        * and cpuset.cpus, otherwise, echo $$ > tasks
gives ?no space
+                        * left on device: ENOSPC? when trying to use
cpuset.
+                        *
+                        * Or, setting cgroup.clone_children to 1 can help
in automatically
+                        * inheriting memory and node setting from parent
cgroup when a
+                        * child cgroup is created.
+                        */
+                       tst_cgroup_set_knob(cgroup_dir,
"../cgroup.clone_children", 1);
                break;


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200610/9256daf9/attachment.htm>
