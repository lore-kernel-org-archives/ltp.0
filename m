Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C7AC43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 10:21:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 641243E29AF
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:21:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E9433E5CC7
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:21:32 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8092600914
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:21:31 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8fda6ac0586so2876636d6.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783506090; x=1784110890; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZZyQAsl9275pOXsLp2snsynADUmgu5GkgzJuobJ7jU=;
 b=Je63v/D8t++szPzu7dCDEwbTDSOHudQWdNCQli6osiCoh+3/FZVzRQ49pdygZ+3aFK
 T0POLFKQ0itXWDfWrWpQoDNJjr1/NQ3j3ckWrfiszU+VJpgqp94iRMratcXXRB4QlndM
 bDTYWG9l0bKymxzRbDrur6BpdBXjwI/Fm6QSvN/P9hVYhbXd03oRmN11Jd8a+jmZgPrC
 F0DkybiqHQK4+eMSkE2iNfwKwkuWktw+JlB7tA3zBDk7+DZSjc3SYKrSBN/P+JlQy6PY
 GD6i6GkPK6W1xXNDan0boFu3wQjhXFP8SceniCZMoDkNuSSj47ES7sMyIqGCWGrl9TAN
 sWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506090; x=1784110890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZZyQAsl9275pOXsLp2snsynADUmgu5GkgzJuobJ7jU=;
 b=q4gPMZZWzWk4erDm1Nsh5cZbMj8/P/BoGmBiMuMF6y24l2IRea9V78MDboF3aZhVt+
 iZGuEGw/0WAAYrnDGMAbQ4hqbMwgytzqqJKCc+m2Auqs2u/WF+jazDJyCkAxGxFMTUrz
 ns7KB6rCv/NipVGBilBvi8MvanXIxhSJdRMJmn0IzTpk2T+64AnaIftr3N6Qb7Y8egt+
 zNf10BwO5YK4/BcgLu5eJ7DEUeht7ZlTIgs5B3KMTWzqjTIqPKwMvq+7u2xtKShjNlTN
 dC1rAMU91xTTqUbJFEV92nAqTDMsU637yxp19rA3Pq8vUlfW3BFJ25OB9QoJ5dFh9Xfo
 8o8A==
X-Gm-Message-State: AOJu0YzKBGBMTac06Kp/dGquFbJHGqhv7FdVskr1cKLxMqziG3eTv0bu
 XyR1f2tZTxF05QlP+XdfnioY2wdoGd5jHMGz9ZZ72DfNPgmxJn4EGKuJ
X-Gm-Gg: AfdE7cmtmwIduP7SE7eieDGAy7Sl+47jLNKhZ874cv9DPcXh1qdtMUzsGQvKDTf9jLX
 vCBzqFWy/0PuQoAtzK0HctKbYvsQimJMv+hHHjqjJBvpJY4z3cyP4XBqOS0FB24Rw6H2dse2rT6
 Zcr0u7s5nE2ELF6LHLli/IcPnsRxn7bWi5i5u3X0BbeO37nZaAzmq7R3pUBiJIjX0lVu78PQOcW
 N9OJL2QTe4haTvFfxSPgcOtU7DyAbQVpxCIn8UjhoMjyCtB32st5ne3JK269m1/aAQGbi5Q8D67
 M+6cWqpJZUlWxZaj2rwmCG+OgaxeTZXCd+MkYnmmSx0QoS95i+MBhmciLx/S/BJFmrhC6Hfgd0S
 IifDum627TJ21OayoSRTFN/Rmb4+mXOdLNK0ImWO9/RiS+lGs9+g10pmKTV3Csr/qiebDLQQ1+a
 SmbDrV5igsPoUJlQAh+JYZq9gSj4n9hz9pCBHCrH3syVWg2QtmkkWC+5X9cU2wx/ueu2u3n+cYB
 IgOqumHqXAFPRr0ojtRye4tIfBXk0+hkCE/qxxe
X-Received: by 2002:a05:6214:1c0e:b0:8e5:d7d1:7bf with SMTP id
 6a1803df08f44-8fec03f20camr14720046d6.4.1783506090418; 
 Wed, 08 Jul 2026 03:21:30 -0700 (PDT)
Received: from
 runnervmkkn4f.jes55jykdhaenadivdr5v5tmaf.ex.internal.cloudapp.net
 ([64.236.176.228]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4724bab9esm178433766d6.42.2026.07.08.03.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:21:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Tomas Dzik <tdzik@redhat.com>
Date: Wed,  8 Jul 2026 10:21:29 +0000
Message-ID: <20260708102129.4052-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708093715.45301-1-tdzik@redhat.com>
References: <20260708093715.45301-1-tdzik@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP/Lite test float_trigo core dumps due to free():
 invalid pointer
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

Hi Tomas,

On Wed, 08 Jul 2026 11:37:15 +0200, Tomas Dzik wrote:
> LTP/Lite test float_trigo core dumps due to free(): invalid pointer

> This fix:
> - initializes pointers where we actually core dumped (*din, *dex).
> - adds checks for all malloc() return values int testcases/misc/math/float/
>   directory
> - replaces sprintf() with more secure snprintf() variants

Typo: "int" should be "in".

The commit message lists three distinct changes: initializing the din/dex
pointers in thread_code.c (the crash fix), adding malloc() NULL checks
in the gen*.c files, and replacing sprintf() with snprintf() across 7
files.

These are independently reviewable and deployable changes. The crash fix
is self-contained in thread_code.c. The malloc checks and the
sprintf->snprintf replacements can be bisected and reverted separately.
Please split into separate patches.

Splitting would also let each patch carry a precise subject. The current
subject names float_trigo, but the changes span bessel/, exp_log/,
iperb/, power/, trigo/, thread_code.c, and main.c.

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
