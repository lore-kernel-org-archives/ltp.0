Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC7ACE79AC
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:29:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2663CE3E0
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 11:29:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DA33CBFDB
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:29:25 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7D6C1A0197E
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:29:24 +0200 (CEST)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-49351972caeso2382667e0c.1
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695202163; x=1695806963; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nbOx1BbglWhHdxW1iStH8Zi/cenHx3K/euDipqng7jI=;
 b=JNMHdVi/Qtvxy13Jz6yrY8vZVPKxDFSxdNPXfhXS13XNcBwhbZHT8nwNORo4U79QIx
 5pJ7eFP++KZqKedWN/zSNekfrGoKcHfCPij21yY0FCA+FxMregtleJbcMEKXpOP8vUD/
 0+OhAHDoZKmvPXeGCAnXy6A3xo88QNZQI0mkpzTHtpUTZkQScN4rXyycg0sR57/2pDtV
 F/rqeEYkpbmGGuJzHSS724L0uVEUNlQjjhdvqpzrninKkT6yJchOEaNQJyAMWUP7IKUx
 GEcGTVr8Dut8yvG+xOTThTApUaqW3gsHIVfsIrL0vvgwoj/xofR39Wk27PZKTHPI0t1b
 8MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695202163; x=1695806963;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbOx1BbglWhHdxW1iStH8Zi/cenHx3K/euDipqng7jI=;
 b=CVv3fnhzQQKOEjVcvFXX96uRM/WlLph/RQIYXOAvF5csk9DYT4c8ov/yMfPZ3F0p0H
 mIEt9GKPxQ7UuH4lR31/8/pQ9Birf2qkqe0xXm9pCpYm3kdFej7d3s3BBy1QYhMm7s5l
 dgIJ5GhP8V0Ku7ypeD7Oq6xwLlZNSntUah3wvaWrwQ1twQEpxW9PNXzF5D0lRRYa9yp+
 nQb1FDx0XChamMT6jYcncb1N1esGhCQjjtHi1CjDJcLjfdpuyOVqigV4EG0KDD3seNlO
 x0MulOi5Zsvzis8MHkEBqr46HeJETaY9q5tcAUJ8FTeD28xBiBMmzs/7tVbkRieJ7b56
 dPcw==
X-Gm-Message-State: AOJu0YzBeU/x7tdREjYsFnVn3Has4DVCvtQTtCbFwjwrhM6lft+Rae3i
 FrSnDbgcSjWYjJoyA+bVRz86axN5n51nY6gE7GXcr+GJDWQe7+xMR3wPN5cX
X-Google-Smtp-Source: AGHT+IETpPauNZDkFwFCiHSJaRaecVzeXGKMV6br8Vo5FTAmSiBPuy0XvZNiSJrFk0lydCTSZPJBqrNNvdnDSZfRH1c=
X-Received: by 2002:a1f:6643:0:b0:493:7df9:bcc4 with SMTP id
 a64-20020a1f6643000000b004937df9bcc4mr1757866vkc.4.1695202162964; Wed, 20 Sep
 2023 02:29:22 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Sep 2023 11:29:12 +0200
Message-ID: <CA+G9fYtqLarsezP_-6iQqonh8M4Q6McUCEBM9gFv+GU-zZRHAQ@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, rcu <rcu@vger.kernel.org>,
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] arm64: Unable to handle kernel execute from non-executable
 memory at virtual address ffff8000834c13a0
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
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[ my two cents ]
While running LTP pty07 test cases on arm64 juno-r2 with Linux next-20230919
the following kernel crash was noticed.

I have been noticing this issue intermittently on Juno-r2 for more than a month.
Anyone have noticed this crash ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    0.000000] Linux version 6.6.0-rc2-next-20230919 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.41) #1 SMP PREEMPT @1695107157
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: ARM Juno development board (r2)
...
LTP running pty
...

pty07.c:92: TINFO: Saving active console 1
../../../include/tst_fuzzy_sync.h:640: TINFO: Stopped sampling at 552
(out of 1024) samples, sampling time reached 50% of the total time
limit
../../../include/tst_fuzzy_sync.h:307: TINFO: loop = 552, delay_bias = 0
../../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg
=   127ns, avg_dev =    84ns, dev_ratio = 0.66 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg
= 17296156ns, avg_dev = 5155058ns, dev_ratio = 0.30 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg
= 101202336ns, avg_dev = 6689286ns, dev_ratio = 0.07 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg
= -83906064ns, avg_dev = 10230694ns, dev_ratio = 0.12 }
../../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg
= 2765565  , avg_dev = 339285  , dev_ratio = 0.12 }
[  384.133538] Unable to handle kernel execute from non-executable
memory at virtual address ffff8000834c13a0
[  384.133559] Mem abort info:
[  384.133568]   ESR = 0x000000008600000f
[  384.133578]   EC = 0x21: IABT (current EL), IL = 32 bits
[  384.133590]   SET = 0, FnV = 0
[  384.133600]   EA = 0, S1PTW = 0
[  384.133610]   FSC = 0x0f: level 3 permission fault
[  384.133621] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082375000
[  384.133634] [ffff8000834c13a0] pgd=10000009fffff003,
p4d=10000009fffff003, pud=10000009ffffe003, pmd=10000009ffff8003,
pte=00780000836c1703
[  384.133697] Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
[  384.133707] Modules linked in: tda998x onboard_usb_hub cec hdlcd
crct10dif_ce drm_dma_helper drm_kms_helper fuse drm backlight dm_mod
ip_tables x_tables
[  384.133767] CPU: 3 PID: 589 Comm: (udev-worker) Not tainted
6.6.0-rc2-next-20230919 #1
[  384.133779] Hardware name: ARM Juno development board (r2) (DT)
[  384.133784] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  384.133796] pc : in_lookup_hashtable+0x178/0x2000
[  384.133818] lr : rcu_core (arch/arm64/include/asm/preempt.h:13
(discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1)
kernel/rcu/tree.c:2403 (discriminator 1))
[  384.133832] sp : ffff800083533e60
[  384.133836] x29: ffff800083533e60 x28: ffff0008008a6180 x27: 000000000000000a
[  384.133854] x26: 0000000000000000 x25: 0000000000000000 x24: ffff800083533f10
[  384.133871] x23: ffff800082404008 x22: ffff800082ebea80 x21: ffff800082f55940
[  384.133889] x20: ffff00097ed75440 x19: 0000000000000001 x18: 0000000000000000
[  384.133905] x17: ffff8008fc95c000 x16: ffff800083530000 x15: 00003d0900000000
[  384.133922] x14: 0000000000030d40 x13: 0000000000000000 x12: 003d090000000000
[  384.133939] x11: 0000000000000000 x10: 0000000000000008 x9 : ffff80008015b05c
[  384.133955] x8 : ffff800083533da8 x7 : 0000000000000000 x6 : 0000000000000100
[  384.133971] x5 : ffff800082ebf000 x4 : ffff800082ebf2e8 x3 : 0000000000000000
[  384.133987] x2 : ffff000825bf8618 x1 : ffff8000834c13a0 x0 : ffff00082b6d7170
[  384.134005] Call trace:
[  384.134009] in_lookup_hashtable+0x178/0x2000
[  384.134022] rcu_core_si (kernel/rcu/tree.c:2421)
[  384.134035] __do_softirq (arch/arm64/include/asm/jump_label.h:21
include/linux/jump_label.h:207 include/trace/events/irq.h:142
kernel/softirq.c:554)
[  384.134046] ____do_softirq (arch/arm64/kernel/irq.c:81)
[  384.134058] call_on_irq_stack (arch/arm64/kernel/entry.S:888)
[  384.134070] do_softirq_own_stack (arch/arm64/kernel/irq.c:86)
[  384.134082] irq_exit_rcu (arch/arm64/include/asm/percpu.h:44
kernel/softirq.c:612 kernel/softirq.c:634 kernel/softirq.c:644)
[  384.134094] el0_interrupt (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:763)
[  384.134110] __el0_irq_handler_common (arch/arm64/kernel/entry-common.c:769)
[  384.134124] el0t_64_irq_handler (arch/arm64/kernel/entry-common.c:774)
[  384.134137] el0t_64_irq (arch/arm64/kernel/entry.S:592)
[ 384.134153] Code: 00000000 00000000 00000000 00000000 (2b6d7170)
All code
========
...
  10: 70 71                jo     0x83
  12: 6d                    insl   (%dx),%es:(%rdi)
  13: 2b                    .byte 0x2b

Code starting with the faulting instruction
===========================================
   0: 70 71                jo     0x73
   2: 6d                    insl   (%dx),%es:(%rdi)
   3: 2b                    .byte 0x2b
[  384.134161] ---[ end trace 0000000000000000 ]---
[  384.134168] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  384.134173] SMP: stopping secondary CPUs
[  384.134184] Kernel Offset: disabled
[  384.134187] CPU features: 0x8000020c,3c020000,0000421b
[  384.134194] Memory Limit: none

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230919/testrun/20054202/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230919/testrun/20054202/suite/log-parser-test/test/check-kernel-oops/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2VbZdpWwncUx8oSxsSXCWV3N5DH/
 - https://lkft.validation.linaro.org/scheduler/job/6666807#L2461

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
