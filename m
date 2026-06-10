Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29DFCD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 13:27:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8D83E6E73
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 15:27:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1184E3E2FB8
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:27:41 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8D8310005E9
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:27:40 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso7097501eec.0
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781098059; x=1781702859; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/Ai9UHgwzPJjH41cH3aYX4p2LIIr1GwezNEpMRNuEE=;
 b=mQa46AC+E8tIFl78jzGOSLuxwNbOBzg/KcLf+ZSB4DiCM1LfUjDoyyb5eDBN7U37Te
 H6NFMKZqjH3w7bubr8aL86oUCNdchyt4+KWsE9Vkt2maZ5kHKPasthTacfoZq83Y+Gb1
 X9qzWaBVLpWZx65AJTaQddx62VYadcTqUza+KdAELnA0nx6pA63mgYqbzd37b7OAZYtk
 hR3GuFDdl4sZcb34wTxbFvGL44Hudt66Ea4+APG9PNYIiFLxnf05fjLCwI+u+ahrM6mA
 6VFLH6/CCf3hDAB/E5gdmbDh8tJQWiZh+88XFq5eJgpkrT7nUc8PlxZOpukNhbAYwOqn
 Rs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098059; x=1781702859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P/Ai9UHgwzPJjH41cH3aYX4p2LIIr1GwezNEpMRNuEE=;
 b=qpqvdPUbGXljH4mFp4GFJkmJ096hpIeSvW2OhC6RMSAdrfU1jigvake5qgTUD73k+Y
 Vms8i0En6JX78xspNrVWKADqPzwHL5l8ug+dpZhQAAQA0+mai2JdBYnr8UaQIuCimwL7
 DGMHtax3lNepa+6HgNAzTgCUkJJQWv77ePKJ4vK3hFK3ZGUrwCRL5de2sk0JQWR//+X1
 TOUyfc7vkdoO2n2zeknDLmKZSK6WJfrUStVTostFJ5dyPgDcml1PaAOnjujs7HgznEUC
 4WY9ay/Ag7Fub1Kb52mK2mtDhLnI2DHhOdwW1fbFIIQ5WvZqzjOVZq+LkcbFVxExQGs3
 aUFg==
X-Gm-Message-State: AOJu0YyMXtA3DMoJGLBMF+cBOh1MVNohdUtt13ZRg4mYaGa+ZFpBl8GI
 g3RMCUpgTGnzmgDWyXVh3uTgUlL0CgZzGGEBNlm3v4fWMhkjHAciE0cu
X-Gm-Gg: Acq92OF9+hDdIGR7yUulJrEveqvBGKghe+PIfC9oQOpBH5jQQpiok7aA6KWvg1pcYGS
 FYlInf1MfIEr4lE+hsnX+AxKUlhyyhHz1ROJGkBYnuZhzinyG72PtiYyI6iS/MmcYgXhbBSu7sg
 H6iEOfSWcv/WCBdfmJRdBhR01tzB7ag9iUOXX9pbY+wSyQshGIjJk2fN/+mTKhXP+zx+R6HSkKQ
 hkYncmqfJ+qimdcNwgcezcvsvGwJ8PDQNj5Jeu5lPFyWjzZqiNm10UVYTYKO13Lz8BUCHIia6TM
 RnNgD7/I5Q/Q3dko9tcXp0XS0G1dPbeqiNiKYHdky53CFOrJcoPoeGyBHyNdnq7NNxXdr54cszW
 Baosi9CFz7we3U7khfVdGT0jebEFzEH0Wd56/jqe7GEdQTlRPUZHd4leUEVa1oJCZlbGEJY1vuZ
 iPVYg9UhhfZC4FwBAsf9eoRKyBTok6/K6LRZSBTFelwY/+2VZ0IQ56ult8bjXqGz/+xmXp2k83p
 ZbOc9P7Pl5ubRCplvhfLYNRyP5Do8eLyDNnOufybVM++1JlEEJ4
X-Received: by 2002:a05:7300:320c:b0:304:e7c9:b528 with SMTP id
 5a478bee46e88-3077b2f4881mr14275971eec.30.1781098058754; 
 Wed, 10 Jun 2026 06:27:38 -0700 (PDT)
Received: from
 runnervm1li68.cytx1rmnaezejprhhcequco1ad.yx.internal.cloudapp.net
 ([172.215.212.101]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30791f9da69sm17935658eec.31.2026.06.10.06.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:27:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed, 10 Jun 2026 13:27:36 +0000
Message-ID: <20260610132737.4073-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610111808.110308-3-piotr.kubaj@intel.com>
References: <20260610111808.110308-3-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test for testing
 acpi_cppc/highest_perf
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

Hi Piotr,

On Wed, 10 Jun 2026 13:18:10 +0200, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test for testing acpi_cppc/highest_perf

> +static void run(void)
> +{
> +	bool status = true;
> +	char path[PATH_MAX];
> +
> +	for (int i = 0; i < nproc; i++) {

The static `mismatch` array is zeroed once by SAFE_CALLOC in setup(),
but run() only ever sets elements to 1 and never resets them. When the
test is invoked with `-i N`, stale entries from a previous iteration
survive into the next one.

For example, if CPU 2 mismatches on iteration 1 but matches on
iteration 2, the summary loop still prints "cpu2: MISMATCH" while the
verdict says TPASS. Adding a memset at the top of run() would fix it:

    memset(mismatch, 0, nproc * sizeof(int));

> +		if (msr_highest_perf != sysfs_highest_perf) {
> +			tst_res(TINFO, "cpu%d: sysfs=%llu MSR=%llu",
> +				i, sysfs_highest_perf, msr_highest_perf);
> +			mismatch[i] = 1;
> +			status = false;
> +		}

Per-CPU mismatches are reported with TINFO and the actual TFAIL is
deferred to the end of run() via the `status` flag. LTP convention is
to report results directly where they are determined. Could the
mismatch be reported as TFAIL inline (dropping the `status` flag and
the `mismatch` array), with TPASS emitted at the end only when no
mismatch was found?

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
