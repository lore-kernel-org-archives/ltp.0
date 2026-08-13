Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72269C5DF64
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 15:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 146023C6603
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 17:01:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7398F3C5E2C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 17:00:56 +0200 (CEST)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 118BE10008F8
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 17:00:56 +0200 (CEST)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-7f3aa35af14so2759a34.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786633254; x=1787238054; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RCYd226DqvO74oOeRL+fM1gocbARZpFmreahfCgs9IQ=;
 b=Its2dga9QT77HsRII9DInur9005jwxu1YskaNt+H8IRA2F2KSVM5XrejciE7AOIw4n
 zIUdpxGVnQc4dZl0rprwFtk0jtlyjis7SE2BeZ8Den3hAQTu6PT7Cg2W5XfFe00zb6dZ
 a+48XwPx4etGoov6eLerQzJc+/LWOaxfv8/BObZF5Uca0aMY5N2qGEYhtaSkNGrH3vm8
 Lgyfun1PbLD+wmrtitfvO4w8Ea0+kqCQciHtK/EtF0go758v/64AlWVWpcAVu1karlhi
 MXskTEVlgWO5uC5bHzEvuMX9k8UPOid3Zv2393V/gGrY+SXz+ufu1wRqVpUISUGY5roh
 I2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633254; x=1787238054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RCYd226DqvO74oOeRL+fM1gocbARZpFmreahfCgs9IQ=;
 b=omzuGy8icLa9Rrurd9YoaHG83kkVBAsBqUHSshgpedeqZrbzuPou32OLgjeeugxiPT
 oJ1jOtUgg9X4F9nr8wLIVHdfqzbKRA1zwofKBPKGDrbFMbH4J2Ca93SjwPTzgl6Do7jG
 5RpEXpt3rplHT4wHt5eF4hf/n4lGLGfSEG+Fp9eKiDXfZ9pS0d1v6XqZknMlM/HYEz/n
 FAtI/GB3iVpEbQWU4zlwOMHcICPG2MkpFFKU94dakWmY6AMyMJbyIvLp5hujvVJsKIfK
 naJR0AkoZOliZC5hHsnT7AZI57Ry0aicsrbUs1lKnPNB4RM2EXIlKOVtdETIHTGb1GSq
 8Xzg==
X-Gm-Message-State: AOJu0YxqCMFjC0uCp1hPL+Yh1j8S69pPeB2ERDkECODQ/zp5lyZGryva
 7u3FxjJC+8QxolBdkvcPv0oOh+5jGXW0Z59/IjUiwPERXf4CEN4NRCZs
X-Gm-Gg: AR+sD12+sf0/puTyMfxa29LCrtMJLPPsoJ6lbIXt7FkyfS+hiaZ+SIqB+HBgLfowlpS
 hRut6xO+S04Cp9oZTm5jhyqqOXGbq1mb0bTOjckyXkzPCAe5DsAKi0Yrj4IY1OuW4RZI+k4oxTC
 jwrfgbeBxA6pVngX8UT1X/atS19VA34VRLvs/HMzyqxHeR46U+28FdWIydwISYfcZbRwPPKrkqX
 BIWtRP9y6Idlr+pmdMQNXPKSLvpEFXQHNQfKtleRpZ+OaCd/qsXVpgSLTJkFy2yqk/LHzOTi3kq
 Kuzg5CYexNTbdRxJ3t4Mf6k/RWjAaC65xglDNQYo77EpeYn/6Nae/5dBD5fI+vAS4EOFF26ljvW
 Qlc73G19zZ+DOXJJAc9v239B2hlVWM0p7UpaqVuHUFa6NKHnvUmNLppwCZOeLkHMcWZ5sbs1Dam
 sJ4VqpTmXwB3SwAPlJ9M7Sk5XB0UCPd01XCpG8pH32NhaJtFsEAr5yIFhiU38x9vgl8NeUGJDT/
 MxvKowfTUG74zZgVemXw84TFmsQDgj6+0UdhS2NzRzxCVZhBCAZ0YFr5GSOZx645mx9IEjsuVoW
X-Received: by 2002:a05:6820:1c99:b0:6ae:9d2a:c29b with SMTP id
 006d021491bc7-6b0c422b8afmr5161992eaf.13.1786633254151; 
 Thu, 13 Aug 2026 08:00:54 -0700 (PDT)
Received: from
 runnervmvrwv9.zdxfk0epy0qenhu4rggsnrmaug.gx.internal.cloudapp.net
 ([52.242.217.82]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3c9ca7b0bsm2263714a34.15.2026.08.13.08.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:00:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Frank Ranner <frank.ranner@intel.com>
Date: Thu, 13 Aug 2026 15:00:51 +0000
Message-ID: <20260813150051.8847-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813140609.57520-1-frank.ranner@intel.com>
References: <20260813140609.57520-1-frank.ranner@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/kernel/crypto/crypto_user02.c: fix hmac
 candidate probing
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

Hi Frank,

On Aug 13, 2026, Frank Ranner wrote:
> testcases/kernel/crypto/crypto_user02.c: fix hmac candidate probing

> Fixes: a4be708b4 ("testcases/kernel/crypto/crypto_user02.c: try non-generic hmac names first")

Medium: Could this use c05a44cf1 instead? The referenced a4be708b4 does not
resolve to a commit in the local LTP history, while c05a44cf1 has the quoted
subject.

> +		/* find out which driver actually satisfies this name */
> +		memset(&report, 0, sizeof(report));
> +		strcpy(report.cru_name, ALGORITHM_CANDIDATES[i]);
> +		if (tst_crypto_get_alg(ctx, &report) != 0)

Low: Could this comment be removed? It only restates the
tst_crypto_get_alg() call, while LTP comments should explain why rather than
narrate the code.

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
