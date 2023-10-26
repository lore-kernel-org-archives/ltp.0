Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D68C25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 14:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36DD93CEC0F
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 16:41:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47E3C3CCB37
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 16:41:40 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E333602AFC
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 16:41:40 +0200 (CEST)
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-457c134a702so402843137.1
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698331299; x=1698936099; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dkQIfYRD2kmcDpWms4ZsCRkxZXL2yxY+N9F64I2+ea8=;
 b=SebSSsK54vfwseb/Ou9wl38M2bIFuu+dGKBMiQZDuciHFiauve/xFDDWvPeGy4mEJn
 3rm4FJvaEUrw42Oz4PpJu43Qx/PMy/zhW0Io1OwtPJlkBeQXDNA21nhaJGIfXaeSkND7
 Yl9TJDrpCXT2gYQTkcihljjb1cnG99bgznnqJWmmdEmeAJJaDc9SzAjxj3qNYUUW2YMu
 3F+e1DKKuozMHCVXl1idcmm3alAPDh0duH0jTl/clbCG0pDf7n75SzwMcwGd7ADIW1KD
 N9G9mI80n2sS4Z7I2F53o+KarYX70YtY3qviU2eOZXT35enRx0yGy/rBSY/X8zgEe0eO
 XKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698331299; x=1698936099;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dkQIfYRD2kmcDpWms4ZsCRkxZXL2yxY+N9F64I2+ea8=;
 b=d4qtADt8qiTqvHDYmGka/hXIaOxIPbTHW6NCrsJA2tsNtK5qJ/HYy2VHdXD7JJZrUV
 vn00z1vOhkt10HUWQ4E9EoWAnaQwFRY8VDdLjyCYiveBT91GTqHLSMdsBq/rz75lLZhm
 Qkt21qzAca8RUlcD97qkEt2eW1UHTcO+6ZkP/CKe6vVNOJKWjekqISdNCQSZyLTDD7oD
 VZX6+3gYL1B6qVlAdyy8TQecLPE0otLzV4mTS1dIZMo99d54mTvYvMI+hdqyDbiOBIR2
 pbneDVP3A7vp4JdQEAGm842G3Xe2zV/BDztUf3JqV79VhAHo2N/bOYbhwFuAfZv+3BVn
 0YBQ==
X-Gm-Message-State: AOJu0YxhecZ8iL5LO1vpfy8tMUtaDVPa0yOKHxJPEFDy48vEEr6d/+3Z
 7hhQgzhxKoDvQ2+r6dC7zBDsX4A2Xb92GOeExpA7Tg==
X-Google-Smtp-Source: AGHT+IHx/zSHMyLdiJUKh5V+MPBLxffqrEIdwj33SXOPeTKoTUXqNIPIpTc4e5soUgM9xhOpHwwDWwiE8UHKpHVyHg4=
X-Received: by 2002:a67:c20b:0:b0:452:99e0:54e3 with SMTP id
 i11-20020a67c20b000000b0045299e054e3mr17393798vsj.2.1698331298723; Thu, 26
 Oct 2023 07:41:38 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Oct 2023 20:11:26 +0530
Message-ID: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] qemu-arm64: handle_futex_death - kernel/futex/core.c:661 -
 Unable to handle kernel unknown 43 at virtual address
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Ingo Molnar <mingo@kernel.org>, LTP List <ltp@lists.linux.it>,
 Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following kernel crash noticed on qemu-arm64 while running LTP syscalls
set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 and
6.6.0-rc7-next-20231025.

BAD: next-20231025
Good: next-20231024

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Log:
----
<1>[  203.119139] Unable to handle kernel unknown 43 at virtual
address 0001ffff9e2e7d78
<1>[  203.119838] Mem abort info:
<1>[  203.120064]   ESR = 0x000000009793002b
<1>[  203.121040]   EC = 0x25: DABT (current EL), IL = 32 bits
set_robust_list01    1  TPASS  :  set_robust_list: retval = -1
(expected -1), errno = 22 (expected 22)
set_robust_list01    2  TPASS  :  set_robust_list: retval = 0
(expected 0), errno = 0 (expected 0)
<1>[  203.124496]   SET = 0, FnV = 0
<1>[  203.124778]   EA = 0, S1PTW = 0
<1>[  203.125029]   FSC = 0x2b: unknown 43
<1>[  203.126470] Data abort info:
<1>[  203.126710]   Access size = 4 byte(s)
<1>[  203.126969]   SSE = 0, SRT = 19
<1>[  203.127708]   SF = 0, AR = 0
<1>[  203.128213]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[  203.128788]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[  203.130416] user pgtable: 4k pages, 52-bit VAs, pgdp=000000010606a780
<1>[  203.130817] [0001ffff9e2e7d78] pgd=0000000000000000
<0>[  203.132603] Internal error: Oops: 000000009793002b [#1] PREEMPT SMP
<4>[  203.133483] Modules linked in: btrfs blake2b_generic libcrc32c
xor xor_neon raid6_pq zstd_compress crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
<4>[  203.135177] CPU: 1 PID: 653 Comm: set_robust_list Not tainted
6.6.0-rc7-next-20231026 #1
<4>[  203.135642] Hardware name: linux,dummy-virt (DT)
<4>[  203.136609] pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 203.137028] pc : handle_futex_death (kernel/futex/core.c:661
(discriminator 6))
<4>[ 203.138844] lr : handle_futex_death
(arch/arm64/include/asm/uaccess.h:46 (discriminator 1)
kernel/futex/core.c:661 (discriminator 1))
<4>[  203.139132] sp : ffff8000805c3c10
<4>[  203.139356] x29: ffff8000805c3c10 x28: 0000ffffbf187740 x27:
d53bd04035000220
<4>[  203.140366] x26: 0000000000000000 x25: fff00000c6195280 x24:
fff00000c6195280
<4>[  203.141055] x23: 0000000000000001 x22: ffffa4e6aeef09d0 x21:
0001ffff9e2e7d78
<4>[  203.141771] x20: 0001ffff9e2e7d78 x19: 0001ffff9e2e7d78 x18:
ffff8000805c3cf8
<4>[  203.142457] x17: 0000000000000000 x16: ffffa4e6aeae7078 x15:
000000000000000a
<4>[  203.143134] x14: 0000000000000000 x13: 1ffe000018258661 x12:
ffff8000805c3cf8
<4>[  203.143809] x11: 0000000000000000 x10: fff00000c12c3308 x9 :
ffffa4e6ad0e5748
<4>[  203.144504] x8 : ffff8000805c3c38 x7 : 0000000000000000 x6 :
0000000000000001
<4>[  203.145186] x5 : 0000000000000000 x4 : fff00000c6195280 x3 :
0000000000000000
<4>[  203.145929] x2 : 0000000000000000 x1 : 000ffffffffffffc x0 :
0001ffff9e2e7d78
<4>[  203.147032] Call trace:
<4>[ 203.147254] handle_futex_death (kernel/futex/core.c:661 (discriminator 6))
<4>[ 203.147560] exit_robust_list (kernel/futex/core.c:828)
<4>[ 203.148348] futex_exit_release (kernel/futex/core.c:1035
(discriminator 1) kernel/futex/core.c:1131 (discriminator 1))
<4>[ 203.148891] exit_mm_release (kernel/fork.c:1657)
<4>[ 203.149669] do_exit (kernel/exit.c:541 kernel/exit.c:858)
<4>[ 203.149897] do_group_exit (kernel/exit.c:1002)
<4>[ 203.150209] __arm64_sys_exit_group (kernel/exit.c:1032)
<4>[ 203.150980] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:56)
<4>[ 203.151234] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:144 (discriminator 2))
<4>[ 203.151999] do_el0_svc (arch/arm64/kernel/syscall.c:156)
<4>[ 203.152231] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 203.152936] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
<4>[ 203.153518] el0t_64_sync (arch/arm64/kernel/entry.S:595)
<0>[ 203.154424] Code: d50323bf d65f03c0 9248fa93 52800002 (b8400a73)
All code
========
   0: d50323bf autiasp
   4: d65f03c0 ret
   8: 9248fa93 and x19, x20, #0xff7fffffffffffff
   c: 52800002 mov w2, #0x0                    // #0
  10:* b8400a73 ldtr w19, [x19] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: b8400a73 ldtr w19, [x19]
<4>[  203.155308] ---[ end trace 0000000000000000 ]---
<1>[  203.156234] Fixing recursive fault but reboot is needed!
<3>[  203.157116] BUG: using smp_processor_id() in preemptible
[00000000] code: set_robust_list/653
<4>[ 203.158116] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
<4>[  203.158983] CPU: 1 PID: 653 Comm: set_robust_list Tainted: G
 D            6.6.0-rc7-next-20231026 #1
<4>[  203.159451] Hardware name: linux,dummy-virt (DT)
<4>[  203.159990] Call trace:
<4>[ 203.160394] dump_backtrace (arch/arm64/kernel/stacktrace.c:235)
<4>[ 203.160625] show_stack (arch/arm64/kernel/stacktrace.c:242)
<4>[ 203.160854] dump_stack_lvl (lib/dump_stack.c:107)
<4>[ 203.161869] dump_stack (lib/dump_stack.c:114)
<4>[ 203.162093] check_preemption_disabled
(arch/arm64/include/asm/current.h:19
arch/arm64/include/asm/preempt.h:54 lib/smp_processor_id.c:53)
<4>[ 203.162898] debug_smp_processor_id (lib/smp_processor_id.c:61)
<4>[ 203.163176] __schedule (kernel/sched/core.c:6578 (discriminator 1))
<4>[ 203.163894] do_task_dead (kernel/sched/core.c:6705)
<4>[ 203.164143] make_task_dead
(arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 3)
arch/arm64/include/asm/atomic.h:49 (discriminator 3)
include/linux/atomic/atomic-arch-fallback.h:747 (discriminator 3)
include/linux/atomic/atomic-instrumented.h:253 (discriminator 3)
include/linux/refcount.h:193 (discriminator 3)
include/linux/refcount.h:250 (discriminator 3)
include/linux/refcount.h:267 (discriminator 3) kernel/exit.c:979
(discriminator 3))
<4>[ 203.164871] die (arch/arm64/kernel/traps.c:239)
<4>[ 203.165093] die_kernel_fault (arch/arm64/mm/fault.c:321)
<4>[ 203.165905] do_mem_abort (arch/arm64/mm/fault.c:850)
<4>[ 203.166149] el1_abort (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:399)
<4>[ 203.166864] el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:486)
<4>[ 203.167173] el1h_64_sync (arch/arm64/kernel/entry.S:590)
<4>[ 203.167824] handle_futex_death (kernel/futex/core.c:661 (discriminator 6))
<4>[ 203.168329] exit_robust_list (kernel/futex/core.c:828)
<4>[ 203.168829] futex_exit_release (kernel/futex/core.c:1035
(discriminator 1) kernel/futex/core.c:1131 (discriminator 1))
<4>[ 203.169375] exit_mm_release (kernel/fork.c:1657)
<4>[ 203.169884] do_exit (kernel/exit.c:541 kernel/exit.c:858)
<4>[ 203.170372] do_group_exit (kernel/exit.c:1002)
<4>[ 203.170857] __arm64_sys_exit_group (kernel/exit.c:1032)
<4>[ 203.171643] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:56)
<4>[ 203.172281] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:144 (discriminator 2))
<4>[ 203.172815] do_el0_svc (arch/arm64/kernel/syscall.c:156)
<4>[ 203.173284] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 203.173769] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
<4>[ 203.174052] el0t_64_sync (arch/arm64/kernel/entry.S:595)



Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231026/testrun/20823098/suite/log-parser-test/test/check-kernel-bug/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231026/testrun/20823098/suite/log-parser-test/tests/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231026/testrun/20823050/suite/log-parser-test/tests/

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
