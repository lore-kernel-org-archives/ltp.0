Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703F4C43327
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 17:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C04353E4C25
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 19:55:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD63B3E2100
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 19:55:32 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34BF01400345
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 19:55:32 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-51c16ac21acso6607971cf.0
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782842131; x=1783446931; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fsHTqKKjHYeihrUNZcFTwA/URwU9KlIAvke+cmU1Bw=;
 b=oHXwsDsYKj3RtMUSJ/rLGNNzILgKe3FJ3mKU/rGi1YBKSsedePh9nXsvJ7G5x0yKLA
 5y16OlHz7WjF5T7CXrvvUGlEIS4ITk5n2xwhGP+ov4iUQSGesZBpB+/NpH2tDXfBxA5i
 4ZQqwXQIm72KbJ154CQKupgzzELdEv8eQ7ImX0FytwqHFgJ3v9TSh4MpK4ICPSaOn4LA
 X9sfQmMO47fIfuAR2ODV4mV2N5gGIRMWTIh9lfabYr/Fmsvu8WM1NTjoWQp9P52yN+lC
 E3Gnl/tPW1qLC5vfrM8gQ5PuicGqaT14hcNO5gZLxsaBMU9gFMoYaruRFreuFBHrS/cj
 3u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782842131; x=1783446931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0fsHTqKKjHYeihrUNZcFTwA/URwU9KlIAvke+cmU1Bw=;
 b=mNZVDBBN9QSRZQBbLQ69NbaVY5AcTfik+9uo7jsMzIZN4qn5ysHROXtzfnwyHnv4RG
 wJ8Ky7Sg8C9BHO/irSa+Ultz5NU2gezUr2BLKeaJYTJ5M1+QU+s6lp4FAr9p5iJfIehi
 U7wwRmGnjO2TXurCawVfviv8YMmMk/S1kTsJuJlhQAWeRnyiXhMf9qxyqR0LcnKUF/eJ
 Uh1tV/lVgapzzZLAQvkEdU9SIpUtMbc0C+hkNGBSwV6TkEIIy5jV07qYkOKa17m7GybS
 jJm4UxgAxp1q2xTy8BLVzAoLxCm9g83sjTCZdEW8W2p1e0YhzSJrFS9xTk+YTD0YvpTI
 DE0w==
X-Gm-Message-State: AOJu0YwSOaMsKcdo6rVySJ1Qf/z2dJ08eSFgHr/P12OC5nPvGqIZNG1m
 OWBJciPWNOLs8SlpZXHWtphD2pptHO2lkYrPNztSo8dBMv3C7SRT1Jtl
X-Gm-Gg: AfdE7ckVZBGFwLsyfsZHXqHSfVIDbSOKF/d5gphNI/DME7O2I/2btXR3Tp6pWQfCAwZ
 E6GoLy0u9ACjlTySDGcaiDmAwCexqHvGUHX7Xy0xp19yi+YyTiRvq40DPfYFVJ9CILkHQx82aAu
 S7V5nF+sm7K3qfD22qLitC9hcR5w8MaHjAFhXU+pSJeBky50xhz/pQtFCStdu1VQClhfxcuXY/M
 iRUagEhyH9l+38vXxV53wF3aRS2WL9OR/rCB5lqgMk1hk4wE4HsbPf46yjxxNf0xy594EGt1bLj
 lz/tzArbTlrP8pZtlo4Wa0B+PV8u11UqaltqgZDdkOHsJrXaCwPNJ9GbigdMlfyeH4Mb55wMIQq
 dQHLehdSjNIuKKvCSC81WKznAW5FMK0qJwciTRNuPWrjgDS2V1MRVAP87NsrB+ltReIJ/+LMv+f
 kJyF0LRqG/nbwSv2F1fPZtoBJOxPm7Pbm6qLWPa6Alj4JWYhl1TNv5vDcuUPThD0aArwUDQKIy6
 7wtV6Ra/wTv6U/rn5gVhQyt7UiDqsZ0x3Gy54w=
X-Received: by 2002:a05:622a:6097:b0:517:905d:dc72 with SMTP id
 d75a77b69052e-51c10758c5fmr60115671cf.18.1782842130761; 
 Tue, 30 Jun 2026 10:55:30 -0700 (PDT)
Received: from
 runnervmmklqx.x5d1n0cxpzaenaqbjvsq3ltcmf.bx.internal.cloudapp.net
 ([4.227.174.180]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c1080d4aesm23577861cf.6.2026.06.30.10.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 10:55:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Jun 2026 17:55:29 +0000
Message-ID: <20260630175529.3946-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630170611.479639-1-pvorel@suse.cz>
References: <20260630170611.479639-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] irqbalance01: TCONF on missing interrupts
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

Hi Petr,

On Tue, 30 Jun 2026 19:06:11 +0200, Petr Vorel wrote:
> irqbalance01: TCONF on missing interrupts

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
