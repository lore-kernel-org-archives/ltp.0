Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F10DC433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 13:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B3D73CA7CF
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 14:37:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 071573C1777
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:37:38 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 59518600285
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:37:38 +0100 (CET)
Received: by mail-yb1-xb2b.google.com with SMTP id e186so30779842ybc.7
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=p9QUWUXMG6CjpUa+HzP2gwo+3axAKzjFQF2ULzEJvO4=;
 b=OqXQdGYSKt/Y+45NDlpunpMVZd2kEZF7WXE9Q9tng6Cg9jVQGqDGOH2gsx53zcB9XZ
 ML1J1mo1+DLdiB3TFDWD2H0I0zidksAtZptRXHzPqN1f+Sy7f8p0Mk8FA5yxVcgqbkHE
 I6/n7m89DuSXzvazl1bCtuvMOueSUaCL4J/wyr2mE6KrTXnDLnH9cQfNB3dBbFu278b5
 ncckrkXJULIIaqRB8cV9YCr7dgGDj7v08PNTyfdUppPv+j0umwaLtwZ/15WA1ytclqip
 I10Y33/qT6YFVzbgbtvjJlp2Cuq7xdEtJS6mcgdnR5yRJRHwQgyWXSCvolwo7mpj7l8A
 4+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=p9QUWUXMG6CjpUa+HzP2gwo+3axAKzjFQF2ULzEJvO4=;
 b=QW+OLMQ7Oaa4iMxuz+lPaJWbqrf7W0db6xDnLt4Bd2SpTyrlEISqy8piY/p840V6X8
 QHRdOvYEamlm1KgpiIOdAtEUjKa/KgWZD8gXXP5PsxTmFOCMntHp5qs3goF+TdwzFv7r
 6tRrl0SBwfWOmZG3ExUwLb892337N5z1u8DNC1fJgvWG6r6E9bab0iuW8MqPlYB4ayFA
 z6xXi6IlhcUtoMpH+YL7a6x0tD8s33GXSOcpSOnaJN49TxB04cl6LsHlBYiG3J2IiGM8
 DyARE43Qd5ZyIMOAtS/NgO2AN8xqD5ZyiXl8OleGf+bEwV9nebs00HzMkKVPNHdPOHUc
 QcEA==
X-Gm-Message-State: AOAM532Glrle/7yq6p49TvvKyrrSargQXPs8V8d4YswaIs/ppTk36yCm
 eAHW89a34AyGH8rNv0MaXgSIh/P+ysSvl7r+QHGhUg==
X-Google-Smtp-Source: ABdhPJyxCX4kXZjcqYDLRx1nJ90EzYTKdPBabw2ZSOFDEO5iPFiAiX67WGDMl0RZ4JfcycgIrXofSgT1KYIxXQT+8tk=
X-Received: by 2002:a25:be05:0:b0:629:1f49:b782 with SMTP id
 h5-20020a25be05000000b006291f49b782mr17321983ybk.88.1647265056161; Mon, 14
 Mar 2022 06:37:36 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 14 Mar 2022 19:07:24 +0530
Message-ID: <CA+G9fYtZ0vJaiA2sD+UuUiqAuZ+Yh88YNqgjTU7R9cwsvRcHTQ@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] arm64: db845c: cpuhotplug: WARNING: CPU: 3 PID: 26 at
 kernel/irq/manage.c:1887 free_irq+0x348/0x370
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
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[ please ignore this email if it is already reported ]

While running LTP cpuhotplug04 tests on linux mainline 5.17.0-rc8 on the
arm64 db845c device the following kernel warning was noticed [1] & [2].
This is not a regression but this warning was noticed for a while.

/opt/ltp/testcases/bin/cpuhotplug03.sh: line 40:   929 Killed
        cpuhotplug_do_spin_loop > /dev/null 2>&1
cpuhotplug03 1 TPASS: 1 cpuhotplug_do_spin_loop processes found on CPU1
Name:   cpuhotplug04
Date:   Thu Jan  1 00:00:43 UTC 1970
Desc:   Does it prevent us from offlining the last CPU?

[   34.409899] psci: CPU0 killed (polled 0 ms)
[   34.589257] psci: CPU1 killed (polled 0 ms)
[   34.748788] migrate_one_irq: 30 callbacks suppressed
[   34.748834] IRQ169: set affinity failed(-22).
[   34.748867] IRQ171: set affinity failed(-22).
[   34.748911] IRQ183: set affinity failed(-22).
[   34.748929] IRQ184: set affinity failed(-22).
[   34.748945] IRQ185: set affinity failed(-22).
[   34.748964] IRQ186: set affinity failed(-22).
[   34.748981] IRQ187: set affinity failed(-22).
[   34.748999] IRQ188: set affinity failed(-22).
[   34.749014] IRQ189: set affinity failed(-22).
[   34.749031] IRQ190: set affinity failed(-22).
[   34.757748] psci: CPU2 killed (polled 0 ms)
[   34.973881] ------------[ cut here ]------------
[   34.978667] WARNING: CPU: 3 PID: 26 at kernel/irq/manage.c:1887
free_irq+0x348/0x370
[   34.986579] Modules linked in: snd_soc_hdmi_codec venus_dec
venus_enc lontium_lt9611 videobuf2_dma_contig qcom_spmi_adc5
qcom_spmi_temp_alarm qcom_pon rtc_pm8xxx qcom_vadc_common qcom_camss
snd_soc_sdm845 crct10dif_ce videobuf2_dma_sg snd_soc_rt5663
snd_soc_qcom_common v4l2_fwnode hci_uart venus_core snd_soc_rl6231
v4l2_async btqca soundwire_bus v4l2_mem2mem btbcm i2c_qcom_geni
videobuf2_memops bluetooth msm camcc_sdm845 videobuf2_v4l2
reset_qcom_pdc i2c_qcom_cci videobuf2_common gpu_sched spi_geni_qcom
qcom_rng qcom_q6v5_mss ath10k_snoc ath10k_core ath xhci_pci mac80211
xhci_pci_renesas qrtr display_connector slim_qcom_ngd_ctrl cfg80211
qcom_wdt rfkill qcom_q6v5_pas pdr_interface qcom_pil_info qcom_q6v5
icc_osm_l3 lmh slimbus qcom_sysmon drm_kms_helper qcom_common
qcom_glink_smem qmi_helpers mdt_loader socinfo drm rmtfs_mem fuse
[   35.061476] CPU: 3 PID: 26 Comm: cpuhp/3 Not tainted 5.17.0-rc8 #1
[   35.067760] Hardware name: Thundercomm Dragonboard 845c (DT)
[   35.073506] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   35.080582] pc : free_irq+0x348/0x370
[   35.084328] lr : free_irq+0x300/0x370
[   35.088073] sp : ffff800008263c90
[   35.091457] x29: ffff800008263c90 x28: 0000000000000003 x27: ffff65e489bac000
[   35.098720] x26: 0000000000000000 x25: ffff287f41e51edc x24: ffff287f41e51f90
[   35.105981] x23: 0000000000000000 x22: 00000000000000ad x21: ffff287f40d06b00
[   35.113242] x20: ffff287f41e51e00 x19: ffff287f42bc7300 x18: ffffc29b34722b00
[   35.120504] x17: ffffc29b34722b18 x16: ffffc29b31d22ca4 x15: 0000000000050088
[   35.127762] x14: 0000000000000010 x13: ffff287f41fbd958 x12: 0005008800000000
[   35.135019] x11: 0000000000000040 x10: ffffc29b34401eb8 x9 : ffffc29b32ebc62c
[   35.142278] x8 : ffff287f40400270 x7 : 0000000000000000 x6 : 0000000000000000
[   35.149535] x5 : ffff287f40400248 x4 : ffff287f40400378 x3 : 0000000000000000
[   35.156796] x2 : 0000000002030200 x1 : ffff287f41e51e00 x0 : ffff287f42a57000
[   35.164056] Call trace:
[   35.166558]  free_irq+0x348/0x370
[   35.169955]  qcom_cpufreq_hw_cpu_exit+0x80/0xd0
[   35.174584]  cpufreq_offline.isra.0+0x26c/0x2b0
[   35.179202]  cpuhp_cpufreq_offline+0x1c/0x30
[   35.183561]  cpuhp_invoke_callback+0x16c/0x5b0
[   35.188094]  cpuhp_thread_fun+0xd0/0x1c4
[   35.192090]  smpboot_thread_fn+0x1ec/0x220
[   35.196287]  kthread+0x100/0x110
[   35.199607]  ret_from_fork+0x10/0x20
[   35.203273] ---[ end trace 0000000000000000 ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_describe: v5.17-rc8
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
  kernel-config: https://builds.tuxbuild.com/26LbWSfZlShbqStTOvXGslR1RBI/config
  build: https://builds.tuxbuild.com/26LbWSfZlShbqStTOvXGslR1RBI/


steps to reproduce:
  # cd /opt/ltp
  # ./runltp -s cpuhotplug04

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4715107#L4147
[2] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.17-rc8/testrun/8446603/suite/linux-log-parser/test/check-kernel-warning-4715107/log

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
