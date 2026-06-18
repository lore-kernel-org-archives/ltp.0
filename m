Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4345CD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781783556; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DmCUptHwFcQFrWSMOhWFdTXkPdAMXEs490cFzfWiHTM=;
 b=dj42QTYvaQ7iwEEUBb/wq0AQLyfAxYCzqSvRmbozgNZ6ASbhbuYEkGn9AE04v5w9l87j1
 z56eK8/cEOvAci+wYUaGW3fDYimGzSUUNrKfezOrrwVm9TmGlVg2S8zpPTPtzTLO+fd4xMk
 iWCjqET7Y24zCHyCuVa4ln85rsrDQFY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB1D33E5879
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:52:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C6303E586C
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:52:17 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7702B60066E
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:52:15 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so5077855e9.2
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781783535; x=1782388335; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yeGGm6t9mHwkXfemU80IBzZFD51o9W1EXU+aq4SP1O8=;
 b=Z2WGbm9odn5vDtwenKnPFumazAzD65/O4A39gGF9+CTNRWWlXh11i4aedGsAeG4E7D
 ybqtOyPfRCFCxmirC6Nj+7CMrmyhOOW9R7TWnKGh+WSwLwvJafOBAgv+qB4vncTYphgl
 RuGzhG9VVMxYgSCXSQjZeCOx0bga3CXbi3XDblHCKiAbk76sXV3dndyc1WWn91WDoxa8
 zb8r3WCBo0ekcBThtPnv7RMtZFSFRUBCf4k2lUE60MIgFecu8qD1hblZWa033ZTmeZE7
 E64L72o9L21BGk+NvQcNtqAIWJ7o/8b+TKrNzLEbpNM7NOuIanRFY6VCwuaTHtG3uaSJ
 RtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783535; x=1782388335;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeGGm6t9mHwkXfemU80IBzZFD51o9W1EXU+aq4SP1O8=;
 b=hHCfoG5nJD6ynxyM82osSt2dqj8cXqWH+Q2JvCa/qeLzg/u+pq4POLeB4FQvG8XGs0
 RAH7mNVWHBMgcuMRixd4UpM1h69mRQy2Dc79/D7FPqKYKC1oyMpeCm6yLXCouGjrWqAU
 i43EUE8XN0glqmsyJaXgfQVNKCnKePJ7yKy/ItZv43nXC3l0kM0pkYwRSdjpSGBV/2i5
 4LKCKm4MbtPD14uJJlFcrSIBaG/VaaKJyoFOCMQaKCRzFdypcSAebftd2S4IlNlmTm5Q
 Nboi9GjW7Ml6SHdyif5R0m7KRukCRuFgQ9CnBwqzhrwVkIQkEa1utHHIhIj2ws0hKXP6
 6jJg==
X-Gm-Message-State: AOJu0YwLQeUcCAJ/nrfTHyL4VKDhWoV8jnCp9Q3XS9tQiBeFQmsvJl7C
 ksPcEUI6BDq2JkLGvuApORETzrO0SgU2ilGK6ggORomt3c5DerInFpTfJKc3gjLnQAx3VNvD9Ny
 jvLK+wQY=
X-Gm-Gg: AfdE7ckNgK3Idz3YUerfYAeIsy7LBMvxkWVkqfdkhTvd1RMQgImm2xw8rkTzxDzCZ4F
 d4sopVG8xFR5TSmZVf+eWuFS7ZMY/FmhwIH3a3ZyZTnr8Flw/CPMwVxeaF8470s/fAdkfgLoLXk
 10jghOjbFtF0A0sVbRjbdlwfTrZ0cLeeLWikiLguezBpN00t/lT/KLHlAp3QFDoaeqIXCdODsas
 /Tfj46mtTCoxn4Qn52mN5Zfnmu5zAPCQUxt/OXefgCCLyk/nbzr2afJRWxtJEBvmUCDuCSsywzN
 0tk3LMq1puIgvi/QpKhhglIYghbkcsHsT4iQeGMB+giX1YWuPbKjVu7Jeym4xRVsGmZbRJ8x/QH
 vG9fzUtS0gNCa9f0YFzT/UZUsDm7+k4ZzttJm9qsg98Ns1QMT2bd35xjg0bMxonZKB8e2uK1PBg
 10iQIv6zrg4NtzAzcoxk+A+s0ZI9yGgluayiICCKf5pLAGqqsQ81BnmXf4YuuSkwylMZOWPqLV
X-Received: by 2002:a05:600c:3f19:b0:492:1e36:bb04 with SMTP id
 5b1f17b1804b1-4923822df1cmr49105995e9.37.1781783534775; 
 Thu, 18 Jun 2026 04:52:14 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a45b30sm242504385e9.2.2026.06.18.04.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:52:14 -0700 (PDT)
Message-ID: <6a33dbee.51d65a57.34452b.c5b3@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260618114706.105296-1-avinesh.kumar@suse.com>
Date: Thu, 18 Jun 2026 11:52:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fw_load0[12]: Skip on Lockdown and Secure Boot
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi
> these checks were lost in the recent commit converting
> these tests to new API.
> 
> tst_module.c:139: TINFO: module signature enforcement: off
> insmod: ERROR: could not insert module ltp_fw_load.ko: Key was rejected by service
> tst_cmd.c:112: TBROK: 'insmod' exited with a non-zero code 1 at tst_cmd.c:112
> 
> with checks added:
> 
> tst_security.c:104: TINFO: Kernel lockdown: on
> tst_test.c:1467: TCONF: Kernel is locked down, skipping test
> 
> Fixes: fd2c4d2c25d3 ("fw_load: rewrite test using new LTP API")
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
> Changes in v2:
> Use .skip_in_lockdown and .skip_in_secureboot fields in struct tst_test
> instead of tst_lockdown_enabled()/tst_secureboot_enabled()
> ---
>  testcases/kernel/firmware/fw_load/fw_load01.c | 2 ++
>  testcases/kernel/firmware/fw_load/fw_load02.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/firmware/fw_load/fw_load01.c b/testcases/kernel/firmware/fw_load/fw_load01.c
> index 4b30a3b40..cdf0d387b 100644
> --- a/testcases/kernel/firmware/fw_load/fw_load01.c
> +++ b/testcases/kernel/firmware/fw_load/fw_load01.c
> @@ -108,4 +108,6 @@ static struct tst_test test = {
>  		"CONFIG_FW_LOADER=y|CONFIG_FW_LOADER=m",
>  		NULL,
>  	},
> +	.skip_in_lockdown = 1,
> +	.skip_in_secureboot = 1,
>  };
> diff --git a/testcases/kernel/firmware/fw_load/fw_load02.c b/testcases/kernel/firmware/fw_load/fw_load02.c
> index 8d2063772..fbcfd3faf 100644
> --- a/testcases/kernel/firmware/fw_load/fw_load02.c
> +++ b/testcases/kernel/firmware/fw_load/fw_load02.c
> @@ -90,4 +90,6 @@ static struct tst_test test = {
>  		{FW_PATH, NULL, TST_SR_TCONF},
>  		{},
>  	},
> +	.skip_in_lockdown = 1,
> +	.skip_in_secureboot = 1,
>  };
> -- 
> 2.54.0
> 

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
