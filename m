Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0EEC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8893C91F0
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:45:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDFC93C9204
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:17:03 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4068C1A009A1
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:17:03 +0100 (CET)
Received: by mail-lj1-x231.google.com with SMTP id y17so8425718ljd.12
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=i2Lo6xuTrSwDCA3BPZyQewuVo4NMGVzCLhFPiL+eabU=;
 b=nIhM10LfMIRJB/Hg50GqpBCiNFIYIrOegxfHrfvFLun8xMRbC9m6B/tzAUNbiWUdAj
 2xlivjfUROnSWnJksS/v1800CME/nmAsBu3GPhEl09pcOP25fNEvcRQwuCmInvf3ewhJ
 cJr7Mtj3sEuSipWbyfISFDUdu54sQGA3Js4xR9KOdnxyfXB6OKwOWyz1LKiUpNA81wMw
 ULAq3S6R2Snijv1eQvBum7pNZnLnvC+FOK8qQ6qhHYI6wJ2ZVOpQu+PPc5jSC2f1qsSg
 019WxYJnfr3/0mosfLJDOwmcDwjOEh1WCe5W4gWga8zbEeycfKPO9qpQrYSIiPwEFHBq
 VOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=i2Lo6xuTrSwDCA3BPZyQewuVo4NMGVzCLhFPiL+eabU=;
 b=P9Yw6Scok4bDIRFMSUpc/QdyTR89lts0nJQs/Yw+XABiv/XN3qLph6YPuVWZ2zEEPD
 frxcQPltzaXstRKI/PZhTAae8KkfhtLPNk5Db+WMrphmW7JleOQgqWi3rXJc/Ro7JSiL
 pCsefy66p2dHILavCirnZ654v2AkqA0iNilaHFZ/IMv1rYxlsyHunua+eYojO/oUqxL/
 3Z8Bhi5/0npRfDcFS2hTzIeeo2JrcK6mgRqqoTyh0pYr9tpiBmFcaQXOAEDWmn7GIw2j
 uWEaz6CimfiQZCLf4W6WGUZcI/QFine7LbYJU1vbYn6lOrf7j916aJtKHxUSWRPthpwz
 lNYA==
X-Gm-Message-State: AOAM530kpN27HzxLXGpnnBVz3SNu5A+dgy6aspdlkGNCYNP+65cfirz5
 C5hBWgTBTP0kZfQ0idHAkLXXMg==
X-Google-Smtp-Source: ABdhPJwoILLQJDWKnaeqTqenkyMpMA49OH0o/COsh5GUNJz6YE8lA4QphGqurRKPDzV/EV39d9ntCA==
X-Received: by 2002:a2e:5748:0:b0:249:23b0:fab with SMTP id
 r8-20020a2e5748000000b0024923b00fabmr10057576ljd.265.1647335822419; 
 Tue, 15 Mar 2022 02:17:02 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a2e9f47000000b0024802e6f480sm4313997ljk.130.2022.03.15.02.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 02:17:02 -0700 (PDT)
Message-ID: <945434d4-1083-7aca-d290-847ccee15194@linaro.org>
Date: Tue, 15 Mar 2022 12:17:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-GB
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>
References: <CA+G9fYtZ0vJaiA2sD+UuUiqAuZ+Yh88YNqgjTU7R9cwsvRcHTQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CA+G9fYtZ0vJaiA2sD+UuUiqAuZ+Yh88YNqgjTU7R9cwsvRcHTQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 15 Mar 2022 13:44:55 +0100
Subject: Re: [LTP] arm64: db845c: cpuhotplug: WARNING: CPU: 3 PID: 26 at
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 14/03/2022 16:37, Naresh Kamboju wrote:
> [ please ignore this email if it is already reported ]
> 
> While running LTP cpuhotplug04 tests on linux mainline 5.17.0-rc8 on the
> arm64 db845c device the following kernel warning was noticed [1] & [2].
> This is not a regression but this warning was noticed for a while.
> 
> /opt/ltp/testcases/bin/cpuhotplug03.sh: line 40:   929 Killed
>          cpuhotplug_do_spin_loop > /dev/null 2>&1
> cpuhotplug03 1 TPASS: 1 cpuhotplug_do_spin_loop processes found on CPU1
> Name:   cpuhotplug04
> Date:   Thu Jan  1 00:00:43 UTC 1970
> Desc:   Does it prevent us from offlining the last CPU?

This should be fixed by the series at 
https://lore.kernel.org/linux-arm-msm/20220309223938.3819715-1-dmitry.baryshkov@linaro.org/

> 
> [   34.409899] psci: CPU0 killed (polled 0 ms)
> [   34.589257] psci: CPU1 killed (polled 0 ms)
> [   34.748788] migrate_one_irq: 30 callbacks suppressed
> [   34.748834] IRQ169: set affinity failed(-22).
> [   34.748867] IRQ171: set affinity failed(-22).
> [   34.748911] IRQ183: set affinity failed(-22).
> [   34.748929] IRQ184: set affinity failed(-22).
> [   34.748945] IRQ185: set affinity failed(-22).
> [   34.748964] IRQ186: set affinity failed(-22).
> [   34.748981] IRQ187: set affinity failed(-22).
> [   34.748999] IRQ188: set affinity failed(-22).
> [   34.749014] IRQ189: set affinity failed(-22).
> [   34.749031] IRQ190: set affinity failed(-22).
> [   34.757748] psci: CPU2 killed (polled 0 ms)
> [   34.973881] ------------[ cut here ]------------
> [   34.978667] WARNING: CPU: 3 PID: 26 at kernel/irq/manage.c:1887
> free_irq+0x348/0x370
> [   34.986579] Modules linked in: snd_soc_hdmi_codec venus_dec
> venus_enc lontium_lt9611 videobuf2_dma_contig qcom_spmi_adc5
> qcom_spmi_temp_alarm qcom_pon rtc_pm8xxx qcom_vadc_common qcom_camss
> snd_soc_sdm845 crct10dif_ce videobuf2_dma_sg snd_soc_rt5663
> snd_soc_qcom_common v4l2_fwnode hci_uart venus_core snd_soc_rl6231
> v4l2_async btqca soundwire_bus v4l2_mem2mem btbcm i2c_qcom_geni
> videobuf2_memops bluetooth msm camcc_sdm845 videobuf2_v4l2
> reset_qcom_pdc i2c_qcom_cci videobuf2_common gpu_sched spi_geni_qcom
> qcom_rng qcom_q6v5_mss ath10k_snoc ath10k_core ath xhci_pci mac80211
> xhci_pci_renesas qrtr display_connector slim_qcom_ngd_ctrl cfg80211
> qcom_wdt rfkill qcom_q6v5_pas pdr_interface qcom_pil_info qcom_q6v5
> icc_osm_l3 lmh slimbus qcom_sysmon drm_kms_helper qcom_common
> qcom_glink_smem qmi_helpers mdt_loader socinfo drm rmtfs_mem fuse
> [   35.061476] CPU: 3 PID: 26 Comm: cpuhp/3 Not tainted 5.17.0-rc8 #1
> [   35.067760] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   35.073506] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   35.080582] pc : free_irq+0x348/0x370
> [   35.084328] lr : free_irq+0x300/0x370
> [   35.088073] sp : ffff800008263c90
> [   35.091457] x29: ffff800008263c90 x28: 0000000000000003 x27: ffff65e489bac000
> [   35.098720] x26: 0000000000000000 x25: ffff287f41e51edc x24: ffff287f41e51f90
> [   35.105981] x23: 0000000000000000 x22: 00000000000000ad x21: ffff287f40d06b00
> [   35.113242] x20: ffff287f41e51e00 x19: ffff287f42bc7300 x18: ffffc29b34722b00
> [   35.120504] x17: ffffc29b34722b18 x16: ffffc29b31d22ca4 x15: 0000000000050088
> [   35.127762] x14: 0000000000000010 x13: ffff287f41fbd958 x12: 0005008800000000
> [   35.135019] x11: 0000000000000040 x10: ffffc29b34401eb8 x9 : ffffc29b32ebc62c
> [   35.142278] x8 : ffff287f40400270 x7 : 0000000000000000 x6 : 0000000000000000
> [   35.149535] x5 : ffff287f40400248 x4 : ffff287f40400378 x3 : 0000000000000000
> [   35.156796] x2 : 0000000002030200 x1 : ffff287f41e51e00 x0 : ffff287f42a57000
> [   35.164056] Call trace:
> [   35.166558]  free_irq+0x348/0x370
> [   35.169955]  qcom_cpufreq_hw_cpu_exit+0x80/0xd0
> [   35.174584]  cpufreq_offline.isra.0+0x26c/0x2b0
> [   35.179202]  cpuhp_cpufreq_offline+0x1c/0x30
> [   35.183561]  cpuhp_invoke_callback+0x16c/0x5b0
> [   35.188094]  cpuhp_thread_fun+0xd0/0x1c4
> [   35.192090]  smpboot_thread_fn+0x1ec/0x220
> [   35.196287]  kthread+0x100/0x110
> [   35.199607]  ret_from_fork+0x10/0x20
> [   35.203273] ---[ end trace 0000000000000000 ]---
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> metadata:
>    git_describe: v5.17-rc8
>    git_ref: master
>    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>    git_sha: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
>    kernel-config: https://builds.tuxbuild.com/26LbWSfZlShbqStTOvXGslR1RBI/config
>    build: https://builds.tuxbuild.com/26LbWSfZlShbqStTOvXGslR1RBI/
> 
> 
> steps to reproduce:
>    # cd /opt/ltp
>    # ./runltp -s cpuhotplug04
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> [1] https://lkft.validation.linaro.org/scheduler/job/4715107#L4147
> [2] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.17-rc8/testrun/8446603/suite/linux-log-parser/test/check-kernel-warning-4715107/log
> 


-- 
With best wishes
Dmitry

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
