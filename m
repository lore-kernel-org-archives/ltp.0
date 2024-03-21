Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D4C6FD1F
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 18:14:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C3AE3CFBC6
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 19:14:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72B23C0E54
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:14:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8048100159F
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711044875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fh+0nrrMkOv+0d0T69rbw0UsR/HS1O05QPE3oMrP5pY=;
 b=fbq+cISnVcEE+0jtLKctmI2Ui5R4qREFyc54Va1ZNJ8zuRuVZ4PRsuBcOU64kIUaWylhlW
 fQMuRuwaoTiDCpf/Y30nDqJ4UAXnvW4BXsVjbA4a5PeiLoulmKfRU0syZpHifmfH98bJIC
 M96PtK9Mbr+qOXNijuHdpNWw5t8xAVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-EC0oUJWYO7ixhGvlBXcXmg-1; Thu,
 21 Mar 2024 14:14:33 -0400
X-MC-Unique: EC0oUJWYO7ixhGvlBXcXmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E65729AB3F8
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 18:14:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.226.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95D4A3C20;
 Thu, 21 Mar 2024 18:14:32 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 21 Mar 2024 19:14:00 +0100
Message-Id: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/timer_getoverrun01: initialize timer variable
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

Initialize entire "timer" variable to 0.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index 5c444857aaa7..897bf65a2480 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -25,6 +25,7 @@ static void run(void)
 	timer_t timer;
 	struct sigevent ev;
 
+	memset(&timer, 0, sizeof(timer_t));
 	ev.sigev_value = (union sigval) 0;
 	ev.sigev_notify = SIGEV_SIGNAL;
 	ev.sigev_signo = SIGALRM;
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
