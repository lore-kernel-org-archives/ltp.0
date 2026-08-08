Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76995C5AC67
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786201435; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=45/2RZwFWF9KyXHm5/PQrJdvPo+SDQCQeC88s/bviZ8=;
 b=qujPauJLN7MhLlR1g7rhAFxZ5lvVoEv1xcPTC1LGnvXxpgCBcneaI1aIO41dGmkVYJPY9
 fg3OCxC6z06n77M8lW+FD3MmlJCijhgktazUlAKCdTTQQYdE4aQBCOorZqMYUF/iTbuXnSc
 DfKMwOPDX8gdanj6yLa2cT5fBgu7+3c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5CDF3E6F79
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 17:03:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19BD43C568D
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:03:35 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C4BE20008B
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:03:34 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso311152f8f.3
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786201414; x=1786806214; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9PjjTToqe8qf8icPZWSFVUn93MJGPFFSEoortKEvb/Q=;
 b=VIzWqXqor5LyjgMtyBBJ2zJEwaxrBSZ2lutqjYBrxg3rKV4C8V/1MIHbvsfVJSGS8Q
 aKn15R8M/XQFw0HRADMGmZab8D9kIkE66OeZyheRoQvaKQFZfCwTQm4wrgFllnf7aG2R
 akqT495ihFn3lGGBQSTAeuVwFVW/AhC1DoyB3279ZMid86bADqCkzCajxTBhtd1w0tJu
 G3JvNyY/kqdirmRUdkv6SFriw6/Q74rBXAYhwpwPnXg0OCEVh7xDqVJLUfkgfxvxwsIu
 NxVko4/P0KQouYR+NlG0jtRIsVtXhKTU0iplos/Lz95c4xQXYGHBfFDi5jJLV2aLuakJ
 /JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786201414; x=1786806214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9PjjTToqe8qf8icPZWSFVUn93MJGPFFSEoortKEvb/Q=;
 b=JiElG1SknFhn0ucdgl48Xg03YdYOE27fzKr8IZCTGjZb9kUfiVx9DZAff/cgHqmGSF
 qB/31SEz1QFSXWjAKRkKwZn5v9ie60v8qNF8j0Lqnrv8G6ny2b/5oCPPUcSedBBaW/ik
 JPSO8K5AVY40egT0fcsGYbjoUefZUtethDDybyYQpZ4G73Iknz+ivYFkqFsqQzLrdgIH
 GZL6dHq0EN6vqLQUjbh7cunFOPfD6qx/Xgd5JrtDT0j3/KEwSodnkGQHsBVx8QIz9y6x
 sUCfy396Rl0eAJOnXF+YR6smMsPibRnPAL7XZ1fj7b7BH2apR4V3l9AfMX4PFjuPOBpQ
 6TBw==
X-Gm-Message-State: AOJu0Yzmbma9WWfda49vhE8Jv6+rfpUS2NLEcjJCBds2ViMwlSkF8z6p
 /AQm+8PuHjVuIgwMmGnYHe6KPzDAfMzrBdpvUelKnY/Wfl7XZ70rSnzpyFFaSkNpaCxI92ACAwt
 lhOqUjPg=
X-Gm-Gg: AR+sD12dGdPVS4Uj0yDGUcZyzIZKskPqQuQh7TluaHpUokGZ4moxR2jjaUh0cNOQA5a
 ETHvh7s399eLIiNVvBXQRsx3FBWppMkQTdh9l1hhhR+ABgbhzOd0wutNxEBRZeau+5mKUJSQNgr
 PXEUwj93m/+LC+Z1meAtL9sZW8KEHtbXcTaP8/FY8H21E3Ti6RQL+vi444mq7akQigGVbJP87LO
 2mMUzFV79nRiAYcOKpsN7Ld6uweprnAuQ7umFpVaP7R55Hvqo1g+Ip+3tGMpJq3Fi9PIUsIuseq
 rVbuWMGp0uTUNFRltTf+9oG7YeuHgHi/rvoOzI1QApEWr/dKGzeKy6a+3WGj022PY3RvChtGj61
 yjj1j2Bd7fKJUHOkIwxrshRlaxTnEpO/KDAVL4pi1TSoEHYX8NpdVMNp/bUihTosPFVZ/3U1dmB
 zbEdOoVQ0oJgrDxyocch7TRUUc9LgwV9P6itdrTrVwmjul4aV/Jfk85V5pdg==
X-Received: by 2002:a05:6000:1a8c:b0:47f:ebdf:2022 with SMTP id
 ffacd0b85a97d-47fec519b11mr49185545f8f.12.1786201413608; 
 Sat, 08 Aug 2026 08:03:33 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f8b9bsm18123474f8f.25.2026.08.08.08.03.32
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:03:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  8 Aug 2026 17:03:31 +0200
Message-ID: <20260808150331.127440-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] openposix: timer_*/speculative: Handle SIGSEGV on
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
index 912cf5800e6f..af01f72a59d1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -13,16 +13,35 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTIMERID 99999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
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
index 6e18560e5084..faaa4bc09329 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -13,16 +13,35 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
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
index d09c2f70901d..91c8aaad59c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -13,16 +13,36 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
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
index 5d4e1dda30ba..092ca723975d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -12,16 +12,36 @@
 #include <time.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <unistd.h>
 #include "posixtest.h"
 
 #define BOGUSTID 9999
 
+/*
+ * when timerid argument does not correspond to a timer ID returned by
+ * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
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
