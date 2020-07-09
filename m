From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 9 Jul 2020 10:06:24 +0530
Subject: [LTP] BUG: KASAN: global-out-of-bounds in
 is_affected_midr_range_list on arm64
Message-ID: <CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While running LTP cpuhotplug test on mainline 5.8.0-rc4 the kernel BUG noticed
on arm64 Juno-r2 KASAN config enabled kernel.

steps to reproduce:
- boot KASAN enabled Juno-r2 device
- cd /opt/ltp
- ./runltp -f cpuhotplug

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git commit: 63e1968a2c87e9461e9694a96991935116e0cec7
  kernel-config:
https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/kernel.config
  vmlinux: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/vmlinux.xz
  system.map: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/System.map

Test log:
Name:   cpuhotplug02
Date:   Thu Jul  9 00:09:24 UTC 2020
Desc:   What happens to a process when its CPU is offlined?

CPU is 1
[  123.400330] process 722 (cpuhotplug_do_s) no longer affine to cpu1
[  123.400428] CPU1: shutdown
[  123.409425] psci: CPU1 killed (polled 0 ms)
[  123.752216] ==================================================================
[  123.759476] BUG: KASAN: global-out-of-bounds in
is_affected_midr_range_list+0x50/0xe8
[  123.767327] Read of size 4 at addr ffffa0001159bf78 by task swapper/1/0
[  123.773953]
[  123.775453] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc4 #1
[  123.781648] Hardware name: ARM Juno development board (r2) (DT)
[  123.787579] Call trace:
[  123.790041]  dump_backtrace+0x0/0x2b8
[  123.793716]  show_stack+0x18/0x28
[  123.797043]  dump_stack+0xec/0x158
[  123.800456]  print_address_description.isra.0+0x6c/0x448
[  123.805785]  kasan_report+0x134/0x200
[  123.809457]  __asan_load4+0x9c/0xd8
[  123.812957]  is_affected_midr_range_list+0x50/0xe8
[  123.817763]  has_cortex_a76_erratum_1463225+0x10/0x30
[  123.822830]  verify_local_cpu_caps+0xbc/0x1a0
[  123.827202]  check_local_cpu_capabilities+0x24/0x128
[  123.832183]  secondary_start_kernel+0x1b8/0x2b0
[  123.836719]
[  123.838211] The buggy address belongs to the variable:
[  123.843364]  erratum_1463225+0x18/0x40
[  123.847117]
[  123.848607] Memory state around the buggy address:
[  123.853413]  ffffa0001159be00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  123.860654]  ffffa0001159be80: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  123.867895] >ffffa0001159bf00: 00 00 00 00 00 00 00 00 fa fa fa fa
00 00 00 fa
[  123.875131]                                                                 ^
[  123.882286]  ffffa0001159bf80: fa fa fa fa 00 00 00 00 00 00 00 00
00 fa fa fa
[  123.889526]  ffffa0001159c000: fa fa fa fa 00 00 00 00 00 00 00 00
00 00 00 00
[  123.896762] ==================================================================
[  123.903997] Disabling lock debugging due to kernel taint
[  123.909333] Detected PIPT I-cache on CPU1
[  123.913420] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]

Full test log link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.8-rc4-81-g63e1968a2c87/testrun/2911119/suite/linux-log-parser/test/check-kernel-bug-1548361/log

-- 
Linaro LKFT
https://lkft.linaro.org
