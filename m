Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEE7CA5FB1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790757986; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=y8jWC1lqK0ANZSHJUOm8tT93u4xqsN4eogLQgfYwf+I=;
 b=ajalRz5mxkplNhbq5kSi7WVB3TVZjb/UxFfRk3UYSNWIdZ58ztVrTppH2MpyN96WoLwUz
 nuQO46Bdq2jlEKDw+ubmMjKb39RMrAMzGtVL+YJeFe3oTZsUTMrr8rxg8+9M6HQ/42ItPVa
 qfUaUOo6ZziS0aXoBWXxnN23+YtNQ/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97A003E55DE
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D11783E55AC
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:46:07 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50C4D6008DA
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:46:05 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso31582615e9.2
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790757965; x=1791362765; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jY2M4mP1aPV40o7qowcXITFNwkLKj+k8dbBzovooL7w=;
 b=O9Si/T3K+CELhacTO2WkbTR3JJut5YE8pA1sMiYf102AUlOGwUiFV9fYWjlfOyOIrO
 8CNhtAWBJ75yoz6te40voxfwxb+AxV+AhNwRooxH30A2iSccy7gXzLWAGT+HIhBGR7Bk
 ivbqlk5QbBc1IeA+v2+x7x+V+iPX7GBG1+W+LQZXJwhWMh7RGjdROt9ylFOEY1QwoFPc
 xpz/yD4x0jjtPWITEZdXagbHQkVi+AbicUvxb1AJlb5dPKoCzv91F8wRj3qlfaEkdIN3
 Rax47klD59Q9cCUjoiBK4DUJEYDBLPJsnUe3e6XudINmUGvaxVNAk3+PTa6t4SprRb5r
 bNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790757965; x=1791362765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jY2M4mP1aPV40o7qowcXITFNwkLKj+k8dbBzovooL7w=;
 b=TdueJI6HXfKFOSPsvaQzh7ltTXZyWcawI6gPLRtPSqvAPnSVy5DLBS6n8WG12CHP0K
 AIFBSwIKx7Ka7NwA5IZIKbNX2FQpDN/Q5Rm8xi3wGOJRFPQevWqnztO5G0wCx8EDCkLD
 3jocfUT/4K06fMfdHh+RY+TPX/8XlpjBPsB5qqWsWD4SvUcbTS2YqGeF4jTzwXpjYGdT
 xIWveJY0WQK4YYlZJL0zIdy48U+Pq27yBal6Q0sNp6KksFFp5lo5fKxEv00tv2N9PwMS
 is819M3S+Iyg8fTu5kIjgFKQ2hCM7xzeGw7etsxsSgvFAuwlWSu3KnsE9tdL855ifoEs
 QZtA==
X-Gm-Message-State: AFuF++kIktoX8cR4FabvPULz+ghJcymslh/UBa3xh2AlSnq4j0DnP7/J
 PPgpx38lQCWoUiIts+0PMJcqS6sUpvipxnxoERHNwFdPW12Sngy6uqlGS+K/L3CBbree5J0Dlvh
 zi8M09oQ=
X-Gm-Gg: AYBFou2Z8NUNQn4bjucKN+JHi7iATypKkWlKTsaxbm3ZHsKxFHwlwprr1/69O0pQiDK
 rt9bbgtAHW5uC59xOxeTcRk2lrpbqLYx5+CMOGbn9WAC28902OpeOhSKz06190lVXEiNVopnY2+
 uB8K40UeSND4QwMoS7+tE3iLlIJP9prjETYBvofboj41+X/J/pcl9/wToTOfv5406lcGOg8u9Nd
 SSrqg4Adi0iGHWLPjPcuVZL09ApUbz0WzkwShU8nAixjWHQSdp4Pc10SblxQvKM14tppMBuTfPk
 19wxI6dgBGNFQTxt5Bc5JbKyqD2ebIMBdr1HS2lOj5D0uzogoV5LLQtPchpBWsYPjPt3s5wAfhf
 2jL752c+TY+/RGvHBuOc9emUiEhsc2sKCiJxhsKBmz0t7x0Ln/ZLJrMhX11MFY3s2F2QqT/uuMx
 yguiEyBUj6q21XSTp6M4cSlKV+KsX+A5HCIQrvrgVFu/YH7alubJLSjiFyTeDnhVk6Iq0=
X-Received: by 2002:a05:600d:864b:10b0:4a0:2dd:7573 with SMTP id
 5b1f17b1804b1-4a01b12b666mr7354815e9.33.1790757964578; 
 Wed, 30 Sep 2026 01:46:04 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017b7337bsm21640325e9.3.2026.09.30.01.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:46:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 30 Sep 2026 10:46:00 +0200
Message-ID: <20260930084603.947906-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930073556.GA57146@pevik>
References: <20260930073556.GA57146@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] openposix: timer_*/speculative: fork() to isolate
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
only a recommendation), so the child being killed by SIGSEGV or SIGBUS
is treated as success.

Fixes: d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a stack pointer as timerid")
Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../interfaces/timer_delete/speculative/5-1.c | 56 +++++++++++-----
 .../timer_getoverrun/speculative/6-1.c        | 55 +++++++++++-----
 .../timer_gettime/speculative/6-1.c           | 58 +++++++++++-----
 .../timer_settime/speculative/12-1.c          | 66 +++++++++++++------
 4 files changed, 169 insertions(+), 66 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
index dce9277b5d6a..8e7d1b2e54dc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -5,34 +5,58 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
 
- * Test to see if timer_delete() returns -1 and sets errno==EINVAL if
- * timerid is not a valid timer ID or not.
- * Since this is a "may" requirement, either option is a PASS.
+ * Test to see if timer_delete() sets errno==EINVAL for an invalid
+ * timerid. Recent POSIX versions leave this behavior undefined, so
+ * returning -1 with EINVAL, succeeding, or crashing (older glibc
+ * dereferences timerid as a pointer) are all accepted outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
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
+			printf("timer_delete() returned -1, but errno=%d (%s), not EINVAL\n", errno, strerror(errno));
+			fflush(stdout);
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
+	if ((WIFSIGNALED(status) && (WTERMSIG(status) == SIGSEGV || WTERMSIG(status) == SIGBUS)) ||
+		(WIFEXITED(status) && WEXITSTATUS(status) == PTS_PASS)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
 
-	printf("timer_delete() did not return -1\n");
-	return PTS_PASS;
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
index 3a8f1448d4d4..fbc0edc38f94 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -5,33 +5,58 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test to see if timer_getoverrun() sets errno=EINVAL if no timers have been
- * created yet or not.  Since this is a "may" assertion, either way is
- * a pass.
+ * Test to see if timer_getoverrun() sets errno==EINVAL for an invalid
+ * timerid. Recent POSIX versions leave this behavior undefined, so
+ * returning -1 with EINVAL, succeeding, or crashing (older glibc
+ * dereferences timerid as a pointer) are all accepted outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
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
+			printf("timer_getoverrun() returned -1, but errno=%d (%s), not EINVAL\n", errno, strerror(errno));
+			fflush(stdout);
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
+	if ((WIFSIGNALED(status) && (WTERMSIG(status) == SIGSEGV || WTERMSIG(status) == SIGBUS)) ||
+		(WIFEXITED(status) && WEXITSTATUS(status) == PTS_PASS)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
 
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index 586b0ed3a2b1..4bc1e7b43843 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -5,33 +5,59 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test to see if timer_gettime() sets errno = EINVAL if no timers have been
- * created yet and it is called with a bogus timer ID.  Since this is a "may"
- * assertion, either way is pass.
+ * Test to see if timer_gettime() sets errno==EINVAL for an invalid
+ * timerid. Recent POSIX versions leave this behavior undefined, so
+ * returning -1 with EINVAL, succeeding, or crashing (older glibc
+ * dereferences timerid as a pointer) are all accepted outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
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
+			printf("timer_gettime() returned -1, but errno=%d (%s), not EINVAL\n", errno, strerror(errno));
+			fflush(stdout);
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
+	if ((WIFSIGNALED(status) && (WTERMSIG(status) == SIGSEGV || WTERMSIG(status) == SIGBUS)) ||
+		(WIFEXITED(status) && WEXITSTATUS(status) == PTS_PASS)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
+	}
+
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
index ac7f7bf24c39..0ae7ee28201c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -5,36 +5,64 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test to see if timer_settime() sets errno = EINVAL if no timers have been
- * created yet.  Since this is a "may" assertion, either way is a pass.
+ * Test to see if timer_settime() sets errno==EINVAL for an invalid
+ * timerid. Recent POSIX versions leave this behavior undefined, so
+ * returning -1 with EINVAL, succeeding, or crashing (older glibc
+ * dereferences timerid as a pointer) are all accepted outcomes.
  */
 
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
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
+			printf("timer_settime() returned -1, but errno=%d (%s), not EINVAL\n", errno, strerror(errno));
+			fflush(stdout);
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
+	if ((WIFSIGNALED(status) && (WTERMSIG(status) == SIGSEGV || WTERMSIG(status) == SIGBUS)) ||
+		(WIFEXITED(status) && WEXITSTATUS(status) == PTS_PASS)) {
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
