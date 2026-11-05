Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D236606A326
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJDzP5Xk
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A109F3CDB24
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 01:39:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7363D3CD79F
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:39:13 +0100 (CET)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 074941400123
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:39:13 +0100 (CET)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso318202a34.0
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 16:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793839151; x=1794443951; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBZGjvhuv7kI2zhD6kHbCZOhSsXnxwdODO0hJ5YuNeE=;
 b=vJDzP5Xksj+bta29TWHlXQ9oZEZY+GQDcrTNZ2Riduxkrt8L5jNqeV+vRY875oXlwX
 XMlDqRlHPOfuR/NBn0EQy4zNODrmNtvmnDk6vvKtiYRGh5KZJSoc8lArkH0tUe+ii52B
 WsQeINU8TteuV5Q1AjKLn8+bcPb5tqAS4lVSZNwnryqUtWf3YfASGiaA4WaQ3B/mY55l
 V69HTQOVo5dnvYi6xA/LUr+o7WGDs6EWAHu1Xmy5i/kWy5HmtLP4phWfabNqcvRAg2nI
 s8nw9BCo4dMasbwZQ1SaWKLeInfBk0g0jdjWy7E0LfUo6ch0jJlTtcwvCoGtgojsVSZG
 dx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793839151; x=1794443951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBZGjvhuv7kI2zhD6kHbCZOhSsXnxwdODO0hJ5YuNeE=;
 b=2JSw+FRjb4hYZ4FKG0Fd4Y3qOwCkeShk0aVXWzsc5ZW7w68frBg21GXLDgNE11YxC9
 KQhIC5oXF6ZWumUNPdKXJI/CQgcLflHzJL00xKGeY0+CnyiMgEAXKt+tj175WIHF9LFf
 rlRDpV3ROTACbiToRqDr0SZKRBDTZHH9muiIRxzay1NsS0g6qbMpbf/1d9rGLF+SK4Fn
 DQn9pRCbODFrVt+zKQwVft7A0r5tKjXkYK9x7olWb5atv+ivLd5ZVvAQL4fs5BbHXb9r
 NcqnXVYwQMeN96OPsbPuF9bEmY9aYHnWkihjFhvoP19zlbQDAfbaPAp9z9vMzulttfdd
 Rt5g==
X-Gm-Message-State: APuU4Z+ggm7C+/ToSd9p8BoZSPyydnuF6wdlb600CdXRzIXqwN60jp26
 FDIcaHV1BdciQEIOA6TXFWtVe18BXZj7dp7dl6stgC4KvEyZGzrVJO3KwfekhajkZ+A=
X-Gm-Gg: AYBFou1II6ejjOoUUfmTHAmfiTy8h169iPkX/rKsZk49HwyrcpkY2RQRsRgBFgSF/r/
 9FaKtIcAmw/OaS2eCIO5qQio5rIbejx2mgocIvFOZ52z/dkjV9TuXUrRswm7GoBYVuS1lD8k2Ym
 EXknI9tcL9QE48R8Mcvy1P5b+dy+3Jxs9iaYwMj+RApoGWiCUAVts6yWIUwt9+uvtveeI9avasF
 BVVgsCKM4gSOISLh/gm+NoKrcptG9Uv+f6y2+OBB9/rzyuhzXFqiqBfebiZghzA+2ldTcoFTnuw
 om/f8h0sXdGiHfXziA96Mu+11cTzlnDrxhNYN7Pil2LZcPzB2FmN1/MBHoVklfnXujkJyyWXpOS
 fbMBOIZiEZ2FToWSd7AR6gSzs+nVT8Gl2Wfb14TnOpWhuJsbGyNf8CEqhyNEvGoRvHKKKsDH7nr
 VjtJY9Gr+WJKGSHyEWsKDZUxvElH+Z9kv8rAoVjwWFPlnZJU31jkuJTxG9qwr0TpJDAqDk0203Q
 QsrcG1m5i4VB5ewazVNaleq7Yh5GXGOl7blKEBtJ/v7pyOJKdYkbJaZLHiE1qdJtqyQRGIckIhY
 CxGnfJXwif8fj6Eov+dv55S+jQTw9r49yy7dVZQQgE6DudXddUbzflgq2S8Wu2whQuUstih9qCk
 nCN+KI1l1D+d92/rSqwc8+3rqgkYVXAHCXnWuoXGxorAt
X-Received: by 2002:a05:6870:3b15:b0:475:e0a7:9f2b with SMTP id
 586e51a60fabf-4a9076a5287mr10921099fac.25.1793839151204; 
 Wed, 04 Nov 2026 16:39:11 -0800 (PST)
Received: from
 runnervmwuk1x.y3en5ldd3b2ebobdorhaggvslg.jx.internal.cloudapp.net
 ([172.202.174.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea56853dsm3208577fac.8.2026.11.04.16.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 16:39:10 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Thu,  5 Nov 2026 00:39:08 +0000
Message-ID: <20261105003908.3796-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104225051.402911-2-anders.roxell@linaro.org>
References: <20261104225051.402911-2-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Install the .args files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Anders,

On Wed Nov 4 23:50:50 2026 +0100, Anders Roxell <anders.roxell@linaro.org> wrote:
> openposix: Install the .args files

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
