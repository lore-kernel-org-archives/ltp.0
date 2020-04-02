From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 Apr 2020 16:49:02 +0530
Subject: [LTP] mm/mremap.c : WARNING: at mm/mremap.c:211
 move_page_tables+0x5b0/0x5d0
Message-ID: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While running LTP mm thp01 test case on i386 kernel running on x86_64 device
the following kernel warning was noticed multiple times.

This issue is not new,
we have noticed on stable-rc 5.4, stable-rc 5.5 and stable-rc 5.6 branches.
FYI, CONFIG_HAVE_MOVE_PMD=y is set on
and total memory 2.2G as per free output.

steps to reproduce:
--------------------
boot i386 kernel on x86_64 device,
cd /opt/ltp
./runltp -f mm
thp01.c:98: PASS: system didn't crash.
thp01.c:98: PASS: system didn't crash.
thp01.c:98: PASS: system didn't crash.

[  207.317499] ------------[ cut here ]------------
[  207.322153] WARNING: CPU: 0 PID: 18963 at mm/mremap.c:211
move_page_tables+0x5b0/0x5d0
[  207.330061] Modules linked in: x86_pkg_temp_thermal
[  207.334940] CPU: 0 PID: 18963 Comm: true Tainted: G        W
 5.6.2-rc1+ #1
[  207.342498] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  207.349881] EIP: move_page_tables+0x5b0/0x5d0
[  207.354233] Code: 00 00 c0 ff 2b 45 08 39 c3 0f 46 c3 89 45 d4 01
f8 89 45 cc e9 7e fb ff ff 8d 45 d8 83 4d e8 01 e8 65 b0 01 00 e9 b2
fa ff ff <0f> 0b 80 7d be 00 0f 84 7e fd ff ff 31 db e9 74 fe ff ff 31
db e9
[  207.372969] EAX: 7ce5f067 EBX: 00400000 ECX: e2cc8000 EDX: 00000000
[  207.379225] ESI: e2cc8bfc EDI: bfc00000 EBP: f3273e18 ESP: f3273dc0
[  207.385484] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010202
[  207.392261] CR0: 80050033 CR2: b7d02f50 CR3: 22cc8000 CR4: 003406d0
[  207.398517] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  207.404774] DR6: fffe0ff0 DR7: 00000400
[  207.408605] Call Trace:
[  207.411053]  setup_arg_pages+0x22b/0x310
[  207.414977]  ? security_bprm_committed_creds+0x22/0x30
[  207.420107]  load_elf_binary+0x2fb/0x10a0
[  207.424110]  ? selinux_inode_permission+0xfb/0x1d0
[  207.428894]  ? bm_status_write+0x61/0xa0
[  207.432811]  ? security_inode_permission+0x2c/0x50
[  207.437597]  ? writenote+0xb0/0xb0
[  207.440992]  search_binary_handler+0x77/0x190
[  207.445356]  __do_execve_file+0x429/0x760
[  207.449375]  sys_execve+0x21/0x30
[  207.452693]  do_fast_syscall_32+0x7a/0x280
[  207.456784]  entry_SYSENTER_32+0xa5/0xf8
[  207.460702] EIP: 0xb7ee7c5d
[  207.463491] Code: Bad RIP value.
[  207.466716] EAX: ffffffda EBX: bfff9ed0 ECX: 08069420 EDX: bfffa134
[  207.472971] ESI: 080599d4 EDI: bfff9ed9 EBP: bfff9f78 ESP: bfff9ea8
[  207.479230] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  207.486008] ---[ end trace d49b75932d5396d5 ]---

full test log,
https://lkft.validation.linaro.org/scheduler/job/1328795#L14498
https://lkft.validation.linaro.org/scheduler/job/1331455#L8923
https://lkft.validation.linaro.org/scheduler/job/1331632#L17251

Kernel config:
https://builds.tuxbuild.com/RJ9BGpsgfPfj3Sfje8oLSw/kernel.config

Test case source:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/thp/thp01.c
-- 
Linaro LKFT
https://lkft.linaro.org
