Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED617606A321
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cp54wFIf
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D4C63E1541
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 04:11:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D95893EAE63
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:11:31 +0100 (CET)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D268060087F
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:11:30 +0100 (CET)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-55bf20a703eso32618071cf.0
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 19:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795662689; x=1796267489; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YMgrBpzf6d2E4StvGiIF1FLmXQ0uuib8RrGdahW8k9k=;
 b=Cp54wFIfQUcu91MOh5pyik/qSb7nxWFG1mIn5OCuxv+rjwDXK7wghoZ7oDgu/qJY8I
 JXyRHEktKkkc4D1trwcCA9GU7fJn98n9VadE3OICwdT6ShzS206tjSAQL25SHG8ZP505
 gQBSuHPhQqMGH62fYCOGeI/YZo7G1f2IfhWq+12Gkk+XULE0AEfYjqySwS8Da67TY13o
 3LS4ktbl7L1duCD/W0hNFB2ZNnb3v8PrO+rImQd3PeBgf8AWMv9No4g+rTV9Kadrg4Q1
 C0HMUieBb5KS2QwrPcqQZlZMYCr4kZtCVOS3utXcOJawOAqOGYpcRWQtzUemchj7yOL/
 NLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662689; x=1796267489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YMgrBpzf6d2E4StvGiIF1FLmXQ0uuib8RrGdahW8k9k=;
 b=Lpv7ZM8jZrSV8JCRQXgD5AqC7FqM2sZFDutWuNHRY0OUj7mDqsYtAElYDml87MSDn3
 ppO4SQUFh6lfyyfyhZrktL40/Wp11oxeZOEVES08ygywq4+doMspcZ+X8s0n3i+q2kob
 lMK5X3+Cg7M0KQ4WEaU4mnWXQ60+6QHX0jeMVj9zpLnN96ZjqdUcGP+NzP7kGBo4fjcS
 b0hN79Irtr/g5Pc61f2x9ikAcNdW258lj9Urv3GNJpEbH45jZG9To9zkFzJMWe7q6bd+
 uLBy0Q6gLZHJt0oRgSVKylADFbNiFKniMUIPvtyS5OCHFhZcV435Yo4a7C5MX3QeITUs
 QdNg==
X-Gm-Message-State: APuU4Z/04BodT/TGa6dfDNoRfi68HbraVWEEH00RervKRCK2JhBzeGRW
 yVtrAB2mg0pY/kHj1Iwk4x2LMbcjBN/+2pov8CGQJ8sjXcQvqxSzaSB/
X-Gm-Gg: AZFdTZeKLeygWa0uDfQfLjiT9FyHdL+QNEA1+Zf2L4q+KzEqCpZy1GGNO8u5jba95LJ
 8JLUM3ZkQsGTutqxXUsOef3ERor6Ac+e4fUVvTrzb79mi+IBqYeotHzd23y42Ksc/sCQpCe9W8y
 QMN9bxkmGMLfyS8HjE8ekBKhzqx3OeOYQqu6YL9b1SreTDrgjGGo5q/muRu4KymU91PnINwxaR5
 FoMsInm2OiK3zZzyrme/dIQCDyxktJwhZc25Vf2WZcG2eQw/GoelcIi1xslK8lNpNJ2qVq1qK28
 MRzycIl0jQ15C4/IXEKBjonMHeSflLWShV1hX4XVmsEKeG94jJq5lJLSbgKLrta2J9uBseOUPSM
 dYlvmxq0RwZ7AZfN7RLwEQi43PzBnFi/dhWQJqxEjZbD9vB9FaJ96xke2XJsBLpK9HC15hQfkVn
 QNdLlBORmsmAHfC8xEyho8OVCjIpnJkwV+m+9D0tvQzhYYwhq/vC3IPiFCZ/3y1KG6qmku1v3Vk
 64LqwELm8rHtS1e17F66S0k3BNNlHwXTB+20lIQgIvJTmvkD/b0/OGD3Wpd0VNNVoHY1hBJPzXa
 gRZapEYfaW0M8iO5kRPhREEQGIE9hOxbEOioJkwo7NUtpQrE8hsGWilueM3qQ0OC8gwA+g+ucE1
 VsPc7BT1JNsxhhP5xfbYLDrH3xG1Q2EW8NwJZZopFg6tO3LjzXlooSQ==
X-Received: by 2002:ac8:5a0a:0:b0:55c:9c77:deab with SMTP id
 d75a77b69052e-55d76aa3550mr386741971cf.75.1795662689543; 
 Wed, 25 Nov 2026 19:11:29 -0800 (PST)
Received: from ip-10-0-135-135.ec2.internal
 (ec2-3-41-210-69.compute-1.amazonaws.com. [3.41.210.69])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7889f8b6sm172174481cf.28.2026.11.25.19.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:11:29 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 26 Nov 2026 03:11:28 +0000
Message-ID: <20261126031128.9363-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125210933.2913177-2-anders.roxell@linaro.org>
References: <20261125210933.2913177-2-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: mqueues: Use one thread by default
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

On Wed Nov 25 22:09:30 2026 +0100, Anders Roxell wrote:
> openposix: mqueues: Use one thread by default

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
