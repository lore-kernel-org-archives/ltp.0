Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8989C2A09B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786133552; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=b8nM5+UxwY+nVqKfwTTSpD87xbJoS3tEb1m9rVCLEGQ=;
 b=ez+DUHvpXdusccciEUx1kV7CbCSS+JK/DPmJdMvpF7l1dHTFyOB6hK67stYZdEhOtJI6A
 ruuce9k1xUXP8Vdf5gTn3zeDWVXhML4H6xChiZUvH1loITODxS+joYN7xg3g4ZzECvv5zLZ
 37O0FgzDlVG2x63iONyuGRP/OlmIJV4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1353E3E7035
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 22:12:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A20B13E27F1
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 22:12:12 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A9D2A1000482
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 22:12:11 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so40148695e9.2
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786133531; x=1786738331; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZIsRAcBURV/q2qhhj3ZpGXH5GsP5+M4kGx7rGBQVQQ=;
 b=Xsod2dWF6iWmB28xZVwrsHGt2TaRDWmCTM2EiumWPsgKSCqsv582bH/IEskgJR9Pel
 NT3lqGqU3N2Jq/iGiy11bcbUwt9wcOae633okT5uP2HoWIXpfHVCSkxDCrIIjKMC94i7
 CWbLzGXVaizgu4ksVp1Lv/UFauepPORz/eVY+v4R7teDN3nYTVZ3J+BMwcjt1LU1+Kwk
 yETVdNaimlY9izU65pGfBYltQ0Yc7J9epHa5RWtR9HYrjQ1IVPdpoazVsHe8bH5jmjX4
 NyNC1z6mzcvC1gqt3kPsR31nqOTJ7TwMhjcFm7JGg/QZR6n79kTtSbeOd8e7Mk/jqu87
 sAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786133531; x=1786738331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tZIsRAcBURV/q2qhhj3ZpGXH5GsP5+M4kGx7rGBQVQQ=;
 b=FNxoXzxSOzG0peSvTiA/KtYx70QtZsGwyQF839OQcQZn826lNnbtFs4FFJt4G1Kj9G
 H7kJxQ6IMih8fdmSuf0pXjS5buTtEcc0AyO/UKu0bKvZdsj0JC9Yiifrt+TuDhO5V837
 3TJHD+xntStvXN/yBVQyt7NFax3h9/coRKIrQlUE7cc73CwMteEyl+5CnE7Z8X2RfDoU
 FXBZNxmpgZVEZiIKbpnIfdW52GD7t7dHOLg1CfDVyL8yIjSeD/SuhH1uI7B8NzEBk8nZ
 4CHmayNJ+FFa83E0UZJFFPaHvMpnI8Gv5+J8hqCfYYKIU1Vn+udW0WsuEnbMM/VYB30o
 s9lg==
X-Gm-Message-State: AOJu0Yy2SpRJYg+196Mwd55SL65QVm6BAaFwxUF30tz40tgcRH5slNUX
 VguDNYA784wPRZVeAlAx2uTKTp0WVPpPXHAT5tjsz00TZcic/oJVkKTJwbjxKN6CkhVWdldQUYZ
 0UOeY6ag=
X-Gm-Gg: AR+sD12ii6XyMTxGQlsVH/xqf3Lrg74dcmwsZF8DiXf66AD8Jzo2VD1qGB+yi10/KEd
 5XvAqMeNyL8tPnADrtvGWp8DNyRwnPvALyD4hv69rmP+iZTW3QvegDGAo7Y/Ea04e+JIFw5mFra
 LIaC8QhUt7zFHFRw5FP5RGbe0Uepcl4k4rxJg4+G20sMPlPT6QW5Y1fVTXV1zo84g61dm5dO/ZD
 YnOnH+gw1WUFq0aHuesbj3OTagSuPGcaQuOXuILHfuuWPoLBWaY7EGKY1Hks+s4Z9j9on61zLls
 O0BeFCjZPC55cFVhBw6Kj23cFjaG6MogY9GwuDX18spOGHPpuIJmsUFGxm5aMd5AonienmLrn94
 zA2FXfc6rhPCjz+avD5mvQVzhH/QKo/akodDKIjh7HnVsua+AKU0nZx5lHHzglRPKxXT9f10otr
 6iJpls0EcYQm2D42TjaumoMYMu5yPO6Tr418JYtNgcz+4ozvw=
X-Received: by 2002:a05:6000:a92:b0:47f:943a:45fa with SMTP id
 ffacd0b85a97d-47fec63ebc2mr31888496f8f.29.1786133530870; 
 Fri, 07 Aug 2026 13:12:10 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f90f8sm7846444f8f.26.2026.08.07.13.12.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 13:12:10 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  7 Aug 2026 22:12:08 +0200
Message-ID: <20260807201209.116225-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: timer_*/speculative: Handle SIGSEGV on
 invalid timer ID
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

timer_delete/speculative/5-1, timer_getoverrun/speculative/6-1,
timer_gettime/speculative/6-1 and timer_settime/speculative/12-1
all pass a bogus value as an invalid timer_t timerid.
On i586, glibc dereferences timer_t as a pointer into
internal state, and the bogus pointer causes a SIGSEGV
instead of the tests' expected EINVAL:

  timer_delete_sp[22499]: segfault at 7f4982f0 ip b7e07824 sp bfa4c140 error 4 in libc.so.6[a4824,b7d87000+191000]

POSIX defines no required behavior for an invalid timer ID (EINVAL is
only a recommendation), so a SIGSEGV is just as valid an outcome.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../interfaces/timer_delete/speculative/5-1.c | 19 ++++++++++++++++++
 .../timer_getoverrun/speculative/6-1.c        | 19 ++++++++++++++++++
 .../timer_gettime/speculative/6-1.c           | 20 +++++++++++++++++++
 .../timer_settime/speculative/12-1.c          | 20 +++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
index 912cf5800e6f..fb46c3e7dabb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -12,17 +12,36 @@
 
 #include <time.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
+#include <signal.h>
 #include "posixtest.h"
 
 #define BOGUSTIMERID 99999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	printf("Got SIGSEGV when calling timer_delete() with an invalid timer ID\n");
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	timer_t tid;
 	int tval = BOGUSTIMERID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
 	tid = (timer_t) & tval;
 
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
+
 	if (timer_delete(tid) == -1) {
 		if (errno == EINVAL) {
 			printf
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
index 6e18560e5084..429b08379e9c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -12,17 +12,36 @@
 
 #include <time.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
+#include <signal.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	printf("Got SIGSEGV when calling timer_getoverrun() with an invalid timer ID\n");
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	timer_t tid;
 	int tval = BOGUSTID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
 	tid = (timer_t) & tval;
 
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
+
 	if (timer_getoverrun(tid) == -1) {
 		if (EINVAL == errno) {
 			printf("fcn returned -1 and errno=EINVAL\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index d09c2f70901d..c124497153a9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -12,17 +12,37 @@
 
 #include <time.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
+#include <signal.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	printf("Got SIGSEGV when calling timer_gettime() with an invalid timer ID\n");
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	timer_t tid;
 	struct itimerspec its;
 	int tval = BOGUSTID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
 	tid = (timer_t) & tval;
+
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
+
 	if (timer_gettime(tid, &its) == -1) {
 		if (EINVAL == errno) {
 			printf("fcn returned -1 and errno==EINVAL\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
index 5d4e1dda30ba..056f75448ea8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -11,17 +11,37 @@
 
 #include <time.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
+#include <signal.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	printf("Got SIGSEGV when calling timer_settime() with an invalid timer ID\n");
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	timer_t tid;
 	struct itimerspec its;
 	int tval = BOGUSTID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
 	tid = (timer_t) & tval;
+
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
+
 	its.it_interval.tv_sec = 0;
 	its.it_interval.tv_nsec = 0;
 	its.it_value.tv_sec = 0;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
