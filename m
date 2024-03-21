Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DA8C54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 18:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5C33CF1E5
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 19:26:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 035DD3C0E54
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:26:24 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F2DA1601071
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711045582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjTD4g8c/Wq0FPSToCK+sKDLNwg/I5qbgq+63Hdw0rM=;
 b=NqUj3wR7RT1jvXPQdrxAMxwG5NxJ+tSMt+Go6LusNBjRiE9dQPQ+vkuS+sCnmvHe/43atk
 BxM1m7xLheUIeby2sQ7AOiTl4jP6PvHpf+Et8esZNQ6cai0F+zJomjZEhL1TDqllbOMf1q
 FZS51+0zP2GoMHqgtb4TwRIqE4o1D2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-wBNM8NcoPvuwNio6FBFNIg-1; Thu, 21 Mar 2024 14:26:20 -0400
X-MC-Unique: wBNM8NcoPvuwNio6FBFNIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B653800267
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 18:26:20 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.226.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1CD23C20;
 Thu, 21 Mar 2024 18:26:19 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 21 Mar 2024 19:25:55 +0100
Message-Id: <cf3287a8009ab6104a4dec45b7b8160f35a358b0.1711045522.git.jstancek@redhat.com>
In-Reply-To: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
References: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/timer_getoverrun01: use kernel_timer_t
 type
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Testcase is failing on s390x, with glibc-2.39 and 6.9-rc0 (git commit
a4145ce1e7bc). Userspace defines timer_t as void * (8 bytes), while
__kernel_timer_t is defined as int (4 bytes).  This means that kernel
only populates 4 bytes, and other 4 can remain uninitialized, possibly
containing some non-zero garbage, e.g.:

  timer_create(CLOCK_REALTIME, {sigev_signo=SIGALRM, sigev_notify=SIGEV_SIGNAL},  <unfinished ...>
  <... timer_create resumed>[0]) = 0
  timer_getoverrun(1 <unfinished ...>
  timer_getoverrun resumed>) = -1 EINVAL (Invalid argument)
  timer_delete(1)    = -1 EINVAL (Invalid argument)

Since we are dealing with syscalls directly, use kernel_timer_t.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/timer_getoverrun/timer_getoverrun01.c      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index 5c444857aaa7..57c2147bf47f 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -19,10 +19,11 @@
 #include <time.h>
 #include "tst_safe_clocks.h"
 #include "lapi/syscalls.h"
+#include "lapi/common_timers.h"
 
 static void run(void)
 {
-	timer_t timer;
+	kernel_timer_t timer;
 	struct sigevent ev;
 
 	ev.sigev_value = (union sigval) 0;
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
