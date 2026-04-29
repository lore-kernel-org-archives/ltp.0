Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF3FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:21:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 041483E49C3
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:21:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF3A23E12DF
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:21:19 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A8B21A0064F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:21:19 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso12666006eec.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777465278; x=1778070078; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzHq7PGTGxPyPjJYJwVvZTJS6MLsaOMoeYbq7Vcz368=;
 b=b8R6A4OJSlGgUURq6bn8bSZxqZmaQXunZbIkisXFuo2TmSyndKp5xNSt/i4CKprHeI
 tpKXuVyqHg0vV8Je61RRsQOsWQzACBnRMtljunIzF1PjqcC2wYPkForxe2m/ZvsVUG3l
 jkBhet3Y1yE2ngReS6JxS0aCnsYiEytakRtZkvSGt9KJkzhJZ2ahBEbBJt0wmGBJzm0u
 VphhqJF4iHs7WefeiQnncdaojqNMo0qSHHcxg3pRJltnSYH+nXtVtVZk4P1iab6XT9xi
 scmufxPqqLI92FTKOnlaumex1j55PlCRyML+bnoq8he/NnchbIKAQtx6Zinl53pAEcb7
 3H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777465278; x=1778070078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VzHq7PGTGxPyPjJYJwVvZTJS6MLsaOMoeYbq7Vcz368=;
 b=hTmIK96/YuBefvj1AQD6wUKNTnK2kVJubJm18nm6qB3D0+Ovm+6ekfkqKHCLeJV5vI
 8NevgdFlfh7rW/YK7TAhNspu4HV1s9PqjeQi3KDZfJkWdGV+SBJb8tLcl0bRgdJWDZjy
 TnnfluGep1e2imNIJkBpL3fjrPCRlnkG6xhDSv84v0qLWa8098+4lLkl7Ffph49KF5uN
 LJSiICBqZC1XQoScPOLzDIuw7COiZ4/G46pzMEQDZBHaU7PwZq07hP8+n6R0c2H20wYG
 pqTvbg0YWkk54o+4Pb6t9If6xzB3kkGNh087aZqWYknmoBpCvzrtnAeANdsd2ttkiv4y
 nZRw==
X-Gm-Message-State: AOJu0YzMagAgE8Q2tfGaxvobIqUlpEEfyTNmVB6Ik9BdA31JYnq5satT
 43G23OWFuE//pu9rLncN3ZwkKyfXf+GIc5OvJsSKQ4nG9IgOmsiS8hApM+T6py2rmgZkLA==
X-Gm-Gg: AeBDieuCNSm99RhpFSTTXIJVsOcW0omX9YKHjGljHZVwyeisDJrwnTbRnomr1JUANqU
 LWCUA5iDgA7WRv+pWyMBWV2Npsgo5taOIAHlzPLaa6jpkYjDcSLW9dU0zVmmon5ev1ieSHrNm1q
 AqNbyWXYghPGB6QuN5PCyZiDzglsPVB7uS6eHIlEUrtJ4NJolnneeij+SyvjAEFwC1KJFOcVOCg
 jK6i35oN/2TenCajjorTQDFIGgEVjuAeck7zd6TfFHQdqVXmuE/HQKo25ksOSmEY4Hx3d3/P1Wo
 7hESfv/Clii0q6IQhUCpkJW+UboYwLW+fQDGaK2Aotasb4bezXCWGVoyrllaISaDGExlTTXb68P
 Ro+U/FUG6CeGgG5LhROOe9QAiXac7LFsl65TznImDBrZT5jkC5qiNW0BY/41KWCTMUZsJ4DzBtr
 jMT6xwd8nP7Vv3zgnGy7i1kwJ02GPYVz7VuxDaUkszi0xkWE3SyySXtNL9ZYftPMXS8v3jXu9NY
 v0MrunscB0g78YWGPG0cXVqid4ogaLbtk+6xydtzZPPJYn3Dw==
X-Received: by 2002:a05:7300:cb85:b0:2da:a813:a60c with SMTP id
 5a478bee46e88-2ed0a1163b7mr3945190eec.20.1777465277509; 
 Wed, 29 Apr 2026 05:21:17 -0700 (PDT)
Received: from
 runnervmeorf1.cwerdptpvzpeflxqczcybh3zdd.yx.internal.cloudapp.net
 ([52.161.74.198]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm1964464eec.7.2026.04.29.05.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 05:21:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Apr 2026 12:21:16 +0000
Message-ID: <20260429122116.3978-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429105644.986278-1-pvorel@suse.cz>
References: <20260429105644.986278-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Move runtest/irq into runtest/kernel_misc
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2026-04-29, Petr Vorel <pvorel@suse.cz> wrote:
> Move runtest/irq into runtest/kernel_misc

> -irqbalance01 irqbalance01
> ...
> +irqbalance01 irqbalance01

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
