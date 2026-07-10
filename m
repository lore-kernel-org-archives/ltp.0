Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6999FC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 04:56:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EE3A3E1F82
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 06:56:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D2443E1F82
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 06:56:15 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 20EDC2000FE
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 06:56:15 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-7e9fdad388fso129926a34.0
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 21:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783659374; x=1784264174; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4taBXb+g575F4lEUjlmdhllrOY22MEi3Kq8rsoe1dGc=;
 b=LIuS96TcAyhnzCWuKMv86SR8C4Qgr7osdLsB8TWJzOxpxFA+gKuvB5xj8FFHWKr3HC
 jSgAAfheQISVCmSvs9EgFJgVcRvJA+OEA+F1DMh+GKjpIzmBlsNggOgUX1u3AV+mQlGT
 U17XMLm0W53R0vSn35TS8pcPXUwKHEDD15Y6CJs6PlKIsFjZA5EMdU9HMB1Wsyk/J1Tc
 KbvYPh4gmyeUIiQsro7/ZeMVmNtOwcXCYhhnCUr/hobE4jv7lD9YxokOh4m34sqWvZDi
 fNc4sFRK5TikZQqdfIIpbgu/KLp5XFPH4cM2vzlHx2XPJcPQE9js++f1pVLjxj5vv+bP
 5W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783659374; x=1784264174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4taBXb+g575F4lEUjlmdhllrOY22MEi3Kq8rsoe1dGc=;
 b=QVpGE/9gycK33QgwggM9GrcYV/WlGMNjAYqb+ZpUte01nEfHN+uH8DKFxDfb2LcQvf
 0dk9K7RjfXrIAvwgJu1feCw+uO9rak/DXkJDWUPgrWJnOFoJLzUYZcRAGJu5VWBuEs4a
 S+/ET79ah3JTD9evn7ct7HF+npmDkRP0Na0pDAN8YCS5T1fDKGuiILARFcFVDgBEv7IG
 YO5ziAIplPuaulzlKdaputCVCjvLadXzIIU56tqGKLZzlruqjGoGaj6VbAl+1At8ow+B
 0R1K5rkuCXxpw29cfeDyn5YQmVZgz8io6JvSRoOBsFSdS9YgAyazR1r81FbtqQrA3uvb
 P4Nw==
X-Gm-Message-State: AOJu0YwVMlZEIyjKT+MkA3PSl1XcCbuI//ZLVfOXX++865OgdpMHFEmP
 N9CRLkimeFTJkQQ1miVfsvmPDeWOJl1YbB40HSYC9EImbwynTybL3/9N
X-Gm-Gg: AfdE7cmrC/IBsU0c3K7UzkM08MkONrd8u2kPIZknbqhHoMbnJCSW8No18cd7VwOh51s
 nyotLHHcSrQ3CVPJQWtWqEC5bp9V3Tbu8HYUec6xmSZViGucaIup0N5SUS+LZJmchMsOAlZEbxj
 OOjw7mmvepO9NOih2S3OcUvdsgB6YXx/oMP8sCS6ijAXnoqUSbLOCiKt49KDzadIMOxfXNa2xst
 Q45czO5tCFxOf6IKK1kLgXkPQswpLszPF0KWMra8shydGH0cc7O9lctdcqNtsiYHV/7pHJJ1/Oq
 6Oo40JWZufl8+2prm1QjcnqLkpPiZ6KHX2RROPZ11rLwC5T+LpIbk/hajPHYBXnjXDOtDjlkk36
 pp1q50q48LDh6qjjALErKRI5IdLg26I9mUi3T3IpiWMHUDsSem668by4GIh/EFinUqeOpNJWrr0
 Ebu6SeTbQET6MpAJ9XN/oOqsS7FsyCujlVSag+X755+ERsy5u4prLb+3l7EiLuI70Affs9ZGkhE
 x9eX24HnbnGtbSmiJB3tfzm8BMt
X-Received: by 2002:a05:6830:919:b0:7e9:ea18:d1e3 with SMTP id
 46e09a7af769-7ebcffcc1c3mr7100047a34.29.1783659373620; 
 Thu, 09 Jul 2026 21:56:13 -0700 (PDT)
Received: from
 runnervm5mmn9.a3fpuwuwyzsu5cpgkdqmkc4l3g.gx.internal.cloudapp.net
 ([40.78.174.130]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2bd6c4sm5450482a34.23.2026.07.09.21.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 21:56:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri, 10 Jul 2026 04:56:12 +0000
Message-ID: <20260710045612.3831-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710021502.1798161-1-wakel@google.com>
References: <20260710021502.1798161-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp: syscalls/madvise09: Reset cgroup memory limits
 before test retries
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

On Fri, 10 Jul 2026 02:15:02 +0000, Wake Liu wrote:
> ltp: syscalls/madvise09: Reset cgroup memory limits before test retries

> ### Background
> When executing `madvise09`, the test intermittently fails with:
>
> ```
> madvise09.c:163: TFAIL: MADV_FREE pages were freed immediately
> ...
> madvise09.c:116: TINFO: 0x7476845000 unexpected   (0) at 1 expected 'a'
> madvise09.c:232: TFAIL: Found 2 corrupted page(s)
> ```

The Signed-off-by: tag is missing from the commit message. It is
mandatory and must appear at the end of the body.

The commit body shows the failure symptoms but does not explain the
root cause. The code comment explains it well (cgroup memory.max
persists at MEM_LIMIT after a retry, so the new child inherits a
constrained limit before it can even touch the madvised pages). That
root cause belongs in the commit message body, not only in the source
comment.

> +	if (SAFE_CG_HAS(tst_cg, "memory.max"))
> +		SAFE_CG_PRINT(tst_cg, "memory.max", "max");

> 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);

There is an inconsistency here. The reset is guarded by
SAFE_CG_HAS(tst_cg, "memory.max"), but the subsequent write to the
same file (a few lines later) is unconditional. If memory.max can be
absent, the unconditional write would abort. If it is always present
when the memory controller is available (as the unconditional write
assumes), the guard is dead code and misleading.

setup() uses SAFE_CG_HAS only for memory.swap.max, because swap
accounting is optional. memory.max is mandatory with the memory
controller. Dropping the SAFE_CG_HAS guard from the new code would
be consistent with the rest of the file.

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
