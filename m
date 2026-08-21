Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A94CC5DF88
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 06:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52FCF3D03D4
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 08:53:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0CFC3CA177
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 08:53:37 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 442731000374
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 08:53:37 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-9371529ed6cso13612085a.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787295216; x=1787900016; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GjwLTeBuM+pgCtCVq33ZAsWG7BY9Nt/RqtdWnxphYbw=;
 b=jjkSFu8bIIZpwhaTqJGMjeusYzEdQ6Ie8ccBRX89ze31NHrBF042B+VcdhCydN8NVs
 NZSdLL+FON6LcUeQVz72FoFpSB8qNVlikXyRmqD8T/MSMNzdtYC7llPxXutFIRWy6wvV
 aCfQ1OupBMkuYx+1nw+cc6xeLv8zTNM9RmbWq2MPG/LmBFEj86yrpzWlcKJ51/S3ec+B
 EVgrqgTmLrJhWh8EZ7XY5pkAltnqz4iNbyBc5rsP4GCvaVjaoG7Po8jaMQVQGM10rk45
 PaWvzZ4xNv1mIk8fNnpRNRA2xmoZMeRQQ9pZ2YK+eH65x4rgezVwHii5iMJnD+8pLrLY
 XbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787295216; x=1787900016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GjwLTeBuM+pgCtCVq33ZAsWG7BY9Nt/RqtdWnxphYbw=;
 b=NqaeiHgeU4JZ02T0kAXVuOqTpaTdCn63+h7RrvPE2BpbY+51l0Rkjt8S/Jwx13Fgoh
 9NZEZj0xBRDDd4+HADensFd2ytOxzum63Q4YUAt85PVjXzsvJNbYdlnLWEUZbFoTDru6
 GJdFgyTv3JEmoJnmsHPytRqsBabPoAvgpFp8FlPLxVVtSCaFuiGkqzHXjvsF4bIKtBBv
 QJTkxL6hxcLxyVhf6HB0auE8MzFePPxt85roUp4/QtC4hXklQOAhcjyNLVCGDNyBDWIT
 SCAuBjleV4vrbrpkZjiTeV4VxiSuQHfMapqK+Czc5NH/oMDTnWS7OqwuLe8bvmkhCqjd
 Bc1g==
X-Gm-Message-State: AOJu0Yw1Ld+zo7IiI6O2FcZrr2QwCWb2764bG+NaXMj7rOK3cZLdB/OG
 Ol+5z0Jiz2r2swmp6HwKz0iKmTqrZKpXyiKTkzkKeftL9ecyafGjenJGLSeOtsrp0wQ=
X-Gm-Gg: AR+sD11VMrJo5eBGBvQDljwLf5+TCl/Bby06nAzQQsYnCaMqiHs+WtHCOA+AwGV+DI1
 w06fB1VRQa0mnYH5Jyajokg8Riplbd6az7t5uJp8KpcufASfbE/MytYx3Jw2DxtxV90nJfVhm7D
 H+DVgh8QVW67NFoVtd4+MyjZDpDVXY3pGOsNztba2eSNS8CqYHX6kCtakbmoWzEzmfcFXPSIsRy
 /juo2SaakqPwi8QowKBNkUhL/L/u0e87qKQfTb4W5/IUzJWn1QsNo0fG68lHiU4YHY9O5E2tKwT
 dIlqB6qKaPmUV4W16Tbr8S9rV3aHRNJYR3R5dd/53OKlxmt+xlzP9TOviBGFeiGdIGeX/KVucwM
 vHmCEkgk1abwZkMzQGCEcVx/neK3fRMAw5kawKAQYqAerO+XZ2LCge8zNY3KuQJoQcp+IODHBIJ
 NQB/LhaWxBScn3KLXHld3OA7XNjjSfglCYjShE/cRdJm++ibLG13zk1LKUs7x7+KPu4K/NwWXdl
 qgSRt9yUTXP2xQAa6mEEFfi9gJPDfhZHqlIsmrS5AwR1EbaM5J5DOFwoagWa0xIXF84dfRnBxex
X-Received: by 2002:a05:620a:952f:b0:92e:f3ca:2ebc with SMTP id
 af79cd13be357-937395a4f3bmr217942785a.37.1787295215886; 
 Thu, 20 Aug 2026 23:53:35 -0700 (PDT)
Received: from
 runnervm76f27.y1jgdqamqv2urkxkrjbq5gqbvf.bx.internal.cloudapp.net
 ([20.106.182.96]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720582185sm535207085a.37.2026.08.20.23.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 23:53:35 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Fri, 21 Aug 2026 06:53:35 +0000
Message-ID: <20260821065335.8050-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821063248.2208776-1-cyyang772@andestech.com>
References: <20260821063248.2208776-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] readahead02: Fall back to the parent disk's BDI for
 partitions
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

Hi Victor,

On Fri, 21 Aug 2026, Victor Cheng-Yen Yang wrote:
> readahead02: Fall back to the parent disk's BDI for partitions

> +		snprintf(sys_bdi_ra_path, sizeof(sys_bdi_ra_path),
> +			"/sys/class/block/%s/../bdi/read_ahead_kb", backing_dev);
> +		if (access(sys_bdi_ra_path, F_OK))
> +			return;
> +	}
>
> 	SAFE_FILE_SCANF(sys_bdi_ra_path, "%d", &orig_bdi_limit);
>
> 	if (orig_bdi_limit)
> 		SAFE_FILE_PRINTF(sys_bdi_ra_path, "%d", orig_bdi_limit);

Could restoration track whether the value was read separately from its
numeric value? The kernel accepts zero for read_ahead_kb, so if the parent
BDI starts at zero, setup writes a positive value but cleanup skips the
restore. This leaves the parent and its sibling partitions modified after
the test.

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
