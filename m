From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Sep 2020 11:36:28 +0800
Subject: [LTP] [RFC][PATCH] tst_cgroup: Attempt to use CGroups V2 then
 V1 instead of guessing
In-Reply-To: <20200925121941.10475-1-rpalethorpe@suse.com>
References: <20200925121941.10475-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2eo6qVt0D36QVDFeW_2csWFEDnnghxRjd3_Ysu=CD-8Hw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Fri, Sep 25, 2020 at 8:20 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> The best way to find out if we can do something is to try it, we don't
> check if the system has enough RAM and PIDs available before calling
> fork() in safe_fork(). Currently we try to guess what cgroups are
> currently in use then try to use the same version. We guess by
> grepping the mounts and filesystem files, these files need to be
> parsed in a structured way and even then, it is not the job of all
> tests which *use* cgroups to test that if cgroup(2) is present in
> mounts or filesystem that it can then be used.
>
> The cpuset group is only available on V1 and we can mount and use V1
> even if V2 is active. Just because the system has V2 active does not
> mean we cannot execute tests which require V1. This is one example
> where trying to figure out ahead of time what can or can't be used
> results in less testing.
>

Good point.

My previous thought on the Cgroup test-lib design was only to respect one
version,
because the upstream developer hopes to use V2 replaces the V1 step by step.
So the key point of work mainly focused on the supported&mounted version,
which sounds like Cgroup itself is the leading actor, and to easily extend
Cgroup
itself testing according to different versions.

But I didn't realize that there will be a mixed using situation we have to
take care of.
At that moment, the Cgroup test-lib actor as an assistant in the general
test case.

Anyway, this patch looks practicable and fitted for the period of
transition of Cgroup.


>
> Furthermore removing these checks results in a ~50% reduction in code
> and this is without correct parsing and checking of mounts and
> filesystems. We also have to consider that just because one V1
> controller is mounted, this does not prevent all V2 controllers from
> being used. So someone may mount V1 cpuset for legacy reasons, while
> using V2 for other controllers. To account for this we would need to
> check each controller individually.
>
> Note that the above may be a valid thing to do in a test checking
> specific cgroup behavior, but this library code is meant for use by
> all tests which need cgroups for some reason.
> ---
>  include/tst_cgroup.h |   2 -
>  lib/tst_cgroup.c     | 118 ++++++++++++++-----------------------------
>  2 files changed, 39 insertions(+), 81 deletions(-)
>
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index 77780e0d6..62d381ce9 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -21,8 +21,6 @@ enum tst_cgroup_ctrl {
>         /* add cgroup controller */
>  };
>
> -enum tst_cgroup_ver tst_cgroup_version(void);
> -
>  /* To mount/umount specified cgroup controller on 'cgroup_dir' path */
>  void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
>  void tst_cgroup_umount(const char *cgroup_dir);
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index ba413d874..887423bc6 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -21,47 +21,6 @@
>  static enum tst_cgroup_ver tst_cg_ver;
>  static int clone_children;
>
> -static int tst_cgroup_check(const char *cgroup)
> -{
> -       char line[PATH_MAX];
> -       FILE *file;
> -       int cg_check = 0;
> -
> -       file = SAFE_FOPEN("/proc/filesystems", "r");
> -       while (fgets(line, sizeof(line), file)) {
> -               if (strstr(line, cgroup) != NULL) {
> -                       cg_check = 1;
> -                       break;
> -               }
> -       }
> -       SAFE_FCLOSE(file);
> -
> -       return cg_check;
> -}
> -
> -enum tst_cgroup_ver tst_cgroup_version(void)
> -{
> -        enum tst_cgroup_ver cg_ver;
> -
> -        if (tst_cgroup_check("cgroup2")) {
> -                if (!tst_is_mounted("cgroup2") &&
> tst_is_mounted("cgroup"))
> -                        cg_ver = TST_CGROUP_V1;
> -                else
> -                        cg_ver = TST_CGROUP_V2;
> -
> -                goto out;
> -        }
> -
> -        if (tst_cgroup_check("cgroup"))
> -                cg_ver = TST_CGROUP_V1;
> -
> -        if (!cg_ver)
> -                tst_brk(TCONF, "Cgroup is not configured");
> -
> -out:
> -        return cg_ver;
> -}
> -
>  static void tst_cgroup1_mount(const char *name, const char *option,
>                         const char *mnt_path, const char *new_path)
>  {
> @@ -100,26 +59,18 @@ out:
>         tst_res(TINFO, "Cgroup(%s) v1 mount at %s success", option,
> mnt_path);
>  }
>
> -static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
> +static int cgroup2_mount(const char *mnt_path, const char *new_path)
>

We'd like to make the series function name starts with tst_*.


>  {
> -       if (tst_is_mounted(mnt_path))
> -               goto out;
> +       if (!tst_is_mounted(mnt_path)) {
> +               SAFE_MKDIR(mnt_path, 0777);
>
> -       SAFE_MKDIR(mnt_path, 0777);
> -       if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
> -               if (errno == ENODEV) {
> -                       if (rmdir(mnt_path) == -1)
> -                               tst_res(TWARN | TERRNO, "rmdir %s failed",
> mnt_path);
> -                       tst_brk(TCONF,
> -                                "Cgroup v2 is not configured in kernel");
> -               }
> -               tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
> +               if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1)
>

Here we have to remove mnt_path if the mount fails since it also tries to
create
the same path in V1 then.

+                       if (rmdir(mnt_path) == -1)
+                               tst_res(TWARN | TERRNO, "rmdir %s",
mnt_path);


> +                       return -1;
>         }
>
> -out:
>         SAFE_MKDIR(new_path, 0777);
>
> -       tst_res(TINFO, "Cgroup v2 mount at %s success", mnt_path);
> +       return 0;
>  }
>
>  static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
> @@ -274,39 +225,48 @@ void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl,
> const char *cgroup_dir)
>         char *cgroup_new_dir;
>         char knob_path[PATH_MAX];
>
> -       tst_cg_ver = tst_cgroup_version();
> -
>         tst_cgroup_set_path(cgroup_dir);
>         cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
>
> -       if (tst_cg_ver & TST_CGROUP_V1) {
> -               switch(ctrl) {
> -               case TST_CGROUP_MEMCG:
> -                       tst_cgroup1_mount("memcg", "memory", cgroup_dir,
> cgroup_new_dir);
> -               break;
> -               case TST_CGROUP_CPUSET:
> -                       tst_cgroup1_mount("cpusetcg", "cpuset",
> cgroup_dir, cgroup_new_dir);
> -               break;
> -               default:
> -                       tst_brk(TBROK, "Invalid cgroup controller: %d",
> ctrl);
> -               }
> +       if (ctrl == TST_CGROUP_CPUSET) {
> +               tst_res(TINFO, "CGroup V2 lacks cpuset subsystem, trying
> V1");
> +               goto cgroup_v1;
>         }
>
> -       if (tst_cg_ver & TST_CGROUP_V2) {
> -               tst_cgroup2_mount(cgroup_dir, cgroup_new_dir);
> +       if (cgroup2_mount(cgroup_dir, cgroup_new_dir)) {
> +               tst_res(TINFO | TERRNO, "Mounting CGroup V2 failed, trying
> V1");
>

Can we add the diagnostic check when mounting Cgroup V2 failed?
(i.e reserve the tst_cgroup_check() function and used in
tst_cgroup2_mount())

    if (tst_cgroup_check("cgroup2"))
       warning for mounting failed, else ignore this failure

+               goto cgroup_v1;
> +       }
> +
> +       tst_res(TINFO, "Mounted CGroup V2");
> +
> +       switch(ctrl) {
> +       case TST_CGROUP_MEMCG:
> +               sprintf(knob_path, "%s/cgroup.subtree_control",
> cgroup_dir);
> +               if (FILE_PRINTF(knob_path, "%s", "+memory")) {
> +                       tst_res(TINFO,
> +                               "Can't add V2 memory controller, this
> might be because it is mounted as V1");
>

Seems we have to umount Cgroup_V2 and do the cleanup for the shift to
Cgroup_V1.

if (rmdir(cgroup_new_dir) == -1)
    tst_res(TWARN | TERRNO, "rmdir %s", cgroup_new_dir);
if (umount(cgroup_dir) == -1)
    tst_res(TWARN | TERRNO, "umount %s", cgroup_dir);
if (rmdir(cgroup_dir) == -1)
    tst_res(TWARN | TERRNO, "rmdir %s", cgroup_dir);


> +                       break;
> +               }
> +               tst_cg_ver = TST_CGROUP_V2;
> +               return;
> +       default:
> +               tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
> +       }
>
> -               switch(ctrl) {
> -               case TST_CGROUP_MEMCG:
> -                       sprintf(knob_path, "%s/cgroup.subtree_control",
> cgroup_dir);
> -                       SAFE_FILE_PRINTF(knob_path, "%s", "+memory");
> +cgroup_v1:
> +       switch(ctrl) {
> +       case TST_CGROUP_MEMCG:
> +               tst_cgroup1_mount("memcg", "memory", cgroup_dir,
> cgroup_new_dir);
>                 break;
> -               case TST_CGROUP_CPUSET:
> -                       tst_brk(TCONF, "Cgroup v2 hasn't achieve cpuset
> subsystem");
> +       case TST_CGROUP_CPUSET:
> +               tst_cgroup1_mount("cpusetcg", "cpuset", cgroup_dir,
> cgroup_new_dir);
>                 break;
> -               default:
> -                       tst_brk(TBROK, "Invalid cgroup controller: %d",
> ctrl);
> -               }
> +       default:
> +               tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
>         }
> +
> +       tst_cg_ver = TST_CGROUP_V1;
>  }
>
>  void tst_cgroup_umount(const char *cgroup_dir)
> --
> 2.28.0
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200928/6a5f56d5/attachment-0001.htm>
