Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FF1C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:33:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2B4E3E90C1
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 19:33:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A45973E2D22
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:33:36 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 84BB1600A23
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:33:35 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38de693676dso883314a91.0
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785951214; x=1786556014; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S0BRheoUuJg7lcP2pVUg2m3ISoBCurfYwBgzZOcDkuQ=;
 b=T5YRLhOWozJAY5zV68W0t/V3OuWJSBXKb6eMn3kqJo02QiocBv6q20YtFaWw0KU8pA
 4Zlcikls7LnD5PpI/WwrL1GlXRMVV6bmgbrSqBN5GDuoooW1PZuw0sLOJhBIGiJ7rA3T
 L0VojYxBo1RL2Img+IbkmWnOVlzQN5F8wVWxPhHZsxaMSJPPo6hMg0qGcMHFYnZ1pEV0
 n3TvLc4Ejhc4UpM6GPnJo+K/LnOlgl8ZLeuc1oq3Sfb/ygGP+q5crClCSfuVV8rBOytN
 zEkyykD4guZ3ZIpsg1sdVC7JNDQ+yoZV3oFGCl93pd+bcIQWaVJ4yzo4+fpEVflOgO7L
 2VhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785951214; x=1786556014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S0BRheoUuJg7lcP2pVUg2m3ISoBCurfYwBgzZOcDkuQ=;
 b=lAp82V/P6EH2DYVfv1F/wBOCWvk/eY+tHttG0Kt99meM8xuGQvYSwP5ouh4btV1vCH
 0rBuId8ZYwXc5anB+nqWeR8hRZOrd88EbAdQW6oef/IkZsY617lh6HT5xkGal7S0lcSR
 JX+D/AkWJm98ODqJv1sdL/Hx+eZhRx5C6B7sy4YT3isUa3R97m5YfFbFAaX1dCQxbSjT
 iPf3+MoyGYPeOGYX7y/tOp8c1WVaXX+SyhtSouuhTV1dzoFgdMi2F0g/rJh4z6VKUtE2
 mAENv4RnjhKXOoSpnACUECDIZzual9h3ZfmeggbudoQaKTf/RVjPPShSAGcdvpWy/uhp
 oNSw==
X-Gm-Message-State: AOJu0Yx/EC2maX+sKeY2pSxFdqeEGGtDz+eLct2UNjcTT2N1yqVpq6Gi
 w9Qa5wYIDqGobPgTBpqMGbIVZoYYY6tLvAwNkaYYqrYWCwEYTrhdSIcr
X-Gm-Gg: AR+sD12OwGYM6Ccp6S4/zF7SFrAQEVikL6jbhwjgeKUGS7OuCgJdwiRS3wxsmge/gdr
 P/SnfkTD36O8tEmeXSAhiW4IhcdbJHxknlvvO8wIGLZCqNRRr8M2uHleNKQFy5vvJyzlUvYsQ58
 4Tsn45cIJo2tRUxcpmxR0//JG0ZxiWB/h3/Mc9pSaqeT+rlN8cfVY1YTTvEiuHIsg18ma+VeRhs
 FwW9Oy/WEtf7sy6zSHW3PED6bFvuRiRZ81u8lplTxJbJYbNZu/URchUcYxJAUlbCg+FzrJBf7VB
 Nn56t/tUqNN4f+3iQdCocz7G9rd3J695AlaSrNvN0pVJxxk9yIwHgCPOIW0XvWFyB6LSOZBAALg
 6VVUkgTSMtC91nEUWTHzp7+KIR6KO65tOI5t/gkz5naFuFqDc2b18z3rEomkQvMOTDM3WUm7bni
 o9jH19LcqlnzrAKYPD/LMavJcsAbm0k7A/SJ8p2IQv8pFocjJKRBnPa6hM0Syly6rdMqeLDAsgH
 iqWrnivXlWeUOh9WgI3AU68fYh8/NKtYfH3D9gPBJVrv4/67ipOnt+OwwsjTyb+F/kMQP5SVWlf
X-Received: by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3cb85ef91f7mr11091165637.20.1785951213638; 
 Wed, 05 Aug 2026 10:33:33 -0700 (PDT)
Received: from
 runnervmvrwv9.qtkme5kclwxuvgk1gfqfrwzr2h.dx.internal.cloudapp.net
 ([68.220.56.242]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bdasm18896260eec.22.2026.08.05.10.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:33:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Aug 2026 17:33:31 +0000
Message-ID: <20260805173331.4185-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805151451.648990-2-pvorel@suse.cz>
References: <20260805151451.648990-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi Petr,

On Wed, 5 Aug 2026, Petr Vorel wrote:
> tst_kvercmp: Factor out error handling

--- [PATCH 2/9] ---

> This is a preparation for struct tst_test max_kver member in the next
> commit.

Could this explain the distinction between minimum- and maximum-version
checks without referring to the next patch? Commit messages in a series
should be self-contained.

--- [PATCH 5/9] ---

> +	.max_kver = "7.1",

Could only the FAN_REPORT_PIDFD | FAN_REPORT_TID case be adjusted or split
instead? This skips every case on Linux 7.2 and newer, including
FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME, whose expected
behavior did not change. That permanently removes its regression coverage on
newer kernels.

--- [PATCH 6/9] ---

> +	.min_kver = "4.4",
> +	.max_kver = "5.0",

How does this exercise the successful min/max path on current kernels? It
exits with TCONF on every kernel newer than 5.0, and runtest.sh accepts TCONF
as success without calling do_test(). Could the upper bound be made safely
higher than the running kernel, or otherwise deterministic?

--- [PATCH 7/9] ---

> +/**
> + * tst_kver_cmp() - Compare two kernel versions, versions passed by 3 integers.
> + *
> + * @a1: First kernel major version.
> + * @a2: First kernel minor version.
> + * @a3: First kernel patch level.
> + * @b1: Second kernel major version.
> + * @b2: Second kernel minor  version.
> + * @b3: Second kernel patch level.
> + */

Could this document the return value? Callers need to know that a negative
result means the first version is older, zero means equal, and a positive
result means newer.

> This will be heavily used in metaparse.c (speedup of metadata
> generation) in the next commit.

Could the reusable comparison need be explained without referring to the next
patch? Commit messages in a series should be self-contained.

--- [PATCH 8/9] ---

> Will be used for metadata.c in the next commit.

Could this describe the host-tool link or build-order problem solved by the
rule? The current body relies on the next patch and does not explain why host
targets need MAKE_DEPS.

--- [PATCH 9/9] ---

> +	if (min_kver && max_kver) {
> +		if (tst_kver_cmp(a1, a2, a3, b1, b2, b3) < 0) {

Could this apply the same two-component max_kver semantics as
check_max_kver()? For example, min_kver "7.1.5" and max_kver "7.1" is rejected
as 7.1.5 > 7.1.0, although the API defines max_kver "7.1" to include every
7.1.x kernel.

> +include $(top_srcdir)/include/mk/testcases.mk
>
> +metaparse: HOST_CFLAGS		+= -I$(abs_srcdir)/../include -L$(abs_builddir)/../lib
> +metaparse: HOST_LDLIBS		+= -lltp

How will this work for cross builds? metaparse is built with HOSTCC, while
testcases.mk builds libltp.a with the target CC. A host linker cannot consume
a target-architecture archive. Could the parsing and comparison code used by
metaparse be built with HOSTCC or shared without linking the target library?

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
