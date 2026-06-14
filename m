Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C411ACD98C5
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 18:20:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50A643E5DED
	for <ltp@archiver.kernel.org>; Sun, 14 Jun 2026 20:20:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C41783E11C6
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 20:19:50 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D51106005C9
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 20:19:49 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-13721dfd471so2785544c88.1
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781461188; x=1782065988; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bW6NSIN13DRmCdrRn5WVtZCqy5QarCpPuHVivasRcw=;
 b=r/nZwUhgI1ZIi1zK3wOtmAE8yKgCJjFZ2aAsUZNzJMXTlZxBy1BRNtfA4/es7oOQGa
 M0XVoBqOcqnR+/Em+Eddv2rUV1iC8FjeaTI/c/wQI3puhkxCeri+ouVOy/JuOibJmxnF
 a0/SWOD8hyRnvLvHv0At2EX4CzjtFyQcbAJZa0FBeqYizi83h09khoqE9tn1I/8Sg4Qc
 FjvH0IR/4M7ivjh3ANnHUcRGgjqFOhmR88IaRQiRVbyItyhDlYYuGS9HBrqHsVP9Tohd
 lycvcm5zZLcBZMCqP3LJGMcoibH/CJPxTFYhOUPMraHy8Of4d6tF37MDnasEa8jPgG9v
 b8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781461188; x=1782065988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bW6NSIN13DRmCdrRn5WVtZCqy5QarCpPuHVivasRcw=;
 b=BSD8f6ZNcZwrTUHhaX1Tgpg8VHylWSSNdtspfrvv53SWicd0RGQDhfCsFswiglJN3M
 zq0CmbAlL/jl39DRPMJPzbT7nTIqOoQV9EgujfQCH+wDIZJtC/Qpgiws6rDGArQUlQ86
 P75qnfMu3O2hlAAgbWNn11rMn9P/Gxse6hUtF25fjMLuCnnJ5J9I0l82jt4CidImPGwz
 ad4RlGdnocdarzBhn3s3ldHJSDf4PTUyrCDK4l8xH7coJYWyjnsG77GOh0WaPl2I0oVV
 4oPddKDidqm3ciZ0O8PHsf6AGP0hE8zyhewT3yR/WUalJ3gMZ3CSgPnIDgVm2rU5n3FH
 dOZg==
X-Gm-Message-State: AOJu0Yy/qGmZyi6stIf2DHUU/qpwNmeDLqeWRsZlhep3JoBQjHHQ1vqG
 c9rmJS8uhbeUnr8D61F8aF1GVjL3cFtOfgkOK+kXPkr4KFS3mzxQ+oJy
X-Gm-Gg: Acq92OESM0M9xXEw4F1QDkG3eOM6ADizjZ1I93r+QidarHvdgk8qqnS6gQ/3poYmMPU
 f4WahjUH5LpYb+i4vn/ohNQ4EybDVp2TqNEi8cZFa1PVYla5V7jc6tmai0yoZK7AWjUrCVKKnL2
 QiDfF6XoyTm8NFMsm4MyeJlNviJGpyHGw2s0xJ67O/oSfhr1tREkIlpD7gVHuX24UKad0f4dHME
 hOij28TDgF8RyjGUywottCoI/Kfy8h6IiVj1Y0zsa1gAzo8mapt2qCnag/3EWMd7riK2udmtByZ
 uwyR+dUwM8tuPAZjewpJra+dbqK0NgbHcwuJziFcLBz46oXbIXaUttqg4rLjPyPz/tI1oayuG0d
 l4hU7OYl1v1XUlK+JinoSs7iL+FHLtn8shvTGrIyUqWq1oTRqxeMv0mwp1CQXiG4rfKwOvDL3xX
 HIMTBwr1JGbFZqvRnYBqovIMZAFejZjrrWxkndb+K0+bm3wa6EcALrcTodR3aViynVAVC0yJme2
 /qGY8vOiYKRPdlxCpaiqZnKFjxuVQjwPkSltTRf
X-Received: by 2002:a05:7022:252b:b0:138:243e:ce97 with SMTP id
 a92af1059eb24-1386f24aac9mr2906251c88.4.1781461188079; 
 Sun, 14 Jun 2026 11:19:48 -0700 (PDT)
Received: from
 runnervm1li68.pexe2arhy53e1kmc0kdex5vwzc.dx.internal.cloudapp.net
 ([52.159.247.149]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b910c51sm8016765c88.4.2026.06.14.11.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 11:19:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Sun, 14 Jun 2026 18:19:46 +0000
Message-ID: <20260614181946.4069-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614174759.24546-1-sebastian.chlad@suse.com>
References: <20260614174759.24546-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Redesign common helpers to follow liburing API
 conventions
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

On Sun, 14 Jun 2026 19:47:56 +0200, Sebastian Chlad wrote:
> io_uring: Redesign common helpers to follow liburing API conventions

--- [PATCH 2/4] ---

> io_uring01: Update to use new io_uring_common.h helpers
>
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

The commit body is empty. The diff is non-trivial (restructured CQE
consumption, separated submit from wait, dropped explicit
io_uring_enter return-value checking), so the motivation should be
stated in at least one sentence, e.g. why the switch to the new
helpers is needed.

--- [PATCH 3/4] ---

> io_uring03: Update to use new io_uring_common.h helpers
>
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

Same as patch 2 -- the body should explain why the change is made.

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
