Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31718C27C54
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717695628; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WWZukqoKnLVmG+gnHFGj8qumhcRdepUbuUkiVqz/ZyA=;
 b=GAl8DTqvkWW5QVLbCEUt/WMSMT0LzsUKMLwmZzeVes8CBK7gYl3TYeDY5f5k4AveRgKdE
 AH6cpvXlDTCAxvQnKw1AEaaq1WFcNUidfhNBcM9IyqmLlEZanwSxzAz3Y/aA5PcFqJe/iKr
 +XKfurbmSJQypFRo4IPFEr9mzx2iVvs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EEA83D0A7C
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 19:40:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFC0E3C04BB
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:39:44 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6528F1000A25
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:39:44 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1f67f27bea9so10167635ad.0
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717695583; x=1718300383; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=B9fDIm68qSqGOlwzl3EwgvcQ21IJ9C3Nzo3+IMZK93w=;
 b=VBR3FUEib1glpI8Pk9PqjS39YYsRIMc/1tbF7XwGrZt5qSST+Xe1wT5mcunKCT86yt
 8rVjenB6USLskXWjRevrVJz92OsWsCPawgg49SggnelYvzWXRemZIN3YbBjKrY2mMPWA
 g9g7v0Bw/1cP3ATGF+tztLUQBs5qCKgupo5nOOjeR36Zlwc9DZC/Fo0a8APP3aJX7ZG+
 EDYTU7k2AO1UuJbqumggYF93jWJwUtSz9T0gA3xd6LPGtKcOUB/I/1G10MkKQ9AMxfmy
 6wKWuSFqtxPVt2iCaVdyIHo4Mq3oKQUFCFNlndGlqyZl6i8lSbGfhuhtmK95Xm8oRRwV
 ilUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717695583; x=1718300383;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9fDIm68qSqGOlwzl3EwgvcQ21IJ9C3Nzo3+IMZK93w=;
 b=bjK3QP1iFZk3WHQqoo1+yfMIWnPxhDgtrkgT/pxettE52w9p7AM8Mx2ORpAEVaLrn/
 s1rLfzNiBJJ0yjW5e0HukGP0TsCKpKLmNBxk18i/owysI6oHeMVtORNDtIcrpCxH91mD
 TvzaG6u+SGvbltmbB2+BTmRfRIhEKnRyXpvaEHt478INohVsomrS+8mpj4SDAK4e3PoS
 q3PX9LUVuPoSiNIEIgxYSf3oF7pyofTvM1LvTNJK/FAHvopg3zj0/r8hwG/vHkEzPFmR
 Z6V6goSzNxB2La8p3SCsXJkC8+Yc603dcNPPJ4fmsTNssgbZtg7gO7KB/uK9PqhiJSAd
 7TPw==
X-Gm-Message-State: AOJu0YyodnxbGVFHNt3WWcpdavr63upbhaNGCcuBWJEy+tuVunf1UKFf
 ByWjg2ELQV9Av8oc9fjihM4kfOtJayBpUbS9S1tOuI3tGtEDujmtqJwXF04JDIeMrf11orpcGVD
 ZUA4ytR2+r532rGxficJE5cSOBqWjkwQ7FDA45kEmF7NoPS/TQoGB9yupg50zfZAJOQls8MPyFs
 Ddcxj8ynVVM1DZBBWEqYarYsAW9Ug=
X-Google-Smtp-Source: AGHT+IE4RPGhsX+lhP489e5HpukkeYGq9OXEJiCwXfPeuZ0Ve9j8kQDxxbwC91gf1o8wXY9mAi9JxptxLhs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d4c2:b0:1f6:7fb5:c720 with SMTP id
 d9443c01a7336-1f6d0363313mr7105ad.8.1717695582432; Thu, 06 Jun 2024 10:39:42
 -0700 (PDT)
Date: Thu,  6 Jun 2024 17:39:31 +0000
In-Reply-To: <20240606173933.1671989-1-edliaw@google.com>
Mime-Version: 1.0
References: <20240606173933.1671989-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606173933.1671989-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] sched/starvation: Fix sched_setaffinity return
 check
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TST_EXP_POSITIVE to check the return value is incorrect because
sched_setaffinity returns 0 on success / -1 on failure.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index eb9fd6ff5..1d0d5ff97 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -54,7 +54,8 @@ static void setup(void)
 
 	CPU_SET(0, &mask);
 
-	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
+	if (!sched_setaffinity(0, sizeof(mask), &mask))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
 
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
-- 
2.45.2.505.gda0bf45e8d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
