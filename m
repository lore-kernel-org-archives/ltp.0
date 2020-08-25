From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Aug 2020 01:04:16 +0530
Subject: [LTP] WARNING: at kernel/trace/ftrace.c:2425 ftrace_get_addr_new
Message-ID: <CA+G9fYu6OiLPb3CNCZmKYVqY-vd2-KU7tHNMmFuwpUaWTGb-xQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While running LTP tracing tests on qemu_i386 running mainline linux master
branch kernel the kernel warning continuously popped up on console.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git commit: 6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a
  git describe: v5.9-rc2-42-g6a9dc5fd6170
  make_kernelversion: 5.9.0-rc2
  kernel-config:
https://builds.tuxbuild.com/xpCK22s8vIl8tmDm4G8wVw/kernel.config

steps to reproduce:
# Boot qemu i386 with trace configs enabled.
# cd /opt/ltp
# ./runltp -f tracing

ftrace-stress-test 1 TINFO: killing 694
/opt/ltp/testcases/bin/ftrace_stress_test.sh: line 73:   694 Killed
              sh ftrace_${target}.sh
ftrace-stress-test 1 TINFO: Finished running the test. Run dmesg to
double-check for bugs
[  151.266804] ------------[ cut here ]------------
[  151.268375] WARNING: CPU: 0 PID: 654 at kernel/trace/ftrace.c:2425
ftrace_get_addr_new+0x8a/0xf0
[  151.270337] Modules linked in:
[  151.271117] CPU: 0 PID: 654 Comm: ftrace_stress_t Not tainted 5.9.0-rc2 #1
[  151.272718] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  151.274600] EIP: ftrace_get_addr_new+0x8a/0xf0
[  151.275694] Code: 8b 3b 8b 35 48 6b 50 d4 8b 46 30 8b 48 04 8b 10
89 f8 e8 09 df ff ff 84 c0 75 55 8b 76 04 85 f6 74 08 81 fe 60 6b 50
d4 75 de <0f> 0b c7 05 54 6b 50 d4 00 00 00 00 c7 05 44 6b 50 d4 f0 ca
2c d3
[  151.279628] EAX: 00000000 EBX: f4c40000 ECX: 00000000 EDX: 00000000
[  151.280844] ESI: d4507040 EDI: d32002e8 EBP: f32ddea0 ESP: f32dde94
[  151.281737] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  151.282762] CR0: 80050033 CR2: 0a0849e0 CR3: 328bd000 CR4: 003506d0
[  151.283725] Call Trace:
[  151.284148]  ftrace_replace_code+0x12f/0x150
[  151.284791]  ftrace_modify_all_code+0xba/0x170
[  151.285531]  arch_ftrace_update_code+0x8/0x10
[  151.286158]  ftrace_run_update_code+0x16/0x80
[  151.286808]  ftrace_startup_enable+0x30/0x40
[  151.287550]  ftrace_enable_sysctl+0x124/0x15e
[  151.288173]  ? ftrace_is_dead+0x10/0x10
[  151.288781]  proc_sys_call_handler+0x11f/0x150
[  151.289502]  ? proc_sys_call_handler+0x150/0x150
[  151.290170]  proc_sys_write+0x12/0x20
[  151.290741]  vfs_write+0xb3/0x200
[  151.291393]  ksys_write+0x58/0xd0
[  151.291885]  __ia32_sys_write+0x15/0x20
[  151.292476]  __do_fast_syscall_32+0x3f/0x70
[  151.293090]  do_fast_syscall_32+0x29/0x60
[  151.293739]  do_SYSENTER_32+0x15/0x20
[  151.294357]  entry_SYSENTER_32+0x9f/0xf2
[  151.294955] EIP: 0xb7f85549
[  151.295450] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  151.298035] EAX: ffffffda EBX: 00000001 ECX: 0a08b9f0 EDX: 00000002
[  151.299024] ESI: 0a08b9f0 EDI: 00000002 EBP: b7f4ed80 ESP: bf8f9e90
[  151.299992] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  151.301039] ---[ end trace 13d91cd42a9362c2 ]---
[  151.301820] Bad trampoline accounting at: 97ee436a
(sanitize_boot_params.constprop.0+0x0/0xa8) (10000001)
[  151.303214] ------------[ cut here ]------------
[  151.303985] WARNING: CPU: 0 PID: 654 at kernel/trace/ftrace.c:2425
ftrace_get_addr_new+0x8a/0xf0
[  151.305246] Modules linked in:
[  151.305768] CPU: 0 PID: 654 Comm: ftrace_stress_t Tainted: G
W         5.9.0-rc2 #1
[  151.306984] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  151.308241] EIP: ftrace_get_addr_new+0x8a/0xf0
[  151.308964] Code: 8b 3b 8b 35 48 6b 50 d4 8b 46 30 8b 48 04 8b 10
89 f8 e8 09 df ff ff 84 c0 75 55 8b 76 04 85 f6 74 08 81 fe 60 6b 50
d4 75 de <0f> 0b c7 05 54 6b 50 d4 00 00 00 00 c7 05 44 6b 50 d4 f0 ca
2c d3
[  151.311612] EAX: 00000000 EBX: f4c40008 ECX: 00000000 EDX: 00000000
[  151.312594] ESI: d4507040 EDI: d3200390 EBP: f32ddea0 ESP: f32dde94
[  151.313544] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  151.314544] CR0: 80050033 CR2: 0a0849e0 CR3: 328bd000 CR4: 003506d0
[  151.315543] Call Trace:
[  151.315947]  ftrace_replace_code+0x12f/0x150
[  151.316589]  ftrace_modify_all_code+0xba/0x170
[  151.317325]  arch_ftrace_update_code+0x8/0x10
[  151.317948]  ftrace_run_update_code+0x16/0x80
[  151.318626]  ftrace_startup_enable+0x30/0x40
[  151.319367]  ftrace_enable_sysctl+0x124/0x15e
[  151.320025]  ? ftrace_is_dead+0x10/0x10
[  151.320613]  proc_sys_call_handler+0x11f/0x150
[  151.321346]  ? proc_sys_call_handler+0x150/0x150
[  151.322042]  proc_sys_write+0x12/0x20
[  151.322639]  vfs_write+0xb3/0x200
[  151.323192]  ksys_write+0x58/0xd0
[  151.323748]  __ia32_sys_write+0x15/0x20
[  151.324386]  __do_fast_syscall_32+0x3f/0x70
[  151.324991]  do_fast_syscall_32+0x29/0x60
[  151.325597]  do_SYSENTER_32+0x15/0x20
[  151.326170]  entry_SYSENTER_32+0x9f/0xf2
[  151.326774] EIP: 0xb7f85549
[  151.327209] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  151.329767] EAX: ffffffda EBX: 00000001 ECX: 0a08b9f0 EDX: 00000002
[  151.330777] ESI: 0a08b9f0 EDI: 00000002 EBP: b7f4ed80 ESP: bf8f9e90
[  151.331762] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  151.332774] ---[ end trace 13d91cd42a9362c3 ]---
[  151.333520] Bad trampoline accounting at: f22f519e
(trace_initcall_finish_cb+0x0/0x40) (10000001)
[  151.334788] ------------[ cut here ]------------
[  151.335586] WARNING: CPU: 0 PID: 654 at kernel/trace/ftrace.c:2425
ftrace_get_addr_new+0x8a/0xf0
[  151.336843] Modules linked in:
[  151.337358] CPU: 0 PID: 654 Comm: ftrace_stress_t Tainted: G
W         5.9.0-rc2 #1
[  151.338541] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  151.339826] EIP: ftrace_get_addr_new+0x8a/0xf0
[  151.340547] Code: 8b 3b 8b 35 48 6b 50 d4 8b 46 30 8b 48 04 8b 10
89 f8 e8 09 df ff ff 84 c0 75 55 8b 76 04 85 f6 74 08 81 fe 60 6b 50
d4 75 de <0f> 0b c7 05 54 6b 50 d4 00 00 00 00 c7 05 44 6b 50 d4 f0 ca
2c d3
[  151.343103] EAX: 00000000 EBX: f4c40010 ECX: 00000000 EDX: 00000000
[  151.344098] ESI: d4507040 EDI: d32007c0 EBP: f32ddea0 ESP: f32dde94
[  151.345026] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  151.346078] CR0: 80050033 CR2: 0a0849e0 CR3: 328bd000 CR4: 003506d0
[  151.346987] Call Trace:
[  151.347447]  ftrace_replace_code+0x12f/0x150
[  151.348075]  ftrace_modify_all_code+0xba/0x170
[  151.348745]  arch_ftrace_update_code+0x8/0x10
[  151.349501]  ftrace_run_update_code+0x16/0x80
[  151.350175]  ftrace_startup_enable+0x30/0x40
[  151.350845]  ftrace_enable_sysctl+0x124/0x15e
[  151.351605]  ? ftrace_is_dead+0x10/0x10
[  151.352170]  proc_sys_call_handler+0x11f/0x150
[  151.352832]  ? proc_sys_call_handler+0x150/0x150
[  151.353599]  proc_sys_write+0x12/0x20
[  151.354163]  vfs_write+0xb3/0x200
[  151.354694]  ksys_write+0x58/0xd0
[  151.355237]  __ia32_sys_write+0x15/0x20
[  151.355848]  __do_fast_syscall_32+0x3f/0x70
[  151.356525]  do_fast_syscall_32+0x29/0x60
[  151.357106]  do_SYSENTER_32+0x15/0x20
[  151.357675]  entry_SYSENTER_32+0x9f/0xf2
[  151.358391] EIP: 0xb7f85549
[  151.358821] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  151.361407] EAX: ffffffda EBX: 00000001 ECX: 0a08b9f0 EDX: 00000002
[  151.362434] ESI: 0a08b9f0 EDI: 00000002 EBP: b7f4ed80 ESP: bf8f9e90
[  151.363367] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  151.364402] ---[ end trace 13d91cd42a9362c4 ]---
[  151.365082] Bad trampoline accounting at: f89b861d
(initcall_blacklisted+0x0/0xd0) (10000001)
[  151.366309] ------------[ cut here ]------------
[  151.367062] WARNING: CPU: 0 PID: 654 at kernel/trace/ftrace.c:2425
ftrace_get_addr_new+0x8a/0xf0

ref:
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.9-rc2-42-g6a9dc5fd6170/testrun/3113849/suite/linux-log-parser/test/check-kernel-exception-1707157/log


-- 
Linaro LKFT
https://lkft.linaro.org
