Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B909DCD98E8
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B7FF3E5977
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:10:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44A003C19F0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:09:47 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AE16F1A00780
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:09:46 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-918559ee2a8so435835185a.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604585; x=1782209385; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XvMKaCmagoAARwEm3eOU7x7NdfS3XEjv1nFhrL6kw4=;
 b=k+VYvbLjLheA3tlD0Eh6fdWe0HDlS0dA5QNWJIziRtDVzb2gdivW8kVIN6oP4i5mZa
 8q043Dx9ogVzv+tvwR67VEyE1vna6a4ctsDIRHO2VqP1w/22m2Tlldg1fkocext1Z5H3
 Xh0evXxRRfImwRI28CVsppDqlVP4KSbMX+1uy60o+NqqGYzG9sSz+qmg0w9QVaCrjGWD
 prDuZYJnGm7gZgOpQ3EbZIE9gDJFYniOVdbTXRP5ZIy1c5hGgZmbPpXyHtFVcooyAoUJ
 s7pq2UJCMt7pub+dqOCXXu4mX8QxIcX3I4Gtm3DOPpLjaiRUr+l5b707ZrDdxdxsZv8V
 ciDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604585; x=1782209385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2XvMKaCmagoAARwEm3eOU7x7NdfS3XEjv1nFhrL6kw4=;
 b=mO8itaPnyI+8sP88gwdb64V2jZfIwUM4/E2hTut5ji0mrPwUQ0ZnfwhEyHdQriSjmR
 5nLsbHxh6qGozG0C5sr1BDdA5Rxdj6IHU0+XuQ9gGN5/3LbSjRu8YSsBRPEpUrgEcSkO
 TgA/gN0lliTA8xjfRzzZa2qRMvIl40LvSdT4BRRQJ+TdnkcS2mqnyzsenmuYeN68XBp/
 PtX4Im0vyhdULsk3p14oBsMxi53GD119gHUPlRVyeal/C8f+xLBjabykEhQ8rqVuTjre
 EEb7YsUNJMbgnrq7hitLDfUzVl80fEeWtqBZRTYEoTUlVg9TDDA87bpYV+bSTMINAq8c
 F10Q==
X-Gm-Message-State: AOJu0Yz6wIXTJ/0z16m+4WU3/DeBOQs9H9mJ1djF7hDh5G7WlB3GEbtt
 9VaTIifGPztZ4vNGRf8szXNYwaCp91FVyqnd+56m+d+CzHbk9JCTTShC
X-Gm-Gg: Acq92OGCqR1YkWBOXz7tiazmoGDxXrv/ZhV0OKEbuXldMMWo/qVmE1XlvudqNd3BiLt
 e6UpX9lkD6b6q2gGc16X33aVzDYM3Sluhkb94ZmkoaExXRAivBU9GTqrszj5XL2fBznqZpfJ1ta
 DWmAhhebEe+iP57nopur7RQqIiGBX58DC7DtRCUD7VJu2TM8r0CGULMmLLI7AqKdBKCiojFVGx8
 JQRRaasvzb+VPJypCaRJtY5f3OkcC7fOgOAhuKA9SitK3zjGH70ztO8DsVzpkJZ5qPyO034eEzb
 juX1x1rd6LewxooFkVRC7j6yf0iotDZEUq71/B8BXUV9JZDxow+SoZq+d/Nvc/Rj+ER24TfjhFo
 yC+4eTdRtNHfqMsGMRsEcKu/w89QfveIMxJsYRifiQoKJ0wrgbCkJenT14c4RUk2Dxxfi08Sato
 wAJUAUXczH+5ZsbYH/sik8AxYfFjanhEao9N4zKY/WlC4zyCcvCdI8vvsWstXGMSwSvDY0d38vG
 d0GuJj8Nggqhs3CNJmKxZul9frUKpaSdPkCes+sJw==
X-Received: by 2002:a05:620a:2984:b0:915:9efe:6de8 with SMTP id
 af79cd13be357-917f33ee56bmr2213244185a.58.1781604585371; 
 Tue, 16 Jun 2026 03:09:45 -0700 (PDT)
Received: from
 runnervm1li68.dy0dcyvzke5e5dxxzu5nqqj3qb.cx.internal.cloudapp.net
 ([172.172.119.107]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619f2d6a5sm1390023585a.20.2026.06.16.03.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 16 Jun 2026 10:09:44 +0000
Message-ID: <20260616100944.4001-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616-fix_clock_gettime_openposix-v1-1-ae4ade48039d@suse.com>
References: <20260616-fix_clock_gettime_openposix-v1-1-ae4ade48039d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime/4-1: CLOCK_MONOTONIC for timer validation
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

Hi Andrea,

On Tue, 16 Jun 2026 10:57:22 +0200, Andrea Cervesato wrote:
> clock_settime/4-1: CLOCK_MONOTONIC for timer validation

> During test execution, any service which is operating on clock might
> interfere with the final result. For this reason, we use CLOCK_MONOTONIC
> (when available) in order to the compute the right delta between

Typo: "in order to the compute" should be "in order to compute".

> +		if (use_mono)
> +			clock_gettime(CLOCK_MONOTONIC, &mono_before);

> +		if (use_mono)
> +			clock_gettime(CLOCK_MONOTONIC, &mono_after);

Both clock_gettime(CLOCK_MONOTONIC) calls are missing return-value
checks. Every other POSIX call in this test checks for errors and
returns PTS_UNRESOLVED on failure.

If clock_gettime() were to fail, mono_before / mono_after would
remain uninitialized and the delta computation would use garbage
values silently.

Verdict - Needs revision

Pre-existing: timer_create() allocates tid but timer_delete(tid)
is never called on any exit path.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
