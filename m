Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0704FC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:09:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72EF53E9A1E
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:09:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C4A3E21F7
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:09:04 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C23DE1A00708
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:09:03 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-9032b580ed4so11683556d6.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783951742; x=1784556542; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8D1GLysOmvGOFMCW6AKjkor+A33cWkLUk94mEp8S/20=;
 b=akm1Dq1ESnN5IQxSfrlsx6HGPwEWd2I/Vf5qrccoDWub0L0QaIW4ZHMoqhjUolRzIF
 8wABmenpbM2uqmmBnIUEX0PESamcuJJZTTEeu0DfR0ImAhHd1DyfWP/4fSP4mELx/apJ
 98Lu/yDmH74Fg+6zywG1N6sYDj12ZzgQLIRbjuEct0JnmQlI/k5mlKmQsIoGWQLEFrA8
 /anJzJjl1ORKgxiKj+rKtO2t7+YRAnGu6DZtITaPlMaNKZ1sbTh8uLR+mp9+fBde+2Sc
 BuIWpJc3NJrQcA5TOWkCOzF222TowB/KEQMH7ZQ0GEmPbc6cScNnPIwaz0k0INK4vE67
 nBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951742; x=1784556542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8D1GLysOmvGOFMCW6AKjkor+A33cWkLUk94mEp8S/20=;
 b=Y9Fbt8vu1JPmINDKSv1A4AcjrL2V7go5/qapy2iiKt5uN7VlbNMNL3P4ImqBEFJZaa
 y/9QMchLdAwr2W2f3MVCfvaUb6goc2dgBKdP1LyT+9h6j6Ag3j+Ym/Sd7XWK+qgRUC8T
 /Ypn25yzZZl9EuUN2K3m02O6IDJjQAKL0H49/R8W6X9YMwHU8a4Pxo9H3Sn15xoYfEAE
 180/xRCzvJVGFq1niE1PUPjxv6aLXYBYSrUokzYWs1kzO/BszAKNgDTVAY4mFF0bSHFt
 n7t/a+TCSPzl23cnh5lSEk8EP8KIIdN/sJjzHDAgmtJMQ9SxC53+A6ZrRvA5dS1rJXjv
 VrdA==
X-Gm-Message-State: AOJu0YyAgdOTySj68z97nhM8MN0D6fSdjoe+HwH3jLEmwc4x0f+dTUuu
 osL8CBUl3WVe0M8razQYe9G8TaHyCcU2AwXepg8tsdEw/SH5MlGgbvKb
X-Gm-Gg: AfdE7clV94tAFyScmL3fLeZConjKiEe/iYWMALqu6SYOG0TmyTtmvsU9489WLv9wtdp
 c4Woc6bAE0LlT4Q8tC+9pN3mOF1hNhMAa/km7daxgvPdd+K4mfV4bsCp2K8EcEMudBMv7EjwdUP
 ZYiaMiS9nj4AgdJ5wEvQvJ+MYwLewxb6GwLQ6OdRs7AeKim9wBYdBhIU0MI7MtkCc84RzMmvT9I
 yu6+8WusX35SQ8rqW5mniFlTXmr+QTgm39OrcaKQlL9KssdKPIE10FoguUT/0O2bwvnGKgoH1sL
 2LEduOVFzmkcSn+5DmOLX0n4sXKyt39QRNBHJUF6MtTTraiOyEx6bR9q2JVVdwXtCiiO3mvNJdi
 0cu31HE0RYl4nC0B17vDQDPGpM5s54hWfyw1w/oHeN49vF3q25OSb1neylk/pi7GT8uY29HiChh
 48GxGWsM+so5zQHPTi5SlQL7fwDOstpcxIBMfcT20tDW7J2eWXtamKPbAvEADwReBbqRKKs74MA
 SmvTXD8KKZ0I2EEVVyBBjyophkiQ1s=
X-Received: by 2002:a05:6214:4114:b0:8eb:24e8:8d28 with SMTP id
 6a1803df08f44-9040206af4cmr100401566d6.46.1783951742251; 
 Mon, 13 Jul 2026 07:09:02 -0700 (PDT)
Received: from
 runnervm5mmn9.c1owmm2apunufa0yanmraqiv1g.bx.internal.cloudapp.net
 ([172.203.253.173]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c4b78sm129189886d6.18.2026.07.13.07.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:09:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 13 Jul 2026 14:09:01 +0000
Message-ID: <20260713140901.4008-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713114220.4185427-1-wakel@google.com>
References: <20260713114220.4185427-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Reset cgroup limits before retrying test
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

Hi Wake,

On Mon Jul 13 11:42:20 2026, Wake Liu wrote:
> madvise09: Reset cgroup limits before retrying test

> Reset both memory.max and memory.swap.max to "max" at the start of
> child() to ensure each retry run begins in an unconstrained cgroup.

The description says "reset both" unconditionally, but memory.swap.max
is only reset when swap_accounting_enabled is true:

> +	SAFE_CG_PRINT(tst_cg, "memory.max", "max");
> +	if (swap_accounting_enabled)
> +		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");

The code itself is correct -- it mirrors the conditional set pattern
already in child().  The commit message just omits the conditional.
Something like:

  Reset memory.max unconditionally, and memory.swap.max when swap
  accounting is enabled, to "max" at the start of child() ...

would match the code more accurately.

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
