Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEBFCA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790686099; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+H4fC1RFVjw4oKvaHZ+EW2UnpuzyAYm7c4FyD+rco78=;
 b=oa+E49renc8qAfAPf08M9r41NuAAkOpFb9/XlcbD/mGjvCIAC3qI6fJn/tDN2Tu6mXZCC
 Y57B6jII1de4u1th9T6VXlffoRTsnYAFpZl4Ngs3b/nZVFeteeiQ+J3GV5M6Ja1tSWa7lRi
 J9WNyDL/a+rA+BFC2d5xnXNQ72iVjuo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C5093E5829
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:48:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 524E73E571B
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 14:47:58 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 35A10600B24
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 14:47:58 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so2421737f8f.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790686077; x=1791290877; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YA90l3/b/1L+W5V4YPRSE95qBbxwxPnJmJXcSgoB140=;
 b=DGltxXyCstSzXqmH1t3S30qeEHsWl7Fm34Jb3WHl0rybfp2mDEf34Dnv3mtHYF9SoD
 Z9ijlsqaOhNM5jZ4ZwCrHxRagZNT/TawpReERqPaLZRqXtRKUalsgor1c1Wx270gSMfm
 +fFe+Vt0Epp7mJL0MuUGYZujK69yOqPhuDOFEKTu1VQeIJ8pnAM4B9ATFCEDghneQqRB
 Rcq+xWqQv2cC+gmtb4p8y+QH5eY88n5VG2NMCTOGX5OhgxAf7ABPWTq0F9I9yqIl6WpT
 iz7Tu0qbr0/9HCbfShM+ZNIzq7hn51OvcYuzVkRLnCIm1PaV9j/Jxe6zVSeUVcxYThXX
 b/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686077; x=1791290877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YA90l3/b/1L+W5V4YPRSE95qBbxwxPnJmJXcSgoB140=;
 b=sLzgUZE74CiBUEH92FhlCSwWBfTy0LCeRAvmwi7wtP0xQbrE0O92Y8rLyeUqk/KqLj
 0FKPKSGaQUtY4jyr/RBFH9JhEzBEspNdfeVgnO1rHYzDxtdl3G3vIBW13wziQLUvnea1
 lBACqbNuJTupKO240xHRAEL0tLGgM9ZM99DO3tSGJEsg8Ljv/qVlDxkt6IA4eXLLgm4O
 55yxlkbooMAxQDRkNURUbhZBv3LNksA5oZ6U2A1BIcblj5JmZ/FkRFXkDivHaL+L2Xyh
 +SetKbJoI/0bP862kz6LdNotnmW7BL5hSsAJ117D5I8Lm5O6BAeRaWHVnhio1/twa16g
 U2Wg==
X-Gm-Message-State: AFq9FYJ+R875NXbG26P/XjvoLaysLcF2n1IcdMJQMrXQKpmLndQ5h9XQ
 GEn3B4/5RbHzCdP+zunFfGVd9kSUByjOjQUtZgR/Xfju9LmFvSjFZiRQkmhljC1aGRf2gjnURTo
 KpHfnpvs=
X-Gm-Gg: AYBFou1xT5VPFUADIjXQWqP8cmjzVLKeoZpzj96dzB6Yt6Ys1XFOuQO60lhJhyOOIDc
 rojMiBvbsYVYJ7HwTOcJTmCBfdg3DA6XvZ+kSUYF7oJEDobQZ1VVqVfN6DSOWe1RrHYRGLo/m3z
 fTDsBVyHlo+Wwxz8YkjdnuXmM+f1/Byd5mRRaF4XlqzYP7GaotnyohNIT+TlsOwnaTo7qGRTcL+
 saFfT1PNx0qNyhcdMHoGLr23ms5bT7aoGNARUsxxVO3WPX0yF5nSi6TrsKCufRP2jqwb157zf4L
 /3Ujkp/1bzYJDpsYRGwgGdw5IUgM5ByqubEAhOC5Ttj+DfGZ50qv+1ZkPvJbYYhupaVGibrlEJQ
 RhzOYDQJjdnxeBAy5DV58ToUJO3Cu8DrLRDPNfN/e2/nFE14lzEM05Md0CDPM2wy+ik3zbWomjH
 LpOswV377WTcI2F/GYMptb74V+wNU5Xjzwiz/GH12/0NCh5pjvtodcrrPToQmjTAsPsoo=
X-Received: by 2002:a05:6000:4021:b0:487:c4b:7bd7 with SMTP id
 ffacd0b85a97d-4887db2d04cmr24107322f8f.34.1790686077354; 
 Tue, 29 Sep 2026 05:47:57 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5058c52sm4304441f8f.19.2026.09.29.05.47.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:47:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 29 Sep 2026 14:47:54 +0200
Message-ID: <20260929124756.836342-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: timer_*/speculative: Handle SIGSEGV on old
 glibc
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
timer_gettime/speculative/6-1, and timer_settime/speculative/12-1 all
pass a bogus BOGUSTIMERID/BOGUSTID value as an invalid timerid.

Commit d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a
stack pointer as timerid") fixed a SIGSEGV on i586, where current
glibc's sign-bit check (timer_is_sigev_thread()) can misread a stack
address as a tagged pointer. A small constant avoids that.

But older glibc (<= 2.31, before this check existed) unconditionally
dereferences timerid as a pointer, so the same small constant now
faults instead, on any architecture:

  timer_delete_sp[13131]: segfault at 186a3 ip 00007f15973aed4e sp 00007ffefb52c5a0 error 4 in librt-2.31.so[7f15973aa000+8000]

POSIX defines no required behavior for an invalid timer ID.
Install a handler to accept SIGSEGV.

Fixes: d377d1cff1ec ("openposix: timer_*/speculative: Don't pass a stack pointer as timerid")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../interfaces/timer_delete/speculative/5-1.c | 18 ++++++++++++++++++
 .../timer_getoverrun/speculative/6-1.c        | 18 ++++++++++++++++++
 .../timer_gettime/speculative/6-1.c           | 18 ++++++++++++++++++
 .../timer_settime/speculative/12-1.c          | 19 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
index dce9277b5d6a..c7a94e1446f7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -13,13 +13,31 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTIMERID 99999
 
+/*
+ * timerid is not a valid timer ID; POSIX defines no required behavior
+ * here (EINVAL is only a recommendation), so SIGSEGV is an equally
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	PTS_WRITE_MSG("Got SIGSEGV when calling timer_delete() with an invalid timer ID\n");
+	PTS_WRITE_MSG("Test PASSED\n");
+	_exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	timer_t tid = (timer_t)BOGUSTIMERID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
 
 	if (timer_delete(tid) == -1) {
 		if (errno == EINVAL) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
index 3a8f1448d4d4..7861e99d4c8d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -13,13 +13,31 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * timerid is not a valid timer ID; POSIX defines no required behavior
+ * here (EINVAL is only a recommendation), so SIGSEGV is an equally
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	PTS_WRITE_MSG("Got SIGSEGV when calling timer_getoverrun() with an invalid timer ID\n");
+	PTS_WRITE_MSG("Test PASSED\n");
+	_exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	timer_t tid = (timer_t)BOGUSTID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
 
 	if (timer_getoverrun(tid) == -1) {
 		if (EINVAL == errno) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index 586b0ed3a2b1..a3a9e080e26c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -13,14 +13,32 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * timerid is not a valid timer ID; POSIX defines no required behavior
+ * here (EINVAL is only a recommendation), so SIGSEGV is an equally
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	PTS_WRITE_MSG("Got SIGSEGV when calling timer_gettime() with an invalid timer ID\n");
+	PTS_WRITE_MSG("Test PASSED\n");
+	_exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	struct itimerspec its;
 	timer_t tid = (timer_t)BOGUSTID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
+
+	sigfillset(&sa.sa_mask);
+	sigaction(SIGSEGV, &sa, NULL);
 
 	if (timer_gettime(tid, &its) == -1) {
 		if (EINVAL == errno) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
index ac7f7bf24c39..953d585b8730 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -12,14 +12,33 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * timerid is not a valid timer ID; POSIX defines no required behavior
+ * here (EINVAL is only a recommendation), so SIGSEGV is an equally
+ * valid outcome.
+ */
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
+{
+	PTS_WRITE_MSG("Got SIGSEGV when calling timer_settime() with an invalid timer ID\n");
+	PTS_WRITE_MSG("Test PASSED\n");
+	_exit(PTS_PASS);
+}
+
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	struct itimerspec its;
 	timer_t tid = (timer_t)BOGUSTID;
+	struct sigaction sa = { .sa_handler = sigsegv_handler };
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
