Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57485C624D6
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 15:58:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A55F3E907B
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 17:58:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7E4D3E525C
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 17:58:08 +0200 (CEST)
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F6CF600564
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 17:58:08 +0200 (CEST)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-7f0355eb4b3so744370a34.0
 for <ltp@lists.linux.it>; Sat, 05 Sep 2026 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788623886; x=1789228686; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOBxSUur9HpW0iXofJ2qPecAi940U0kw7KyuJgOGFZg=;
 b=Ez3o91+9xpt4N0M42xyBC61H2LWP1nYLrNYzzOMBJt/dAR2C9DG44Q1cqZBbcSLotO
 +suxmvjS5P5lciaJYk/28sMIMI0XuGgyQbBI1W5/wriZHkPo1z7oT582kIsEc85iLxUJ
 V5txBVC0gbNOviqsx3RDylpkUk6/H6a+8SY9lWN91BDFnqdpSDf51XLpuTodSfzQwbx6
 dAIILVJr/ybnyDI6jr0qGOnWSpc/b0RwhAHCzdPf/QDlney1gIy/F+ojVgixB7d/jasS
 xF/wLrubbco0ujH6gBn0IGXWuTFTKEHw1G6gCV8Atwpt1XbdxX5e5M6zL3FJR3cMuL+V
 4FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788623886; x=1789228686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GOBxSUur9HpW0iXofJ2qPecAi940U0kw7KyuJgOGFZg=;
 b=LMOqtzaOzJsI4BHArZJswDE4q90G268sj7yH03ulK3GY3eGuKxUglRVSfYg0yzttsa
 19cb25w8OVk6W24nRZwWxLDJZUz8eqZI2nmi9ocImB+caEY2YWs84jXcaF9asMLtUDSS
 +3w/5tUJ989RS2xrb7tgM7INd4pVmg0dGuC2oeuoiEjynp1yzO7pgPbTVPjLZ/+1jv93
 YoLXcAS+Qpte/lN38IAeZdPAAj/KKWamt3ngKXbrmVmX3ZLP+Upc0MRHMyc7MBJrfzxb
 v3tJusMrcLmHfGw7ZAjJFLaa+ptqyjv26cN3GEM5hyO3rXt8hp6Dj87eUNqb1pEqxoC1
 tgWw==
X-Gm-Message-State: AFuF++lIhAaflo5oGtivBSLkM0UE7fU7GWwOouAFwrdDT3tezsrS0/ms
 rcUgoFxT1h8H/3wd/qh+B0k3Xc2q6eaLeuBlz+7FnsBdxbprSl4aks4Y
X-Gm-Gg: AYBFou2y4rhuxQWkGfMe++0dO2inQuuziGIN0/2qOvJcybU70dBCuWe5zi2ejxsfLUA
 FQsyhaz/HCrykO+oRQ/rUe74ix/xZFv+OTMhERJ4rf8Y8R74+HaHfPVHvB7X7rKujM7kQ2nrt1q
 1ezCoAc7tjHVhv6nO/0rKheGhxK5oo+RRT+j/jrqRFt51kIK7cfhPmWIcKImTChKBrDhden+jpS
 TOzsrivWbzA7s9JWmwUi1hdQcYme1KD8KiA4LEySiquNfSG2+nEaU1q7f9e2UTGXtOr2ZA+26AP
 mMCaAEMeLeMkN+7qFSvvh1dLMitaXt9Naz/kU8QZfwQ1eVAwOrEU38EDh7kBwwdliKOs8t0/7FA
 tKw4UwrOIYyBjILpSIaqXxH1pEiXbOy712wQi1e5wr9Uo6H8ZSkBT1mrlmd4ThPQN8V8c8X6FlN
 SC9nEnmT+8Y6NG6V52Y/9EikjDWGDEBjR7r+mSN2A04cu+74bL1b5vKCKIOels7V3gjsFqPj+Pi
 AhzuWq4bjvPYPJm2IJ0A5cLFDLGChAC3Qd4ESaMJ+IPPoj73l3XIIgyePyLfIcEmyx3eTPvHK25
 rg==
X-Received: by 2002:a05:6820:16a6:b0:6b7:8415:d779 with SMTP id
 006d021491bc7-6b78415d96fmr5778493eaf.36.1788623886545; 
 Sat, 05 Sep 2026 08:58:06 -0700 (PDT)
Received: from
 runnervmejwal.yahdu5czu0kufn0zd2mtniig1d.ex.internal.cloudapp.net
 ([130.131.55.224]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dc6aca49sm5878791eaf.6.2026.09.05.08.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:58:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat,  5 Sep 2026 15:58:04 +0000
Message-ID: <20260905155804.8977-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905124522.961300-1-pavrampu@linux.ibm.com>
References: <20260905124522.961300-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

Hi Pavithra,

On September 5, 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> +/hugetlb/hugemmap/hugemmap33

New test binaries must be ignored by a .gitignore in their own directory.
Move this entry to testcases/kernel/mem/hugetlb/hugemmap/.gitignore as
/hugemmap33.

> +	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
> +	if (TST_RET_PTR == MAP_FAILED) {
> +		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");

Use TST_EXP_PASS_PTR_VOID() for expected successes and
TST_EXP_FAIL_PTR_VOID(..., ENOMEM) for expected failures instead of manually
combining TESTPTR(), errno checks, and tst_res(). Keep only the cleanup logic
that depends on TST_PASS or TST_RET_PTR.

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
