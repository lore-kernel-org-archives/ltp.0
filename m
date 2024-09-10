Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4508FECE58B
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 06:31:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43EAF3C1A1E
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 08:31:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4CC93C0F5F
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:30:52 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93ACF2005FB
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:30:50 +0200 (CEST)
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-501204753c4so2542343e0c.0
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725949849; x=1726554649; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D29wqIU/MqdK42Hyv0CohOkSOr39XuSIDBy4dPZxDgM=;
 b=CUumbxfzJMadsWd0d5R9ac6EZ0/yA5/8hCYSWBvmQCoEv/qw7APP6wvQbliM2bH837
 hbJmy4pRXDNPGiiPLEQg/bekrVfcY/iSKRFnMkGo/nspPsFjuMt6/fIkf0HguE3evqTw
 //Q8lFUQU0JRCDwoIS8fTlLUrS7/s8bb3yj19Ko8/jCRQmAQXo90D7OXGIMR1h8b0mv3
 U5SV93cEklMcYX+EoznIgRpYU+G4LyruPLb06NDuMYHMZ/5hhEwjEdOx/L3Q/UciB058
 agu9jejk4JCY6bgTzGwAZu4ZcmcQm9jOoG2Q+Rca2y8PR7Fr8ofoFUfoqI3KeF+CSagJ
 FEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725949849; x=1726554649;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D29wqIU/MqdK42Hyv0CohOkSOr39XuSIDBy4dPZxDgM=;
 b=mBmygty4RGH69XG9LB0NsdE7f6Ed44EpTA5vW/gwmcYGHOjFRO6S8QGLYtuI3g8CUu
 73qc3vmDcCBX1QSOk2WIpZ+aughjM05+q2DMQ7ZAQNgEXOGxF54PmIq0hpaoEN6bJ9q8
 ynrMWAt4OC8GRD+T2AnLsIfmlucPn/cqCU3nl6ML8GfK9eT3QLl8xsw9UDKthYDfY67l
 4+csjoReQEA2Llq5BMH/s6LA79VX87Iozru3nAN54IHEE9H6ilZICLhK3oQUUg6vTIRh
 fQ8Gs7cUPUdTQofinOkr8LtfKN1i+5Nw4wWkgr4wVQxhx73rINGtHJGnFLUiI2MnNJWR
 uo9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjIEuew+3/ZZE7nrebNuf2SwfksPcwuQHu/ojsr/QnzgLK93iIB/YnulAIVXqqAdL4CMo=@lists.linux.it
X-Gm-Message-State: AOJu0YwbwsImnQWfIEuGln8f4YV9K7TrnJAVTStKu/OJ6zErwnGdLih9
 Wha7aJQ1dG/kncwS2OyH3Ul6f1zGTU+Rz9KUYj2+296Zwm8ksVt/sM8WOJYQAalRycftnrx1QPR
 RWYl0a/yRq7J4WCOKYe9IKDNZPGvmZTzCsCVZHQ==
X-Google-Smtp-Source: AGHT+IHcoWPZAPvlRorBhaWeYrWRcW8qT1wMakYMB+0xfz8JrsHlT0IMluZivW9XBmwtLaDIWY+MTbQx0inPfUk4M6c=
X-Received: by 2002:a05:6122:31a6:b0:501:1aec:d2c4 with SMTP id
 71dfb90a1353d-502f72e194amr1582561e0c.2.1725949849112; Mon, 09 Sep 2024
 23:30:49 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 12:00:37 +0530
Message-ID: <CA+G9fYvarKEPN3u1Ogw2pcw4h6r3OMzg+5qJpYkAXRunAEF_0Q@mail.gmail.com>
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] next-20240905: WARNING: at arch/arm64/include/asm/pkeys.h:40
 do_mmap
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
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, joey.gouly@arm.com,
 Will Deacon <will@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following kernel warning noticed while running the LTP test case
LTP syscalls mlock03 ( mmap03 ) on
  - Arm DUT Juno-r2
  - Qcomm DUT Dragonboard-410c

running Linux next-20240905, next-20240906 and next-20240909 kernel.

First seen on next-20240905
  Good: next-20240904
  BAD:  next-20240905..next-20240909

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
----------
[    0.000000] Linux version 6.11.0-rc6-next-20240905
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU
ld (GNU Binutils for Debian) 2.43) #1 SMP PREEMPT @1725536306
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: ARM Juno development board (r2)
..
mlock03.c:58: TINFO: mlock [aaaaddae1000,aaaaddafd000]
mlock03.c:62: TINFO: munlock [aaaaddae1000,aaaaddafd000]
[  795.850426] ------------[ cut here ]------------
[  795.857261] WARNING: CPU: 5 PID: 101577 at
arch/arm64/include/asm/pkeys.h:40 do_mmap
(arch/arm64/include/asm/pkeys.h:40 (discriminator 1) mm/mmap.c:338
(discriminator 1))
[  795.868833] Modules linked in: tun overlay btrfs blake2b_generic
libcrc32c xor xor_neon raid6_pq zstd_compress panfrost tda998x
onboard_usb_dev drm_shmem_helper hdlcd crct10dif_ce cec gpu_sched
drm_dma_helper drm_kms_helper fuse drm backlight dm_mod ip_tables
x_tables
[  795.895379] CPU: 5 UID: 0 PID: 101577 Comm: mmap03 Not tainted
6.11.0-rc6-next-20240905 #1
[  795.906430] Hardware name: ARM Juno development board (r2) (DT)
[  795.915135] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  795.924881] pc : do_mmap (arch/arm64/include/asm/pkeys.h:40
(discriminator 1) mm/mmap.c:338 (discriminator 1))
[  795.931236] lr : vm_mmap_pgoff (mm/util.c:588)
[  795.938113] sp : ffff80008ba0bc90
[  795.944206] x29: ffff80008ba0bc90 x28: 0000000000000001 x27: ffff0008329cf800
[  795.954128] x26: ffff0008329cf800 x25: ffff000822140cc0 x24: 0000000000000000
[  795.964050] x23: ffff80008ba0bd20 x22: 0000000000000004 x21: 0000000000000000
[  795.973972] x20: 0000000000000001 x19: 0000000000001000 x18: 0000000000000000
[  795.983895] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  795.993817] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  796.003739] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008032e2c4
[  796.013661] x8 : ffff000827e64c00 x7 : ffff80008ba0bd20 x6 : 0000000000000000
[  796.023583] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000004
[  796.033505] x2 : 0000000000001000 x1 : 0000000000000011 x0 : 000000000000fffa
[  796.043428] Call trace:
[  796.048651] do_mmap (arch/arm64/include/asm/pkeys.h:40
(discriminator 1) mm/mmap.c:338 (discriminator 1))
[  796.054658] vm_mmap_pgoff (mm/util.c:588)
[  796.061187] ksys_mmap_pgoff (mm/mmap.c:542)
[  796.067980] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
[  796.074597] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
[  796.081213] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:140 (discriminator 2))
[  796.088699] do_el0_svc (arch/arm64/kernel/syscall.c:152)
[  796.094879] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:713 (discriminator 1))
[  796.100799] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
[  796.108024] el0t_64_sync (arch/arm64/kernel/entry.S:598)
[  796.114467] ---[ end trace 0000000000000000 ]---

boot Log links,
--------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240905/testrun/25069344/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-archarmincludeasmpkeysh-do_mmap/log
  - https://lkft.validation.linaro.org/scheduler/job/7842087#L21916
  - https://lkft.validation.linaro.org/scheduler/job/7847924#L23191

Test results history:
----------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25081195/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-archarmincludeasmpkeysh-do_mmap/history/

metadata:
----
  git describe: next-20240905
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: ad40aff1edffeccc412cde93894196dca7bc739e
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2leMFe4WompPEOUNN7ODxtTMCxf/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2leMFe4WompPEOUNN7ODxtTMCxf/
  toolchain: gcc-13

Steps to reproduce:
---------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2leMISlsoJqQdTCCzBmuVwKHq9m/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2leMISlsoJqQdTCCzBmuVwKHq9m/tux_plan

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
