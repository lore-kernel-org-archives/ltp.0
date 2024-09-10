Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C5FA3733
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 08:57:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37FD83C27B4
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 10:57:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 248F43C00BE
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 11:49:54 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=joey.gouly@arm.com; receiver=lists.linux.it)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 85C061000A00
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 11:49:53 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFB57113E;
 Tue, 10 Sep 2024 02:50:20 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com
 [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6243F66E;
 Tue, 10 Sep 2024 02:49:50 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:49:45 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20240910094945.GA649558@e124191.cambridge.arm.com>
References: <CA+G9fYvarKEPN3u1Ogw2pcw4h6r3OMzg+5qJpYkAXRunAEF_0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvarKEPN3u1Ogw2pcw4h6r3OMzg+5qJpYkAXRunAEF_0Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 13 Sep 2024 10:57:32 +0200
Subject: Re: [LTP] next-20240905: WARNING: at
 arch/arm64/include/asm/pkeys.h:40 do_mmap
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 10, 2024 at 12:00:37PM +0530, Naresh Kamboju wrote:
> The following kernel warning noticed while running the LTP test case
> LTP syscalls mlock03 ( mmap03 ) on
>   - Arm DUT Juno-r2
>   - Qcomm DUT Dragonboard-410c
> 
> running Linux next-20240905, next-20240906 and next-20240909 kernel.
> 
> First seen on next-20240905
>   Good: next-20240904
>   BAD:  next-20240905..next-20240909
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Warning log:
> ----------
> [    0.000000] Linux version 6.11.0-rc6-next-20240905
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU
> ld (GNU Binutils for Debian) 2.43) #1 SMP PREEMPT @1725536306
> [    0.000000] KASLR disabled due to lack of seed
> [    0.000000] Machine model: ARM Juno development board (r2)
> ..
> mlock03.c:58: TINFO: mlock [aaaaddae1000,aaaaddafd000]
> mlock03.c:62: TINFO: munlock [aaaaddae1000,aaaaddafd000]
> [  795.850426] ------------[ cut here ]------------
> [  795.857261] WARNING: CPU: 5 PID: 101577 at
> arch/arm64/include/asm/pkeys.h:40 do_mmap
> (arch/arm64/include/asm/pkeys.h:40 (discriminator 1) mm/mmap.c:338
> (discriminator 1))
> [  795.868833] Modules linked in: tun overlay btrfs blake2b_generic
> libcrc32c xor xor_neon raid6_pq zstd_compress panfrost tda998x
> onboard_usb_dev drm_shmem_helper hdlcd crct10dif_ce cec gpu_sched
> drm_dma_helper drm_kms_helper fuse drm backlight dm_mod ip_tables
> x_tables
> [  795.895379] CPU: 5 UID: 0 PID: 101577 Comm: mmap03 Not tainted
> 6.11.0-rc6-next-20240905 #1
> [  795.906430] Hardware name: ARM Juno development board (r2) (DT)
> [  795.915135] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  795.924881] pc : do_mmap (arch/arm64/include/asm/pkeys.h:40
> (discriminator 1) mm/mmap.c:338 (discriminator 1))
> [  795.931236] lr : vm_mmap_pgoff (mm/util.c:588)
> [  795.938113] sp : ffff80008ba0bc90
> [  795.944206] x29: ffff80008ba0bc90 x28: 0000000000000001 x27: ffff0008329cf800
> [  795.954128] x26: ffff0008329cf800 x25: ffff000822140cc0 x24: 0000000000000000
> [  795.964050] x23: ffff80008ba0bd20 x22: 0000000000000004 x21: 0000000000000000
> [  795.973972] x20: 0000000000000001 x19: 0000000000001000 x18: 0000000000000000
> [  795.983895] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  795.993817] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  796.003739] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008032e2c4
> [  796.013661] x8 : ffff000827e64c00 x7 : ffff80008ba0bd20 x6 : 0000000000000000
> [  796.023583] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000004
> [  796.033505] x2 : 0000000000001000 x1 : 0000000000000011 x0 : 000000000000fffa
> [  796.043428] Call trace:
> [  796.048651] do_mmap (arch/arm64/include/asm/pkeys.h:40
> (discriminator 1) mm/mmap.c:338 (discriminator 1))
> [  796.054658] vm_mmap_pgoff (mm/util.c:588)
> [  796.061187] ksys_mmap_pgoff (mm/mmap.c:542)
> [  796.067980] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
> [  796.074597] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> [  796.081213] el0_svc_common.constprop.0
> (include/linux/thread_info.h:127 (discriminator 2)
> arch/arm64/kernel/syscall.c:140 (discriminator 2))
> [  796.088699] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> [  796.094879] el0_svc (arch/arm64/include/asm/irqflags.h:82
> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
> arch/arm64/kernel/entry-common.c:165 (discriminator 1)
> arch/arm64/kernel/entry-common.c:178 (discriminator 1)
> arch/arm64/kernel/entry-common.c:713 (discriminator 1))
> [  796.100799] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
> [  796.108024] el0t_64_sync (arch/arm64/kernel/entry.S:598)
> [  796.114467] ---[ end trace 0000000000000000 ]---

I see what has gone wrong here, it's fortunately harmless. I will send a patch
to fix it.

Thanks,
Joey

> 
> boot Log links,
> --------
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240905/testrun/25069344/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-archarmincludeasmpkeysh-do_mmap/log
>   - https://lkft.validation.linaro.org/scheduler/job/7842087#L21916
>   - https://lkft.validation.linaro.org/scheduler/job/7847924#L23191
> 
> Test results history:
> ----------
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25081195/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-archarmincludeasmpkeysh-do_mmap/history/
> 
> metadata:
> ----
>   git describe: next-20240905
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git sha: ad40aff1edffeccc412cde93894196dca7bc739e
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2leMFe4WompPEOUNN7ODxtTMCxf/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2leMFe4WompPEOUNN7ODxtTMCxf/
>   toolchain: gcc-13
> 
> Steps to reproduce:
> ---------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2leMISlsoJqQdTCCzBmuVwKHq9m/reproducer
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2leMISlsoJqQdTCCzBmuVwKHq9m/tux_plan
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
