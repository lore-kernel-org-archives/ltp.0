Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B0EC678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 10:05:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 871583CD9C4
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 11:05:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 342263C30A8
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 11:05:14 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E013D1000A68
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 11:05:13 +0100 (CET)
Received: by mail-ua1-x935.google.com with SMTP id x40so8462561uaf.2
 for <ltp@lists.linux.it>; Tue, 07 Mar 2023 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1678183512;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZJQteWRnYzXph7B/Yag6wboM2N2GJr+YfQg8dgWg9fg=;
 b=i8YkSnXonegkW6NuzrPQBnddeL5AYYykbpX7rf6mfB8qYXCajrksSX8+6x4H5APR+w
 CyNC62BEdd3IYiqGt744W8UizLpcEOdhUiDZRYh/JcwTFH6rlLqr7g9s07erwqZcY7dp
 q/F4VRUtobYOSrlJ7QIQWS6hZAgJzvST7krsB060SCJMGqiX21BS0uo1RLBt3V0qA+Cf
 WT23cEsgXMPi/eZrq57WQU3qNvc/9+1vGZmbtzjWxUWi/VDuq4oxgV+Sg408FcGFZxpi
 ft4GnPZVeN7MdoezfV5rJKQ0+V0oxD6qCplcauC3YCrpheLCf/aDfQi/OCF/2Gopx5U0
 RQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678183512;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJQteWRnYzXph7B/Yag6wboM2N2GJr+YfQg8dgWg9fg=;
 b=zoKrmjuIlailKeAoSf9nIBmjsc6TwM4LcaQUawIim0d7QuB3WY7tUuzqjM5Q9EfVtX
 esqjFhtmd9zTMXEUGpfC2Z9DLIp4UedM2VG9vZx0Hk8vExf1tcn9GaLy8hhbl+gc3jiM
 4y0Oqc9F7TMKk2KJnrwai3uAvElCKCcBfS7SHR5P1iFvLyXLL8ysaiUBW/ux8gNoHCqe
 5YTXalBIXCdrB3HBw+oRRtXRA5D5LxQYagqbVxU8qpAgjaZkPiIgbDhZK4o1tYk2wDJv
 SSaIcSzMgOEQoWBlRx2QRpzfZ0M+/yQn4NgW0A3ADbmd06o16noUFW8/EVtioq7ndx38
 k95w==
X-Gm-Message-State: AO0yUKXlkZEVHZIBv163p/hoiv9PBZbk0l2hHbN174kyDRuy1Y3Dq9jJ
 9XcIBg7mPXIun9RS6eMb4vihmRT6Lc11glrEYdwCcA==
X-Google-Smtp-Source: AK7set8c+gLtppl3OV34UlpT2NVSBrBDOXjbBL6Qoi5a7s9uQCdvDonXutxUCPmrYcSLhl/Eg4gal+XbsMwFV15tygk=
X-Received: by 2002:a1f:e483:0:b0:406:3e8d:92c8 with SMTP id
 b125-20020a1fe483000000b004063e8d92c8mr8898453vkh.1.1678183512529; Tue, 07
 Mar 2023 02:05:12 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Mar 2023 15:35:01 +0530
Message-ID: <CA+G9fYuJJySMY_6oLx_R_ebX9wDkwTLbDW7f7_CqF9UgFhSajg@mail.gmail.com>
To: linux-clk <linux-clk@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] ftrace_regression01: qemu-i386: EIP: vm_area_free: Kernel
 panic - not syncing: Fatal exception in interrupt
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following kernel panic noticed While running LTP tracing tests on
qemu-i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


[    0.000000] Linux version 6.3.0-rc1 (tuxmake@tuxmake) (Debian clang
version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
Debian LLD 16.0.0) #1 SMP PREEMPT_DYNAMIC @1678136838
...
LTP tracing tests
Running tests.......
<6>[   35.957375] traps: systemd-network[287] trap invalid opcode
ip:b7d99bef sp:bfcf8e20 error:0 in
libsystemd-shared-250.so[b7c33000+1c0000]
<6>[   39.887678] traps: systemd-network[330] trap invalid opcode
ip:b7db0bef sp:bfb6ab00 error:0 in
libsystemd-shared-250.so[b7c4a000+1c0000]
<4>[   41.883172] clocksource: timekeeping watchdog on CPU0: Marking
clocksource 'tsc' as unstable because the skew is too large:
<4>[   41.885195] clocksource:                       'acpi_pm'
wd_nsec: 633206175 wd_now: 13fe92 wd_last: f168b4 mask: ffffff
<4>[   41.886363] clocksource:                       'tsc' cs_nsec:
5320282620 cs_now: 1cbab6bece cs_last: 19231a48ea mask:
ffffffffffffffff
<4>[   41.887503] clocksource:                       Clocksource 'tsc'
skewed 4687076445 ns (4687 ms) over watchdog 'acpi_pm' interval of
633206175 ns (633 ms)
<4>[   41.888583] clocksource:                       'tsc' is current
clocksource.
<6>[   41.889615] tsc: Marking TSC unstable due to clocksource watchdog
<4>[   41.894933] TSC found unstable after boot, most likely due to
broken BIOS. Use 'tsc=unstable'.
<6>[   41.895623] sched_clock: Marking unstable (41348265135,
546543322)<-(41919545028, -24729054)
<4>[   41.905093] clocksource: Checking clocksource tsc
synchronization from CPU 1 to CPUs 0.
<6>[   41.921496] clocksource: Switched to clocksource acpi_pm
<47>[   42.122074] systemd-journald[108]: Successfully sent stream
file descriptor to service manager.

ftrace_regression01 1 TPASS: Finished running the test

<4>[   43.795642] int3: 0000 [#1] PREEMPT SMP
<4>[   43.795642] CPU: 0 PID: 331 Comm: systemd-network Not tainted 6.3.0-rc1 #1
<4>[   43.795642] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[   43.795642] EIP: vm_area_free+0x1/0x20
<4>[   43.795642] Code: e5 85 1d 00 85 c0 74 14 b9 11 00 00 00 89 c7
f3 a5 89 c1 83 c1 24 89 48 24 89 48 28 5e 5f 5d c3 90 90 90 90 90 90
90 90 90 3e <8d> 74 26 00 55 89 e5 89 c2 a1 ac 99 82 d3 e8 fc 8f 1d 00
5d c3 90
<4>[   43.795642] EAX: c243bab0 EBX: c243bab0 ECX: 00000000 EDX: c23cb9c0
<4>[   43.795642] ESI: 00000000 EDI: 000001c0 EBP: c25c1e24 ESP: c25c1dd0
<4>[   43.795642] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000246
<4>[   43.795642] CR0: 80050033 CR2: 081d764c CR3: 02ce1000 CR4: 000006d0
<4>[   43.795642] Call Trace:
<4>[   43.795642]  ? do_vmi_align_munmap+0x26e/0x380
<4>[   43.795642]  mmap_region+0x26e/0x880
<4>[   43.795642]  ? arch_ftrace_ops_list_func+0x20/0x1a0
<4>[   43.795642]  ? ftrace_call+0x5/0x13
<4>[   43.795642]  do_mmap+0x33f/0x4b0
<4>[   43.795642]  ? do_mmap+0x3f6/0x4b0
<4>[   43.795642]  vm_mmap_pgoff+0x9b/0x120
<4>[   43.795642]  ksys_mmap_pgoff+0x15d/0x1b0
<4>[   43.795642]  __ia32_sys_mmap_pgoff+0x21/0x30
<4>[   43.795642]  do_int80_syscall_32+0x39/0x74
<4>[   43.795642]  entry_INT80_32+0xf0/0xf0
<4>[   43.795642] EIP: 0xb7f7d9c1
<4>[   43.795642] Code: c3 8d b4 26 00 00 00 00 90 8b 5c 24 08 01 c3
8b 6c 2b 40 89 2f eb b6 66 90 f3 0f 1e fb 53 57 55 8b 1f 8b 6f 08 8b
7f 04 cd 80 <5d> 5f 5b c3 66 90 66 90 66 90 66 90 66 90 90 f3 0f 1e fb
e8 5a 00
<4>[   43.795642] EAX: ffffffda EBX: b7c94000 ECX: 001c0000 EDX: 00000005
<4>[   43.795642] ESI: 00000812 EDI: 00000004 EBP: 0000003b ESP: bff393e0
<4>[   43.795642] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000202
<4>[   43.795642] Modules linked in:
<4>[   43.795642]  \
 ---[ end trace 0000000000000000 ]---
<4>[   43.795642] EIP: vm_area_free+0x1/0x20
<4>[   43.795642] Code: e5 85 1d 00 85 c0 74 14 b9 11 00 00 00 89 c7
f3 a5 89 c1 83 c1 24 89 48 24 89 48 28 5e 5f 5d c3 90 90 90 90 90 90
90 90 90 3e <8d> 74 26 00 55 89 e5 89 c2 a1 ac 99 82 d3 e8 fc 8f 1d 00
5d c3 90
<4>[   43.795642] EAX: c243bab0 EBX: c243bab0 ECX: 00000000 EDX: c23cb9c0
<4>[   43.795642] ESI: 00000000 EDI: 000001c0 EBP: c25c1e24 ESP: c25c1dd0
<4>[   43.795642] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000246
<4>[   43.795642] CR0: 80050033 CR2: 081d764c CR3: 02ce1000 CR4: 000006d0
<0>[   43.795642] Kernel panic - not syncing: Fatal exception in interrupt
<0>[   43.795642] Kernel Offset: disabled

test log:
-----
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc1-2-g8ca09d5fa354/testrun/15298979/suite/log-parser-test/test/check-kernel-panic/log
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc1-2-g8ca09d5fa354/testrun/15298979/suite/log-parser-test/tests/


steps to reproduce:
--------------
# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.37.2
#
# See https://tuxrun.org/ for complete documentation.

tuxrun  \
 --runtime podman  \
 --device qemu-i386  \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2MemUurDShqDi3xoAvTknd2dbfd/bzImage
 \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2MemUurDShqDi3xoAvTknd2dbfd/modules.tar.xz
 \
 --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2MV9clY6B5uyK3SNAIPgiO5gCoP/images/intel-core2-32/lkft-tux-image-intel-core2-32-20230303113918.rootfs.ext4.gz
 \
 --parameters SKIPFILE=skipfile-lkft.yaml  \
 --parameters SHARD_NUMBER=4  \
 --parameters SHARD_INDEX=1  \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
 --tests ltp-tracing  \
 --timeouts boot=15 ltp-tracing=30


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
