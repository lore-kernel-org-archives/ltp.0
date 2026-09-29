Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713DECA5FA7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790710302; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=WYVwx/VC3GC277iA71LAk3tMNbiXGJ16w8uxvBwnuVM=;
 b=OAN97M6oR34fEWNuYuk7qaiAQYX2rEAydNMELtS1HEpFngzgMBkA5xgyCe/e3pwhIiep+
 Pc5N2GegV/gbGGQ39i7D3D5LLSFt8RFBg2r8LGSsAZn5muIguxur8APHUhopbRbruBZOWcJ
 U6EICs24vQ1PYjL7UpMqAs91tQqPMSY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 369723E6C08
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 21:31:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 979743E6BDA
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 21:31:22 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 52CDF600782
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 21:31:21 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so26058695e9.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790710281; x=1791315081; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z85WQQm5aPjudjwqBd0px7P6zqLUDWkXb4aK8Cp8M5I=;
 b=G5FT7S0IEwzFkCRM0ZyzCa9n6vThhyAmLchx7buSpEgxG5+grdXmBcAPaRv9aglokw
 E45sula5XtfXiWcx0445P0/3Rv9c2pn4X5/LkzSz4njm0qks0oVHYBbjJ05C5YR+2a5A
 chrPXSN0nfDk0JuS7YnXYcUMIdNexh6PZCA6F7/Al+CfrDw8S0UU63xTXOOQ7XzB3LaZ
 oN3DmD2FRJP2wiGa0h3hUNklQU1BHs2+6znjDhCbLm0ylSIpvBQo8fzjVq1stouzpVqK
 V/5sqYsSX25Tm6qVshLD1l1Ye0b665PTKlhtzEITqSNoR35kfPZ6zr37pOArU4KJW1w/
 8/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790710281; x=1791315081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z85WQQm5aPjudjwqBd0px7P6zqLUDWkXb4aK8Cp8M5I=;
 b=uC3aYQ/EgdiF74NAhHYkMUffCUU1mM4ZhvUFJwnQUDqKu8MNq/mVP0JoB0rVYdndCw
 Gkeef9tdX51uJ2yPx5PogGZlUFWHnvGhrIWiH0hZ2rm5jwKLmG9FUb94yIfuRZzuqO9g
 1wiTpCoP48lyfWa13MX14hGq2yXnGQEO4IX++i5GItymG8xSg0RVtp066YN51los0uyv
 0sQE5hfEoYSbeJySSYX6pt7ZhW5T3jig13Rxz4rXVW/dguZPiSnhR3YC8FcQhjm8U3LJ
 fsi8OMrfEsFzUuUoGL6CcanGSFVCw8BjvO6XE013Iumw4QkrkHZdWJQ9NhUThtpJ3SgA
 4rtQ==
X-Gm-Message-State: AFuF++lFhnu8cqpXCCNmcud42ctn5ScSKU+f045PjAFozoPSBTaXRgwJ
 L9YSn1XtPKW3e8pAUnkgY7pmXuAG9al8T2Uyj/BB+z7MLggy962UryvoCTpbRBD+Dwqh/FSJpOS
 6GydY904=
X-Gm-Gg: AYBFou3xAJ+rn01GDv1h3AOlImqtI7penvPXa21YeGN5pC3qOWKtLh+fCf2S2nWulr8
 20lkNO5VbqyQ0o+vxQCTwyvZmXZ7ICw9HW9CvPjIb/ga4On6x/vW8opa0nWByJDy+fw6BVsjjIJ
 1xOPXeaKkp/ygkqeR3xpUHeEQ2WJQ1AIQRkwmXQsaA6MzwcG8fyhvtdS/bXxdkk3XEGW2zlaWgr
 TopWOP/E8/j5cU4PShmsmsARMxZ9T/DvsVEpPi6aZomqUl6cgDO3blyebJZvqBIzAhvC3vBkCqp
 /HzQFktEffH+TB5h7KtN8eU3iGX2t9TIPx6b22RADNyUctQmbqaiUDkVoav7Bw/n1Ujf0eMIPmV
 KxvEhizuPpyCsjnvIgdZSzXBw3ui42KoKQ2p8qZKK2xoBiyT5IkaRpxqI77qyjfck+oks9DicZV
 TJk396r/etoCnQAEruUOdeVq2+PR/nQS8jTMX5SLRjl3OJ13z2U4kLWoD2
X-Received: by 2002:a05:600c:c8f:b0:4a0:333:253a with SMTP id
 5b1f17b1804b1-4a01501fc64mr1734945e9.14.1790710280517; 
 Tue, 29 Sep 2026 12:31:20 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014f8ed8asm3887215e9.13.2026.09.29.12.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:31:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 29 Sep 2026 21:31:15 +0200
Message-ID: <20260929193119.912502-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929124756.836342-1-avinesh.kumar@suse.com>
References: <20260929124756.836342-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] openposix: timer_*/speculative: fork() to isolate
 the SIGSEGV on old glibc
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

Commit d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a
stack pointer as timerid") fixed a SIGSEGV on i586, where current
glibc's sign-bit check (timer_is_sigev_thread()) can misread a stack
address as a tagged pointer. A small constant avoids that.

But older glibc (<= 2.31, before this check existed) unconditionally
dereferences timerid as a pointer, so the same small constant now
faults instead:

  timer_delete_sp[13131]: segfault at 186a3 ip 00007f15973aed4e sp 00007ffefb52c5a0 error 4 in librt-2.31.so[7f15973aa000+8000]

fork() a child to make the call, then inspect the child's exit status.
POSIX defines no required behavior for an invalid timer ID (EINVAL is
only a recommendation), so the child dying from any signal is treated
as success.

Fixes: d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a stack pointer as timerid")
Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../interfaces/timer_delete/speculative/5-1.c | 50 +++++++++++-----
 .../timer_getoverrun/speculative/6-1.c        | 49 ++++++++++-----
 .../timer_gettime/speculative/6-1.c           | 52 +++++++++++-----
 .../timer_settime/speculative/12-1.c          | 60 +++++++++++++------
 4 files changed, 145 insertions(+), 66 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
index dce9277b5d6a..d1857efead18 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -5,34 +5,52 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
 
- * Test to see if timer_delete() returns -1 and sets errno==EINVAL if
- * timerid is not a valid timer ID or not.
- * Since this is a "may" requirement, either option is a PASS.
+ * Test to see if timer_delete() sets errno==EINVAL for an invalid
+ * timerid. Since this is a "may" requirement, succeeding or crashing
+ * are equally valid outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <sys/wait.h>
 #include "posixtest.h"
 
 #define BOGUSTIMERID 99999
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	timer_t tid = (timer_t)BOGUSTIMERID;
-
-	if (timer_delete(tid) == -1) {
-		if (errno == EINVAL) {
-			printf
-			    ("timer_delete() returned -1 and set errno=EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf
-			    ("timer_delete() returned -1, but didn't set errno!=EINVAL\n");
-			return PTS_FAIL;
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		return PTS_UNRESOLVED;
+	}
+
+	if (pid == 0) {
+		timer_t tid = (timer_t) BOGUSTIMERID;
+
+		if (timer_delete(tid) == -1) {
+			if (errno == EINVAL)
+				_exit(PTS_PASS);
+			_exit(PTS_FAIL);
 		}
+		_exit(PTS_PASS);
+	}
+
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return PTS_UNRESOLVED;
+	}
+
+	if (WIFSIGNALED(status) || (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
 
-	printf("timer_delete() did not return -1\n");
-	return PTS_PASS;
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
index 3a8f1448d4d4..6da435430879 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -5,33 +5,52 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test to see if timer_getoverrun() sets errno=EINVAL if no timers have been
- * created yet or not.  Since this is a "may" assertion, either way is
- * a pass.
+ * Test to see if timer_getoverrun() sets errno==EINVAL for an invalid
+ * timerid. Since this is a "may" assertion, succeeding or crashing
+ * are equally valid outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <sys/wait.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	timer_t tid = (timer_t)BOGUSTID;
-
-	if (timer_getoverrun(tid) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno=EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1, but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		return PTS_UNRESOLVED;
+	}
+
+	if (pid == 0) {
+		timer_t tid = (timer_t) BOGUSTID;
+
+		if (timer_getoverrun(tid) == -1) {
+			if (errno == EINVAL)
+				_exit(PTS_PASS);
+			_exit(PTS_FAIL);
 		}
+		_exit(PTS_PASS);
+	}
+
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return PTS_UNRESOLVED;
+	}
+
+	if (WIFSIGNALED(status) || (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
 
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index 586b0ed3a2b1..ec153e9866da 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -5,33 +5,53 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test to see if timer_gettime() sets errno = EINVAL if no timers have been
- * created yet and it is called with a bogus timer ID.  Since this is a "may"
- * assertion, either way is pass.
+ * Test to see if timer_gettime() sets errno==EINVAL for an invalid
+ * timerid. Since this is a "may" assertion, succeeding or crashing
+ * are equally valid outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <sys/wait.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	struct itimerspec its;
-	timer_t tid = (timer_t)BOGUSTID;
-
-	if (timer_gettime(tid, &its) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		return PTS_UNRESOLVED;
+	}
+
+	if (pid == 0) {
+		struct itimerspec its;
+		timer_t tid = (timer_t) BOGUSTID;
+
+		if (timer_gettime(tid, &its) == -1) {
+			if (errno == EINVAL)
+				_exit(PTS_PASS);
+			_exit(PTS_FAIL);
 		}
+		_exit(PTS_PASS);
 	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
+
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return PTS_UNRESOLVED;
+	}
+
+	if (WIFSIGNALED(status) || (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
+	}
+
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
index ac7f7bf24c39..f4400ce0dd64 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -5,36 +5,58 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test to see if timer_settime() sets errno = EINVAL if no timers have been
- * created yet.  Since this is a "may" assertion, either way is a pass.
+ * Test to see if timer_settime() sets errno==EINVAL for an invalid
+ * timerid. Since this is a "may" assertion, succeeding or crashing
+ * are equally valid outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <sys/wait.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	struct itimerspec its;
-	timer_t tid = (timer_t)BOGUSTID;
-	its.it_interval.tv_sec = 0;
-	its.it_interval.tv_nsec = 0;
-	its.it_value.tv_sec = 0;
-	its.it_value.tv_nsec = 0;
-
-	if (timer_settime(tid, 0, &its, NULL) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1, but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		return PTS_UNRESOLVED;
+	}
+
+	if (pid == 0) {
+		struct itimerspec its;
+		timer_t tid = (timer_t) BOGUSTID;
+
+		its.it_interval.tv_sec = 0;
+		its.it_interval.tv_nsec = 0;
+		its.it_value.tv_sec = 0;
+		its.it_value.tv_nsec = 0;
+
+		if (timer_settime(tid, 0, &its, NULL) == -1) {
+			if (errno == EINVAL)
+				_exit(PTS_PASS);
+			_exit(PTS_FAIL);
 		}
+		_exit(PTS_PASS);
 	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
+
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return PTS_UNRESOLVED;
+	}
+
+	if (WIFSIGNALED(status) || (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
+	}
+
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
