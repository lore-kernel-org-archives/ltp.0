Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21004C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:24:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD3013E213F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 16:24:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 301643C1C41
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 16:24:29 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B19CB60080C
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 16:24:28 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8f23e46d268so6734796d6.0
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784643867; x=1785248667; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lh2Mfm0xM/fyHiC8TpQuMSkZyg+ZQMfPVbfZhAQmPmQ=;
 b=Z26f8hnGOOVy44gNNy1FqmGlUKRFtNIXez/8WxG2VkvnlXrIxy8x/2oJJ7IHFaZcRU
 zWMM3MS4y0+X3Ir5K83bwM9ze0pYQMloM38/WGWaCCPEsw6Ez19GOZIpgda7C/nj/Oc6
 VA1zireqOdonaERXmH+SJJ/Y4x7aWEMahuAFc2I3ghqvReRD3GM/dI9OzjoRGtDPwO1o
 8LfXT2VaGDDPakponOtMn3yPYasvBhtL3qD+lzQZ7PiLwjFe5RhlFXjpz33MEF0CQZnF
 ojedUrm8dKG09FOLkhcQUlxpYu/TBeYn5VswtzmYfpdrmCBaBNZnaV48Zr1IIKKSmxxi
 bimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784643867; x=1785248667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lh2Mfm0xM/fyHiC8TpQuMSkZyg+ZQMfPVbfZhAQmPmQ=;
 b=sbEZdl66G9qxE2MYizesKytQNplhA+IZONAsJikLhwmizslodUvZBeZOkt9HHBs8kl
 gHM5q1bW5uzMVVHxxeSsdtYR8M42dNQHQhfj4XudtcdrweErmEQJ/GemIPM1W60ejGC4
 mH9S8zq7+hqPPw1RVRvAF5D5r/p0o1caNy6VeM8e/rweR4jOaqdgy8pjKiFciGYtvjgx
 IoJDjTp5orUticty9wXK6/G7zg2fklUSc4Fvar7d5+DROaIIdjVEQ7lqWRv9JUVW+BFb
 eAuHrWSZ7zOD3af5oQ62H6djVWg6CtxdSR/t8dduxiIZReHk9AWiU15jdILTOmh+Swc7
 z6xQ==
X-Gm-Message-State: AOJu0YznF5G/xOv+gT5x5VCHNz4/Li6TaKr+Oj4bMjfncAR9saQImKwv
 E7/0Y70GbR07ZjzkkBegI98qWcmZUWThV1jZPyAJWua41WIDa9KMydOA
X-Gm-Gg: AR+sD13ZtIMO5NaJ7xHF2VQCliO+50dLv7p0B4GHeCEBIWnmfShcdu028SGh+etwsNd
 x9Ag1LAxo1N3aJSVa4L79ynFxAQU6mtRi9Ek4rTIJs8mizi8+tWamwinjw/rNu0b1MvUNSodpjP
 1l2NXPDjtl9Yv2lSr97o0p2CL3U7jyeO/F8qrXFZPlaTQsZN3MJ92YY1Y+EThPr1pFV7I149Ztx
 6m4vSzu7XAqGdbtxjL3Iei+AwplI7aXjo0iMLsYs5VWz6M20fklZXszBZxzUJDDVOnxlCL9Xd68
 rE0iJ9AmzUtmtqxcQbHQBz6GG/0KqQ0tt1iyhHTdnajhzI09gZCIqX5YMDRxBR0dFOsQMweNH6e
 98nRfo8RnDImnEd5IZZbIe1e+zCuRbrlcEadpgJgPq2Qp2nbIwMIelqA4yIHQmpqM5TDUN753SH
 IJQNCstfzvpPuzyoxNyqEdJb68rh3Zg/lOkbilcbZBjWm53+GzW6g6MFxQP9k6myh0jp3IQ2gzp
 MWhJD1w8K6SE89pqc7kF4lnSg==
X-Received: by 2002:a05:6214:2345:b0:8f1:74b0:a4ec with SMTP id
 6a1803df08f44-907787c479amr192671636d6.4.1784643867374; 
 Tue, 21 Jul 2026 07:24:27 -0700 (PDT)
Received: from
 runnervm3jd5f.iqcvtop1gtletd22nby4u5jplg.bx.internal.cloudapp.net
 ([4.246.135.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778562524sm116948856d6.13.2026.07.21.07.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:24:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 14:24:26 +0000
Message-ID: <20260721142426.8581-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721141601.667095-1-andrea.cervesato@suse.de>
References: <20260721141601.667095-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inode: convert to new API and merge into a single test
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

Hi Andrea,

On Tue Jul 21 2026, Andrea Cervesato wrote:
> inode: convert to new API and merge into a single test

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
