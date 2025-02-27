Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5AFC021BE
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 10:11:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54B123C9DCE
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 11:11:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 847BE3C262F
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 11:11:34 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8AC9365BE3E
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 11:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740651091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JO4kNd1rUFw2ZG0PG41P1U1uQr3Eyf4YODBf0hX55k8=;
 b=Bh2Nez9hNHJZOgO4Wai+pG5KLCnVLcho1SxS+KqQG8JOK2BNvDsq8lSprzRY7mopyzo0WY
 IQYK99ovi6+kb34xHR7Xy4Q9LlseYRt/QR6TV20NbE776Mqmxl9T4eIVjrN27125IpdKMX
 +BhYLkOR+jm72jKL2d0Ymu2S/zcoNNQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-b2a9OwltNUKvFI79tCPncg-1; Thu,
 27 Feb 2025 05:11:29 -0500
X-MC-Unique: b2a9OwltNUKvFI79tCPncg-1
X-Mimecast-MFC-AGG-ID: b2a9OwltNUKvFI79tCPncg_1740651088
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8568D180087E
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:11:28 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.85])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A325819560AE
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:11:27 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 27 Feb 2025 11:10:17 +0100
Message-ID: <18cb6752b375941581aa66617e52edad0913344e.1740650948.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vy99DUJZWsO99-SBANMupjfzKVSTKB5MUhe24KpdvYA_1740651088
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: sem_timedwait: replace sleep with
 tst_process_state_wait3
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This makes the test faster and also avoids a small race - when the
time is very close to starting new second, this makes the test use
timeout that's effectively just slightly over one second, because
nanosecond portion is always set to 0. And previously child would
sleep roughly one second.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/sem_timedwait/2-1.c                | 4 +++-
 .../conformance/interfaces/sem_timedwait/9-1.c                | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
index d9012cc5ed1a..61603cee56b1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
@@ -22,6 +22,7 @@
 #include <time.h>
 #include <sys/mman.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define TEST "2-1"
 #define SHM_NAME "/posixtest_2-1"
@@ -79,7 +80,8 @@ int main(void)
 	} else if (pid > 0)	// parent to unlock semaphore
 	{
 		int i;
-		sleep(1);
+
+		tst_process_state_wait3(pid, 'S', 1);
 		if (sem_post(mysemp) == -1) {
 			perror(ERROR_PREFIX "sem_post");
 			return PTS_FAIL;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c
index f9175839dab3..ee7ad7aefe26 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c
@@ -21,6 +21,7 @@
 #include <sys/wait.h>
 #include <time.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define TEST "9-1"
 #define FUNCTION "sem_timedwait"
@@ -79,7 +80,8 @@ int main(void)
 
 	} else {		// parent to send a signal to child
 		int i;
-		sleep(1);
+
+		tst_process_state_wait3(pid, 'S', 1);
 		(void)kill(pid, SIGABRT);	// send signal to child
 		if (wait(&i) == -1) {
 			perror("Error waiting for child to exit\n");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
