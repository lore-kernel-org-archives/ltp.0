Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC79CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 12:33:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E2273E5E85
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:33:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F4FE3CB3C2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 14:32:51 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1C3E140074F
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 14:32:50 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-13809223fd4so7769932c88.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781181169; x=1781785969; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAttTrZsx96TNUjCsucyt4f73b4zUzB+M7txLCEogWI=;
 b=L0IeQ9DDmSp2x2c4B4RT3iybvWAYBDuuzLqyeac4zyORWz+TtL/eHRZIgHpnM/AUar
 8LPXe+nTunQ11j80GYw2GbBrfDMdEEs0nMfuJnN+IgeTKako9slWz60p7UlmjQ9LubRI
 jKQEyzRQCbgwm6pvzhf/J2id6kVM8wLaXkL1IiCI7bjfuoVJX/W/SzIrWMxjjMi1UOc3
 kDOB+UnsNj1vCvP8i57L7iYCzloV/hM0+7uOj/99IU+U72ykiTVPNoK/NsmVTLCS1jxk
 2ZFU+jjyHQYIcI8IKeFEXXOAAkUQ9rcEQ0K702hqwtoHzs1ag4Fw83SAhAS4TD/VhcRU
 fGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181169; x=1781785969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wAttTrZsx96TNUjCsucyt4f73b4zUzB+M7txLCEogWI=;
 b=POaLBJhfCcoCdhIeXC/3L3RCuLzktGatQ5wBk2X6v8gTw7y7XHDCING8+GbbVKavpA
 WTsEQl4mVs7Cpypy+eS2hZMQhMi8CYQ76Lm4cfW4viD6yw4J6GHlIJ1WVbYQzrk3/Q3q
 cxD/JwFLUMq2zql3SAUoLd1MqdBedeOPbAFTHc/VMHdaQf8NdjnPi8CB747Ivae277q5
 sDjsscN5S5WIT49lBu0spcMImY5RApRq3LTpZVtOk5zu0zN1zlhTpAO9MCLdQ1VeLKn6
 LyY/lUyxe4NDJMqSfpjk5Qrxb1aw/atUY6l6qKIr13IN0nt+wgYHpTbsBrgsF+HIilhs
 aYVw==
X-Gm-Message-State: AOJu0YxMxGyZk4YHWXMPQShg/fqHtesn6oPpWQXVI7pY5j80jzwu+b8T
 DojfnafgwcGzReqe97ixiNp3B7MSE3X/H0GO/HGJXaA8DIs+TU+PMxwk
X-Gm-Gg: Acq92OEWO0NrK6YuMQQgoDknv3sCs9sFXLDFbWoDZQZqwh8H5PhlpQad+A+elDUOTRO
 rPH1qL1kyDFehnj8zDfZHr0YNGHKq5yCrbuI6UZkMGfNTdqD6ptmiUm9gIyv5qr+DTYt1jhpo5+
 qBBbdY4KlAe+TQOiBZQ9+8Qbvklyp1e+Q83JHUXsdA+JRYWXO9HAruUOpK/3u1P1Ez6iehtLG7C
 DosO8gnGHm6QRszBokD7r989MjodOJJ3Cjz7xX0fM2IEpffN4hcTf3tXsjtkKvTDBADNWaEhWPN
 Ptepe5kgK34LbBnq1IamZVOS1+2fok6Oqir11hX60f0brr66hgZVC15gFnz1Qi2ZLcduEMc/+xD
 LqEY7jOmmrR9aOTyqOIo18pgZ5n0p57GKWSNvPa1EsdWTl94rtgqQk/C5wvZIf9mX5ZlBxR8lJo
 fosRHh9iHPykk8zcqBhbVfsda+/GmbNJOd3P1mqLJY5/nRDcVq6ubP9ccNBW38tVqox2dyuwxxI
 yldHiBHGBYN1z2tIN3wy0msW1g2uuMjmRQM6EHf8kCSJdC4Cw==
X-Received: by 2002:a05:7022:ba8:b0:137:ed3b:e543 with SMTP id
 a92af1059eb24-1384213d33fmr1914685c88.9.1781181169182; 
 Thu, 11 Jun 2026 05:32:49 -0700 (PDT)
Received: from
 runnervm1li68.m5t4lhfzhnhutar1pm4xhdw05g.dx.internal.cloudapp.net
 ([68.220.60.144]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13843790552sm1476995c88.13.2026.06.11.05.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:32:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 11 Jun 2026 12:32:47 +0000
Message-ID: <20260611123247.4081-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114219.146444-2-piotr.kubaj@intel.com>
References: <20260611114219.146444-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

On Thu, 11 Jun 2026 13:42:20 +0200, Piotr Kubaj wrote:
> cpufreq.c: add new test for cpufreq sysfs interface validation

> +		if (cpuinfo_max_freq < scaling_max_freq) {
> +			tst_res(TINFO, "cpuinfo_max_freq: %ld", cpuinfo_max_freq);
> +			tst_res(TINFO, "scaling_max_freq: %ld", scaling_max_freq);
> +			tst_res(TFAIL, "Failure setting %s", path);
> +		} else {
> +			tst_res(TPASS, "Successfully set up %s", path);
> +		}

The frequency write-back checks throughout run() use one-directional
comparisons. Here the test writes cpuinfo_max_freq to scaling_max_freq
and reads it back, but only fails when the read value is *higher*
than what was written. If the kernel rounded the value *down* (or the
write silently failed to a lower value), the test would still report
TPASS with "Successfully set up".

The same pattern applies to the scaling_min_freq checks further down,
which only fail when the read value is *lower* than what was written.

Since the purpose of these checks is to validate that exact boundary
values can be written, would it not be more correct to use != instead
of < / > here?

> +		if (cpuinfo_max_freq < scaling_min_freq) {

Same issue: only catches upward deviations.

> +		if (cpuinfo_min_freq > scaling_min_freq) {

Same issue: only catches downward deviations.

> +		if (cpuinfo_min_freq > scaling_max_freq) {

Same issue: only catches downward deviations.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
