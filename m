Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA89C433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 14:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3586B3CA019
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 16:20:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B2A63C1BCE
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 16:19:54 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9E99E6006D4
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 16:19:53 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A2825B80F02;
 Mon,  4 Jul 2022 14:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C77C3411E;
 Mon,  4 Jul 2022 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656944391;
 bh=7vo3mqe9Qcsda9vM7KMrdZX6HLtI93fHFj//LQvLa1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JyxgDDmspKLKZARO6/0mzW5SyZmrYTpHMagY6ROaJRWlOhs1AHvKsyP4PRLGGO/sT
 xUAP5m5gCDulzdWfXJYocg1lFFzf/ujfTFCClQ1iw+gPd1kDRnka5akEXlOGKIGt8O
 KEM+SpeYUseM6xTZbNEQhfdD4nQlHHYyelhtgC77K6MMnIs1ojTpIaEe2k7MHVU3QN
 Vq0aFOptRokK+nRvx3TK91Qs1IM5t9bQaZ3/dpGaGR1NqkeTqtBEoB82rnYrNeRX/s
 n6xN05qpqIZAIUMGMhGWbEV8TliWRIME0b7b2zVbO0AvS7jreQT0CPdT9pSjQYvmXh
 F3yXEXunoL8WQ==
Date: Mon, 4 Jul 2022 15:19:45 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Message-ID: <20220704141945.GD31684@willie-the-truck>
References: <CA+G9fYtu1G4oGtKZQ_g5VJbQoET8c7hN_Ds-O1-1HD3PwV4wkQ@mail.gmail.com>
 <20220704112605.GB31553@willie-the-truck>
 <aa641b98-98ca-14d3-2a28-2c0aef96ed0d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa641b98-98ca-14d3-2a28-2c0aef96ed0d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 5.19.0-rc5 : Raspberry Pi 4 : Unable to handle kernel
 paging request at virtual address
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
Cc: brauner@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 regressions@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 LTP List <ltp@lists.linux.it>, Linus Torvalds <torvalds@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jul 04, 2022 at 02:37:52PM +0100, Robin Murphy wrote:
> On 2022-07-04 12:26, Will Deacon wrote:
> > On Mon, Jul 04, 2022 at 01:28:30PM +0530, Naresh Kamboju wrote:
> > > While running LTP controllers tests on arm64 Raspberry Pi 4 Model B
> > > the following kernel crash noticed.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > metadata:
> > >    git_ref: master
> > >    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> > >    git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
> > >    kernel_version: 5.19.0-rc5
> > >    kernel-config: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/config
> > >    build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/579007773
> > >    artifact-location: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh
> > >    vmlinux.xz: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/vmlinux.xz
> > >    System.map: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/System.map
> > >    toolchain: gcc-11
> > > 
> > > Steps to reproduce:
> > > -------------------
> > > ./runltp -p -q -f controllers
> > > 
> > > Test log:
> > > ----------
> > > cgroup_fj_stress_blkio_4_4_each 1 TPASS: All done!
> > > cgroup_fj_stress_blkio_4_4_each 2 TINFO: Removing all ltp subgroups...
> > > cgroup_fj_stress_blkio_2_9_each 1 TINFO: Subsystem blkio is mounted at
> > > /sys/fs/cgroup/blkio
> > > cgroup_fj_stress_blkio_2_9_each 1 TINFO: Creating subgroups ...
> > > [ 2414.973441] Unable to handle kernel paging request at virtual
> > > address 00620000090336a0
> > > [ 2414.981581] Mem abort info:
> > > [ 2414.984480]   ESR = 0x0000000086000004
> > > [ 2414.988323]   EC = 0x21: IABT (current EL), IL = 32 bits
> > > [ 2414.993765]   SET = 0, FnV = 0
> > > [ 2414.996905]   EA = 0, S1PTW = 0
> > > [ 2415.000124]   FSC = 0x04: level 0 translation fault
> > > [ 2415.005118] [00620000090336a0] address between user and kernel address ranges
> > > [ 2415.012393] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > > [ 2415.018048] Modules linked in: btrfs blake2b_generic libcrc32c
> > > raid6_pq zstd_compress xhci_pci snd_soc_hdmi_codec xhci_pci_renesas
> > > raspberrypi_cpufreq hci_uart btqca brcmfmac brcmutil btbcm vc4
> > > bluetooth cfg80211 cec drm_display_helper drm_cma_helper rfkill
> > > clk_raspberrypi reset_raspberrypi drm_kms_helper crct10dif_ce
> > > raspberrypi_hwmon drm i2c_bcm2835 iproc_rng200 rng_core pwm_bcm2835
> > > bcm2711_thermal pcie_brcmstb fuse
> > > [ 2415.055725] CPU: 0 PID: 11626 Comm: cgroup_fj_stres Not taintedlinu#1
> > > [ 2415.062965] Hardware name: Raspberry Pi 4 Model B (DT)
> > > [ 2415.068175] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [ 2415.075238] pc : 0x620000090336a0
> > > [ 2415.078600] lr : ktime_get+0x50/0xac
> > > [ 2415.082228] sp : ffff80000dfdbb90
> > > [ 2415.085585] x29: ffff80000dfdbb90 x28: 00000000ffffffff x27: ffff00006405e580
> > > [ 2415.092832] x26: ffff00006405e748 x25: 0000000001200000 x24: ffff00006405e180
> > > [ 2415.100076] x23: ffff80000dfdbd68 x22: 0000000000000000 x21: 000002321545f201
> > > [ 2415.107320] x20: 000000000012017e x19: ffff80000ae3b440 x18: ffff000000000000
> > > [ 2415.114564] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000000dc
> > > [ 2415.121809] x14: 0000000001200011 x13: 0000000060000000 x12: 0000ffffa7b6c1e8
> > > [ 2415.129052] x11: 0000000000000040 x10: ffff80000a96c5c0 x9 : ffff8000080990d4
> > > [ 2415.136295] x8 : 0000000000000000 x7 : 0000000000a9c84a x6 : 4480001ec1769752
> > > [ 2415.143538] x5 : 00ffbffeffffffff x4 : 0000000900000000 x3 : 0000000000000000
> > > [ 2415.150781] x2 : ffff80000a94e000 x1 : ffff8000090336a0 x0 : ffff80000ad102f0
> > > [ 2415.158025] Call trace:
> > > [ 2415.160498]  0x620000090336a0
> > > [ 2415.163505]  copy_process+0xe34/0x1534
> > 
> > Do you have the disassembly (and source:line infor) around
> > copy_process+0xe34/0x1534? The faulting PC is like a messed up copy of x1
> > where the upper bits have been corrupted somehow.
> 
> Even better, according to the vmlinux that LR value points right after a
> "blr x1". From the shape of it, looks like it's probably the tk_clock_read()
> call.

System.map has:

ffff8000090336a0 t arch_counter_read

so yes, it looks like we want to call that via:

	clock->read(clock);

but the indirect branch goes wrong :/

Naresh -- do you see this repeatably and on more than just one board?

Will

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
