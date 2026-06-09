Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0AECD8C92
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46DD23E6EFE
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:43:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDA453C1C6B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:42:56 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B84311400B89
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:42:55 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso5477842a91.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781008974; x=1781613774; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KBUnHNeCZs/AzewUvEQ0GPxezF4yIncCvO/N7QbJRk=;
 b=R2qcmB67/ck6jZTgrt2fhTByUzSEM8qa6g/A5FHE0Q49RZXA2jOhPeuN24aJqA08ea
 IAuzYkoeB9pXwqOabi6HmBgAFMqTiV8zSLYKjJmYrlZa27oEl0g4M+tUpMQoLDYPmeT9
 jW9LHzPa/+zcDZ35UHNN/Uup7OTMe8UAQdaade7U9BjxczK2MPAnT0ZCb65cu48STV0E
 0Eaet/yO6UrjJrvT+50TUgM5s9dGHAVPSJiN05F5GbzLVvDfNUDEZvCxIkN4VtRxbNc8
 ZlytUlGP0rXiBWi8fFnzN4ojJ26rr0VS4n5cxKiB+G+zERkTCxc3urilNeEpyqhTRHQW
 KgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008974; x=1781613774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KBUnHNeCZs/AzewUvEQ0GPxezF4yIncCvO/N7QbJRk=;
 b=EppqRDdY2THvm1g5eOvF+sDRgC20QtkotDlECrHivIsx+oEbH0DsJJX+pWTgSlla29
 tTPiCu0qYyd3q8XCAj8eQmEYEL9zFYe3CUyovHAJuPY6LPqop5+AxOfm4YPkjt4hM/Uz
 IaujSj+k3VYnv+zruebRNXICBB8csBB0NxhnX0xRtKDXiRQ3ekShw7/KUeEn9Mz8Obb4
 Va7pf0dY3hNqUtFpYw2ElUxxl4kLk2z3ciOim/KQppgojyXUR+AKDlIIN+ZNqV01C7dA
 BshUHBW8xoRs4iTJ+PGcnR2wflIuW6GiE46aq5jih0CMo4FblriG6R+MZkjXCwBHaXPF
 OyZg==
X-Gm-Message-State: AOJu0YxuhJhKKqcWoTGgz0qXqj0A7bIERsqmKDK32SWj58HMBZSij5sL
 yvxnAgOilc3dYH5Im7K8lqwHYECm0dkIdbvQBIrF6hPEKfTlXAHwRHXz
X-Gm-Gg: Acq92OGxKCySGVFCgBkLQ828xJ7XdV9Vp8W6Lj7jas4U2E+a/G3dFbN0MBFX0jVq9UN
 KDCSGBHm2mraFKMVnfcMVJUFmhVmCa+GY0/2hhu4Upmf02Zle54EtaAtiLLcU1T1YE64uO/OhqT
 v0AM35oN9aRNvQzYetMjHQA6U0iVgZpaTXnvgM7+YJ1u/8rNj3CFGJti+rkfWI3ITS0DfBVU+ye
 vsyNplGeTaUV6OMZpTnwj3UzGr7mDxdlilQwqieXX7khksNfchY7LUQBLXKJV5DcpZay4p0i0Gs
 UzP0Umi9lEGAjoYY4QEaZilZnuuA568B+oBrpPshQNKqY0fLyWXKaPQHomYnUuzWsGWXz48rrox
 HRJsONueTMxdRMTZOVF8UaHd8bERZxOaA3SFy0qW2Y7Dt4oiPPfJPaNTgb5tCSS3UY/o/fF8Oun
 0Q+g+11qA57lTnEUSyYz2Ob7lx8vjdt5KtG2OKsPy1fYERIpAc4IYi55TX3EGKc0xoMyf+KvEXr
 Wq01id/lbxLy+c/1f12dgHVClaejezVr1wa8Bjd2NbW/XfJCjTLqDEcNKY=
X-Received: by 2002:a17:903:291:b0:2c0:c940:dc32 with SMTP id
 d9443c01a7336-2c1e821dde8mr239527025ad.16.1781008974064; 
 Tue, 09 Jun 2026 05:42:54 -0700 (PDT)
Received: from
 runnervm3jyl0.bo5t1dxqcrwu5gfyvsnzvi4j2h.xx.internal.cloudapp.net
 ([52.233.87.85]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6ce98sm195153895ad.10.2026.06.09.05.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:42:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue,  9 Jun 2026 12:42:52 +0000
Message-ID: <20260609124252.4112-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609121840.61087-2-piotr.kubaj@intel.com>
References: <20260609121840.61087-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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

On Tue, Jun 9 2026, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test

> +#include "tst_test.h"
> +#include "tst_safe_prw.h"
> +#include "lapi/cpuid.h"

lapi/cpuid.h contains #error on non-x86 architectures and
__cpuid_count uses x86 inline assembly, so this file will not
compile on ARM, s390x, etc.

Ground rule 6 requires architecture-specific tests to still compile
everywhere. The existing ptrace07.c shows the correct pattern:
wrap the entire file body in
#if defined(__i386__) || defined(__x86_64__) with a
TST_TEST_TCONF("test requires x86") in the #else branch.

> +	for (int i = 0; i < nproc; i++)
> +		tst_res(TINFO, "cpu%d: %s", i, mismatch[i] ? "MISMATCH" : "OK");

Offline CPUs are skipped during the comparison loop but the
summary still prints "OK" for them (mismatch[i] is zero from
memset). This is misleading -- "OK" implies the values matched
when no check was performed. Consider skipping offline CPUs here
too, or printing "OFFLINE" instead.

> +/*\
> + * Verify for all online logical CPUs that their highest performance value are
> + * the same for HWP Capability MSR 0x771 and CPPC sysfs file.

The test sets .needs_root = 1 but the doc comment does not explain
why root is required. Per the LTP guidelines, the reason should be
stated (reading /dev/cpu/N/msr needs CAP_SYS_RAWIO / root).

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
