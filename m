Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C7DC5AD4E
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 17:33:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80D1E3C7F67
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 19:33:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 978823C2006
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 19:33:26 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 44F52140004C
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 19:33:26 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2cf02ecb572so11766445ad.1
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786296804; x=1786901604; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=agXRbbJseF8GPIIwRutzLrTF22uioPp8OQ6Qwg7cmhI=;
 b=ocoS6E2nnmbJH/pgPoakfKCjDngQzuqSGo7uCafljMn3Zrupue++iYsWh95rFn6Mqr
 3TbYrDVmPEPPTDFG5l39qjTxamirUP80L0iBY4fGlecZ/fPy4ZgcMO+6EunCfueg4MBP
 052R0W36yIxVxh44vmsjKyxefePJCgR+URUh+6iOZrWjTi0cfWMRBZz+74HteHWrTo3g
 Pox2z9rDT8tNzeB/HkQm/idNxAB2vN5EZl+FMKSHUjAT++aXUUjnwBv6O+7pWOAw5fIQ
 rSPm8865YiQte7U/IXoyHEybG7uqr7K7m+5LVXxSnbf6qFcBPSuP2sF1nRbjWvdhM3H/
 SVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786296804; x=1786901604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=agXRbbJseF8GPIIwRutzLrTF22uioPp8OQ6Qwg7cmhI=;
 b=lVXVj/NGpxj/jmVFXMYGI/VMeT0wiS9hQYwjWR637N7p167RWeZvAnjZco+NFYmqM0
 pDyEVMzOBadXQbWDfqjJOFpy9FUv6FxdyOCnSDbtIFDYBTeA19lNYXi4y+GeDAJaTUAy
 ocjBc7Lm//Q5V+P/KXhO8lTVjXjtGAys2xjHM/+yk71j6QAzpwnNSUZ6jTpD/MlI0BbZ
 2+NXO20Pjc1uovmkwxlID0/nI9+Z4GZuyj5o8ujNqp3Ib6rAZfeRGNmD4we22zboN0T7
 FhN2yqWD31w62ntNrJ+z5VmQO7kfRPYSxvob3khv5zUm6ra+OceHWH3joPQhrGhjE85x
 t4eA==
X-Gm-Message-State: AOJu0Yz/Ix6H56wS0XN8aHocMwHZcXnQ09Xu1rcYStFBWyShqCyhIIiz
 vwTsm79MVZthOqtFwuYX14mVZOZ22SA+XiMvC4+nqlBKNO0rNlaOF8Vt
X-Gm-Gg: AR+sD12nU2JUshy83JhLiqc6eU734CZ1l66H/tZFV0W18mSLgFBXhmhqDiPl2neTM5T
 2VOJzkbNOU+YC+T6U1OTUCNgJXPM2zevkfGHhQphRGyS1wr2MDuYwv19l3WHPlmXnGmePVTKv4z
 Tr9YaXv7v921Pcu8Y8+qnAUUGHFnjftznPrCYQL4Wu5hTA2DTUTKvf3VR5ADSYlcV+R5wUmpv8c
 KI3neD2iXmmovYK3Ck3wDMBlIoYqJhsyWEluFQ7nrnHn8WKLV7zvVceofc1XEWruRfUmVHWL/kp
 FnZ3Eyd3XCz7ixZ4rUS2nu3RgT+fzKXCapSU9OQ4Dm4GEX/VFQ1xq8nFBK1CXdEbv3XQ0JtBf4T
 0YsqwbvjocyzNg57Ouwifm/OTweufqdGKmP2YpMty4DyZQSs994IobUGWN2peZmHhLUVQ5fMHoe
 xGq5fWSUiiDzs/d3ZjDoSMlelL0IEdvAe+dmqSxZ84l5lcgBVtibIEB+hGr5j0LHCbIJzqUwhzD
 CA79/eU5v8kixHFMdJ/KmV25lD9dChL/zSfchMeRqkHWLpBWRl27ZllIvJR7RMm+jQ7mRhoshf1
 sye58gDrAw==
X-Received: by 2002:a17:902:e84b:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d0ca7b5490mr386649845ad.3.1786296804411; 
 Sun, 09 Aug 2026 10:33:24 -0700 (PDT)
Received: from
 runnervmvrwv9.brc24qr1dk5uhh5gza5i2uw0yg.xx.internal.cloudapp.net
 ([4.154.27.68]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d16c5104bfsm25531255ad.84.2026.08.09.10.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 10:33:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  9 Aug 2026 17:33:21 +0000
Message-ID: <20260809173321.8905-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809171646.1832676-1-pavrampu@linux.ibm.com>
References: <20260809171646.1832676-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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

On Sun, 9 Aug 2026, Pavithra wrote:
> hugemmap/hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

> +	tst_res(TINFO, "Poking at %p...", p);
> +	SAFE_PTRACE(PTRACE_POKEDATA, pid, p, (void *)CONST);

Could this call use TEST() or a suitable TST_EXP_* check and report failure
as TFAIL? PTRACE_POKEDATA is an operation under test, but SAFE_PTRACE()
converts a kernel regression here into TBROK.

> +/hugetlb/hugemmap/hugemmap41

Could this entry instead be added as /hugemmap41 in
testcases/kernel/mem/hugetlb/hugemmap/.gitignore? LTP keeps generated test
binary entries in the leaf test directory so they move or disappear with
that directory.

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
