Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88261C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:53:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC760F92
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36FC760F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4C763C952A
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 04:53:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95BC33C2639
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:53:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 73D26600732
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630983185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KWQEZR5TPvspL8xH4/e0swr82MdewjfB81bDplnN0tU=;
 b=LCUIZnbGRHc+0dJBnKls/+WuuB6pfHNo+OzOX+ptH01O8B0bChEObhSN5rO9gxzXDADixf
 MUigKwvoUzsMCBPmaGIkT3k5tM2eZWRJOk23qQzcSGuE2dz0+lV1U5OIV3CZfJ0fAKW7tI
 O8jtg0XsnACWuCiTPHIjc/0H0lVQ02A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-lEpYUuzGO2GNJr4CG7n8mw-1; Mon, 06 Sep 2021 22:53:03 -0400
X-MC-Unique: lEpYUuzGO2GNJr4CG7n8mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6943A801A93
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 02:53:02 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 965FC1ABDF
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 02:53:00 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  7 Sep 2021 10:52:58 +0800
Message-ID: <20210907025258.3294914-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: make use of tst_process_state_wait3
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
Message-ID: <20210907025258.px4jsAuV592p22GPs1LvF_El0Abtupu_FFrhExXMHGo@z>

Replaces that sleep 1 sec with a wait until child process state
changes to 'S' (sleeping).

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../conformance/interfaces/clock_nanosleep/1-3.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/1-4.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/1-5.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/10-1.c              | 3 ++-
 .../conformance/interfaces/clock_nanosleep/2-2.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/2-3.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/9-1.c               | 3 ++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c
index 98de93a9e..e2fdc4c37 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -63,7 +64,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c
index 9808c5c4f..ca3d0798f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c
@@ -14,6 +14,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -36,7 +37,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
index 46f26163d..263d98a08 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
@@ -18,6 +18,7 @@
 #include <sys/wait.h>
 #include <stdlib.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 5
 
@@ -52,7 +53,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGSTOP) != 0) {
 			printf("Could not raise SIGSTOP\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c
index f6adcc938..9fae578b4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c
@@ -15,6 +15,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -59,7 +60,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c
index 330618877..8cafb3bf0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -71,7 +72,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c
index 06a79a96d..3938f44b7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -45,7 +46,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
index 04ef0a2cc..554714695 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -88,7 +89,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
