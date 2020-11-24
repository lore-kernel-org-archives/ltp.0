From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Nov 2020 18:52:44 +0530
Subject: [LTP] kernel BUG at mm/highmem.c:417! invalid opcode: 0000 EIP:
 zero_user_segments
Message-ID: <CA+G9fYuKZGaHVvAv=ZwOL_p6UM3YhOHy0DcJRRM_DOLGYXg1Dw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While running LTP test case access01 the following kernel BUG
noticed on linux next 20201124 tag kernel on i386.

git short log:
----------------
git log --oneline next-20201120..next-20201124 -- mm/highmem.c
d9927d46febf Merge branch 'akpm-current/current'
72d22a0d0e86 mm: support THPs in zero_user_segments
2a656cad337e mm/highmem: Take kmap_high_get() properly into account

Please find these easy steps to reproduce the kernel build and boot.

step to reproduce:
# please install tuxmake
# sudo pip3 install -U tuxmake
# cd linux-next
# tuxmake --runtime docker --target-arch i386 --toolchain gcc-9
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1kj7IzwXtISXHWGaaR15CRHM2Zt/config

# Boot the i386 kernel on x86_64 devices.
# run LTP
# cd /opt/ltp
# ./runltp -s access01
# you will notice the below BUG

crash log:
-------------
access01.c:243: TPASS: access(accessfile_r, R_OK|W_OK) as root
access01.c:243: TPASS: access(accessfile_w, R_OK) as root
access01.c:243: TPASS: access(accessfi[   50.847347] ------------[ cut
here ]------------
[   50.852189] kernel BUG at mm/highmem.c:417!
le_w, R_OK|W_OK)[   50.856437] invalid opcode: 0000 [#1] SMP
[   50.861774] CPU: 2 PID: 628 Comm: loop0 Not tainted
5.10.0-rc5-next-20201124 #2
[   50.869073] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   50.876457] EIP: zero_user_segments+0x242/0x250
[   50.880987] Code: e4 fe ff ff 8d 74 26 00 85 c0 0f 84 30 ff ff ff
c6 01 00 a8 02 0f 84 25 ff ff ff 31 ff 66 89 7c 01 fe e9 19 ff ff ff
90 0f 0b <0f> 0b 8d b4 26 00 00 00 00 8d 74 26 00 90 3e 8d 74 26 00 55
89 e5
[   50.899723] EAX: 00000e00 EBX: 00000001 ECX: f6e6f860 EDX: 00000e00
[   50.905983] ESI: 00000000 EDI: 00000e00 EBP: dec35c7c ESP: dec35c60
[   50.912237] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
[   50.919015] CR0: 80050033 CR2: 011bcd40 CR3: 163b1000 CR4: 003506d0
[   50.925272] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   50.931530] DR6: fffe0ff0 DR7: 00000400
[   50.935360] Call Trace:
[   50.937807]  __block_write_begin_int+0x3ec/0x640
[   50.942426]  ? __ext4_get_inode_loc_noinmem+0x80/0x80
[   50.947478]  __block_write_begin+0x15/0x20
[   50.951566]  ? __ext4_get_inode_loc_noinmem+0x80/0x80
[   50.956611]  ext4_da_write_begin+0x170/0x3a0
[   50.960874]  ? __ext4_get_inode_loc_noinmem+0x80/0x80
[   50.965920]  generic_perform_write+0x9c/0x180
[   50.970279]  ext4_buffered_write_iter+0x91/0x170
[   50.974888]  ext4_file_write_iter+0x112/0x910
[   50.979240]  ? check_preempt_wakeup+0x100/0x250
[   50.983773]  ? _cond_resched+0x17/0x30
[   50.987524]  ? __inode_security_revalidate+0x68/0x80
[   50.992481]  do_iter_readv_writev+0x18e/0x1c0
[   50.996831]  ? ext4_dio_supported+0x40/0x40
[   51.001010]  do_iter_write+0x74/0x1b0
[   51.004665]  ? ext4_dio_supported+0x40/0x40
[   51.008845]  vfs_iter_write+0x1b/0x30
[   51.012510]  lo_write_bvec+0x54/0x170
[   51.016175]  loop_queue_work+0x1bd/0x9e0
[   51.020092]  ? finish_task_switch+0x7c/0x3c0
[   51.024356]  ? kthread_worker_fn+0x6e/0x250
[   51.028535]  ? loop_kthread_worker_fn+0x1b/0x20
[   51.033067]  kthread_worker_fn+0xa0/0x250
[   51.037070]  ? lo_rw_aio+0x3c0/0x3c0
[   51.040640]  ? loop_set_status_from_info+0x350/0x350
[   51.045596]  loop_kthread_worker_fn+0x1b/0x20
[   51.049948]  kthread+0xf0/0x120
[   51.053084]  ? loop_set_status_from_info+0x350/0x350
[   51.058042]  ? kthread_park+0xa0/0xa0
[   51.061701]  ret_from_fork+0x1c/0x28
[   51.065269] Modules linked in: x86_pkg_temp_thermal
 as root
access[   51.070275] ---[ end trace d002cac2383c24be ]---
[   51.076150] EIP: zero_user_segments+0x242/0x250
01.c:243: TPASS:[   51.080778] Code: e4 fe ff ff 8d 74 26 00 85 c0 0f
84 30 ff ff ff c6 01 00 a8 02 0f 84 25 ff ff ff 31 ff 66 89 7c 01 fe
e9 19 ff ff ff 90 0f 0b <0f> 0b 8d b4 26 00 00 00 00 8d 74 26 00 90 3e
8d 74 26 00 55 89 e5
[   51.100815] EAX: 00000e00 EBX: 00000001 ECX: f6e6f860 EDX: 00000e00
 access(accessfi[   51.107174] ESI: 00000000 EDI: 00000e00 EBP:
dec35c7c ESP: dec35c60
[   51.114723] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
le_x, R_OK) as r[   51.121608] CR0: 80050033 CR2: 011bcd40 CR3:
163b1000 CR4: 003506d0
[   51.129153] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
oot
access01.c:[   51.135518] DR6: fffe0ff0 DR7: 00000400
243: TPASS: access(accessfile_x, W_OK) as root
access01.c:243: TPASS: access(accessfile_x, R_OK|W_OK) as root
access01.c:243: TPASS: access(accessdir_r/accessfile_r, F_OK) as root

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

full test log,
https://lkft.validation.linaro.org/scheduler/job/1978393#L1593
https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20201124/testrun/3487539/suite/linux-log-parser/test/check-kernel-bug-1978393/log


metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: d9137320ac06f526fe3f9a3fdf07a3b14201068a
  git describe: next-20201124
  make_kernelversion: 5.10.0-rc5
  kernel-config: https://builds.tuxbuild.com/1kj7IzwXtISXHWGaaR15CRHM2Zt/config


-- 
Linaro LKFT
https://lkft.linaro.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kernel-bug-mm-highmem-next-20201124.log
Type: text/x-log
Size: 3652 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201124/10f03d73/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-i386-20201124
Type: application/octet-stream
Size: 133200 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201124/10f03d73/attachment-0001.obj>
