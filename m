Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721CCC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788194013; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BgzxbD1sR70Qu+NrUAoFvwRK87gnQi6H2cNtkUxreGs=;
 b=gIUnuxj8ZDxl+j2enLDake7kgN47eAyDkjuE+vMfzb/jthKy+Ui06SAYPQoOeRrivNQAJ
 lv+rwmcHktEMqGj30KrIlY4jyGPDYuF7eZYd6zYvWDhcKok8SlABmhSWDNwXvHGLYPFeu0u
 +WoFBUrhdk3Ym2pkd4FIdQbKbg0CYNo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F79A3E99A3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA8EF3E1505
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 18:33:13 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B0DD6009D6
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 18:33:12 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so36546645e9.2
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788193992; x=1788798792; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlqriuminiP7xNoGipBBkX1oemh2fkawB839GAHOA78=;
 b=HbhDgsN59ESw9t6QxEUm9Hsd3c+ZAx/jDb3vGamvi66/CY9DpqW+7st78CBrwbd1WM
 Oo+z4ZVipNCSmBsBN89yE68lx7Nd4gNxthqQUFCW7CUu2acFwlHJXyLWD+ZA8+HXdxy9
 Ltmsmh+4zjDRprzHROm6dyWD/ywHZEXjAZMYIROToEb0JVx2nMDRXVaDX/h1tcqeJXVJ
 vNvGkn56FQRaIkXi7fuZyoFHDSSwqb9jctjUWAoHFdrjJdRdABNkcgNW1lN1DM0AwQqM
 vBFjQ8dsdyCAYuFKn71yTscIyDpE365QkSLHK4xIzEVjbBIXc1GXf2hrE5W7J5YpZKSJ
 wCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193992; x=1788798792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlqriuminiP7xNoGipBBkX1oemh2fkawB839GAHOA78=;
 b=iXzq0aClu3LS4PLGPF0wWB5CZzGUhdD+SKqsIufDzVnlD4qN6AnLMmic309GIi8Tlr
 uzNrbaiyk5a8W6yieXDmR/DQDHq0Af4EjbMs99cZIroND7e70v2mtp3XwI1nG2uSBvpG
 8Xi8G0xcdcrcS7/+F9PfXKeBr3cg6VmPlmlUURnGIKSRRo8dLHzl4kGPFOwbU7SMRkv0
 RYMXW/4/x7VH5dPwYl73EE7ITyxKb7+hzKBiBjQ0/2elgp51eSiPyC8BnSLP9loTV2+R
 JWpRShiAcq45scAOeAXuid72eM/4pFRg5PyxkxAL5BkxsmbrfPgC7BhKUAq45PGDBiA7
 pUGw==
X-Gm-Message-State: AFuF++nbQuNCpRgDMIfUQ1fBpppbD2H7VCmzDUAtNWC0C9rczNgpB0B/
 tVjJUchfLm3U/RZUBUqAycHKp5rX4LdCkijLm0/QYgQ6eXM5LgU5Mi41BtDhqcYlaC9MrveTFTB
 MGRB9ZHc=
X-Gm-Gg: AR+sD10olUdDv6qs18e1MAocheRKRonuN+7c4st/Q6CEvEQQIdpwVPe+RfXDYwB2sYg
 Hvq5WK7Iuqic9TPDFt9Qz79w/xTFgml7baLHjQwoimIoDaRoNJV75xeFNgrFWJzr4y+Hp9P5aU4
 U6dmg/jcRcAw9Gs94z+iRZDBxRpdBhkEcUG7vWZBlFncYo+rzL23n/KvY8OrzqI2ILAqMiAjJgN
 xs5oXFl7vX0eLxEAxRtsnrXNDaLGs88IacgmDE07vHJG+4jFQE1m3rYXiwBQMZ86zh0Gp0CEy3o
 uCiMlFjT5VUIgyLGY5QHXrdPMqc7BavyN2mXjBqPrDQrpsAvnLQIDWThqjMbfZYfJn+aulcMlPP
 NgLGBEOC2qjAvERyMowq97OS8WNygyCvBJrUr7yEDHquJ7hYLG7s8EzG52XE11+27KvKzDK5TLc
 hk+fGTYBOS9c8dzTcYND7+nDJevwrDpybo3G8Ah3DGctwn5xWzyijZAEQV
X-Received: by 2002:a05:600c:1c0a:b0:499:51f0:a9b2 with SMTP id
 5b1f17b1804b1-49b91c1dd3fmr443528855e9.1.1788193991593; 
 Mon, 31 Aug 2026 09:33:11 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0d4f3sm4238325e9.5.2026.08.31.09.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:33:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 18:33:08 +0200
Message-ID: <20260831163310.137399-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] openposix: timer_*/speculative: Don't pass a stack
 pointer as timerid
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
construct an invalid timerid from the address of a local variable:

  int tval = BOGUSTIMERID;
  tid = (timer_t) & tval;

glibc's timer_t is overloadedp[0]: for !SIGEV_THREAD timers it is
the kernel-assined timer ID, while for SIGEV_THREAD timers it is a
tagged pointer into glibc's own internal state. Before issuing any
syscall, timerid_to_kernel_timer() picks between the two using only
the sign bit of the value:

  if (timer_is_sigev_thread (timerid))
    return timerid_to_timer (timerid)->ktimerid;
  else
    return (kernel_timer_t) ((uintptr_t) timerid);

On i586, an ordinary stack address can have its sign bit set,
so glibc mistakes &tval for a tagged pointer, derives an unrelated,
fabricated address from it via a bit shift, and dereferences it -
crashing inside libc before the kernel is ever reached:

  timer_delete_sp[22499]: segfault at 7f4982f0 ip b7e07824 sp bfa4c140

A small integer value like the ones we use for bogus IDs in these tests
will never have its sign bit set on any architecture, so it will always
take the safe "just an int" path and will be correctly rejected by the
kernel's own timer lookup with a genuine EINVAL.

[0] https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/kernel-posix-timers.h.html

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../conformance/interfaces/timer_delete/speculative/5-1.c    | 4 +---
 .../interfaces/timer_getoverrun/speculative/6-1.c            | 4 +---
 .../conformance/interfaces/timer_gettime/speculative/6-1.c   | 5 ++---
 .../conformance/interfaces/timer_settime/speculative/12-1.c  | 4 +---
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
index 912cf5800e6f..dce9277b5d6a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -19,9 +19,7 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	timer_t tid;
-	int tval = BOGUSTIMERID;
-	tid = (timer_t) & tval;
+	timer_t tid = (timer_t)BOGUSTIMERID;
 
 	if (timer_delete(tid) == -1) {
 		if (errno == EINVAL) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
index 6e18560e5084..3a8f1448d4d4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -19,9 +19,7 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	timer_t tid;
-	int tval = BOGUSTID;
-	tid = (timer_t) & tval;
+	timer_t tid = (timer_t)BOGUSTID;
 
 	if (timer_getoverrun(tid) == -1) {
 		if (EINVAL == errno) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index d09c2f70901d..586b0ed3a2b1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -19,10 +19,9 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	timer_t tid;
 	struct itimerspec its;
-	int tval = BOGUSTID;
-	tid = (timer_t) & tval;
+	timer_t tid = (timer_t)BOGUSTID;
+
 	if (timer_gettime(tid, &its) == -1) {
 		if (EINVAL == errno) {
 			printf("fcn returned -1 and errno==EINVAL\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
index 5d4e1dda30ba..ac7f7bf24c39 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -18,10 +18,8 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
-	timer_t tid;
 	struct itimerspec its;
-	int tval = BOGUSTID;
-	tid = (timer_t) & tval;
+	timer_t tid = (timer_t)BOGUSTID;
 	its.it_interval.tv_sec = 0;
 	its.it_interval.tv_nsec = 0;
 	its.it_value.tv_sec = 0;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
