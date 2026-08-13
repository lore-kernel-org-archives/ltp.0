Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F223DC5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 10:12:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 109583E6C08
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 12:12:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D4E33CB270
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:11:44 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D49A140074A
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:11:44 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 d9443c01a7336-2d313798bf8so4189435ad.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786615902; x=1787220702; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y6Oqe5hsqZ/9Ee0hlQt1om43AfGgeb1gqpLXm4IxzNI=;
 b=OoNdsn7ZgCAA0pfAljThfguAcoidt6y6IJbCj5E++JobztnU9/wluhxClMe/W9EIMS
 MH+9/R2ZMi6ClYuaFWV+B917QEOXnToDg9/imA94s9xsdf98t3JGk1CltvIV34XCuN1O
 lnIjgMfQBXNnOh4kBReMaG6v72eVJxuRXaqCKG1eWpVqIkE1P7ZVZy2BWPaEgqNeH9A3
 3QJmhhYOQJ1vK8vDvTBEgvWE5DB6dY4X7L32QfRnDFiEig4NQoX6DuBQTQbyVQhRYk+E
 bZfPQg4lQ5BvNbUFl5L9Gu7E+33ktc2SoK2MPEYHRbAbxBgHNuXC3dsIq63y5CLLwMBe
 b63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786615902; x=1787220702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y6Oqe5hsqZ/9Ee0hlQt1om43AfGgeb1gqpLXm4IxzNI=;
 b=cS99mKfFMSvNZ4GPIP4ongvR39EkSnp0Uj7YPnPlygSY88cVN8uz5oxir5w1+D0llx
 CX5m8LZmKiKfVxNFK0yrZTM7phx1Anky1n0DSOMQYv4ydvR6aS89WJBi8Xl7VYd7wAvX
 mrIP7Oq1k5wdSXJWMF+LsWz5gdYjjgy1y6ZRzjTlp32HSO0rONf2Hs7ftiRxTiOVRGQc
 XwQ8vXtUAFGMQpCyCi0Et2FJq1fgaLeKtH9nQcG2BrAIniAOS7/XuwlHWpjNZmtrbDVH
 ZpCPm431m6ljJNY+8p1oW+7K2wosiwqhVUkNKAJDTBYuViF+bWSQp/1lDLSeGCufJY3n
 D+hw==
X-Gm-Message-State: AOJu0Ywz72PgT2i7KqfKt6UuYmlwrfaibgKfOhy8xxeWZXbEmtT8+EDG
 INei0STZoAxVHFcpK6R0Lk9awfc7NKenwz+QiiX94dRVHIUAtDFdaGdH
X-Gm-Gg: AR+sD11+bLDyoZXGqHBBBiKe82cbWrfc9xsDNGpYUG2BIzhkl+obrSk+loiEKUmfnEx
 2RtSoCtdyxanOhHXwZHFR2/Dj4IdvrT7LonuedGOjnUEMLr0Ej4DGF7rHN1jiVjKNuQ2IAKpBwG
 tnZOhVEhpPKX/e9fNKSF12H2dVo9fq4FbMdFcesexfpXbAvNmukkaCGQtENoJg1ANa8XbGRmVNG
 KszFA50y4jfPaJqL6Iw/FvjhXK2ImF0NEPMg4PeNwtM5r0kHgxFs9E3u4TPpkrak5SxNDlX3ow4
 FcDbhlqSk/Ldw3aB5X8eFdjdzvhxAHoq+hgaNDhWiwuH2qL9cktDKLzksI80ch4767IOnq2N0Vs
 eI1QezqgnfqiAvj3mlDPBP8Cl32YO9C3MIwWFJHaA7HykAPmUB2kP3rTQ9MQs7DuS9x1oE0TZCf
 9z/BcWCJNnfunSp6IDqB821UVW69rM+m4IBozMK8Ko7XonwofVGnTKIEyWoT+2dUxYZV34evkHK
 npq5MQXZz+MmukSITJElIFS9riz41NNZlph34zSnHYLTrbzqtms68+OyebIFp/KBjOODBUA0QAr
 JxE=
X-Received: by 2002:a05:6a20:94c9:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cc54f970fbmr5539852637.3.1786615902360; 
 Thu, 13 Aug 2026 03:11:42 -0700 (PDT)
Received: from
 runnervmzvulz.hoabpu31hpaupmk2ycwfr0t0ee.phxx.internal.cloudapp.net
 ([172.182.244.83]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec0223e52sm6647915eec.24.2026.08.13.03.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:11:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 13 Aug 2026 10:11:40 +0000
Message-ID: <20260813101140.9156-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813094549.196724-2-piotr.kubaj@intel.com>
References: <20260813094549.196724-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pmc_core: add test for pkgc_blocker_residency_show
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

Hi Piotr,

On Thu, 13 Aug 2026, Piotr Kubaj wrote:
> pmc_core: add test for pkgc_blocker_residency_show

> +static void setup(void)
> +{
> +	if (access(DEBUGFS, F_OK))
> +		tst_brk(TCONF | TERRNO, "debugfs not mounted at " DEBUGFS);
> +
> +	if (access(PATH, R_OK))
> +		tst_brk(TCONF | TERRNO, "%s not available", PATH);
> +}

Could the test mount debugfs when it is not already mounted, and unmount only
a test-created mount in cleanup?

On a supported Nova Lake system with debugfs unmounted,
/sys/kernel/debug still exists as the mount-point directory. The first
check therefore succeeds, and the missing counter path makes the test report
TCONF without testing the supported interface.

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
