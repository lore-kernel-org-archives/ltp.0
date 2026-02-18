Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5010DE9A047
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771418105; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=d4plD46c3k7Fd84U1obPHTRS5Ks/GGTRM6x4xb+Swtc=;
 b=gni7qj71bg/xq/rSdtsS3UCx0P79fEqicit21K9SOEyvizDCeDABdGQEXCSor9Num5INn
 O6vPUW1Wszvp86KvQ2syL3OY090RsXiPsPEsNxTkHh2Ymy3E8zpLexNMeBxMYL2+g0rHEee
 Z5ING+BXd6p369s3NBRiZHp84PwEZLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 006CE3C65E2
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C8993C58A2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:34:42 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E3086200979
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:34:41 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4362c635319so5157696f8f.2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771418081; x=1772022881; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=709Q5kzcJOPL6uMDbRtn7WZxU4KLW9y9e+IMW3T2Ddo=;
 b=VLRuL2f4gruWZT0Hs6YeD3Mrt/dIXN3rhJ8rJHpNxWjONvzDYZaLaj6Hsn/iTTtOVd
 B9pnrQLz0v+gUKsPvLk6E3KCubMHRCnlEsTSbUdV00qic2Mz/4HrMaA3MPH4z60mp9TW
 uk8aPy/xA9XIxKB9bwCszMaU4Q1s89NrOd9nDkV/azSrI5DOUohTfF8TvNp+rl1iVwjI
 UDNza3PQiUnjxWvFpq7isT2e051Qy7BJznAG6zCS80Iu0JC9aBemXRR77bhvQNd3rnDc
 2ifJZGvnMCJhYLBhIFTVB0IeZTFHsKEVWDi+jDYojp4NRjKBHb09g9b+9s36yRO/6OxA
 NPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771418081; x=1772022881;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=709Q5kzcJOPL6uMDbRtn7WZxU4KLW9y9e+IMW3T2Ddo=;
 b=kbos0uEABCEOW+HWfxPjNEF3ew9WcP0zGwVg0im/uYJQM2Dd8gkTSKTmGkP80WK+P5
 kWLetUvw9YUvdw1fkPxbYnhG/3vanP2yfk4D6vVP/LzKLI6AANJ33GT3czVuS4++lIg5
 L5mRSU4pJSuIxreyRUJhEPkToJD4hhjnqxvZuHRYT23RoB7pe/dlon/mwp39rx3lVzyE
 3GnV3zb8Z5L7mF5PEjrDAirkYtPnTO0cMll/qu9THk6me9IBYJqxvSueLUs7UHhyyXag
 L0i4NpMoZ780DE7UDgvjqWJhf2RgRJUffUzXY/Bj6cTTdY1r1XdQs/q7UlrICEqRdN7p
 l9oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU33EGdD1TuX2AO/XgEmrd0+kAsCe+OrBQRrs/EOw/nbTvebXYqX9xURkfrzfsAmUqC0Sc=@lists.linux.it
X-Gm-Message-State: AOJu0YwcsBCSyP+Sk6K6XPFUNAZyUBKd0PjbHbnYpg1w+5DGDOrj6ZYK
 k8XXlOgaqt9m+hIJKE5Jn/yBDUrPPBzIkrXBc6n6HyX5Jw0bAKaya4IWL6/EZNDiCgA=
X-Gm-Gg: AZuq6aKIIm/7mUhGu6um0JZO5qLkP+RXtiTyjUh7myAzm4f3D+tTo1YTnq1im52ZCf1
 tECbqgoLKESTWOrFaKxVELYeAninwJ0c6y9hKSjkiZqyCruSQC/XjXMRrikBH/+4Tks2MMOgJ6c
 Ew9a7mg96F6cZMu4JfWcZ3o3rVFhHoEID/SI5mCE0qYCC+1EBr4MgDeDA2iIdDYVy7frqIYlZ3g
 U3KwL/FGuGVkxMEsqfYKZnAsNrRPOd8hhfpwTSset+CUc3Kr7RblOFWiLnpv3alC7TXmD1ysVTr
 6zQmaBbtcNLkOdSekZgi2YPbXnYgFDVTi4WUJhe810BZpAuxCWQ1K4ERt/BKTTSfbRJwh9EAnyU
 hnSToyZQKA/6b9zBpzC0gyJpRtP0buIlwun2azR3aWaFPsf/u2zqYfXiMOJkLaMyHiaR2uLq8Iu
 MBdAoQO0+xe8HeEWy5gy2/KcMDJTuWBbM2Wx2T1xyEEZChjR6IFZWsq0V33SQOi/BaI736RXB55
 tpOfL2T59egEDcdUO8=
X-Received: by 2002:a05:600c:458a:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-48398a7e1e2mr31072035e9.10.1771418081078; 
 Wed, 18 Feb 2026 04:34:41 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm795388005e9.6.2026.02.18.04.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 04:34:40 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 13:34:40 +0100
Message-Id: <DGI3AVRTDVVN.14V2UVJXCIRE0@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <DGH7IUS12FMT.QMUF16MQGD6U@suse.com>
 <20260217122245.5806-1-always.starving0@gmail.com>
In-Reply-To: <20260217122245.5806-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] open: fix cleanup condition and use
 snprintf
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Feb 17, 2026 at 1:22 PM CET, Jinseok Kim wrote:
> Hi Cervesato.
>
> Thanks for the review!
>
> Changes since v1:
> - Replace remaining sprintf() with snprintf() in setup()
>
> Thanks,
> Jinseok.
>
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>

Are you using an automatic tool? This seems like a wrong commit message.
Please resend the whole patch-set with a proper version and right commit
message. I will reject this one.

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
