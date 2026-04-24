Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1591AFDEE5F
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 02:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABF7C3E53C0
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 04:42:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651293E1AA2
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 04:42:29 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 737D81400744
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 04:42:29 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8acb09ddbf6so102308566d6.2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776998548; x=1777603348; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2asbXm83jN1R5PqJcG4dIKq9UodeL0aCQif0Gn1ZtH4=;
 b=PY1MLCpGX7UjIKfL7TwPPVjGEa4RdBxSeyHzU+KzgZGbulkn9/oykuTkwVk3LoQjyV
 TJpu6IW2lsTwacFt1tn9D6urk/UiRl7lvX3ns5mKJJDDnanGpgFasU/EtyPQwoVXkkQK
 z+C27PF1Ih0S7sLUnQaAXENh1P2R3C3HLLgfQEN75w/Fvnt0IMqcgs6PUUGSt1tzDsdo
 gwX0OBOLgywmAJn9ljtfDZHSvU759hQCQOoezw9avDay7di/c8/rLpxTsNN4p7esfe71
 j6yrYKO4/Xgqq/AaGBZdJY9/2V0Mnvbpd04btEV1G3ILqEfuEVuI9C/Sdq61emudPYO3
 7xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998548; x=1777603348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2asbXm83jN1R5PqJcG4dIKq9UodeL0aCQif0Gn1ZtH4=;
 b=NpuDTX3uw9GoZWuowRfmJQddNoHrhnTEBI3B5XG0eGDQnyYDNOX42Fc7t6iammcp/g
 yoOiNpkNvvBA32zOWzDBzzwhtQIUjHY2YEXb2lH1hDCuxjgndd+9Q0cc8F0GAM2TXGsi
 fLtUVACg2cYSJzzcqkcrnSgDnNStHvriynnD5NxLRupWrSHZUWc47mdJyt+D/cjUk+Wg
 uzHnbFoGi2onOk9xpN9+aZOWZxdD+rxmqlKigfsz90QEg7yO+J3eKJsJQgDH5k0zP4Ma
 ygK1UzN3IVmaDtxNxK/FbAmS8O2yXcyQfxM9bWRA1jHbKEYXF4Ilr0ENZGmkFK7UzSeY
 V48Q==
X-Gm-Message-State: AOJu0YyrPQ7yQwzlKU7OhzL22dZ8VKXgRXNPVOchB4h75Tya7q8l5370
 x00YgPghdQPZJJVE99scTe6E5XAezZgGcIso4Afw7QusXE4jwtZTOfVpJbDCY/RRWXcr1Q==
X-Gm-Gg: AeBDies/bASnHB7PGotX+y9PH14lCZjaWeT+7AASGc+4VtD0OA5pl517dkeqJnG1o3z
 FKi8+r2CmcKppwCXcO7SlhjkxKOja+REMSnPDlQcKMDV7esor95EtV0oIJYDVT5deXGOmEI3mIu
 vmA0/MyAIiH4xC4uxqjc3sUIL8jNk+cBjXEyofHGIhDDshwx3Kra9t3SH5k9NpswVq+2ohPcKGH
 RPk/tBBu8Yh2OUmtQHDGRvFkoK9VKY8sK7JrhbV1Xihv1jp/rYNQweQOw32Dw0YxKWSiZERnmIx
 eShxkcrky9j+NnhJYKGjKLUum9FifYd8T7jMzun+z1FZKVBnrgXXwH5tCGjnNywevtTTkiZYymf
 8rZD9odkVbhWV2QtvXIzO87QKcANUztIMCYkKU+/ImmoeM16bEpGrqQJy/nnxfI5RmFPmspTJXz
 WFHJofZqgDDIzqnGKS7PUqKeeGfEC8vY4Obc9kSoNPvdiv6IiMrV6o+ch67XtNvuX9O9p03cmaM
 dSBGfr9l3r9HVE0tLw/hKDGafIBz1lgJrnyo575sttnfXER
X-Received: by 2002:a05:6214:2a4d:b0:89a:629:2203 with SMTP id
 6a1803df08f44-8b02806fc0cmr515550136d6.11.1776998548275; 
 Thu, 23 Apr 2026 19:42:28 -0700 (PDT)
Received: from
 runnervmeorf1.dfa5kwsimfeenovaffeki3ojdh.cx.internal.cloudapp.net
 ([48.214.55.48]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac72915sm176917556d6.15.2026.04.23.19.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:42:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: lufei <lufei@uniontech.com>
Date: Fri, 24 Apr 2026 02:42:27 +0000
Message-ID: <20260424024227.4074-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424020854.96845-1-lufei@uniontech.com>
References: <20260424020854.96845-1-lufei@uniontech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Rewrite ftrace_regression tests with new C API
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

Hi lufei,

On Fri, 24 Apr 2026, lufei wrote:
> [PATCH] Rewrite ftrace_regression tests with new C API

> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression.h
> +/* SPDX-License-Identifier: GPL-2.0-or-later

SPDX must use the single-line style: // SPDX-License-Identifier: GPL-2.0-or-later

> + create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
> + create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c

This adds two new test cases in a single commit. Please split into one
commit per test; ftrace_regression.h can go with the first.

[...]

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
