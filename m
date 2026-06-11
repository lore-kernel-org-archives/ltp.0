Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123A7CD98C7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 18:18:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8673CE2E5
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 20:18:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 617AE3C54DA
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 20:18:01 +0200 (CEST)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 95955200904
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 20:18:01 +0200 (CEST)
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso143365eaf.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781201880; x=1781806680; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNCI8NonBUxJp3qqSSAUpAqZksSdgGuWtdlG/VyOk5s=;
 b=TggzLMs8sfflWWWAz7uZjH9avlq7SIOlHyvyE7R+/DLqFXoT+YkaKMxdU1X/WdVDgg
 ZBMkev0wUQxRRr8JcRV+4ddbqy5WT0RccJCABCkeVoBxuB4gPa/vJvj/qX+v80RYC6iI
 nuniz3U1dDCoXF7koOX3zjs6EEJw23I9kHUSQIBHxW7osfGitKjKD87oWgsdtDvzJWNl
 buYDeOds1Sqs3FC0SvUZelpJBxbWvDE/A+FVZDaFOYH5j98gEUeu/YxIVGaoa1yrM/w0
 6XJX1qKiP3QLwEn8cAF43hEjGVvPPYF8HeQDLOcNI0Xg1UrCj+i8SpkIKRYis5+/2dhg
 hQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201880; x=1781806680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bNCI8NonBUxJp3qqSSAUpAqZksSdgGuWtdlG/VyOk5s=;
 b=kB2yYADzQ1L7WFrf6yhrC5Ie6O/N0ASqS/jXUeJ4gwZGV3cx8MYTK/mF15OcDKeQ7p
 Yq8GDcoDKGU8JK+IwH0h7iLvxegs7lbDG995iHBG9uKQ1XGeme216UQOmutCyfERMoMs
 Iekj+kI6PK317xCPkP2qnC7wT1Xxcc1pqXb7ckufAYS+3xZRHcgmizm7oArtTs7DiVgs
 EadbPSeVQyKU5U6diU5CkUv7Jcy+yygIggE4L7pV6iBLMjCGc9ewPWNqEvcJOvuwgKel
 gxH7RHF95XORjNp4MoW9hRJ13OB3a6WqL/hGKfMzmHdbN5HDnjg/6Y655fioy4Dz7Gzq
 Gk5w==
X-Gm-Message-State: AOJu0Yxna0kfOevUVQuWMEe4v8ZVfY1GxsmQj1IJjKU08ef5WSH2/e1X
 Oj+fr6/fxHCw/VK51WIuHqcUzVUI2xX9u08SeqmVaWrJNHc9zayXbYfP
X-Gm-Gg: Acq92OEa22L7EVRj+6V0kUPuvFmIGJppdXlRLR8p4npXeMo1s3loZ6XBW6l/Ecb8NLu
 4kyhGg9Tan5IYO12vLpY9IS2QEwHuuExhxBdyw+zTY6i6rn7h4xt4D7n17FHznCwodc+/UVgs1i
 JQk1JbKzfvS30J9gZXMBaAdGuPBIfmYIXD6qWoi2b92YEpbPNzkVeVfLwMvJCkIvoc4LlWUf34y
 Bl+qqRx6nSM3vfdPnFXgeHhhpqKdf/8LMm7EZyfKohXTwX1CpdAwcRsMfd+0wzJdZ9zeRMJYexj
 9+C5oHybAf8w2bbovucJFT1KEP8ZPwJLkarEKSQK0/1/PmI6IInf+QNHoSgSe/QyjRAuhApp93W
 pLrwFNFobPcdmoFim6rgwQp3Gh2w0OEI4t6mQKUJOvzK4doY0QoFdlDFsPHhhXddQUKgKXE9dFc
 RxbtGPQS/yXBOdR7axfnGtcwKfQ8+4//7Arph8a9GAB90cWwwrAZoW1JWycP70NLvSwQGzr92nj
 pog7KcdF0SGDbeyJL8WHmh0DQc7tLIfseG00VuDsisL3QGmxQ==
X-Received: by 2002:a05:6820:208b:b0:699:a28b:18ed with SMTP id
 006d021491bc7-69ecb06ae9emr2545918eaf.48.1781201880175; 
 Thu, 11 Jun 2026 11:18:00 -0700 (PDT)
Received: from
 runnervm1li68.m2re4ex0a4vejgjnzlyjcqapsg.gx.internal.cloudapp.net
 ([20.40.212.246]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44244c30559sm1602822fac.13.2026.06.11.11.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:17:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 18:17:58 +0000
Message-ID: <20260611181758.3906-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
References: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup_fj: don't disable controller that was already
 enabled
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

On Thu, 11 Jun 2026 17:03:41 +0200, Andrea Cervesato wrote:
> cgroup_fj: don't disable controller that was already enabled

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
