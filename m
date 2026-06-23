Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970FCDB470
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 20:06:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0F9C3E6976
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 22:06:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2887F3E0E1D
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 22:05:55 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E610F60004F
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 22:05:54 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-48611addcfbso190403b6e.1
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782245153; x=1782849953; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvvSre37nrKppPu3OijNX53QeCwExOE2cQs53svS37I=;
 b=cn6XQAIlZE5hMJXJ6SIN49EOanPnu/VbFhmqI3YiHK/X6Fry+rln7x+tvhbLEm4AB2
 2oTUsKGgI8K1MP7D8zMhJLTFpaUlUqPsMXIHJ+6gcwhavWutSJvXenTZwL23ynvJd8LT
 Q80s1XjmNxA0SP+L01mVm6l9IciYl3MWXq/MUXqKT5v/9LFx3y2v5ZTyoN/wCBIe9c/e
 ZGhAXMs3DUFrojVufsK7G5X/0pA0FSum9wVBzEsAVZOvBSRoDgcTFgaVMIX/gvsvdzud
 pbWMKQVD20xHPE6jfNKFNKKPl4DnyUjRxylmKt4UYMQ0yACR+edNh/8KqgdZDp8Rx74i
 Z2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782245153; x=1782849953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvvSre37nrKppPu3OijNX53QeCwExOE2cQs53svS37I=;
 b=pxGZdN4zABkcm+nd+ErItf/XikQ4qrNMNs8L24N+hOfqlu0QaRz03oGVdw/H3Jq/Qk
 ZpC6cxzMjVR4VjaZY6RbEGrj0tp8znCebTuhsUCR+sY3Lb6hoCEfgkuXTxkoENhsgMxI
 ogPav26FwKGw5dqy27xR8uDVI1U/ucrwAbhcq9xmOBHyZsGJYFAJVGic5DzB6wuXvTvW
 jev2/XLz5XGQbQANk6twQT1qEXx4t361ADnviRL2AyOZuQSAUeVp5cSMY3Sj5uMGKJTW
 X61JST9zxsjGcsaKZcuJ1zEC2IIxl+q2whnjPN/94lxJFgvGn1Rii5Da9AJJPBxGf+Tk
 Qpxw==
X-Gm-Message-State: AOJu0YxGsHeUKCJhYP5gNRhJjGWFUos0kJSYGR42yLu0ye4Zsdf3Gx5P
 9M8tEtMJYgabfJpeWuP2rM2dV3GcSAQSAlTJxlYdOmcdv9wg0AioIkY8y/NOkIME
X-Gm-Gg: AfdE7cmwKHC7YHbcWMjR4ZOlgp5LTZjmEl4gI5Hpqaw4UBOnlP/toeKbQBA4itYaxkR
 Sdxw/M5iK/kk90Lw2LSsD70aJMcbWkZs+kv5EM/A3XhwpG+XN+NG7M9VioY5dES2jwmxAwfp7ei
 aCTED91c/clzDVhgkIT9fN0jvubP+cR5tz6TxmDfgv/B4nBM8Qitr+zKGR4UBgZiNZYw6edOrNG
 Xq/AuB3RMBb00ZeQnVaD9Qy1+qX9MhmuL6akjhjBpunXXibCIFcstB8l2YMCDh39nyDCCbv+2uD
 4QapGFVmy+syXyNBLBlRMjVFY7eg7GV4WzMdLrDUKOSEVHut0oPGuSgMH21be7qZfCvETQZqd19
 VKsi9DjkmAy+UFtanyopEODzgEsJIf5z4o8qY5MbjA1fnuOKeRHrSywEsCUQvuKN0kjYQsySBaM
 Bslkod6v0ttW48d+EUkIwD8h86BxCiutXtt5v6lU8R7AhMdWG0Y+cCwYWnMLp3sJB704xe21JRH
 xlcaaKiVb7sYCvXNCn2Wpa6vCHZHXaWV3nXcqBH
X-Received: by 2002:a05:6808:16a7:b0:487:4d4e:bd46 with SMTP id
 5614622812f47-48f27532de6mr2905010b6e.5.1782245153511; 
 Tue, 23 Jun 2026 13:05:53 -0700 (PDT)
Received: from
 runnervm7b5n9.kkizw1q41lvuhazfqxg01mu2mg.gx.internal.cloudapp.net
 ([172.212.163.19]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aebb9f1d7sm7636905b6e.4.2026.06.23.13.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:05:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 23 Jun 2026 20:05:52 +0000
Message-ID: <20260623200552.3858-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623195000.110648-1-avinesh.kumar@suse.com>
References: <20260623195000.110648-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sendfile09: skip on native 32-bit kernels
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

Hi Avinesh,

On Tue, 23 Jun 2026 21:46:09 +0200, Avinesh Kumar wrote:
> sendfile09: skip on native 32-bit kernels

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
