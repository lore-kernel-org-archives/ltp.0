Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B59606A32C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mvpSUkx7
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6083E96D7
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 13:09:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F7573E96AB
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:08:57 +0100 (CET)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3257E200757
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:08:57 +0100 (CET)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8629eb92bebso955666a34.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794830936; x=1795435736; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWOSHrHzeqO5kZqP8zx0yn129d2mk+4i3ELPPvGnxqA=;
 b=mvpSUkx74433uv4cd0jw1aasNvwFgw5K7GzB6sovlUQpo5h3smCBDCjAZS1imJeSTM
 IdVGrBKrP2yXs0wJXB1uouoiSSs0pdyDGMfuK/ejn50lm0lwOk42Z74/LUe3DkW560cy
 DOaInk2WvXvh5+Nv//oT/uFf4gNs68O3n5D5zExHEZn/dT6aw9gAG5Mwo9hLoIaU2I8p
 /yJKN8Ud6HCH6CKgbDtQ8/+OLSLmOoQt+/B9OOc+1lagGald6/9JlRySUoed7EM3QsKj
 KtRF9eU3JdyrWeMTcD35yBs6A3ZAhN7FdmLe8i3M6Un/PJ2OAkI4y+ZkifBHQiyXgvw7
 2jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794830936; x=1795435736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWOSHrHzeqO5kZqP8zx0yn129d2mk+4i3ELPPvGnxqA=;
 b=X/y4/QKwvOgjCiU49vcdPZ8WLPMoCe5XeTgLD0ZDFS/g8hk6lXCYEnwhjMLr6z0yMN
 aMeNgrxFT5Vr8jvzfKPnKAsebIz8Dq7FeJU81sSCYKXa4s7vGq2An5wqm4ygd8TpHMGx
 hDdM6y5xlhLXUW/4mXEgt364ylCxqnixiU8Ialf+XievlH9wTFGihtgS84OvPUwL7Mu1
 8HRK4CscHojbj8tu5RZCQYDH8ZqRjTt01VNuwD8LF4vlShxVcYBRa4lnlO3qHTsPr4AT
 k1jtd0QZl4yjWTR+GxilSqNcF6n3b3r5sPWw6dX5XOZuQBGYfKFYgppUMlHnH6Fe5ogE
 0jVA==
X-Gm-Message-State: APuU4Z+ZzKym21AN19gZ1jes0zmwMHCzmpGAvsCg6ixTy+D+qHAQd7Hb
 6wzSfhtTviMAVdIaG3Z9O/9w66+8CZ6hMGWQRFBbvScU0cydhG/5BWHi
X-Gm-Gg: AYBFou10izaxrRE5cyrutJMwA12fEPpBsFwR5ibVtI66uqVRMgtEAQLW2dnLpzFeFAS
 WPaR6MvG8jb+8IYAtPP4R3ZOtOimxpED78lpDK4JFA1nrsc50X4HR83QCKIEdni//u1pO9/l7km
 Kxc2mc4FWcU0YrNNBzz5HWCxQ7uvlSm5djEJryCHhqVhG2haeGURWskiV+AwWgHhthMFnFYgdYb
 3ulmXxdNndAP+NlROhmZUnpReTRjK0e+yVk9aViB2J/1+tcBSkiQbMa/Lcw5HHguBtBZvbjrvYP
 OHqRwS4puRg8j6gus1GmeLDNQ9NH8EJO62+p7JuimpkdbmgQymm98rEzGNIlpU/UYLkGkTJT3+s
 2Ia21YzCRsxyFFG+6WDzbA5nC+YmQO35rmGcQno7QzmAgFxnPW41YcbsmrWv8YkAydglxPDhKIi
 bizZgqg1xdUlH3GncOnz8sinJhnJxLnYb234m/xCkHHDVSfLHy7W/VjAIzqlK0THtc+FMazgNG9
 kfMiMwiaEEY83vaEDHKI+Wt4tE0bJT9BQCnzaspL2rc0RuZDhTo6n3oPXe9QzoGlsgVTiJyIvkb
 eoG1Y+JQ8etEs+zCdP5B4YYl6fRhM1ByuGtPb47Y9APyas8oq5JqS/LT+MvlKP7YUWNk3W+wPNL
 KmycYpaIYKDlfxRvaRHshjw5pT6GhlaF/9TNfiSKUWtg=
X-Received: by 2002:a05:6830:34a6:b0:85e:f25a:7d26 with SMTP id
 46e09a7af769-862897378abmr10097374a34.1.1794830935808; 
 Mon, 16 Nov 2026 04:08:55 -0800 (PST)
Received: from
 runnervmccnms.abxiezd4qetevpp3zp2jhejobg.ex.internal.cloudapp.net
 ([172.183.149.70]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a0c3eae5sm7455923a34.14.2026.11.16.04.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:08:55 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 16 Nov 2026 12:08:54 +0000
Message-ID: <20261116120854.3763-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116063153.2343830-1-wakel@google.com>
References: <20261116063153.2343830-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_gettime04: Retry on transient preemption delays
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

Hi Wake,

On Mon Nov 16 06:31:53 2026 +0000, Wake Liu wrote:
> clock_gettime04: Retry on transient preemption delays

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
