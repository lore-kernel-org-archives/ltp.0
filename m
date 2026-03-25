Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EE5106B518
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774441481; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RyS7WCaInDJ7Ku82vvr4fVGukfMUCZgUpJhoKgB3Arg=;
 b=ofbOVs/F7zmVC8PzSD2pjf6XbrwsNtPQXwrIGDNPCyl3WeQjE0DgEFO930kpZYmDz4kEE
 8J61iFc04VWpgMRfdFaDfmFyofwOqKviMfL7gyzEdaSE+wHTXusHLXH9A7ELE7BZ6ndKG0m
 Ar7fB6GyhrL8RhLK+YRqEhSXDBb2guc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3BCA3E2FFD
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 13:24:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9A5B3C041A
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:24:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3A4C140122B
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:24:17 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so8741755e9.1
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774441457; x=1775046257; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=i/qqhjvYN6EMdYJV/6VObMoJyeuR8l6FU81DhL6DV8g=;
 b=U0Q0H4p5KU2zC/jmCi4m5vM5f5OVwhq2wR2k728nct13OshN7EoaWyidD/XK7Xho52
 vO7Ev4N5LpA4b1uUHfFFfYq8/YaScnweytJVTcHAo9Crw24zcEoLXhQdIZ6/9nQxPcfY
 rwkx6caU55wqMRKqKpAvV3yUqgpy6d5jrg04I7GFcZ23n/gaUa50FReaGcwhmB6RNv+V
 BULvT6e19AHNjUqfWpSMaysXTQHHG7/PXrC735lHlxmUNxQYATvxpFTJxJod+wIv3i/D
 E4bgAJFolgvlWrUVscX9rCyrntKlrcDgIOamulx+qhX7rbK0GK/D+IwKaryuBssN4ikC
 SqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441457; x=1775046257;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/qqhjvYN6EMdYJV/6VObMoJyeuR8l6FU81DhL6DV8g=;
 b=i2PDfjIw94vPoM0elwmCruzZB6Ec+0aDkkMS+T8SZmbmm7sxipPKQK9G5CyKji6w1s
 nfQ08mUqg+WIk79fYuHCKnMra+XvB5tKbyh1EkuJZ4QAzgFjP/5hwSRKte381E1W7Cnn
 kAAOpYRKQsO2MQqje1Uf1aNjCR70daooRmXnoXJy1AUErTBP6/8xpn2UtPhJNNziXf38
 Ce6AoC3R+Xv8UmpemtE+dQXqkYqAHOGlu4b6oHwI4QZx7sNmp2jmeBAltQ69OeSDDYdl
 LjZdStTAxa7TR5PSst+bN/iLIydH4oNFWr9aBA3cVhQWT6tF3InqxlDzWwtgi2Ma/d/w
 b+AQ==
X-Gm-Message-State: AOJu0YyT1TPV80DSmoY1Hc4gn7YTP1HYeUYG7AgXGumYRDPEMgxxY0Dz
 IgUnoKg/0h4TpXv0PBfyUBAS3531q3rb/yhj3p5S5lWJASLldqWxETf5QkADZTRHwJ0=
X-Gm-Gg: ATEYQzwhp5rvTwguJom7Yzdk5VwGPq1axaw5JCtKnrb6MHzdJjvtBy+Rl/SHiQjs3zM
 33j1Lxmo1Urr998m5sjeF3pY8K0J43IOdUBVsYDrHFj2QSKpkLV8qfPgyGzAd/wfGLb/0tpM6nA
 jmEMT10MBx5sbbJvYZKgtLyT/s9BZGnjBIm+Lb3HQhve/rfpq/iFHGcKyekd0/9cPNyl7bOppEG
 uWphAmrDYkn388EjuLycijmGrpGf7dTuybXhSedNtg73l+fdH6CvKQr9rJ7ali45jemE49vkVSm
 hwzmkIQS5R5I/I8pSkABhpKV3fHkhWsdS11r00sDDUzwza1wgWBQLcQCySAbf51csIP2UzvXpBf
 hDvKkMw7pEb63S8w0lMczeqQWzo1+a9+ZcKACE9urjtXXZYLvUpl8HO4YIdZDzVtdd+l6U38rhh
 mXJl/RuGYBFsDOjCf3gqcsxYYMWfrZBySQua/+9KUGmWCS6BhE/TvENKF+a1/c5t7/grqw4bYLo
 QbnF0wTrARjzln7qm4ljh7ivYLYsK/QGVslqFhqIxafF8LzLuKc85YUDjqYEC2zwBTzjSQc2YKO
 Vw==
X-Received: by 2002:a05:600c:524f:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-48715fc76bdmr43265625e9.1.1774441456542; 
 Wed, 25 Mar 2026 05:24:16 -0700 (PDT)
Received: from p200300ef2f4fc9002ac0653bb49440e6.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487117077cbsm124118985e9.6.2026.03.25.05.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:24:16 -0700 (PDT)
Message-ID: <69c3d3f0.050a0220.2bacda.8597@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260323113940.188663-2-piotr.kubaj@intel.com>
Date: Wed, 25 Mar 2026 12:24:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

Thanks for the new test. A few issues below.

> +/*
> + * Copyright (C) 2026 Intel - http://www.intel.com/
> + */

The copyright line should include an author name and email, e.g.:

  Copyright (c) 2026 Piotr Kubaj <piotr.kubaj@intel.com>

> +		if (i)
> +			SAFE_FILE_SCANF(path, "%d", &online);

SAFE_FILE_SCANF with "%d" expects a pointer to int, but `online` is
bool (typically 1 byte). This is undefined behavior and will likely
corrupt the stack on little-endian. Please use `int online = 1;`
instead.

This should be spotted by any static analyzer or clangd..and even
gcc shows this error.

> +		snprintf(path, sizeof(path), "/dev/cpu/%d/msr", i);
> +		int fd = SAFE_OPEN(path, O_RDONLY);
> +
> +		SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771);

SAFE_CLOSE(fd) right after it has been used. There's no need to keep it
open after pread().

> +		msr_highest_perf &= (1ULL << 8) - 1;

0x771 and the 8-bit mask are magic numbers. Named defines would
help readability, e.g.:

  #define MSR_HWP_CAPABILITIES  0x771
  #define HIGHEST_PERF_MASK     0xFF

The test fails because msr device is not available, so you need:

  .needs_drivers = (const char *const []) {                                                                                                        
      "msr",                                                                                                                                       
      NULL                                                                                                                                         
  },

And probably the CONFIG_X86_MSR=y check as well.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
