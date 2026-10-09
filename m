Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F74CA6019
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 10:12:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C4863E6AD2
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 12:12:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61C963E4C0B
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 12:12:31 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0BABC2001A7
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 12:12:31 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-93e5da88874so14002385a.1
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791540750; x=1792145550; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJ8JCDNuZ6gxrtuL+1OkfSNpycLPXIAYri+dsSOuwZ0=;
 b=mrCNOY52SehwQa5LSGFb+I0byrzEGGjrj77BTn1iuh1Kw5KJ1dX2hO6ayAAv5LTeDg
 HYoLpQgD4LkCuvXIyhr4bjuu7HZFg64Z7hhOfJekO7vbhEkA8lSOAIO3RA6Nki7GU6ne
 gbyWCG+J2mnFuOuRER7YFoYz2rHgiJsteGBfh3zgBhCLxFn5p7NqBIPQlXj7rDJ6IIY6
 M9APAiCxuJbiW116I/1mx1Vd65utbrpgaF2iOVQAHsGmYEPOZbMpErqoC5EGDSWVWwUn
 6+xXDU1SFMKExbDm3npH07xEYbgV+3TjDT38Oz3Y2V3umc+QwYmaS73jjI8oD6n6g8jv
 CkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540750; x=1792145550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJ8JCDNuZ6gxrtuL+1OkfSNpycLPXIAYri+dsSOuwZ0=;
 b=uXbGhOlDxPn7QqGs8YTKODSSS97kO5INOu2qdwB+vNdD7xwnXhmY3b6tvILJ1+F6tS
 OEyTAUs0gNzImS0eDdMeg58UYm0ZS4S9TQsQLD8BUCcFjSidFtN6D0T1V0lPZrY2XNTP
 vkxhr/rSaFlG6+jk4Bq5gjC4Se41V6kMlaguOmHo6801mR1ecAyU/KEvxcUCZ3Y7ZTVO
 K24eY28ArGe0U1KGZdCg4slvPmtQcmKKrCELHVDs2Z4Yg5YoOFkr36kvJ4DNu7l9mXct
 BDx16UiloBFXsR07T1ztetV1PDMhkFZLMaZ0zkW5o41Z5bMLV++M+6l5aRMSpmNygket
 5qFw==
X-Gm-Message-State: AFuF++keUiA0SK3terf/PiLLngGfFvST2M7pKfzZ2y90ImBHgVSoK6JD
 zPTEe8xlzbNN7BZHFvvUA2T5YHu7bto3vZjntYhJ1jXS9zpn3IL9Diax
X-Gm-Gg: AYBFou33+cq58aMfcMJbtOXfKgcJ0xevnyLM3BQePAULbKXMaYof4PqnEc+GuWCAb1u
 kqBI4YSQXWx0cFzTijSLFmGsBV/Dhhryk29X5a2LknzhMzCc4VxDSJdK6mrgPZuTG1WibfvGhu9
 h1pILcAYgrOzKzFvOhgwuRlo9SfL71kVnbnsd0VGg4T9B29qoYM/+ECvnPY1oQRVLLDn+txTn3F
 Nefya6T+RaZ/HQ8Lv5FMumhVdwOkVW+TqQOuwcRtj6/IHgVowGNB4sdZjslWBsSoiT5xCAZBqbU
 Wll9xqxeHOgCeg0SH4x1Eazipc9rBOJOL0Rwf7w1hPXKaj+Y5mFgsMSjvnS9FzlO+t+KUktHXqA
 nb24EiuROS2wYCLI6JYvlw5CYFYEWcJDJkhCLStXXmV4q8eQ3hmjK34v+o+MqTj9suY5ul9BpBa
 63TF5zAHwCBgJTE9bY5Y50MzbPBy1xnYKj6qtf4cW8DY/yfxnd9UDUSsWEAbn17nyMgnT+8yGln
 T3ow6ZQKwYBjvdpVsFi6nFW18o2r5nbSq3k9G/DywxCvJgopO7lh1N+75KMV3r3EVes6Sl72zFl
 Zji04V5Pc95qKNyY2d29
X-Received: by 2002:a05:620a:6602:b0:93e:c12c:fbc7 with SMTP id
 af79cd13be357-93ec12d100cmr90576185a.67.1791540749443; 
 Fri, 09 Oct 2026 03:12:29 -0700 (PDT)
Received: from
 runnervmmprz5.d3uhv5dcqpzuppv0dnbf21ujch.bx.internal.cloudapp.net
 ([40.76.106.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98861bdsm149971785a.24.2026.10.09.03.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 03:12:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Fri,  9 Oct 2026 10:12:28 +0000
Message-ID: <20261009101228.9426-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008194725.1198-1-dm.chestnykh@gmail.com>
References: <20261008194725.1198-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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

Hi Dmitry,

On Thu, 8 Oct 2026, Dmitry Chestnykh wrote:
> arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests

> +CFLAGS += -mfsgsbase

This directory-wide x86 option breaks supported non-x86 builds, including
the existing arch_prctl01 target; AArch64 clang rejects it. Remove the
option: the new test's inline assembly compiles without it on x86_64.

> +	asm volatile("rdfsbase %0" : "=r"(__res));         \
> +	asm volatile("rdgsbase %0" : "=r"(__res));         \
> +	.supported_archs = (const char *const []){"x86_64", NULL}

Removing the compiler option alone is insufficient: the unconditional
assembly still fails on AArch64, and lapi/arch_prctl.h supplies no
ARCH_GET_FS/ARCH_GET_GS definitions on non-x86 targets. The supported_archs
check runs only after compilation; provide a buildable unsupported-feature
path or filter the target appropriately in the Makefile.

> +#if defined(__has_include) && __has_include(<asm/hwcap2.h>)

GCC 4.8.5, a supported compiler, cannot parse this expression: the left
operand does not protect an undefined function-like preprocessing operator.
The repository's sparse check also rejects this line. Use separately nested
checks or configured optional-header inclusion.

> +#include <asm/hwcap2.h>
> +#else
> +#warning "Cannot obtain HWCAP2_FSGSBASE from system headers"
> +#define HWCAP2_FSGSBASE (1UL << 1)

An existing older header bypasses the fallback even when it lacks this bit:
compilation against Linux 5.4's hwcap2.h fails with HWCAP2_FSGSBASE
undeclared.
Apply the fallback after optional header inclusion, independently of header
availability, and put the compatibility definition in include/lapi.

> +/arch_prctl02

The new binary has no entry in any runtest file, so normal syscall-suite
runs never execute it. Add "arch_prctl02 arch_prctl02" to runtest/syscalls.

> +	TEST(arch_prctl_get(ARCH_GET_FS, &fs_prctl));
> +	if (TST_RET == 0 && fs_prctl == fs)
> +		tst_res(TPASS, "get fs succeed");
> +	else
> +		tst_res(TFAIL, "got wrong fs register value");

These messages discard errno and the expected/actual bases, and report a
syscall failure as a register mismatch. Use TST_EXP_PASS_SILENT(), then
TST_EXP_EQ_LU() only when TST_PASS is true; apply the same change to GS.

> + * Author: Dmitry Chestnykh <dm.chestnykh@gmail.com>

Add the required copyright line with year and author, for example
"Copyright (c) 2026 Dmitry Chestnykh <dm.chestnykh@gmail.com>".

> + * Simple test on arch_prctl to get FS_BASE and GS_BASE

Use the required manpage role and describe the comparison, for example:
"Check that :manpage:`arch_prctl(2)` with ``ARCH_GET_FS`` and ``ARCH_GET_GS``
returns bases matching ``rdfsbase`` and ``rdgsbase``."

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
