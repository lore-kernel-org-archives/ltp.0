Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E4C55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 07:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785482171; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=wIGnTyfq5KdY4QAAYXhWruenZCeyVMeVb9ZGMjCETIU=;
 b=RJGNnttvDAIhG/wWZIm+NgIX+Zv25D/hS2EKS8RI3LF03UhP2f02lNK9ERhbpezK2CSmP
 macCvifkU6AL+ZYqHU7DHFOspBH7Jl/ezasAx1jWFlKdqC7V0HMKAyBiLqA7ch5sVn316U6
 Dq0dmUtYGlT98xCSurnzh11Wp4QGWtU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B8DA3E2D1A
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 09:16:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 979CB3E2958
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:15:50 +0200 (CEST)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AC401A00A4F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:15:50 +0200 (CEST)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-8484b9fb055so2082870b3a.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785482148; x=1786086948; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nBzV8L3eKyvIj4lLEnAaJyQ+wdhSUy44CZN5L7yvjF0=;
 b=TyEqPvZDToHQW5xPufo0jfDGhvyDXQWbyrFTZDWATUm+gwS+J60lfCer3cziXZuSP5
 fBrDx8/vaUl3AnsU3/GYD7NHtpkXmyqR8wcid3uQ0GdBICjJW5n78FGHZ0TzHUARURT/
 +oA/5eqFH+UfdLSjpVH+S7V8p0yn04ntyeQPmoZNv4yqtRAwq3Kqyk+1t9g40lshINER
 qs8GKOl9P/bxxjfO4Tu9PKO0nZYjmpmYNcCsT2McSO4AuJ+MkA5QApqvRHZj3YRpuc4K
 c3fs3XKnXrmxJT+qdFdHNQ5spZZrVY3Wiwrw9UxEz2/z7q59vKKx0iANyQYYmqWvml6v
 MWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482148; x=1786086948;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nBzV8L3eKyvIj4lLEnAaJyQ+wdhSUy44CZN5L7yvjF0=;
 b=C4Yen6MyB3X4IghO6LvNu5PjQK8SDk6c7voXAh5VACDevyfurpYVjPIbOI4wAgWbsD
 HMoTsgvFPO/J1/1P+GxRPOL9sgOU6TYs9a9zZJZZ0d6BF3o0UY5PM+Kak/u5SqgkgQry
 7FXIr3lxsGXv+HDpc7lcienlrN+QZqBdKU5F95dC75K9wGiT0pqnT5CyL0nCQ3GM9ovf
 8LNxjl1kWgClnQnAVpuETRADfpSU76U71uR1t54LmLK60gI2klV9LU4pTWoAFAwej86R
 7C0KmLtlrT95npVRW9IV6fEMXw3d9Fp/3imzNldY/saD2urTMwQW/aV/rJ9dgAZ60u8H
 8Usg==
X-Gm-Message-State: AOJu0Ywz/HxBcqUkNQiwJoio+5yV271pBy+rDDJbLSipb1VmnlRZDotH
 89xz0Mse1Qtv5pzTdp7pYQBfQEG7lWsmbAvneOjTw2kqWQn1xsGQMTbjA+svU2ic9P7xqcNqYtY
 yMQVDbRPiYUd2jDGkLRWJNsbZsrzvrSj10V7P+FhNAO8GEVhZo6/kSdFyFkuZfN/lnRIjy3c1Gc
 sPgxAWfXZbFJXTWbIAlG6HECWaGQ==
X-Received: from pfblm12.prod.google.com
 ([2002:a05:6a00:3c8c:b0:847:99d5:ef10])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e26:b0:846:1698:638b
 with SMTP id d2e1a72fcca58-84ed6bf561cmr837989b3a.27.1785482148162; Fri, 31
 Jul 2026 00:15:48 -0700 (PDT)
Date: Fri, 31 Jul 2026 07:15:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731071545.1334046-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_gettime03: Extend tolerance on slow kernel
 configs
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Debugging/instrumentation kernel configs (like KASAN, LOCKDEP, etc.)
can significantly degrade performance, causing the time namespace
offset checks to exceed the default 10ms tolerance.

Use tst_has_slow_kconfig() to detect these slow configurations and
multiply the delta tolerance by 10, preventing false test failures
on slow/debug kernels.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/clock_gettime/clock_gettime03.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index 495030c07e..665a1107b8 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -16,6 +16,7 @@
 #include "time64_variants.h"
 #include "tst_safe_clocks.h"
 #include "tst_timer.h"
+#include "tst_kconfig.h"
 #include "lapi/sched.h"
 
 static struct tcase {
@@ -117,6 +118,11 @@ static void setup(void)
 		delta *= 10;
 	}
 
+	if (tst_has_slow_kconfig()) {
+		tst_res(TINFO, "Slow kernel config detected, multiply the delta by 10.");
+		delta *= 10;
+	}
+
 	now.type = then.type = parent_then.type = tv->ts_type;
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	parent_ns = SAFE_OPEN("/proc/self/ns/time_for_children", O_RDONLY);
-- 
2.55.0.508.g3f0d502094-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
