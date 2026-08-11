Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4328EC5B56A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 17:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D0AE3D0F4C
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 19:10:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BE373C06EC
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 19:10:09 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C396F1000224
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 19:10:08 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-38f25802c19so40883a91.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786468207; x=1787073007; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aV7Wwf1xYImJooNRVHvIgw44HiFFGcPDlY3XH9GcJxM=;
 b=ZY4xZI3Uc34lA0oZv3soUeUXOJhUKW9/X1xQrWs3Rnxjj8iMCR9CFy7TUORRcKkQqp
 2rG6lpGMWq29aYngq/9lwL8Acwl50MimgrIpnpohe1G52S+xsllCI/K0sTb7x9tkXi4U
 HSZw6hCIgudS70k9Rt6ODyPRcsAhVDxbgtCnvQC1Gam4fzDghQuQ2RxinOxxuPiC8Xdt
 dICX6C5/cNslqFMe0yrtKlfO9f8+Lw8uIjFyxPlYMbAGjea6K/s+dOvo2+9lJ58f5Qvk
 Rqw43yKAAG5Mbm2yVDNPAbDpZBEvA/YQRu0K24vknwrLpvQzPljAnHstMeeqKrjxxeil
 Ekwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786468207; x=1787073007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aV7Wwf1xYImJooNRVHvIgw44HiFFGcPDlY3XH9GcJxM=;
 b=nCBKSkL/hZiCLj0BNA2LORom3XFwagq1QzciiFGpv0WQVBWt5fAXMiA/L4GZ75x8x6
 C3lSnK6SOFzrGOgSRbRecLRLX4dd6weBZz9mqOXJz06DsVHKfAn8XoHsubMasZD/ZQb4
 OKg9wZYnN0eDKb7v3p7/R2fhI4286ZlBLAOyHfY/Jic5gBRvx4sTS3cV7C4Fp0ADTsyK
 wnbAg1J3FCGRrLVh8o+BWIFwu0+0sb+jR1Gx7qdwYxeKUJqouPbBhhIobCBPWtTlAre8
 t4VVTiJSnS/YNDj7Cjvohhmk0Go7bA6kopl7I59FwYsLs/iXXabOCXpnQgsGd+86jezF
 JwSQ==
X-Gm-Message-State: AOJu0YyDEYU662sVyTXJlNiPekhNlHcZmK1G7WG1gJL6Upexap7Vk+Q2
 ZKVrdpenO9knKe77k6ZqEQKSOFeuuYy0o8KRN82st6lukutCBsnWNh72qkFzsheo
X-Gm-Gg: AR+sD132Dk9vIrGBD6+spl82QruH7B5DInxeYGXR9X49fn4HM0MiNf6hE3pVBKcVOSC
 jo/5CArJmYzP84VhYCoZUGTG/cWb9xrN2bNrvSGW15OqmPB7iffOxHDV10par2H08Ar7bKdvw5e
 IJ6DzuFFuMO2ATAcI2/9Qj61W8ExxENonjUKV4QaiRWexQnzbXJTp66TSs5cBXQ/kI2yuw79QCZ
 1Ocx1dnxo0k7Vuqz7I22QGPPnC7M/DiENKWD/jum63JgPIWQF0wURwC+tDRql2GAxwhDetBjCMc
 I7vSkNqcSnNFqqDk2rOi041HBvsvO4eteNcQm/gV0D+flTOdtR7rFZXepSM/wXZ0adOiI8p8nGZ
 hkdkOee+JOWIrfPfz8NEMnIaJ8vfwxFh4gyvQI7XGzPbBwyzLl0UuTwUA8m9TJ0I4+DtoCiuozv
 BSCVLc2MgSr9deirSwPY+1SDfPjkvUGRKRkK5c1IJvjVm1fufAnAXOo/cKI2dLT81K6sk3Ftl6P
 Vrqj+kSaIrcztOZygtn+GwAfRbhjpbKWI2PlC6/t4+bpn63ESZG93LV1iEmHDg2dxLLu8WJlCsR
 aw==
X-Received: by 2002:a17:90b:52c3:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-392ec5a71bbmr5703881a91.15.1786468206936; 
 Tue, 11 Aug 2026 10:10:06 -0700 (PDT)
Received: from
 runnervmvrwv9.vgx3we2vmjdefpcn0vneq0jovc.xx.internal.cloudapp.net
 ([20.115.146.228]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f933f5e3sm237074a91.3.2026.08.11.10.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:10:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue, 11 Aug 2026 17:10:05 +0000
Message-ID: <20260811171005.9063-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811162856.67654-2-piotr.kubaj@intel.com>
References: <20260811162856.67654-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pmc_core: add test for pkgc_blocker_residency_show
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On August 11, 2026, Piotr Kubaj wrote:
> pmc_core: add test for pkgc_blocker_residency_show

> 	/*
> 	 * Interval between the two samples. The PMT telemetry region behind these
> 	 * counters refreshes at roughly 1s granularity: measured on Nova Lake, no
> 	 * counter moved over 200ms or 500ms, while 5 of 28 moved over 1s. Sample well
> 	 * past that so a static counter means "idle source", not "not refreshed yet".
> 	 */
> 	#define SAMPLE_DELAY_US 2000000
> 	...
> 	usleep(SAMPLE_DELAY_US);

Could this use bounded exponential-backoff polling instead? The fixed sleep is
being used to synchronize the second sample with the asynchronous telemetry
refresh, which violates the no sleep-based synchronization rule.

> 		if (sscanf(line, "%63s %u", name, &value) != 2) {
> 			tst_res(TFAIL, "malformed counter line: '%s'", line);
> 			continue;
> 		}
>
> 		if (strncmp(name, PREFIX, sizeof(PREFIX) - 1)) {

Could this validate the complete line and require a nonempty source suffix?
The current conversion accepts signed values, trailing tokens, and the bare
name "PKGC_BLOCK_RESIDENCY_". If both snapshots contain such a line, it is
recorded as a valid counter and the test can pass despite malformed output.

> 	.needs_root = 1,

Could the high-level description explain why root is required? Tests setting
needs_root must document the reason in the exported test description.

>  high_freq_hwp_cap_cppc
>  cpufreq_intel
>  rfim01
> +pkgc_blocker_residency_show

Could the new entry be inserted alphabetically? Leaf .gitignore entries are
required to remain sorted.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
