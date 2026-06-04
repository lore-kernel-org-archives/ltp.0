Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E050ECD6E75
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 18:01:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75E783E71C6
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 20:01:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 659F23E276E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 20:01:38 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E232160095E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 20:01:36 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8ccf181a52bso8873506d6.3
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780596096; x=1781200896; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxZWhC9oGp0mxLs29EpRLvHVlca+ZGBz4N1Sdw8qluM=;
 b=qhTC5+tst4idt363Qv4MLBYfrqSPL3gbwkdOfJMqBX47vFeYwDu4FPYgSRFDGyrJ/H
 Qpo2keRyftXGN6kESu72uudwo58OhNOdYM6gNnHzgiALX4Hgxp9r3plRS8ymnqZJWrH6
 uN6yQqTljNb7IrPLo/+osL9VJJqSS1uFBnin3Wpv5jl/JcW7nY9uMK/GYIAa9DeBmw9O
 LWqMLUO3mqMKYc2tIxplXFrh6iJF6vuPaeE6ZpzXI1k1Y2fGESnQ3SsDhp7ki9YGJrw7
 ciLslBjnGTlwVdTnQpfm1HllkXpJdugKljaU++H6b4wePYmgRgihSzkLfFrgOda6CLUF
 tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780596096; x=1781200896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cxZWhC9oGp0mxLs29EpRLvHVlca+ZGBz4N1Sdw8qluM=;
 b=I4xlpHAmOMQ7xaiupTOV+CcDGwbZFa82aOW1K953lrvW5ANjXJ9lJPv/CEa+z56lFw
 R0X0JHGNtSrAY9ZegREjKHPNSUAXP9HXTgZmFKc2O1Zms4U0op2UneTnfKaO1YDQ0OkG
 KSGBvGfY0srSMghDJCnVDhZMMKwzE5nk8r+3nDkISSzlti4TZJ0Z1JCOSlJMfEJ7PA3E
 f6kB/v0gUz+cUSoyTU3cAAwJ+/r1gnaeYbgxHdYalvtmwaAKZnwFIVaGhBzIOz8hYl59
 qpY/o5KQsjzYh4MJmcK+5AqLyv3DgYJt3ftQC+y8CDfOzNVrLQg9Gx5o6Ed49dZyCmiL
 YAwg==
X-Gm-Message-State: AOJu0YxpX5sdm6Z0dr/1D0UHQnTAVHhyfW68xQ4y2+T8wUtPZ2Tfble+
 Uaj78ulYuuxig76s9E0kB3Kpr2cyyTKfAzqy4v0AYyDoE9s2O9dl3RCdB0CAq3aV
X-Gm-Gg: Acq92OF02AZC7BFwEWoalSRYM7B2sUa0ARWL2/XsBr8yKGa1siOcwjlaLqauBlOJ6qc
 sdW5cePlNW1yQAPTfxnJr0Nz/AOQcCwtR8STSCMSKhiMsdKYd5d+X+hv6gVTcMmsKVyY1ydectW
 C4qOS6sq6HaSLOeniqHjUySI6fhXCmaX6bNRvM85PTEdhMGMASxYutVdmIP0fmDWaQQS6Us7HML
 gDhDCGd3iQwdHvrc/cNraytAEJeQscIJgYDq81CNp38/13Sab8ssYGznobT7pA0mTOB1NRfCjdH
 BQtXiJlUvxEemNssH8xzlJJ/STh+ZjKybLsJnf8rTDIMLo+vxROaOfURmCsyfCHgHzgMkcG5y4H
 DNAWYVw7juXFM/Pg2lm++fmmNeTvCWbwnN/3fJpUGhQbN/KaQYq8Cp347TEDljddN1UTBxkJ6FN
 wuGQkgTWmBswTp1zuNRiccHcAxkFpIcD4CGAZKs4w74CZZqSfkAR2KCqaSq7e6j/DihU3q82w5f
 I3+I1cnpXu6BY8bWYYVx5EgLLlcNbDNNqt14XbUHWsEGgywWPU=
X-Received: by 2002:a0c:f8c9:0:b0:8ce:cc38:e496 with SMTP id
 6a1803df08f44-8cee613167fmr2288206d6.22.1780596053788; 
 Thu, 04 Jun 2026 11:00:53 -0700 (PDT)
Received: from
 runnervm3jyl0.snhy0gfitnfuvopcsurrxjmkjb.ex.internal.cloudapp.net
 ([64.236.187.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9fd77sm58688716d6.10.2026.06.04.11.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 11:00:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Thu,  4 Jun 2026 18:00:51 +0000
Message-ID: <20260604180051.4159-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604163909.17853-1-sebastian.chlad@suse.com>
References: <20260604163909.17853-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add io_uring_clone_buffers and
 RDS_CMSG_ZCOPY_COOKIE fallbacks
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

Hi Sebastian,

On Thu, 4 Jun 2026, Sebastian Chlad wrote:
> lapi: Add io_uring_clone_buffers and RDS_CMSG_ZCOPY_COOKIE fallbacks

--- [PATCH 2/2] ---

testcases/kernel/syscalls/io_uring/.gitignore lists io_uring01..io_uring03
but the new io_uring04 binary is not added to it.

> +		ret = sendmsg(rds_fd, &msg, MSG_ZEROCOPY | MSG_DONTWAIT);
> +		if (ret >= 0)
> +			tst_brk(TBROK, "sendmsg() unexpectedly succeeded at iter %d", i);
> +
> +		if (errno == EFAULT)
> +			efaults++;

sendmsg() is the subject syscall here and must be wrapped in TEST()
rather than called bare.  Switch to TST_RET / TST_ERR instead of
ret / errno.

> +	if (efaults < GUP_PIN_COUNTING_BIAS)
> +		tst_res(TWARN, "Only %d/%d sends returned EFAULT - FOLL_PIN "
> +			"counter may not be fully drained",
> +			efaults, GUP_PIN_COUNTING_BIAS);

When fewer than GUP_PIN_COUNTING_BIAS sends returned EFAULT the pin
reference counter is not fully drained.  The test then continues to
unregister buffers and can end with TPASS without having exercised
the vulnerable path.

TWARN is not sufficient here; the run should be aborted with TCONF
or TBROK so the incomplete trigger is not silently reported as a pass.

> +	for (i = 0; i < CLEANUP_WAIT_SECS; i++) {
> +		sleep(1);
> +
> +		if (tst_taint_check()) {

sleep() must not be used for synchronization even inside a polling
loop.  For deferred kernel actions the expected pattern is an
exponential-backoff polling loop, e.g. TST_RETRY_FN_EXP_BACKOFF().

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
