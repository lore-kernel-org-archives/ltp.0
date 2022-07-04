Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4AAC43334
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 09:37:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA2953C9FDF
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 11:37:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 670273C87EF
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 11:36:56 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B18E710006A1
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 11:36:55 +0200 (CEST)
Received: by mail-io1-xd2a.google.com with SMTP id v185so8113408ioe.11
 for <ltp@lists.linux.it>; Mon, 04 Jul 2022 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=M4PHJyWoqviqJDX9j/AeRUcG7kFnr6lVLWzGBNI2k4A=;
 b=Ns0XW+mjEaz17ha9UNolHB3Tw5s4ruam0MMbB0kfg+OmU+nUjeLt+3QNSjYnhGwnCR
 86NIlg70NUJMXerT+eejnMyIYi38jhnM+0c4wQStsgi5vHZvMxGO5GINPL2+hgfm29Po
 iiFVj3lx0tuVjU9+v+vaovhRcC3ngrjjXfYvxjgmEuOK3b2vtPoO5JBEmbo0qMGoVmlO
 Z7lCcr6nq8gT00W0P7RCAj/R8i6o7E2i3TREuaM0C9GclBjd41LDUssvPzGDGgrFNPXT
 oY5oNUvHi4sRVHlnT9Bmj10BWLA01cF+XZAjr4Th9pJsnTkIF3Mm06BXjrZyPlgulHVP
 wt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=M4PHJyWoqviqJDX9j/AeRUcG7kFnr6lVLWzGBNI2k4A=;
 b=oxa8N3fUswcPfMosT09u3P9CXdZ1+Wm9Df2mlW/Qo8/2kQEUzI3KrN9EqQq4ZStd83
 UrmLWnepgQsGnJVQO5aPLjL1uJTgfbDneoG7Ds04GJTVj0+M4c8q6QCJcpqjVgoflHlE
 fS6qA9AC45MzRsYxlTOXH1a8LqDuEX+eYeE4SHuW3YQiZjz2OdgXRZTzUmkhJsvV2L7L
 NZ/0CWudXebdaBBq80eAXTdrvsBCqGJStRi4LN21HLuV5kundWZftDh0OsrY0Bf7VSqT
 o/zFGR4GjfsvFEfdO6r3+XZpS3jBDQ1O2sdbceNIwfOOe5hQ+A7txHv7M5J4WXVw5aRd
 djLA==
X-Gm-Message-State: AJIora+NPq45IoOzsbgvJQQTzlJqkopiK420+cMlPSpio7LmHxTf8ECv
 5wlt9d8eI8dk1BOTuV8rvWhkTPtz0GFLdfV570SqFA==
X-Google-Smtp-Source: AGRyM1uvQZvVzsJPPykVVolv64ey85zoHlS5rvzKygERnG2CQoxvFiUw/KDbWDW04LFg5ZYSK4a9f7LZnBVbmq1Xx0I=
X-Received: by 2002:a05:6638:468e:b0:33e:be92:ec40 with SMTP id
 bq14-20020a056638468e00b0033ebe92ec40mr6041972jab.74.1656927414391; Mon, 04
 Jul 2022 02:36:54 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Jul 2022 15:06:43 +0530
Message-ID: <CA+G9fYszKbZE4uKig8unFki0KxiMC2xf+2ZNK+1sT_kCXYqv9w@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev, 
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] 5.19.0-rc5 : WARNING: CPU: 0 PID: 17 at
 kernel/irq/manage.c:789 __enable_irq+0x58/0x90
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
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vinod Koul <vinod.koul@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While running LTP cpuhotplug the following kernel warning was noticed
on arm64 Thundercomm Dragonboard 845c device.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
  git_describe: v5.19-rc5
  kernel_version: 5.19.0-rc5
  kernel-config: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/579007773
  artifact-location: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh
  vmlinux.xz: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/System.map
  toolchain: gcc-11

steps to reproduce:
# cd /opt/ltp
# ./runltp -p -q -f cpuhotplug

cpuhotplug04 1 TPASS: System prevented us from offlining the last CPU - cpu7
cpuhotplug04 2 TPASS: Success
[   37.419206] Detected VIPT I-cache on CPU0
[   37.419326] GICv3: CPU0: found redistributor 0 region 0:0x0000000017a60000
[   37.419473] CPU0: Booted secondary processor 0x0000000000 [0x517f803c]
[   37.477891] ------------[ cut here ]------------
[   37.482610] Unbalanced enable for IRQ 131
[   37.486730] WARNING: CPU: 0 PID: 17 at kernel/irq/manage.c:789
__enable_irq+0x58/0x90
[   37.494722] Modules linked in: snd_soc_hdmi_codec lontium_lt9611
venus_enc venus_dec mcp251xfd videobuf2_dma_contig can_dev hci_uart
btqca btbcm qcom_pon qcom_spmi_adc5 qcom_spmi_temp_alarm rtc_pm8xxx
qcom_vadc_common crct10dif_ce snd_soc_sdm845 snd_soc_rt5663
snd_soc_qcom_common snd_soc_rl6231 bluetooth soundwire_bus msm
reset_qcom_pdc qcom_camss gpu_sched videobuf2_dma_sg drm_dp_aux_bus
i2c_qcom_geni v4l2_fwnode drm_display_helper v4l2_async
videobuf2_memops i2c_qcom_cci camcc_sdm845 venus_core v4l2_mem2mem
spi_geni_qcom videobuf2_v4l2 videobuf2_common ath10k_snoc gpi qcom_rng
ath10k_core ath mac80211 xhci_pci xhci_pci_renesas qcom_q6v5_mss qrtr
qcom_q6v5_pas qcom_pil_info slim_qcom_ngd_ctrl qcom_q6v5 pdr_interface
qcom_sysmon cfg80211 qcom_common icc_osm_l3 rfkill qcom_glink_smem
display_connector lmh qmi_helpers slimbus qcom_wdt mdt_loader
drm_kms_helper rmtfs_mem drm socinfo fuse
[   37.574852] CPU: 0 PID: 17 Comm: cpuhp/0 Not tainted 5.19.0-rc5 #1
[   37.581155] Hardware name: Thundercomm Dragonboard 845c (DT)
[   37.586916] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   37.593999] pc : __enable_irq+0x58/0x90
[   37.597937] lr : __enable_irq+0x58/0x90
[   37.601862] sp : ffff800008223cb0
[   37.605247] x29: ffff800008223cb0 x28: 0000000000000000 x27: ffff1a0201cdce18
[   37.612531] x26: 0000000000000000 x25: ffffcde3da0e4000 x24: ffff1a0201cdcc20
[   37.619813] x23: ffffcde3d9b53308 x22: ffffcde3d9b70fc8 x21: 0000000000000000
[   37.627095] x20: 0000000000000083 x19: ffff1a02002a1600 x18: ffffffffffffffff
[   37.634373] x17: 0000000009a60b40 x16: 000000009e1ad4d3 x15: 0720072007200720
[   37.641653] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[   37.648933] x11: 0720072007200720 x10: ffffcde3d9bca7a8 x9 : ffffcde3d7321528
[   37.656213] x8 : 00000000ffffefff x7 : ffffcde3d9bca7a8 x6 : 0000000000000000
[   37.663489] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[   37.670766] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a0200342080
[   37.678043] Call trace:
[   37.680552]  __enable_irq+0x58/0x90
[   37.684135]  enable_irq+0x54/0xb0
[   37.687539]  qcom_cpufreq_ready+0x2c/0x40
[   37.691649]  cpufreq_online+0x550/0xa04
[   37.695582]  cpuhp_cpufreq_online+0x1c/0x2c
[   37.699857]  cpuhp_invoke_callback+0x16c/0x5b0
[   37.704407]  cpuhp_thread_fun+0xd0/0x1c4
[   37.708419]  smpboot_thread_fn+0x1ec/0x220
[   37.712607]  kthread+0x100/0x110
[   37.715924]  ret_from_fork+0x10/0x20
[   37.719597] ---[ end trace 0000000000000000 ]---
[   37.778938] Detected VIPT I-cache on CPU1

Full test log:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.19-rc5/testrun/10489108/suite/log-parser-test/test/check-kernel-warning-5238386/details/
https://lkft.validation.linaro.org/scheduler/job/5238386#L4318

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
