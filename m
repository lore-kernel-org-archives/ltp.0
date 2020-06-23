From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Jun 2020 21:11:18 +0530
Subject: [LTP] [PATCH AUTOSEL 5.4 219/266] ovl: verify permissions in
 ovl_path_open()
In-Reply-To: <20200618011631.604574-219-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
 <20200618011631.604574-219-sashal@kernel.org>
Message-ID: <CA+G9fYsV1wWyKF3Gs9FwBRxCAgEGrmVjT0zmrrHj9x0WKLQPEw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 18 Jun 2020 at 06:51, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> [ Upstream commit 56230d956739b9cb1cbde439d76227d77979a04d ]
>
> Check permission before opening a real file.
>
> ovl_path_open() is used by readdir and copy-up routines.
>
> ovl_permission() theoretically already checked copy up permissions, but it
> doesn't hurt to re-do these checks during the actual copy-up.
>
> For directory reading ovl_permission() only checks access to topmost
> underlying layer.  Readdir on a merged directory accesses layers below the
> topmost one as well.  Permission wasn't checked for these layers.
>
> Note: modifying ovl_permission() to perform this check would be far more
> complex and hence more bug prone.  The result is less precise permissions
> returned in access(2).  If this turns out to be an issue, we can revisit
> this bug.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/overlayfs/util.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f5678a3f8350..eb325322a893 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -475,7 +475,32 @@ bool ovl_is_whiteout(struct dentry *dentry)
>
>  struct file *ovl_path_open(struct path *path, int flags)
>  {
> -       return dentsteps to reproduce:
          - cd /opt/ltp
          - ./runltp -s execveat03ry_open(path, flags | O_NOATIME,
current_cred());
> +       struct inode *inode = d_inode(path->dentry);
> +       int err, acc_mode;
> +
> +       if (flags & ~(O_ACCMODE | O_LARGEFILE))
> +               BUG();

This BUG: triggered on stable-rc 5.7, 5.4, 4.19 and 4.14 on arm64 architecture.

steps to reproduce:
          - cd /opt/ltp
          - ./runltp -s execveat03

[  461.024389] ------------[ cut here ]------------
[  461.029029] kernel BUG at fs/overlayfs/util.c:482!
[  461.033832] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  461.039328] Modules linked in: overlay rfkill tda998x
drm_kms_helper drm crct10dif_ce fuse
[  461.047637] CPU: 2 PID: 15049 Comm: execveat03 Not tainted
5.4.49-rc1-00549-g1d94fa9fbd5f #1
[  461.056093] Hardware name: ARM Juno development board (r2) (DT)
[  461.062026] pstate: 60000005 (nZCv daif -PAN -UAO)
[  461.066879] pc : ovl_path_open+0xc4/0xc8 [overlay]
[  461.071723] lr : ovl_path_open+0x2c/0xc8 [overlay]
[  461.076521] sp : ffff0008d9d578d0
[  461.079841] x29: ffff0008d9d578d0 x28: ffff00090821186c
[  461.085167] x27: ffff000908211800 x26: ffff000902fc7000
[  461.090493] x25: ffffa0000956e800 x24: ffff000902fc7540
[  461.095818] x23: ffff0008d9d57b80 x22: ffff00091149c880
[  461.101143] x21: ffff0008d9d57b80 x20: ffff0008dd24cb10
[  461.106467] x19: 0000000000004000 x18: 0000000000000000
[  461.111791] x17: 0000000000000000 x16: 0000000000000000
[  461.117114] x15: 0000000000000000 x14: ffffa00010395a3c
[  461.122439] x13: ffffa00010394ff0 x12: ffff80011baea816
[  461.127763] x11: 1fffe0011baea815 x10: ffff80011baea815
[  461.133087] x9 : dfffa00000000000 x8 : 0000000000000001
[  461.138411] x7 : ffff0008dd7540a8 x6 : 00000000f1f1f1f1
[  461.143735] x5 : 00000000f3000000 x4 : 000000000000002d
[  461.149059] x3 : dfffa00000000000 x2 : 0000000000000007
[  461.154383] x1 : 0000000000004000 x0 : 0000000000000000
[  461.159706] Call trace:
[  461.162201]  ovl_path_open+0xc4/0xc8 [overlay]
[  461.166697]  ovl_check_d_type_supported+0x98/0x178 [overlay]
[  461.172410]  ovl_fill_super+0x8b4/0x1c78 [overlay]
[  461.177215]  mount_nodev+0x4c/0xb8
[  461.180665]  ovl_mount+0x18/0x20 [overlay]
[  461.184772]  legacy_get_tree+0x70/0xb8
[  461.188531]  vfs_get_tree+0x48/0x158
[  461.192116]  do_mount+0x6f8/0xb38
[  461.195438]  ksys_mount+0x8c/0xe8
[  461.198762]  __arm64_sys_mount+0x64/0x80
[  461.202697]  el0_svc_common.constprop.0+0xa0/0x1d0
[  461.207500]  el0_svc_handler+0x34/0x98
[  461.211256]  el0_svc+0x8/0xc
[  461.214150] Code: f94013f5 a8c37bfd d65f03c0 d4210000 (d4210000)
[  461.220258] ---[ end trace 13147ca9b270cd0f ]---
[  461.224884] note: execveat03[15049] exited with preempt_count 1
[  461.233327] ------------[ cut here ]------------
[  461.237984] WARNING: CPU: 2 PID: 0 at kernel/rcu/tree.c:569
rcu_idle_enter+0xc4/0xd0
[  461.245742] Modules linked in: overlay rfkill tda998x
drm_kms_helper drm crct10dif_ce fuse
[  461.254052] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D
  5.4.49-rc1-00549-g1d94fa9fbd5f #1
[  461.263465] Hardware name: ARM Juno development board (r2) (DT)
[  461.269397] pstate: 20000085 (nzCv daIf -PAN -UAO)
[  461.274200] pc : rcu_idle_enter+0xc4/0xd0
 [  461.278224] lr : rcu_idle_enter+0x30/0xd0
[  461.282397] sp : ffff000935577e90
[  461.285715] x29: ffff000935577e90 x28: 0000000000000000
[  461.291202] x27: ffff00091330b800 x26: ffffa0001309e220
Broadcast message from systemd-jo[  461.296528] x25: ffff00093554ba00
x24: 1fffe00126aaefe4
urnald@juno (Tue 2020-06-23 03:3[  461.304710] x23: ffffa00012227c38
x22: ffffa0001309e1f8
3:27 UTC):
[  461.312810] x21: ffff0009366edc98 x20: ffffa00012231bc0
[  461.319253] x19: ffff0009366edbc0 x18: 0000000000000000
[  461.324576] x17: 0000000000000000 x16: 0000000000000000
[  461.329973] x15: 0000000000000000 x14: ffffa0001009d8c0
[  461.335298] x13: ffffa00010395afc x12: ffff800126cddb24
[  461.340784] x11: 1fffe00126cddb23 x10: ffff800126cddb23
kernel[310]: [  461.033832] Inter[  461.346109] x9 : dfffa00000000000
x8 : 0000000000000001
nal error: Oops - BUG: 0 [#1] PR[  461.354293] x7 : ffff0009366ed91b
x6 : ffff0009366ed918
EEMPT SMP
[  461.362392] x5 : 00007ffed93224dd x4 : 000000000000002d
[  461.368747] x3 : dfffa00000000000 x2 : 0000000000000007
[  461.374071] x1 : 4000000000000002 x0 : 4000000000000000
[  461.379468] Call trace:
[  461.381922]  rcu_idle_enter+0xc4/0xd0
[  461.385755]  do_idle+0x27c/0x320
exit01      1  TPASS  :  exit() t[  461.388992]  cpu_startup_entry+0x20/0x40
est PASSED[  461.395788]  secondary_start_kernel+0x250/0x2b8
[  461.401184] ---[ end trace 13147ca9b270cd10 ]---

test link,
https://lkft.validation.linaro.org/scheduler/job/1516380#L3866

metadata:
  git branch: linux-5.4.y
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git commit: 1d94fa9fbd5f0a775217d4180270dae8cede3f92
  git describe: v5.4.47-549-g1d94fa9fbd5f
  make_kernelversion: 5.4.49-rc1
  kernel-config:
https://builds.tuxbuild.com/-hEoWZbVgbGrYjKHXXPiuQ/kernel.config
  build-url: https://gitlab.com/Linaro/lkft/kernel-runs/-/pipelines/158927561


-- 
Linaro LKFT
https://lkft.linaro.org
