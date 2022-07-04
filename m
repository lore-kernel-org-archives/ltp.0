Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DD2C43334
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 07:58:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26B6E3C9FE0
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 09:58:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 020BA3C9839
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 09:58:43 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20776600490
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 09:58:42 +0200 (CEST)
Received: by mail-io1-xd31.google.com with SMTP id y2so7918214ior.12
 for <ltp@lists.linux.it>; Mon, 04 Jul 2022 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=x7CeVVgKZLzmUKaCijsRr+z8Ka0Zf/3oWPk7mCNqThk=;
 b=RCdKgKPkM5JEQjeRiYQvvNtHrTEVInzEUDy87grheNSeV94LXQLDkM/HEo1w8HQMhI
 HpsCfhwy3cj4K4fgqw96lYtCSivbjxrurwB8crOzuKEGDT1wr3KWFkYiDo5AZ5Ht8Q3k
 ORysG3awUY0xADysG6kaDpcj/qjoI/yNWDjSFQko2Mi0eqp50DWcfhTgArArxj3i7D/B
 gihXzg4WG2Kr69ZYNM4glnEoeiMa7bHq+yj0W8JUCrtZQ3f94BGukC395JzNcm0xzJq3
 IE9tiXuGXnDRnWqXhcnD4Lgb+gnAYDM5Cmjm9g5D8nzC7L9siBuRZ/WS1c7rrulzjLR2
 1z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=x7CeVVgKZLzmUKaCijsRr+z8Ka0Zf/3oWPk7mCNqThk=;
 b=QStJvkHCrNXk+SsRMQDNfgAclDRtxzjcNgDYvTrJ0jLyA3ZETZKo0D0gPgTlx3RRmW
 iIPcAt/CH3chIEh4xZurjBYXc6xtJ7FRw3D2BzPzn0wNtHROQNMwav823qb0yrKr475F
 0JsmyIatozZH9mUm03X0EWAE8PFkivQ0fmW5VWG302TNcD17Q1SqpM68N3iIuVSbvWad
 /BY9ENotXnDk9JYh3wNE6sakQrQfR5Unu0fvjVQEQUI8GPoHOn4ET1Y9ncyx3IODqyV2
 6V4ENd9NKlOqr964oM+xoq33lvf8/3VzIeAzdGlkwZC4f87hRvVXEQdHs/q17vBBWYBA
 0ZVw==
X-Gm-Message-State: AJIora8/JaKOVeWEej5+8zZOEbeADkctAmL+rqs/ZqSCErwX6r3FRcdk
 gbMrh2aC7Q+lGs+LyxZy71UGZdOp7KYN7q30YD+Pfg==
X-Google-Smtp-Source: AGRyM1vNiVGgtOmJuERjghoLO40ju00SBrtTyV0v7oCJ+7NG6D8yxnMy4OAYnCZS+XUKgEIVn6S7bp4TPvD4MMdQkvs=
X-Received: by 2002:a05:6638:2708:b0:33c:975e:707a with SMTP id
 m8-20020a056638270800b0033c975e707amr16733674jav.284.1656921521495; Mon, 04
 Jul 2022 00:58:41 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Jul 2022 13:28:30 +0530
Message-ID: <CA+G9fYtu1G4oGtKZQ_g5VJbQoET8c7hN_Ds-O1-1HD3PwV4wkQ@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
 regressions@lists.linux.dev, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] 5.19.0-rc5 : Raspberry Pi 4 : Unable to handle kernel paging
 request at virtual address
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
Cc: Will Deacon <will@kernel.org>, brauner@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While running LTP controllers tests on arm64 Raspberry Pi 4 Model B
the following kernel crash noticed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
  kernel_version: 5.19.0-rc5
  kernel-config: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/579007773
  artifact-location: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh
  vmlinux.xz: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/System.map
  toolchain: gcc-11

Steps to reproduce:
-------------------
./runltp -p -q -f controllers

Test log:
----------
cgroup_fj_stress_blkio_4_4_each 1 TPASS: All done!
cgroup_fj_stress_blkio_4_4_each 2 TINFO: Removing all ltp subgroups...
cgroup_fj_stress_blkio_2_9_each 1 TINFO: Subsystem blkio is mounted at
/sys/fs/cgroup/blkio
cgroup_fj_stress_blkio_2_9_each 1 TINFO: Creating subgroups ...
[ 2414.973441] Unable to handle kernel paging request at virtual
address 00620000090336a0
[ 2414.981581] Mem abort info:
[ 2414.984480]   ESR = 0x0000000086000004
[ 2414.988323]   EC = 0x21: IABT (current EL), IL = 32 bits
[ 2414.993765]   SET = 0, FnV = 0
[ 2414.996905]   EA = 0, S1PTW = 0
[ 2415.000124]   FSC = 0x04: level 0 translation fault
[ 2415.005118] [00620000090336a0] address between user and kernel address ranges
[ 2415.012393] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[ 2415.018048] Modules linked in: btrfs blake2b_generic libcrc32c
raid6_pq zstd_compress xhci_pci snd_soc_hdmi_codec xhci_pci_renesas
raspberrypi_cpufreq hci_uart btqca brcmfmac brcmutil btbcm vc4
bluetooth cfg80211 cec drm_display_helper drm_cma_helper rfkill
clk_raspberrypi reset_raspberrypi drm_kms_helper crct10dif_ce
raspberrypi_hwmon drm i2c_bcm2835 iproc_rng200 rng_core pwm_bcm2835
bcm2711_thermal pcie_brcmstb fuse
[ 2415.055725] CPU: 0 PID: 11626 Comm: cgroup_fj_stres Not taintedlinu#1
[ 2415.062965] Hardware name: Raspberry Pi 4 Model B (DT)
[ 2415.068175] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2415.075238] pc : 0x620000090336a0
[ 2415.078600] lr : ktime_get+0x50/0xac
[ 2415.082228] sp : ffff80000dfdbb90
[ 2415.085585] x29: ffff80000dfdbb90 x28: 00000000ffffffff x27: ffff00006405e580
[ 2415.092832] x26: ffff00006405e748 x25: 0000000001200000 x24: ffff00006405e180
[ 2415.100076] x23: ffff80000dfdbd68 x22: 0000000000000000 x21: 000002321545f201
[ 2415.107320] x20: 000000000012017e x19: ffff80000ae3b440 x18: ffff000000000000
[ 2415.114564] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000000dc
[ 2415.121809] x14: 0000000001200011 x13: 0000000060000000 x12: 0000ffffa7b6c1e8
[ 2415.129052] x11: 0000000000000040 x10: ffff80000a96c5c0 x9 : ffff8000080990d4
[ 2415.136295] x8 : 0000000000000000 x7 : 0000000000a9c84a x6 : 4480001ec1769752
[ 2415.143538] x5 : 00ffbffeffffffff x4 : 0000000900000000 x3 : 0000000000000000
[ 2415.150781] x2 : ffff80000a94e000 x1 : ffff8000090336a0 x0 : ffff80000ad102f0
[ 2415.158025] Call trace:
[ 2415.160498]  0x620000090336a0
[ 2415.163505]  copy_process+0xe34/0x1534
[ 2415.167307]  kernel_clone+0x98/0x430
[ 2415.170931]  __do_sys_clone+0x70/0xb0
[ 2415.174643]  __arm64_sys_clone+0x2c/0x40
[ 2415.178621]  invoke_syscall+0x50/0x120
[ 2415.182425]  el0_svc_common.constprop.0+0x104/0x124
[ 2415.187375]  do_el0_svc+0x3c/0xcc
[ 2415.190736]  el0_svc+0x38/0xc0
[ 2415.193832]  el0t_64_sync_handler+0xbc/0x140
[ 2415.198162]  el0t_64_sync+0x18c/0x190
[ 2415.201880] Code: bad PC value
[ 2415.204975] ---[ end trace 0000000000000000 ]---
[ 2435.982529] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 2435.988717] rcu: 0-...0: (8 ticks this GP)
idle=c29/1/0x4000000000000000 softirq=479942/479942 fqs=2433
[ 2435.998423] (detected by 2, t=5255 jiffies, g=905669, q=285 ncpus=4)
[ 2436.004953] Task dump for CPU 0:
[ 2436.008218] task:cgroup_fj_stres state:R  running task     stack:
 0 pid:11626 ppid:   502 flags:0x00000202
[ 2436.018278] Call trace:
[ 2436.020749]  __switch_to+0xf0/0x160
[ 2436.024291]  0x3600d98dadcfb700
[ 2499.046529] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:

full log links,
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.19-rc5/testrun/10489769/suite/log-parser-test/test/check-kernel-oops-5238392/details/
https://lkft.validation.linaro.org/scheduler/job/5238392

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
