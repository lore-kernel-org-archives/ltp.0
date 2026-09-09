Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2197EC79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:35:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E1363E9322
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:35:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 818F43E53FB
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:35:12 +0200 (CEST)
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F36A600286
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:35:00 +0200 (CEST)
Received: by mail-oo2-x07.google.com with SMTP id
 006d021491bc7-6b1adb62a63so222529eaf.1
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788950099; x=1789554899; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PaPTu+kJ0N0xGPNCqvD3PKolaty9ebuNW94Q9Ljbv7I=;
 b=Dgk+0c3AFe3ODjZEHwJrinn0WjMaJrJr6G0pmhcyReywS2RiBn9uG3oUA2Rs1g647Z
 fzg4r0AoYl+3udtHTSjQiusZli2plIa4SMxFH5FVYPdfNM8ZCclVe4LzPDD0nNdkC+P7
 o1fKa50GAIEh6iciaSD8SzBl8AX5ASYwgDtveuW+ZHacHmIHdGa2h5FvNSVGVERIRt6k
 csLoaqtylFql/P52y+zKJNKDl25yxkoHK/XmT/Ds8I64GYZMsOtYkLi5kEqSlh3nSL9B
 VIH8m2vQtKO+6EWw5DGaBlV9Mn5wBjgn/V6loqUhflrPPRzbZyiiYvA1E6/CLUQR6Dgg
 RplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788950099; x=1789554899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PaPTu+kJ0N0xGPNCqvD3PKolaty9ebuNW94Q9Ljbv7I=;
 b=g88MtOv9v7aAQs7YqiVAihtEKtyNE9tLwjdH8mC2QbSJPM/LUeUQZ2own1LDNiYHMf
 kjU6/OOnVGjWzgPd6BtboXPzA85UJE/I1TGt8hl6E8w+2M/Kavgd8Gc/5404OkTjJYw2
 E4VbPGT3BaqOnjPGSTf4UZGot+JZ95/hd1VFDAKsztID8B/gnl/QlvfeKpftaxzc1kDw
 c7+032soEn2PUAhOR038CjpEt2dJ7mcBSWIKekVCTTp4BCDEZYKRD1xQ8AP2M972tA3y
 yX2e45PyFj6nlV5edcdkhrKNcbMVA+BWLquDaiGwYMvDgrWYqKI21+j0oFHHO3CMuk5W
 +QqQ==
X-Gm-Message-State: AFuF++kjAhzXl20WeERaBzOx4INa0/qzY1x+0Tf6IvAiT7x/T1JfZ5W2
 BDyOC7zCx64e/076kTFKBGc12GPofQq+dWnFlnJvoF7c1xY+digF2tC4
X-Gm-Gg: AYBFou0qERhO0eMxXiLEFo0oueubvjmmT0K726A6s0DLDyfxgRTbfwk6Lq2bwqMia9X
 xej76gKUfPZMsxYlOhzd5H1424wx+leVz1C6Q3taqwTz1X4eqwhLEiHf98skk9piHq1Outbi64y
 pzE9jJ6Z4vcpNCoRrgClFLyuAmfQWIB9MacEpoliY4cYg5Ouu6Br6gqhXwImVOlpE9str1BhNQA
 KZsU50EbdpYyApEDCDyVf9QF9bfP7r0zu9PsJUbXrtb4lKKu1TsWDhS2KPOxbYPGHTk8P3TOGCD
 U0+8/XPRjKyHsvqQWolM6bL3qT/FqO0DxMsxM2hgYcA5wg2IcAcDT6i9DmTXDZ7ZfbKZOt4jBWe
 anGKGeKh536KINpKOHhfoJupRb8/D/Qm82lwTlnQXxVY/b/rCS2w5SK85rv/bjOVvQia6y/Mc1P
 JXG0pUPRy7Myhov52JCpYN39w4387IGzHJhHzVdey7XXm4QD0HY+qi5/AnR8+61kfy74XOFCjem
 6Jxke7U/oBZlkwU3lcn9C6zMFUQWm7TMbpAO0NqtZQWxTD3sN2kHmkyxAw9ZBUvcUx7ceWvwZqL
 2s0m661Lp7Dwpx3USBbc4C4=
X-Received: by 2002:a05:6820:7087:10b0:6bd:fd44:9035 with SMTP id
 006d021491bc7-6bdfd449900mr1166004eaf.6.1788950098936; 
 Wed, 09 Sep 2026 03:34:58 -0700 (PDT)
Received: from
 runnervmejwal.brvwqeymgzfedkfucv0x4hyzuf.gx.internal.cloudapp.net
 ([20.186.238.152]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dbedc6fasm18888242eaf.3.2026.09.09.03.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 03:34:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed,  9 Sep 2026 10:34:56 +0000
Message-ID: <20260909103456.10020-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909100414.14473-1-wegao@suse.com>
References: <20260909100414.14473-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

On Wed Sep 9 10:03:45 2026 +0000, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));

Pass AT_FDCWD instead of 0 for the aux argument, as aux represents the dirfd
parameter for openat-style path resolution.

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
