Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8CDC5DF71
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 08:39:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E7543E30BE
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:39:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A3233E13D7
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 10:39:31 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 316B214044D6
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 10:39:31 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-4864a5c83f1so125293b6e.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780389570; x=1780994370; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vY8Y8RqoMtqYtuErEDolP/o+G6aZo6gLr20aaqvP1/k=;
 b=hnACepqEJvuyfBqwxviiTtPszZhRTBKdKKRpVNRI7QHHfCl/W0nxig9VqWFVD+pnbA
 0bYoMEzI4yQNv/cTgea7ofIt+KW66Iv7Azy7hfDrxAuFvvpJmKAOjYa6rWwzft+F1zBr
 sE+tjSlzSPMT1XTAh0Hn9vEoxhDy1FTKMXyRHEGe7cSpU7FXmlEo/OlTing+4x61zAFH
 /4o5j4IksRLkplZGTyI3su9DhLEjaY4uF1oYTHzBkjJmZw7aoGV+zAoxzeiZZz23BarV
 a7qTi4KAEv6T5FcDVq6hP1i/TgFwx/3Hk0UflJL9bfRDCgOhDThC3bMLuTiEjIr2givq
 Ut/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780389570; x=1780994370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vY8Y8RqoMtqYtuErEDolP/o+G6aZo6gLr20aaqvP1/k=;
 b=bldtrnms+1+ZJ4YF6Pf+94Xa86WE3IJ3klNmyH5pa37+vMrXA5X76+97Md1u+xfIMS
 Ss9nLRBuEWoCo+See5e8dFvO/QW1BR4bPuNb/hiU0JuoDBJqrPM8bWyDtOWKdH37mabm
 wLUDtEyfo3j4pMFvzHb6OdZj6LDrpsfDon1LGPbJoF2q4Tju56Vi3MAb6IgUEUWbze2q
 wWj4pE0z6K/+TNCm2fUsI9qqyXgXCYeEWNq5eQUTFP8WSe5XJEnk6by31xvcS/Qbqh9h
 h7FJKs4kO4+zywhYqXFf/Pt734PUx9RRY+fLz8ZRT+sRnEt4LrCJ6Ajr/txzv7IJ3lwz
 V8EA==
X-Gm-Message-State: AOJu0YyNPIpBS4Fb8jfnHEgEntzo2GaHgdCOiKrwaTGznYrt358yca42
 RDtRcUasMA4bu4GfI7/c7UJx/FXSzExn+Sy6LqUiE9ZFmA1MpYyxeehucDavNKot
X-Gm-Gg: Acq92OG9MkA/mqqDC8mcoss7ERIi7DpHloX6BahxJdybXrpWvZBCDGJGN8zxLCGgYGU
 lRHpGlrCTmfqr/yWy1P5sXhRXVOAROI7KH9WQrgGbZtgB0IVV+xSXajzN/m1lYpI5dTGDnKvRV0
 7dlXB43GUlMSMnY2GgR+4DT9jamw16FcqV+Ww1mCDZ7Mc34QAkUC82BNxvoWVxbv27CG7/TD239
 PX/v3s6eUBM7WCUvYgd7CFF6JzBVzD7pxluFAQvOiVJHe5fOJwg18JqkVEziQdnwoq53sBfRAd0
 uciiYj4q9pjqPaOS/BrKFav0hufRasNfLEGvUH5QURd0OrOaJ/trcjDBCTWJ0LFrnXEg4+Mbeky
 ogSeOBHO8kEInxJJo8G/hPN9q0jjbe2mpWqxdm7hqQRa3b/xj1DcAlk63wgiIrjD1Cx3aqDBFvx
 ZHPIdMKDa0Zaj+dSy4ICZZT64nMz797wbEy23xgCMC5Ge6IqoRWm5WYJI6B2CHsQM773/G9GGsz
 E3xTDcqnak3RN4rb6FzUk23sps6u3B6BouDTLt/2S4MvxcdrjY=
X-Received: by 2002:a05:6808:2390:b0:47b:d505:d84 with SMTP id
 5614622812f47-485fbaff1d1mr7804069b6e.33.1780389569505; 
 Tue, 02 Jun 2026 01:39:29 -0700 (PDT)
Received: from
 runnervm3jyl0.ehmsejaduutuzhcentlxtedtqh.gx.internal.cloudapp.net
 ([132.196.80.135]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48605fb0158sm6269804b6e.7.2026.06.02.01.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 01:39:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: panzhe <panzhe@kylinos.cn>
Date: Tue,  2 Jun 2026 08:39:27 +0000
Message-ID: <20260602083927.4136-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602041738.146267-1-panzhe@kylinos.cn>
References: <20260602041738.146267-1-panzhe@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] gethostname02: Accept EOVERFLOW on alpha
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

Hi panzhe,

On Tue, 02 Jun 2026 12:17:38 +0800, panzhe <panzhe@kylinos.cn> wrote:
> gethostname02: Accept EOVERFLOW on alpha

> +	const int exp_errnos[] = {ENAMETOOLONG, EOVERFLOW};
>
>  	SAFE_GETHOSTNAME(hostname, sizeof(hostname));
>  	real_length = strlen(hostname);
>
> -	TST_EXP_FAIL(gethostname(hostname, real_length - 1), ENAMETOOLONG,
> +	TST_EXP_FAIL2_ARR(gethostname(hostname, real_length - 1),
> +		exp_errnos, ARRAY_SIZE(exp_errnos),
>  		"len is smaller than the actual size");

`gethostname()` returns 0 on success and -1 on error, so this should use
`TST_EXP_FAIL_ARR` rather than `TST_EXP_FAIL2_ARR`. The `TST_EXP_FAIL2`
family is for syscalls that return a positive value on success (e.g.
`open`, `fork`). The original `TST_EXP_FAIL` call already used the
correct family; the array variant should follow suit:

    TST_EXP_FAIL_ARR(gethostname(hostname, real_length - 1),
        exp_errnos, ARRAY_SIZE(exp_errnos),
        "len is smaller than the actual size");

Needs revision.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
