Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE9BC43334
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 17:15:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF6A53CA16B
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 19:15:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C099F3C97D1
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 19:15:11 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96AD86005F4
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 19:15:10 +0200 (CEST)
Received: by mail-il1-x12a.google.com with SMTP id p13so5949264ilq.0
 for <ltp@lists.linux.it>; Mon, 04 Jul 2022 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrjLN5AARoW5APe4/kjYq4KPlHCbgUUhCrG4GZXeuYs=;
 b=XHqspk3iPbznRGRAGC35dqeQkskml4iS5i/1qp6qiFiHOBvK4Dm+hNK10gvwHHvxQw
 uCt2niOFvgd0G70wgHa98XBZOxEtc3wpXU0IBP1NrrQY4zsoFVYjTeXGs2o3o7jQN6Xu
 Rh5KxemRnCQbRz7P3oVQonH9HiI90cKjDtMU3grfC11j7lpZ7WgWkgEQJmMfwHw4yBve
 nDmaye1pmOu92OWwaxHy4I/OzCETE2Phg6WsGs2F0PWi13z6aqByPlMcViIutBqo22GN
 k0Uao8yWYeaMcZlxUmpRPb8q61uY4N9dM1sXX/RGJppP8/HH/HxAwRUFONh13nHjzAYI
 pFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrjLN5AARoW5APe4/kjYq4KPlHCbgUUhCrG4GZXeuYs=;
 b=2LA6wjk95kWsAyzUKHBXvAZ6UULa9PcliSj1cc+I+AOFJ7es5vs+rTWzHwEPXetBix
 tAuP6D7MUUo+ysJgzZbcI+Bx+JfN6/LdTC2g4Bs0z6/pqSKhEsQ4zbz5XAgTs6R0aguX
 k7+2LGIUKdS5hpSo5MiPltEwiYgz9KBp2jSMXiOHgzB5AKYIWaLRgSsVOMiXtLxU2xQ8
 75TPHI2HlbRtw6pGoEerxZnLOu+13me6psSsYMFVnMDz+1DNjl6Ua0FU/SufhwXLuMS0
 /zQPdHH3WVsXGNM4apL8BYfluKO5wDhH37p5hl2jMRJ/rHsW1G0K32oLR8cQKhcT+9cT
 Lljw==
X-Gm-Message-State: AJIora/0d3qhTLSEWSXMSQK6yJGTsr7z/pJKyL6C86aKF1LbeWwiM3rx
 uxggbvuUg2QcDld8LU+YnHPH7T/eM8dB/0EHzFKZCg==
X-Google-Smtp-Source: AGRyM1v+dNR4XAKHnXHhctboeigNfJC9zm3QJcSYtRaGLTsXhiOQPTWDBCR0k2uhRptNSE9SnF8nZ5fKrmlfj9eubJI=
X-Received: by 2002:a05:6e02:1c27:b0:2d9:4d66:8541 with SMTP id
 m7-20020a056e021c2700b002d94d668541mr17395300ilh.176.1656954909236; Mon, 04
 Jul 2022 10:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtu1G4oGtKZQ_g5VJbQoET8c7hN_Ds-O1-1HD3PwV4wkQ@mail.gmail.com>
 <20220704112605.GB31553@willie-the-truck>
 <aa641b98-98ca-14d3-2a28-2c0aef96ed0d@arm.com>
 <20220704141945.GD31684@willie-the-truck>
In-Reply-To: <20220704141945.GD31684@willie-the-truck>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Jul 2022 22:44:57 +0530
Message-ID: <CA+G9fYsD2oTZkWqVrVgJ1Y2p_3dt623vmOnGE8NDbBEXfwm3PQ@mail.gmail.com>
To: Will Deacon <will@kernel.org>
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
 regressions@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 LTP List <ltp@lists.linux.it>, Catalin Marinas <catalin.marinas@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 4 Jul 2022 at 19:49, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 04, 2022 at 02:37:52PM +0100, Robin Murphy wrote:
> > On 2022-07-04 12:26, Will Deacon wrote:
> > > On Mon, Jul 04, 2022 at 01:28:30PM +0530, Naresh Kamboju wrote:
> > > > While running LTP controllers tests on arm64 Raspberry Pi 4 Model B
> > > > the following kernel crash noticed.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > metadata:
> > > >    git_ref: master
> > > >    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> > > >    git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
> > > >    kernel_version: 5.19.0-rc5
> > > >    kernel-config: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/config
> > > >    build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/579007773
> > > >    artifact-location: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh
> > > >    vmlinux.xz: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/vmlinux.xz
> > > >    System.map: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/System.map
> > > >    toolchain: gcc-11
> > > >
> > > > Steps to reproduce:
> > > > -------------------
> > > > ./runltp -p -q -f controllers
> > > >
> > > > Test log:
> > > > ----------
> > > > cgroup_fj_stress_blkio_4_4_each 1 TPASS: All done!
> > > > cgroup_fj_stress_blkio_4_4_each 2 TINFO: Removing all ltp subgroups...
> > > > cgroup_fj_stress_blkio_2_9_each 1 TINFO: Subsystem blkio is mounted at
> > > > /sys/fs/cgroup/blkio
> > > > cgroup_fj_stress_blkio_2_9_each 1 TINFO: Creating subgroups ...
> > > > [ 2414.973441] Unable to handle kernel paging request at virtual
> > > > address 00620000090336a0
> > > > [ 2414.981581] Mem abort info:
> > > > [ 2414.984480]   ESR = 0x0000000086000004
> > > > [ 2414.988323]   EC = 0x21: IABT (current EL), IL = 32 bits
> > > > [ 2414.993765]   SET = 0, FnV = 0
> > > > [ 2414.996905]   EA = 0, S1PTW = 0
> > > > [ 2415.000124]   FSC = 0x04: level 0 translation fault
> > > > [ 2415.005118] [00620000090336a0] address between user and kernel address ranges
> > > > [ 2415.012393] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > > > [ 2415.018048] Modules linked in: btrfs blake2b_generic libcrc32c
> > > > raid6_pq zstd_compress xhci_pci snd_soc_hdmi_codec xhci_pci_renesas
> > > > raspberrypi_cpufreq hci_uart btqca brcmfmac brcmutil btbcm vc4
> > > > bluetooth cfg80211 cec drm_display_helper drm_cma_helper rfkill
> > > > clk_raspberrypi reset_raspberrypi drm_kms_helper crct10dif_ce
> > > > raspberrypi_hwmon drm i2c_bcm2835 iproc_rng200 rng_core pwm_bcm2835
> > > > bcm2711_thermal pcie_brcmstb fuse
> > > > [ 2415.055725] CPU: 0 PID: 11626 Comm: cgroup_fj_stres Not taintedlinu#1
> > > > [ 2415.062965] Hardware name: Raspberry Pi 4 Model B (DT)
> > > > [ 2415.068175] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > [ 2415.075238] pc : 0x620000090336a0
> > > > [ 2415.078600] lr : ktime_get+0x50/0xac
> > > > [ 2415.082228] sp : ffff80000dfdbb90
> > > > [ 2415.085585] x29: ffff80000dfdbb90 x28: 00000000ffffffff x27: ffff00006405e580
> > > > [ 2415.092832] x26: ffff00006405e748 x25: 0000000001200000 x24: ffff00006405e180
> > > > [ 2415.100076] x23: ffff80000dfdbd68 x22: 0000000000000000 x21: 000002321545f201
> > > > [ 2415.107320] x20: 000000000012017e x19: ffff80000ae3b440 x18: ffff000000000000
> > > > [ 2415.114564] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000000dc
> > > > [ 2415.121809] x14: 0000000001200011 x13: 0000000060000000 x12: 0000ffffa7b6c1e8
> > > > [ 2415.129052] x11: 0000000000000040 x10: ffff80000a96c5c0 x9 : ffff8000080990d4
> > > > [ 2415.136295] x8 : 0000000000000000 x7 : 0000000000a9c84a x6 : 4480001ec1769752
> > > > [ 2415.143538] x5 : 00ffbffeffffffff x4 : 0000000900000000 x3 : 0000000000000000
> > > > [ 2415.150781] x2 : ffff80000a94e000 x1 : ffff8000090336a0 x0 : ffff80000ad102f0
> > > > [ 2415.158025] Call trace:
> > > > [ 2415.160498]  0x620000090336a0
> > > > [ 2415.163505]  copy_process+0xe34/0x1534
> > >
> > > Do you have the disassembly (and source:line infor) around
> > > copy_process+0xe34/0x1534? The faulting PC is like a messed up copy of x1
> > > where the upper bits have been corrupted somehow.
> >
> > Even better, according to the vmlinux that LR value points right after a
> > "blr x1". From the shape of it, looks like it's probably the tk_clock_read()
> > call.
>
> System.map has:
>
> ffff8000090336a0 t arch_counter_read
>
> so yes, it looks like we want to call that via:
>
>         clock->read(clock);
>
> but the indirect branch goes wrong :/
>
> Naresh -- do you see this repeatably and on more than just one board?

I have been trying to reproduce this problem on a pool of Raspberry Pi 4 boards
but have not been successful yet.

- Naresh

>
> Will

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
