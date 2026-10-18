Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA494CCA490
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 17:54:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4C973E26C0
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 19:54:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 028A73E26C0
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 19:54:19 +0200 (CEST)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 621D2140018B
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 19:54:19 +0200 (CEST)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-3535a54c09bso1341618eec.0
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792346057; x=1792950857; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3wH84xhIXTO45bm4pNJjXceBze4fNShNOrbvg141vzE=;
 b=UQyQXfoUJ+5wYt4ostbY3Dp6FgQb0z5awUuk66wbnvnAbbEB8QlPrQzA/4Xdo1OLBA
 d+p7N+jUEpvmN6ajNlbZ5/LIduqsOkEvwZCbQhUh5qWYNVvaUtYtN//TiVOz5r3RFSJF
 dQz4wphlMhwrW94Mrp+Fly05aaHd37wrCuIiKkKYwmRdHyEl5lEilJaoxFwRf9cTlk6m
 pcAewLH1TcBodnEQ+T4lMGI0btwz0XPjtzz+gvNa32vwFHsmzB2Ic6oUA4DNzEoFDSsp
 uypalGVS/WbsGyFmolnFpevz3eUvLYlHTPFk5DZVORHRq7o/Mct/JEFFbrdAFn2faJrz
 WKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792346057; x=1792950857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3wH84xhIXTO45bm4pNJjXceBze4fNShNOrbvg141vzE=;
 b=uzycNGIMKPB1kRmNfH0bIfT/3R4QEl62fOjDKzo2a+caLHSCH1Lyi/I5p5VeIRBZZT
 ZhYFsUgZh9YajgLuYGpW9elx/mFQBdQ9qEAicQA3zzlX4dIdSA4A0ds6+0rSGjjD5GX1
 oTu9DrKrah5q0kTZtd6NVmbsiGbu5sFN+spb+6ZtjZtt30YdKU0mrN196tXh8Bpg8st3
 X/1VMNWRymjKLEN3MMyYNpXuryZQBYsrk+hNRozV5c0eAwMkxyDUPyVTKB2p4a2h5nDs
 Bm49u/9CmAj4NAwGXMJh9khcXQfJ5ZPp/agpj68JULk1YSJH92BO0ZKebEcjIqGMnrdM
 lB9g==
X-Gm-Message-State: AFq9FYIcwyrO2+iBvr3F70G0AzoaabymiMZHFL06xtIpjfl7pjCKBVR2
 ZZ9M3lBWj/9JdE23OgPr9D6U6dPooYsgLtNEoyWdPdYGB32otwxn0CCHtfr5Mn9e
X-Gm-Gg: AYBFou1y+/pKv6lXZoVrFEQfkaOkID8f8Qt71oEPf0EHnKjxNCLNj+svjLLYwTma1jM
 yRzYH+CM7tlnXT17qbgrKs9/3DUQsIHsNsfshdeKmX+hlAO1w0n9WwA7f06nChMiWUCQWuq3bIJ
 g7K9HMQZJPAfQ6J7Apk7ozwFFcv5M+mVI+ywjtM1dOh65dbZjeMvkLRZWHnhXDreLGcqfy+LKFi
 EUPfOPiRt7luHBAtndAGkpJFMcYPpzyoZANbekv9+f5cT8jUQ5fWm6eijTZ/52BrF+ebuGAlHTE
 2LA5HxbsCRJ4ZEVVktxxLerCNSSmVMvbWX2Z8vs9nqZeYXQt+ol1adAVEnmY3ekRz72CLbNlKRO
 WTPtZl2Pfdr9WRNW6fTApMwuyxqZBfoYSqoUGH/HRzsieuN/IsjL+K+QeeNA80kjBWv+j24dlEW
 aCOAk5e5qEJKXtSI8LNXx2gfN2pNuZa1Vfm0G0+4Hg7lRArFqSVJs8Vd6OlZqxyyxTksmF5arRt
 KIWYbZe/CQugLzHTG2EIdyNKNrgvTvcm0SbKPCHjeGTOVcgzaImEZfbGdKSSyYUr32KDlJGHSm9
 Yy0KMOT89boP
X-Received: by 2002:a05:693c:42ca:b0:35b:91da:7cb with SMTP id
 5a478bee46e88-361a284198emr7637944eec.35.1792346057433; 
 Sun, 18 Oct 2026 10:54:17 -0700 (PDT)
Received: from
 runnervm8k3b6.x4bj4itynosevhbe4vv11xkrfg.phxx.internal.cloudapp.net
 ([20.172.37.229]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082a7b33bsm46433217eec.24.2026.10.18.10.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 10:54:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Sun, 18 Oct 2026 17:54:16 +0000
Message-ID: <20261018175416.4137-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018160115.154430-2-avinesh.kumar@suse.com>
References: <20261018160115.154430-2-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: mq_close/2-1: Use a valid signal number for
 mq_notify()
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

Hi Avinesh,

On 18 Oct 2026, Avinesh Kumar wrote:
> openposix: mq_close/2-1: Use a valid signal number for mq_notify()
> openposix: mq_close/2-1: Initialize sigev_signo and check for EBUSY

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
