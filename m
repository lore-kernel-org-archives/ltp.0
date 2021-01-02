From: Li Wang <liwang@redhat.com>
Date: Sat, 2 Jan 2021 17:18:11 +0800
Subject: [LTP] [RFC PATCH 2/5] CGroup API rewrite
In-Reply-To: <20201216100121.16683-3-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
 <20201216100121.16683-3-rpalethorpe@suse.com>
Message-ID: <CAEemH2ddomP4XO=61vNx5=3vQYNj4WOurUX2zcuC-46RxhMk0g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe via ltp <ltp@lists.linux.it> wrote:


> So we have a choice of:
>
> A) Expect a particular configuration and refuse to run
>    otherwise
> B) Expect no CGroups and mount them
> C) Try to use what is available
> D) (C) and try to mount them if nothing is present
> E) (C), (D) and try to cleanup what we created
>
> (A) and (B) are more simple for the LTP library, but require our users
> to do more work, perhaps a lot more. Depending on the test
> environment; disabling or reconfiguring CGroups may be
> difficult. Because many tests require CGroups to expose a bug in other
> subsystems (e.g. the memory subsystem), I do not think (A) and (B) are
> viable options. They may be acceptable for testing core CGroup
> features where a pristine system is required (e.g. first mount), but
> that is not the current focus of these changes.
>
> (C) is probably the simplest viable option, but this tries to
> implement (E). Mounting the CGroups if none are available simplifies
> testing within environments like Rapido where testing is done in the
> recovery console and no CGroups are mounted by the system manager. On
> the other hand it is quite simple for the user to mount some CGroups.
>
> Mounting is relatively simple so does not add much complexity, however
> cleaning up the mounts is broken so possibly we should only
> attempt (C) or (D). It appears that the test process has some references to
> the mount struct and so it can not be removed by the test, but I am
>

Yes, and that's also the reason I like the drain_dir in this patch.


> partly guessing. Using MNT_DETACH at least allows the directory to be
> removed, but it's not clear if the root is eventually destroyed. It
> appears that a separate process (i.e. the umount command) can properly
> remove the mount and the CGroup is destroyed, but this is still not
> fully clear without more tracing.
>
> [...]


> +/* Determine if a mounted cgroup hierarchy (tree) is unique and record it
> if so.
> + *
> + * For CGroups V2 this is very simple as there is only one
> + * hierarchy. We just record which controllers are available and check
> + * if this matches what we read from any previous mounts to verify our
> + * own logic (and possibly detect races).
> + *
> + * For V1 the set of controllers S is partitioned into sets {P_1, P_2,
> + * ..., P_n} with one or more controllers in each partion. Each
> + * partition P_n can be mounted multiple times, but the same
> + * controller can not appear in more than one partition. Usually each
> + * partition contains a single controller, but, for example, cpu and
> + * cpuacct are often mounted together in the same partiion.
> + *
> + * Each controller partition has its own hierarchy/root/tree which we
> + * must track and update independently.
> + */
> +static void tst_cgroup_get_tree(const char *type, const char *path, char
> *opts)
> +{
> +       struct tst_cgroup_root *t = trees;
> +       struct tst_cgroup_ss *c;
>

why not naming *c to *ss? to make it tidier for readability just like what
you did in other functions.

static void tst_cgroup_get_tree(const char *type, const char *path, char
*opts)
 {
        struct tst_cgroup_root *t = trees;
-       struct tst_cgroup_ss *c;
+       struct tst_cgroup_ss *ss;
        uint32_t ss_field = 0;
        int no_prefix = 0;
        char buf[BUFSIZ];
@@ -290,9 +290,9 @@ backref:
        t->ss_field = ss_field;
        t->no_prefix = no_prefix;

-       tst_for_each_css(c) {
-               if (t->ss_field & (1 << c->indx))
-                       c->tree = t;
+       tst_for_each_css(ss) {
+               if (t->ss_field & (1 << ss->indx))
+                       ss->tree = t;
        }



> [...]
>
> +void tst_cgroup_require(enum tst_cgroup_ctrl type,
> +                       const struct tst_cgroup_opts *options)
>  {
> -       char *cgroup_new_dir;
> -       char knob_path[PATH_MAX];
> +       struct tst_cgroup_ss *ss = tst_cgroup_get_ss(type);
> +       struct tst_cgroup_root *t;
> +       char path[PATH_MAX];
>
> -       cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
> +       if (!options)
> +               options = &default_opts;
>
> -       if (tst_cg_ver & TST_CGROUP_V1) {
> -               sprintf(knob_path, "%s/%s",
> -                               cgroup_new_dir,
> "/memory.memsw.limit_in_bytes");
> +       if (ss->tree)
> +               goto ltpdir;
>
> -               if ((access(knob_path, F_OK) == -1)) {
> -                       if (errno == ENOENT)
> -                               tst_res(TCONF, "memcg swap accounting is
> disabled");
> -                       else
> -                               tst_brk(TBROK | TERRNO, "failed to access
> %s", knob_path);
> -               } else {
> -                       return 1;
> -               }
> +       tst_cgroup_scan();
> +
> +       if (ss->tree)
> +               goto ltpdir;
> +
> +       if (!tst_cgroup_v2_mounted() && !options->only_mount_v1)
> +               tst_cgroup_mount_v2();
> +
> +       if (ss->tree)
> +               goto ltpdir;
> +
> +       tst_cgroup_mount_v1(type);
> +
> +       if (!ss->tree) {
> +               tst_brk(TCONF,
> +                       "%s controller required, but not available",
> ss->name);
>         }
>
> -       if (tst_cg_ver & TST_CGROUP_V2) {
> -               sprintf(knob_path, "%s/%s",
> -                               cgroup_new_dir, "/memory.swap.max");
> +ltpdir:
> +       t = ss->tree;
>
> -               if ((access(knob_path, F_OK) == -1)) {
> -                       if (errno == ENOENT)
> -                               tst_res(TCONF, "memcg swap accounting is
> disabled");
> -                       else
> -                               tst_brk(TBROK | TERRNO, "failed to access
> %s", knob_path);
> -               } else {
> -                       return 1;
> -               }
> +       if (tst_cgroup_ss_on_v2(ss)) {
> +               tst_file_printfat(t->mnt_dir, "cgroup.subtree_control",
> +                                 "+%s", ss->name);
>         }
>
> -       return 0;
> +       sprintf(path, "%s/%s", t->path, ltp_cgroup_dir);
> +
> +       if (!mkdir(path, 0777)) {
> +               t->we_created_ltp_dir = 1;
> +               goto draindir;
> +       }
> +
> +       if (errno == EEXIST)
> +               goto draindir;
> +
> +       if (errno == EACCES) {
> +               tst_brk(TCONF | TERRNO,
> +                       "Lack permission to make %s; premake it or run as
> root",
> +                       path);
> +       }
> +
> +       tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
> +
> +draindir:
> +       if (!t->ltp_dir)
> +               t->ltp_dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
> +
> +       if (tst_cgroup_ss_on_v2(ss)) {
> +               SAFE_FILE_PRINTFAT(t->ltp_dir, "cgroup.subtree_control",
> +                                  "+%s", ss->name);
> +       } else {
> +               SAFE_FILE_PRINTFAT(t->ltp_dir, "cgroup.clone_children",
> +                                  "%d", 1);
> +
> +               if (type == TST_CGROUP_CPUSET)
> +                       tst_cgroup_copy_cpuset(t);
> +       }
> +
> +       sprintf(path, "%s/%s/%s",
> +               t->path, ltp_cgroup_dir, ltp_cgroup_drain_dir);
> +
> +       if (!mkdir(path, 0777) || errno == EEXIST)
> +               goto testdir;
> +
> +       if (errno == EACCES) {
> +               tst_brk(TCONF | TERRNO,
> +                       "Lack permission to make %s; grant access or run
> as root",
> +                       path);
> +       }
> +
> +       tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
> +
> +testdir:
> +       if (!t->drain_dir)
> +               t->drain_dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
> +
> +       if (!test_cgroup_dir[0])
> +               sprintf(test_cgroup_dir, "test-%d", getpid());
>

As I was mentioned in 0/5 that maybe we should create test_cgroup_dir
for different progress so that the test could use the same controller with
various configurations in parallel.

e.g. child_1 set SIZE to memory.limit_in_bytes
       child_2 set SIZE/2 to memory.limit_in_bytes

Any possibility to move this to tst_cgroup_move_current?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210102/bc700a01/attachment.htm>
