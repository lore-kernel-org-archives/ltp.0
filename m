Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD50CD8C8C
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 15:26:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D38CC3CE107
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 17:26:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6A3F3CDE59
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 17:26:08 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E686200763
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 17:26:08 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso2880780eec.0
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780759566; x=1781364366; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwomKgjjOJxJIsmlLqkRjSzEMuGKX7gW/QmYOpEhL+8=;
 b=j5hbfPBGpnXBZHRDgVRV08MX4UIoLCLtlbt/iEfctmzoDX0mdH7jma0kpzyStePvGj
 WrdHTE2Vtg4ZGFUr3sNLv7GQf5PBGja4SW54f1Y+I8JpVBM0kkgLq7dLod0Y72+acg9y
 7TBg3Nl71PeoPSYb0Wy+jB+BYWvz6js0w9whZPq4iP6wnDcsC1YOKpLcINv4pmEUuI6F
 s9xHoZSIPWujz8B3KyFCRrBImWaAvjOK/eq0yx6W001Kj9eFVrZX9DHNVxeoeT5Swb8x
 RpnWsdn+b1leNlbDatjkuY0+EoQFUfs+OCvStEn3hPMcwPU/xSnghFhe0t8owZSel+Ws
 0Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780759566; x=1781364366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwomKgjjOJxJIsmlLqkRjSzEMuGKX7gW/QmYOpEhL+8=;
 b=snAhNrYSupFvs5ijZdyVRzp7A880+XAqDjKt7TJcjWr2AzsZQWV9QoHBLhoZsT0eal
 kMHPR2qZ8NTVn7nC86UKWrFJX4HN6k3rNSvVri3Oq7YeJIU6abK1ep3vupo/bf1MNaGn
 pwzGea0HZl0JJ0332pDkE7kGHHzeBn2pT+SHNMo8dWHPe6Kdp/Wt6a8JM6LU3KrFion0
 NkG1JQcD50Vtt7vaxnQKjOyELP/DOF3GuTWu1jmR3aTRmjbzfem6L6JfEp7S+RKD9uws
 XV0NE6ZXw2EZw/8qTRAIYB+PZM6qgPYMm18k+F3v9IhF8wBLjnbAqNsNGRJ+M8tav2JQ
 +Zig==
X-Gm-Message-State: AOJu0YwI0P8ffDXTjaOREHnHrdKItny+mUaolhODTl3NRkaQK5McJOAH
 0gaG3ZRYxTzaxPa90kMJuc+SVAZsG9ugff9VDSnGe2cMRYwKLtPcay68
X-Gm-Gg: Acq92OHEYmxOk/w2eZzONsEb34x8TKIY3U2fmoGUQSlgFkCr4IKomJzF8cH0nS7VniT
 nNUCmrdd+Ir+J0eBdr5dQvBEOu+gCRqrvViKKFsaILGH+q1TB9VOulcHosP4olg1bDjWcyILfcb
 JObHJwJTWHboYeFZfexYqfUMxaC19r4CaKiBjhN8SntJaB1riKZatRkbbqYQbWPJsFgNfDRb+TS
 8bneL6i+FZFPasqQsaqXaazejR/aPTtET5v4mevEWeblWa04OVkerTIPO6ev8oT1Qaz/xk3OSNC
 3vTDVET5qpP5MGXb/Oso8a9NCOCZ5nUQjPQgnM3XY5DbC9vRUY2mjr2fJiBHy4TN2eiNI+sYAyh
 f4wJPHdoI78mEHW90osuOtyheK1PRoFzeNr4OZsjLtsfJVjndIqdPYz7I3tc+ECItYnIVYOzOh4
 VmnuJVLDe7rPVHxM3WQbRgQ5EXZP/dRlvj0U1Fx/Ks99/kYy0RdX3P1w6YhU55X4iy3PQ1KhZOK
 N5pnGbrpvReSGVK1UFPfSZCadKY+rEgEtnIw/zKxywGwz1qRq/1
X-Received: by 2002:a05:7301:9bc5:b0:304:6139:5a3e with SMTP id
 5a478bee46e88-3077b3182cbmr5425411eec.34.1780759566205; 
 Sat, 06 Jun 2026 08:26:06 -0700 (PDT)
Received: from
 runnervm3jyl0.amrht1wn2mtenhi3jntkxrmxsb.phxx.internal.cloudapp.net
 ([20.169.77.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3078c1ac378sm3291988eec.1.2026.06.06.08.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 08:26:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Praveen K Pandey <praveen@linux.ibm.com>
Date: Sat,  6 Jun 2026 15:26:05 +0000
Message-ID: <20260606152605.4136-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606143133.89156-2-praveen@linux.ibm.com>
References: <20260606143133.89156-2-praveen@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ftrace: Add common library for C implementation
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

Hi Praveen,

On Sat, 06 Jun 2026, Praveen K Pandey wrote:
> ftrace: Add common library for C implementation

--- [PATCH 1/5] ---

> +#include "tst_safe_macros.h"
> +#include "tst_safe_stdio.h"

ftrace_lib.h does not include tst_test.h. The SAFE_* macros expand to
code that calls tst_brk_(), which is declared only in tst_test.h.
Without it, ftrace_lib.c and every test file that includes ftrace_lib.h
will fail to compile with an implicit declaration error for tst_brk_().

Add #include "tst_test.h" to ftrace_lib.h.

> +       debugfs_path = tst_tmpdir_mkpath("debugfs");

tst_tmpdir_mkpath() does not exist in LTP. A grep of the entire tree
finds no declaration or definition outside this file. This will produce
a linker error. The intended API is likely tst_get_tmpdir() combined
with a path construction step.

> +// Made with Bob

This line at the end of ftrace_lib.h looks like a leftover development
artifact. It must be removed before the patch is merged.

> +    Fixes: #1282

The Fixes: tag must reference a valid git commit hash (e.g.
"Fixes: abc1234 (tracing: ...)"). A GitHub issue number is not valid
here. The same issue applies to all four commits that carry this tag
(patches 1-4).

--- [PATCH 2/5] ---

> + * [Description]

The [Description] header in the doc comment is deprecated. Remove it
and let the description text follow the opening /*\ line directly.
See rule 18 in the coding style checklist.

> +	/* Small delay to let events trigger */
> +	usleep(10000);

This is sleep-based synchronization (waiting for kernel trace events to
land in the buffer), which violates Ground Rule 2. The correct approach
is to poll the trace file until the expected content appears, using an
exponential-backoff loop.

--- [PATCH 3/5] ---

> +	/* Small delay to ensure trace is written */
> +	usleep(100000);

Same issue as in patch 2: sleep used to synchronize with the kernel
writing trace data. Replace with polling on the trace content.

--- [PATCH 4/5] ---

> +ftrace_regression01:	ftrace_lib.o
> +ftrace_regression02:	ftrace_lib.o
> +ftrace_stress_test:	ftrace_lib.o
> +
> +LDLIBS			+= -lpthread
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

Three issues with the Makefile:

1. The shared helper object rules must appear AFTER the
   generic_leaf_target.mk include, not before. MAKE_TARGETS is not
   populated until that include is processed. Move the three
   dependency lines after the include.

2. ftrace_lib.c is in the directory so the build framework will try to
   build a standalone ftrace_lib binary. Add:

     FILTER_OUT_MAKE_TARGETS := ftrace_lib

   before the generic_leaf_target.mk include.

3. Only ftrace_stress_test.c uses pthreads. The global assignment
   links -lpthread into ftrace_regression01 and ftrace_regression02
   unnecessarily. Change to a per-target assignment:

     ftrace_stress_test: LDLIBS += -lpthread

The new C binaries (ftrace_regression01, ftrace_regression02,
ftrace_stress_test) are not added to runtest/tracing. The existing
entries still point to the .sh versions, so the new C tests are built
but never executed by the LTP runner. Update runtest/tracing to include
entries for the new binaries.

--- [PATCH 5/5] ---

The commit is missing a Signed-off-by: tag, which is mandatory.

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
