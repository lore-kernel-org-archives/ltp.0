Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBDEFF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:22:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 162D33E49C9
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:22:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD5B33E12DF
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:22:17 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41DAA200048
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:22:17 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8b038a00370so107103336d6.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777465336; x=1778070136; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/J09Rs4PdAWQlyiu7UH+0SxLp6TMDtVbLCYxFfvna+s=;
 b=UsyDwzYDNcFBVKDyP+nNXjpOWAB7u2/Rz4lZq9ldjMhEtFZKZTBsSk2/LUXr600jGP
 VwkXf25SAFaTBYBi4aZBGzggqqZL1yldd0dXkVU647MxskiOKw8JHbLQ/iYyWGes2cGa
 IGWjNXFA95GG1FN1AXmaPGE/faNigRX00YPSDanA5zDeZk4HMhfOIsAI2EF+v81J1/0f
 QkzqOmmFcxjTe1tESxGsJt6QG2YRlRP+lZy6FYF9WJVDnk5KeGsRuq4S1FPibaAJT/pg
 v+D9wzW2x9K//Xz4sL4UlzoJjy9vKX2nWApGlJfvO07HzgIx1ctjjrFKfUJOEiihZiYp
 Qrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777465336; x=1778070136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/J09Rs4PdAWQlyiu7UH+0SxLp6TMDtVbLCYxFfvna+s=;
 b=mvv81HSKHRFGV7hf7S7/AKf0UZv25M3P2nXMaxjTqNf1yUEriitE3jIX3bLXRExu7t
 ZimuiEPGspIUAuem+6eRRzgdeqWaHSLQ+igv5FSsfFjkVApiJILi83Qr+K4Nsb/6GSDZ
 ZQuRKXVaHNtboWmrSXULcOwVrDuqM893CPDoi1v+rv2RVCHWC5WfH0dfn0IqD68VBkct
 h0Ibht2wgLn6EIrVKv7A+WYrhHSWG9dfo1MCJ1C0pIoQZ0jtQlYf0J6Aa9PEiEzthEA4
 Ot7s0JhdUqKhUBleJuDnOENFtf47uOajewNlBiD8GxuY8QAXTYs8GilWwri/9WqGcq/S
 FAlA==
X-Gm-Message-State: AOJu0YwJpuaxff17iX7A9ra7ooYdKD+SY4CFnBgjT0co8Jf8WcrO7+6j
 QMGkNHfAQbu2xZ3iOc+r31y+JsvTCzKwjyoU9LZUNrxzuvcecoLrtwfcvPQmQkHebhU=
X-Gm-Gg: AeBDieuxyNKi1WngNZqYR5c+9V+JkyljP34XVrALKc73klZ6fj3sB5/hr2WY5KJXWSQ
 Ld7HN28NMwzrD//zS2e8qsGH7OX7efz4F0wYrTenTXR+HDQGBkJgWyfITGSLUliwW4kseMzkpHe
 1Lc9vsEC2HIfXCojswu+kUMGXo8p5hIg2Q0q2EDomL3yG76+8TiSP1HDCcUmWNtQj2EVTwvmzUd
 jeXCuEEJqVdjsfn0Z+QgOm9S49BlFEjThc2j0x3hC7/C8kgd/+MdfjIFSmSWZ+ZBX6JryfB4ugY
 Ct5zLd/0+ToWhVHquY3FONtbm/yZ1dOFKumzY3CXor6ZfRmONaVvKa/z0RaeHqfcS1WSwu3nlNJ
 5Xy5rIQGfEEgcyNZIQnxX+0dvmI541c1dAKoaXfXkYPb7M/FcjqD8fO8kwxnRysdWHossTevVaQ
 n2UOaRv/ENdVIrPtb2ZoNh7QUUATgzT9+Jh14eFkjhzYxCKoWSLtDF/rhvyfTJACroldAOfMASk
 WaAC/kNMbxGpukTzRtFgFP19KxBapwPXKdRm6u6qv0AxQtiJ2lXdYgLBE8FLnE=
X-Received: by 2002:a05:6214:8007:b0:8ae:652b:e3c4 with SMTP id
 6a1803df08f44-8b3e322cb3bmr107222406d6.49.1777465335970; 
 Wed, 29 Apr 2026 05:22:15 -0700 (PDT)
Received: from
 runnervmeorf1.uyrlpyg104benkpdkze3f00j5g.ex.internal.cloudapp.net
 ([135.232.208.112]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef709687sm16795886d6.12.2026.04.29.05.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 05:22:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed, 29 Apr 2026 12:22:14 +0000
Message-ID: <20260429122214.3987-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429101244.3309913-1-wakel@google.com>
References: <20260429101244.3309913-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/userfaultfd04: Require CONFIG_USERFAULTFD=y
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On 2026-04-29, Wake Liu wrote:
> syscalls/userfaultfd04: Require CONFIG_USERFAULTFD=y

> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USERFAULTFD=y",
> +		NULL
> +	}

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25108331937

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
