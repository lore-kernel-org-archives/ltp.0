Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A83C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:31:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C64363E4B20
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:31:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9DF73E2E31
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:31:22 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 16CEF1400044
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:31:22 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 af79cd13be357-92e7825afc5so33462485a.0
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782995481; x=1783600281; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOPSGI8xPfyF2QU5Uuq8gNFXbQsbYaf1Zs/m2SnLSvI=;
 b=aYsztFUS1izoWwuHq5g0MR4yo0EPdkWI1CSTrjwFMCLULqlbZjec4/yqi9JfRv0x6F
 autbBc7deMZy9281GQKfDQC3wG+O1hcBpe/2F18ry4rfaihE9d1bOcQYekO3mmbFln9j
 4SmxkRADNZSrD1bagm2rWJ5CSwGQTss1FL0UVPgN1qQh7T5VvClrUYkgcJyWWjC9rQmW
 W09BJF/Y6aa8MeoGHqWJAFV3FJJssRjjQh7UTW9qZy+tzGT5CoKVMPkWTREpRSLe09iw
 KumLvJdSfP/MdPZYjLK3EY7ASKfCqFPp49wp6yCDRa4U+raoB4/lOr3422Uuifi4Th6R
 72Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995481; x=1783600281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOPSGI8xPfyF2QU5Uuq8gNFXbQsbYaf1Zs/m2SnLSvI=;
 b=swk8ItEOtZ+dLrTZuk/fPbZy4D9n+5RQYIFyqzVa++dhB62O93EJNZ1IIB2f+vzlgm
 TYkpXJ+syrnV+teiMpUJkzieB+HnvynTljfe3C+SiNJsC3KykaTGJqtAXyS5P0Jloe3t
 W0a4RtG0eTxotc3sT+o+S0OJJ+ZJa36wYo8u/EeI6cIeqBvAX9EKR/HhFEs7KPDahQkv
 sZGku3EpfG1OyxyL8Go8QOcdyeqgdHvqe7Ys6/aiECUaHT4BboBBHVd6awlAVqPi82be
 fwS/oJjk4zV3IKa9/SA/hJFHFxKfw5yLTvW4sQQnJjLYMP51u8sKerE87DU7XnslHhgZ
 1pmA==
X-Gm-Message-State: AOJu0YzoJAQS4SOodK1Iqwh+WTyJ+offVKs0ni6i70MAD5sIxKdcybT+
 7pBONcCBN0N3L4pif1P1P3eJnEY3lYH/nGrFONflOCxxyVp9fQEiBpOT
X-Gm-Gg: AfdE7cmfmA17c/6dc6ZYt+ww8WLkFQiCjS6KgbD4nfZwlUn+x07NjWXHZvE34XdyeYq
 3UyrQnF2VysetfjSgTiNmuXw8CXC2tmuxhrEOqDrx/+opvvkBSpF7QT0gklm912k0OzUDREA8zS
 jMyZkXtQP3k0gI10gE10d5m/CbFE0qa3AnRsLSLvLzbIgsulrKzz6cmEq7m5CjVwUwm4e+aDC0q
 ZqRwu0ynckBmUvv2NMubMmTnBoN5Tb1WInr91bXCDshaAXd6SirsuzqiQiq+GzdtbcxdQreqcSR
 Hm/hi2W/GFFTyS0aNLlB9qpttSL8OiuDXVZE1qvMxl//jXpTpPJmulcKy3pOSDm3iZgLRBr0BfP
 D/sIo9HVf3NT9Z2daUCqWKMQOzYazAIgujetDzKVKlRQCWUNeU38PlfUO5SzG2dz3WN7qD76WY7
 cnggGP1gdvSl3fz7Knj0FFGBzuig+IONpP0iRqiUIMUlYWugynCsD0fwm7jxBS7V5gWb/MrCEI6
 ncw+rWvKHtz5xMoerCeIgIpugM=
X-Received: by 2002:a05:620a:458c:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-92e7aec70ddmr640489885a.0.1782995480434; 
 Thu, 02 Jul 2026 05:31:20 -0700 (PDT)
Received: from
 runnervmmklqx.zlxcakwy2jjudj4ucvtnllunvd.bx.internal.cloudapp.net
 ([74.235.151.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e80009552sm203176185a.11.2026.07.02.05.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:31:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu,  2 Jul 2026 12:31:18 +0000
Message-ID: <20260702123118.3964-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260404134815.1638618-1-pavrampu@linux.ibm.com>
References: <20260404134815.1638618-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs v3
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

On Sat, Apr 4 2026, Pavithra wrote:
> hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs v3

The subject ends with "v3". Is that a patch revision marker that did
not get stripped before committing? If it refers to something like a
libhugetlbfs variant, please rephrase the subject to make that clear.

> +/*
> + * Test ptrace write to hugepage memory.
> + *
> + * This test verifies that ptrace POKEDATA and PEEKDATA work correctly
> + * on hugepage-backed memory regions. A child process maps a hugepage,
> + * and the parent uses ptrace to write and read data from the child's
> + * hugepage memory, ensuring that ptrace operations function properly
> + * with hugepage mappings.
> + */

The description block must open with "/*\" (backslash after the star)
so it is recognized as RST and rendered in the LTP test catalog.

Also, .needs_root = 1 is set but the block does not explain why root
is required. Ground Rule 4 requires documenting the reason here (e.g.,
ptrace(PTRACE_ATTACH) requires CAP_SYS_PTRACE when ptrace_scope > 1,
or the hugetlbfs mount operations need root).

> +	SAFE_PTRACE(PTRACE_KILL, cpid, NULL, NULL);
> +	SAFE_WAITPID(cpid, &status, 0);

PTRACE_KILL is deprecated. From ptrace(2): "This operation is
deprecated; do not use it!" The recommended replacement is to deliver
SIGKILL directly via kill(cpid, SIGKILL) and then wait for it.

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
