Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F98FC433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:28:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 099753C9B6C
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:28:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA4993C6912
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:28:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9FD6D6013A8
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:28:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE426210DE;
 Wed,  9 Feb 2022 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644398887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=55ZcTeQJTqs/wxL6DVGG6Mm8mTC75U9gz3TyNJ1Yy6k=;
 b=Exm21K+DWEdSR3ZKXI1vTJsUm39RwZyJzB/P85Ii3jG4f9VIUYGFBDubbuZ4z8hbv1lJME
 T3Z/LzutFJK/5ITJuoOjmIp2J/bWMNaVtiSi8T/MkqPFB+zbIYqB65UcU7L+AZERMxk3Pz
 tX0+EqEaERjkn4iNVMiUWClewXypp6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644398887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=55ZcTeQJTqs/wxL6DVGG6Mm8mTC75U9gz3TyNJ1Yy6k=;
 b=P7SEqQSbphVHRUpNH4CQ89F/xsKHFACb2ZX899htK+zQJv6tXGq4k+a3gUqN4Vd0VHwSra
 bJ3UgrydEWKTAQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68A2A13522;
 Wed,  9 Feb 2022 09:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KWDhFyeJA2LRQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 09 Feb 2022 09:28:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  9 Feb 2022 10:28:03 +0100
Message-Id: <20220209092803.14153-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify: Fix various checkparse warnings
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
Cc: Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* prefer 'unsigned int' to bare use of 'unsigned'
* add missing static to test functions (add with inline to functions in
  fanotify.h)
* remove else after return
* missing a blank line after declarations
* space prohibited between function name and open parenthesis '('

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

detected with 'make check'. Obviously only missing static would be worth
of fixing, but real error can be overlooked when among many formatting
fixes. THus fixed that all.

Based on v2 'fanotify/fanotify04: Bugfix for running with option of "-i 500"'
https://lore.kernel.org/ltp/20220209080510.167709-1-zhaogongyi@huawei.com/

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify.h |  4 +--
 .../kernel/syscalls/fanotify/fanotify01.c     | 24 +++++++++-------
 .../kernel/syscalls/fanotify/fanotify02.c     | 14 +++++-----
 .../kernel/syscalls/fanotify/fanotify03.c     | 10 +++----
 .../kernel/syscalls/fanotify/fanotify04.c     |  4 +--
 .../kernel/syscalls/fanotify/fanotify05.c     | 15 +++++-----
 .../kernel/syscalls/fanotify/fanotify06.c     | 17 ++++++-----
 .../kernel/syscalls/fanotify/fanotify07.c     |  6 ++--
 .../kernel/syscalls/fanotify/fanotify08.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify09.c     | 17 +++++------
 .../kernel/syscalls/fanotify/fanotify10.c     | 10 +++----
 .../kernel/syscalls/fanotify/fanotify11.c     |  4 +--
 .../kernel/syscalls/fanotify/fanotify12.c     | 10 +++----
 .../kernel/syscalls/fanotify/fanotify13.c     |  4 ++-
 .../kernel/syscalls/fanotify/fanotify15.c     |  9 +++---
 .../kernel/syscalls/fanotify/fanotify16.c     | 28 +++++++++----------
 .../kernel/syscalls/fanotify/fanotify18.c     | 14 +++++-----
 .../kernel/syscalls/fanotify/fanotify19.c     | 19 +++++++------
 .../kernel/syscalls/fanotify/fanotify21.c     |  4 +--
 .../kernel/syscalls/fanotify/fanotify22.c     | 10 +++----
 20 files changed, 117 insertions(+), 111 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index f7778bb36b..b2855d2928 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -15,7 +15,7 @@
 #include <sys/fanotify.h>
 #include "lapi/fcntl.h"
 
-int safe_fanotify_init(const char *file, const int lineno,
+static inline int safe_fanotify_init(const char *file, const int lineno,
 	unsigned int flags, unsigned int event_f_flags)
 {
 	int rval;
@@ -433,7 +433,7 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
 } while (0)
 
-struct fanotify_event_info_header *get_event_info(
+static inline struct fanotify_event_info_header *get_event_info(
 					struct fanotify_event_metadata *event,
 					int info_type)
 {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 6b64e5b135..23b88cd526 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -26,7 +26,7 @@
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
@@ -252,21 +252,21 @@ static void test_fanotify(unsigned int n)
 				"got unnecessary event: mask=%llx "
 				"pid=%u fd=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		} else if (!(event->mask & event_set[test_num])) {
 			tst_res(TFAIL,
 				"got event: mask=%llx (expected %llx) "
 				"pid=%u fd=%d",
 				(unsigned long long)event->mask,
 				event_set[test_num],
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		} else if (event->pid != getpid()) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u "
 				"(expected %u) fd=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid,
-				(unsigned)getpid(),
+				(unsigned int)event->pid,
+				(unsigned int)getpid(),
 				event->fd);
 		} else {
 			if (event->fd == -2 || (event->fd == FAN_NOFD &&
@@ -279,7 +279,7 @@ static void test_fanotify(unsigned int n)
 					"of event: mask=%llx pid=%u "
 					"fd=%d ret=%d (errno=%d)",
 					(unsigned long long)event->mask,
-					(unsigned)event->pid,
+					(unsigned int)event->pid,
 					event->fd, ret, errno);
 			} else if (memcmp(buf, fname, strlen(fname))) {
 				tst_res(TFAIL,
@@ -287,16 +287,17 @@ static void test_fanotify(unsigned int n)
 					"of event: mask=%llx pid=%u "
 					"fd=%d",
 					(unsigned long long)event->mask,
-					(unsigned)event->pid,
+					(unsigned int)event->pid,
 					event->fd);
 			} else {
 pass:
 				tst_res(TPASS,
 					"got event: mask=%llx pid=%u fd=%d",
 					(unsigned long long)event->mask,
-					(unsigned)event->pid, event->fd);
+					(unsigned int)event->pid, event->fd);
 			}
 		}
+
 		/*
 		 * We have verified the data now so close fd and
 		 * invalidate it so that we don't check it again
@@ -306,17 +307,20 @@ pass:
 			SAFE_CLOSE(event->fd);
 		event->fd = -2;
 		event->mask &= ~event_set[test_num];
+
 		/* No events left in current mask? Go for next event */
-		if (event->mask == 0) {
+		if (event->mask == 0)
 			i += event->event_len;
-		}
+
 		test_num++;
 	}
+
 	for (; test_num < TST_TOTAL; test_num++) {
 		tst_res(TFAIL, "didn't get event: mask=%llx",
 			event_set[test_num]);
 
 	}
+
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index eb40a2e24c..9132e1a747 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -26,7 +26,7 @@
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
@@ -41,7 +41,7 @@ static unsigned long long event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-void test01(void)
+static void test01(void)
 {
 	int ret, len, i = 0, test_num = 0;
 
@@ -139,27 +139,27 @@ void test01(void)
 				"get unnecessary event: mask=%llx "
 				"pid=%u fd=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		} else if (!(event->mask & event_set[test_num])) {
 			tst_res(TFAIL,
 				"got event: mask=%llx (expected %llx) "
 				"pid=%u fd=%d",
 				(unsigned long long)event->mask,
 				event_set[test_num],
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		} else if (event->pid != getpid()) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u "
 				"(expected %u) fd=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid,
-				(unsigned)getpid(),
+				(unsigned int)event->pid,
+				(unsigned int)getpid(),
 				event->fd);
 		} else {
 			tst_res(TPASS,
 				"got event: mask=%llx pid=%u fd=%u",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		}
 		event->mask &= ~event_set[test_num];
 		/* No events left in current mask? Go for next event */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 2081f0bd1b..a3b9d5c375 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -30,7 +30,7 @@
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 /* Size large enough to hold a reasonable amount of expected event objects */
@@ -273,20 +273,20 @@ static void test_fanotify(unsigned int n)
 				"pid=%u fd=%d",
 				(unsigned long long)event->mask,
 				event_set[test_num].mask,
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		} else if (event->pid != child_pid) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u "
 				"(expected %u) fd=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid,
-				(unsigned)child_pid,
+				(unsigned int)event->pid,
+				(unsigned int)child_pid,
 				event->fd);
 		} else {
 			tst_res(TPASS,
 				"got event: mask=%llx pid=%u fd=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd);
 		}
 
 		/* Write response to the permission event */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 8c3c179b19..8541a7b969 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -25,7 +25,7 @@
 #include "fanotify.h"
 
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 
 #define BUF_SIZE 256
 #define TST_TOTAL 9
@@ -162,7 +162,7 @@ static void test_open_symlink(char *file)
 	verify_no_event();
 }
 
-void test01(void)
+static void test01(void)
 {
 	/* Check ONLYDIR on a directory */
 	CHECK_MARK(".", FAN_MARK_ONLYDIR, 0, NULL);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 9187025f7e..04670cb1cc 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -63,23 +63,24 @@ static char symlnk[BUF_SIZE];
 static char fdpath[BUF_SIZE];
 static int fd, fd_notify;
 
-struct fanotify_event_metadata event;
+static struct fanotify_event_metadata event;
 
 static void event_res(struct fanotify_event_metadata *event, int i)
 {
 	int len = 0;
 	const char *filename;
+
 	sprintf(symlnk, "/proc/self/fd/%d", event->fd);
 	len = readlink(symlnk, fdpath, sizeof(fdpath));
 	if (len < 0)
 		len = 0;
 	fdpath[len] = 0;
 	filename = basename(fdpath);
-	if (len > FNAME_PREFIX_LEN && atoi(filename + FNAME_PREFIX_LEN) != i) {
+
+	if (len > FNAME_PREFIX_LEN && atoi(filename + FNAME_PREFIX_LEN) != i)
 		tst_res(TFAIL, "Got event #%d out of order filename=%s", i, filename);
-	} else if (i == 0) {
+	else if (i == 0)
 		tst_res(TINFO, "Got event #%d filename=%s", i, filename);
-	}
 }
 
 static void generate_events(int open_flags, int num_files)
@@ -161,7 +162,7 @@ static void test_fanotify(unsigned int n)
 				"got event: mask=%llx (expected %llx) pid=%u fd=%d",
 				(unsigned long long)event.mask,
 				(unsigned long long)FAN_OPEN,
-				(unsigned)event.pid, event.fd);
+				(unsigned int)event.pid, event.fd);
 			break;
 		}
 		if (event.mask == FAN_Q_OVERFLOW) {
@@ -170,13 +171,13 @@ static void test_fanotify(unsigned int n)
 					"%s overflow event: mask=%llx pid=%u fd=%d",
 					got_overflow ? "unexpected" : "invalid",
 					(unsigned long long)event.mask,
-					(unsigned)event.pid,
+					(unsigned int)event.pid,
 					event.fd);
 				break;
 			}
 			tst_res(expect_overflow ? TPASS : TFAIL,
 				"Got an overflow event: pid=%u fd=%d",
-				(unsigned)event.pid, event.fd);
+				(unsigned int)event.pid, event.fd);
 			got_overflow = 1;
 		}
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 30055da4b3..618c85a43d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -45,11 +45,11 @@
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
-unsigned int fanotify_prio[] = {
+static unsigned int fanotify_prio[] = {
 	FAN_CLASS_PRE_CONTENT,
 	FAN_CLASS_CONTENT,
 	FAN_CLASS_NOTIF
@@ -124,16 +124,16 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 		tst_res(TFAIL, "group %d got event: mask %llx (expected %llx) "
 			"pid=%u fd=%d", group, (unsigned long long)event->mask,
 			(unsigned long long)FAN_MODIFY,
-			(unsigned)event->pid, event->fd);
+			(unsigned int)event->pid, event->fd);
 	} else if (event->pid != getpid()) {
 		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
 			"(expected %u) fd=%d", group,
-			(unsigned long long)event->mask, (unsigned)event->pid,
-			(unsigned)getpid(), event->fd);
+			(unsigned long long)event->mask, (unsigned int)event->pid,
+			(unsigned int)getpid(), event->fd);
 	} else {
 		tst_res(TPASS, "group %d got event: mask %llx pid=%u fd=%d",
 			group, (unsigned long long)event->mask,
-			(unsigned)event->pid, event->fd);
+			(unsigned int)event->pid, event->fd);
 	}
 }
 
@@ -148,7 +148,7 @@ static void close_events_fd(struct fanotify_event_metadata *event, int buflen)
 	}
 }
 
-void test_fanotify(unsigned int n)
+static void test_fanotify(unsigned int n)
 {
 	int ret;
 	unsigned int p, i;
@@ -158,8 +158,7 @@ void test_fanotify(unsigned int n)
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
 	if (tc->use_overlay && !ovl_mounted) {
-		tst_res(TCONF,
-		        "overlayfs is not configured in this kernel.");
+		tst_res(TCONF, "overlayfs is not configured in this kernel");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 8887a2d491..1d3c080236 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -137,13 +137,11 @@ static void loose_fanotify_events(void)
 				"pid=%u fd=%d",
 				(unsigned long long)event.mask,
 				(unsigned long long)FAN_ACCESS_PERM,
-				(unsigned)event.pid, event.fd);
+				(unsigned int)event.pid, event.fd);
 			break;
 		}
 
-		/*
-		 * We respond to permission event with 95% percent
-		 * probability. */
+		/* We respond to permission event with 95% percent probability. */
 		if (random() % 100 > 5) {
 			/* Write response to permission event */
 			resp.fd = event.fd;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
index f86b567523..de57f04d2c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify08.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -35,11 +35,10 @@ static void test_init_bit(unsigned int fan_bit,
 
 	ret = SAFE_FCNTL(fd_notify, F_GETFD);
 
-	if ((ret & FD_CLOEXEC) == fd_bit) {
+	if ((ret & FD_CLOEXEC) == fd_bit)
 		tst_res(TPASS, "%s", msg);
-	} else {
+	else
 		tst_res(TFAIL, "%s", msg);
-	}
 
 	SAFE_CLOSE(fd_notify);
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index d622ff3a22..fea3746895 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -47,7 +47,7 @@
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
@@ -179,6 +179,7 @@ static void event_res(int ttype, int group,
 {
 	if (event->fd != FAN_NOFD) {
 		int len = 0;
+
 		sprintf(symlnk, "/proc/self/fd/%d", event->fd);
 		len = readlink(symlnk, fdpath, sizeof(fdpath));
 		if (len < 0)
@@ -186,9 +187,10 @@ static void event_res(int ttype, int group,
 		fdpath[len] = 0;
 		filename = fdpath;
 	}
+
 	tst_res(ttype, "group %d got event: mask %llx pid=%u fd=%d filename=%s",
 		group, (unsigned long long)event->mask,
-		(unsigned)event->pid, event->fd, filename);
+		(unsigned int)event->pid, event->fd, filename);
 }
 
 static const char *event_filename(struct fanotify_event_metadata *event)
@@ -218,16 +220,16 @@ static void verify_event(int group, struct fanotify_event_metadata *event,
 		tst_res(TFAIL, "group %d got event: mask %llx (expected %llx) "
 			"pid=%u fd=%d filename=%s", group, (unsigned long long)event->mask,
 			(unsigned long long)expect,
-			(unsigned)event->pid, event->fd, filename);
+			(unsigned int)event->pid, event->fd, filename);
 	} else if (event->pid != getpid()) {
 		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
 			"(expected %u) fd=%d filename=%s", group,
-			(unsigned long long)event->mask, (unsigned)event->pid,
-			(unsigned)getpid(), event->fd, filename);
+			(unsigned long long)event->mask, (unsigned int)event->pid,
+			(unsigned int)getpid(), event->fd, filename);
 	} else if (strcmp(filename, expect_filename)) {
 		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
 			"fd=%d filename='%s' (expected '%s')", group,
-			(unsigned long long)event->mask, (unsigned)event->pid,
+			(unsigned long long)event->mask, (unsigned int)event->pid,
 			event->fd, filename, expect_filename);
 	} else {
 		event_res(TPASS, group, event, filename);
@@ -323,9 +325,8 @@ static void test_fanotify(unsigned int n)
 			continue;
 		}
 
-		if (ret == 0) {
+		if (ret == 0)
 			tst_brk(TBROK, "zero length read from fanotify fd");
-		}
 
 		if (errno != EAGAIN) {
 			tst_brk(TBROK | TERRNO,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 0fa9d1f4f7..067dd65aeb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -49,7 +49,7 @@
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
@@ -365,16 +365,16 @@ static void verify_event(int p, int group, struct fanotify_event_metadata *event
 			"pid=%u fd=%u", group, fanotify_class[p],
 			(unsigned long long) event->mask,
 			(unsigned long long) expected_mask,
-			(unsigned)event->pid, event->fd);
+			(unsigned int)event->pid, event->fd);
 	} else if (event->pid != child_pid) {
 		tst_res(TFAIL, "group %d (%x) got event: mask %llx pid=%u "
 			"(expected %u) fd=%u", group, fanotify_class[p],
-			(unsigned long long)event->mask, (unsigned)event->pid,
-			(unsigned)getpid(), event->fd);
+			(unsigned long long)event->mask, (unsigned int)event->pid,
+			(unsigned int)getpid(), event->fd);
 	} else {
 		tst_res(TPASS, "group %d (%x) got event: mask %llx pid=%u fd=%u",
 			group, fanotify_class[p], (unsigned long long)event->mask,
-			(unsigned)event->pid, event->fd);
+			(unsigned int)event->pid, event->fd);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index b21c986cc7..03583d84be 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -38,7 +38,7 @@ static int tid;
 
 static int fan_report_tid_unsupported;
 
-void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	char tid_file[64] = {0};
 
@@ -54,7 +54,7 @@ static unsigned int tcases[] = {
 	FAN_CLASS_NOTIF | FAN_REPORT_TID
 };
 
-void test01(unsigned int i)
+static void test01(unsigned int i)
 {
 	pthread_t p_id;
 	struct fanotify_event_metadata event;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index c77dbfd8c2..52e728e2a2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -28,7 +28,7 @@
 #include "fanotify.h"
 
 #define EVENT_MAX 1024
-#define EVENT_SIZE (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE (sizeof(struct fanotify_event_metadata))
 #define EVENT_BUF_LEN (EVENT_MAX * EVENT_SIZE)
 #define EVENT_SET_BUF 32
 
@@ -190,21 +190,21 @@ static void do_test(unsigned int n)
 				"pid=%u, fd=%d",
 				(unsigned long long) event->mask,
 				*(tc->event_set + event_num),
-				(unsigned) event->pid,
+				(unsigned int) event->pid,
 				event->fd);
 		} else if (event->pid != child_pid) {
 			tst_res(TFAIL,
 				"Received event: mask=%llx, pid=%u (expected "
 				"%u), fd=%d",
 				(unsigned long long) event->mask,
-				(unsigned) event->pid,
-				(unsigned) child_pid,
+				(unsigned int) event->pid,
+				(unsigned int) child_pid,
 				event->fd);
 		} else {
 			tst_res(TPASS,
 				"Received event: mask=%llx, pid=%u, fd=%d",
 				(unsigned long long) event->mask,
-				(unsigned) event->pid,
+				(unsigned int) event->pid,
 				event->fd);
 		}
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 9061c1ffed..c3daaf3a2e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -12,7 +12,7 @@
  * calls statfs(2) and name_to_handle_at(2).
  */
 
- /*
+/*
  * This is also regression test for:
  *     c285a2f01d69 ("fanotify: update connector fsid cache on add mark")
  */
@@ -109,6 +109,7 @@ static void create_objects(void)
 static void get_object_stats(void)
 {
 	unsigned int i;
+
 	for (i = 0; i < ARRAY_SIZE(objects); i++)
 		fanotify_save_fid(objects[i].path, &objects[i].fid);
 }
@@ -181,6 +182,7 @@ static void do_test(unsigned int number)
 		FAN_EVENT_OK(metadata, len);
 		metadata = FAN_EVENT_NEXT(metadata, len), i++) {
 		struct fanotify_fid_t *expected_fid = &objects[i].fid;
+
 		event_fid = (struct fanotify_event_info_fid *) (metadata + 1);
 		event_file_handle = (struct file_handle *) event_fid->handle;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 16b2d7ad25..6109d32cd0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -34,10 +34,10 @@
 /* Size of the event structure, not including file handle */
 #define EVENT_SIZE (sizeof(struct fanotify_event_metadata) + \
 		    sizeof(struct fanotify_event_info_fid))
+
 /* Double events buffer size to account for file handles */
 #define EVENT_BUF_LEN (EVENT_MAX * EVENT_SIZE * 2)
 
-
 #define MOUNT_POINT "mntpoint"
 #define TEST_DIR MOUNT_POINT"/test_dir"
 #define DIR1 TEST_DIR"/dir1"
@@ -187,6 +187,7 @@ static void do_test(unsigned int number)
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
 		FAN_EVENT_OK(metadata, len); i++) {
 		struct event_t *expected = &event_set[i];
+
 		event_fid = (struct fanotify_event_info_fid *) (metadata + 1);
 		event_file_handle = (struct file_handle *) event_fid->handle;
 
@@ -208,15 +209,15 @@ static void do_test(unsigned int number)
 				"Got event: mask=%llx (expected %llx) "
 				"pid=%u fd=%d",
 				(unsigned long long) metadata->mask,
-				expected->mask, (unsigned) metadata->pid,
+				expected->mask, (unsigned int) metadata->pid,
 				metadata->fd);
 		} else if (metadata->pid != getpid()) {
 			tst_res(TFAIL,
 				"Got event: mask=%llx pid=%u "
 				"(expected %u) fd=%d",
 				(unsigned long long) metadata->mask,
-				(unsigned) metadata->pid,
-				(unsigned) getpid(),
+				(unsigned int) metadata->pid,
+				(unsigned int) getpid(),
 				metadata->fd);
 		} else if (event_file_handle->handle_bytes !=
 			   expected->fid->handle.handle_bytes) {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 1caf29f235..40bcdd5815 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -36,10 +36,10 @@
 /* Size of the event structure, not including file handle */
 #define EVENT_SIZE (sizeof(struct fanotify_event_metadata) + \
 		    sizeof(struct fanotify_event_info_fid))
+
 /* Tripple events buffer size to account for file handles and names */
 #define EVENT_BUF_LEN (EVENT_MAX * EVENT_SIZE * 3)
 
-
 #define BUF_SIZE 256
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
@@ -386,7 +386,7 @@ check_match:
 				"pid=%u fd=%d name='%s' "
 				"len=%d info_type=%d info_len=%d fh_len=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
 		} else if (!fhlen || namelen < 0) {
@@ -394,7 +394,7 @@ check_match:
 				"got event without fid: mask=%llx pid=%u fd=%d, "
 				"len=%d info_type=%d info_len=%d fh_len=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd,
+				(unsigned int)event->pid, event->fd,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
 		} else if (!mask_match) {
@@ -403,7 +403,7 @@ check_match:
 				"pid=%u fd=%d name='%s' "
 				"len=%d info_type=%d info_len=%d fh_len=%d",
 				(unsigned long long)event->mask, expected->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
 		} else if (info_type != event_fid->hdr.info_type) {
@@ -411,7 +411,7 @@ check_match:
 				"got event: mask=%llx pid=%u fd=%d, "
 				"len=%d info_type=%d expected(%d) info_len=%d fh_len=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd,
+				(unsigned int)event->pid, event->fd,
 				event->event_len, event_fid->hdr.info_type,
 				info_type, event_fid->hdr.len, fhlen);
 		} else if (fhlen != expected_fid->handle.handle_bytes) {
@@ -420,7 +420,7 @@ check_match:
 				"len=%d info_type=%d info_len=%d fh_len=%d expected(%d) "
 				"fh_type=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
 				expected_fid->handle.handle_bytes,
@@ -432,7 +432,7 @@ check_match:
 				"len=%d info_type=%d info_len=%d fh_len=%d "
 				"fh_type=%d expected(%x)",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
 				file_handle->handle_type,
@@ -444,7 +444,7 @@ check_match:
 				"len=%d info_type=%d info_len=%d fh_len=%d "
 				"fh_type=%d unexpected file handle (%x...)",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
 				file_handle->handle_type,
@@ -456,7 +456,7 @@ check_match:
 				"len=%d info_type=%d info_len=%d fh_len=%d "
 				"fsid=%x.%x (expected %x.%x)",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
 				FSID_VAL_MEMBER(event_fid->fsid, 0),
@@ -469,7 +469,7 @@ check_match:
 				"pid=%u fd=%d name='%s' expected('%s') "
 				"len=%d info_type=%d info_len=%d fh_len=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd,
+				(unsigned int)event->pid, event->fd,
 				filename, expected->name,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
@@ -479,8 +479,8 @@ check_match:
 				"(expected %u) fd=%d name='%s' "
 				"len=%d info_type=%d info_len=%d fh_len=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid,
-				(unsigned)getpid(),
+				(unsigned int)event->pid,
+				(unsigned int)getpid(),
 				event->fd, filename,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
@@ -490,7 +490,7 @@ check_match:
 				"pid=%u fd=%d name='%s' num_info=%d (expected %d) "
 				"len=%d info_type=%d info_len=%d fh_len=%d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd,
+				(unsigned int)event->pid, event->fd,
 				filename, 1 + !!child_fid, 1 + !!expected_child_fid,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
@@ -515,7 +515,7 @@ check_match:
 				"got event #%d: mask=%llx pid=%u fd=%d name='%s' "
 				"len=%d; info #%d: info_type=%d info_len=%d fh_len=%d",
 				test_num, (unsigned long long)event->mask,
-				(unsigned)event->pid, event->fd, filename,
+				(unsigned int)event->pid, event->fd, filename,
 				event->event_len, info_id, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
 		}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify18.c b/testcases/kernel/syscalls/fanotify/fanotify18.c
index 54a4b8ba09..07b064b921 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify18.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify18.c
@@ -115,14 +115,13 @@ static void test_fanotify(unsigned int n)
 		    ((tc->init_flags & DISALLOWED_INIT_FLAGS) ||
 		     (tc->init_flags & FANOTIFY_REQUIRED_USER_INIT_FLAGS) !=
 		      FANOTIFY_REQUIRED_USER_INIT_FLAGS)) {
-			tst_res(TPASS,
-				"Received result EPERM, as expected");
+			tst_res(TPASS, "Received result EPERM, as expected");
 			return;
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_init(0x%lx, O_RDONLY) failed",
-				tc->init_flags);
 		}
+
+		tst_brk(TBROK | TERRNO,
+			"fanotify_init(0x%lx, O_RDONLY) failed",
+			tc->init_flags);
 	}
 
 	/* Attempt to place mark on object */
@@ -159,6 +158,7 @@ out:
 static void setup(void)
 {
 	int fd;
+	struct passwd *nobody;
 
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
@@ -169,7 +169,7 @@ static void setup(void)
 	if (geteuid() == 0) {
 		tst_res(TINFO,
 			"Running as privileged user, revoking permissions.");
-		struct passwd *nobody = SAFE_GETPWNAM("nobody");
+		nobody = SAFE_GETPWNAM("nobody");
 		SAFE_SETUID(nobody->pw_uid);
 	}
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
index fac257bb47..ec5b54bcd6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify19.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -29,7 +29,7 @@
 #include "fanotify.h"
 
 #define EVENT_MAX 1024
-#define EVENT_SIZE (sizeof (struct fanotify_event_metadata))
+#define EVENT_SIZE (sizeof(struct fanotify_event_metadata))
 #define EVENT_BUF_LEN (EVENT_MAX * EVENT_SIZE)
 #define EVENT_SET_MAX 48
 
@@ -143,13 +143,14 @@ static void test_fanotify(unsigned int n)
 	unsigned int test_number = 0;
 	struct fanotify_event_metadata *event;
 	struct test_case_t *tc = &test_cases[n];
+	struct passwd *nobody;
 
 	tst_res(TINFO, "Test #%d %s", n, tc->name);
 
 	/* Relinquish privileged user */
 	if (euid == 0) {
 		tst_res(TINFO, "Running as privileged user, revoking");
-		struct passwd *nobody = SAFE_GETPWNAM("nobody");
+		nobody = SAFE_GETPWNAM("nobody");
 		SAFE_SETEUID(nobody->pw_uid);
 	}
 
@@ -161,10 +162,10 @@ static void test_fanotify(unsigned int n)
 			tst_res(TCONF,
 				"unprivileged fanotify not supported by kernel?");
 			return;
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_init(FAN_CLASS_NOTIF, O_RDONLY) failed");
 		}
+
+		tst_brk(TBROK | TERRNO,
+			"fanotify_init(FAN_CLASS_NOTIF, O_RDONLY) failed");
 	}
 
 	/* Place mark on object */
@@ -202,7 +203,7 @@ static void test_fanotify(unsigned int n)
 				"Received unexpected event mask: mask=%llx "
 				"pid=%u fd=%d",
 				(unsigned long long) event->mask,
-				(unsigned) event->pid,
+				(unsigned int) event->pid,
 				event->fd);
 		} else if ((!tc->fork && event->pid != pid) ||
 			   (tc->fork && event->pid != 0)) {
@@ -210,7 +211,7 @@ static void test_fanotify(unsigned int n)
 				"Received unexpected pid in event: "
 				"mask=%llx pid=%u (expected %u) fd=%d",
 				(unsigned long long) event->mask,
-				(unsigned) event->pid,
+				(unsigned int) event->pid,
 				(tc->fork ? 0 : pid),
 				event->fd);
 		} else if (event->fd != FAN_NOFD) {
@@ -218,7 +219,7 @@ static void test_fanotify(unsigned int n)
 				"Received unexpected file descriptor: "
 				"mask=%llx pid=%u fd=%d (expected %d)",
 				(unsigned long long) event->pid,
-				(unsigned) event->pid,
+				(unsigned int) event->pid,
 				event->fd,
 				FAN_NOFD);
 			SAFE_CLOSE(event->fd);
@@ -226,7 +227,7 @@ static void test_fanotify(unsigned int n)
 			tst_res(TPASS,
 				"Received event: mask=%llx, pid=%u fd=%d",
 				(unsigned long long) event->mask,
-				(unsigned) event->pid,
+				(unsigned int) event->pid,
 				event->fd);
 		}
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 6ae70c57e5..a8917992a4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -32,7 +32,7 @@
 #define MOUNT_PATH	"fs_mnt"
 #define TEST_FILE	MOUNT_PATH "/testfile"
 
-struct pidfd_fdinfo_t {
+static struct pidfd_fdinfo_t {
 	int pos;
 	int flags;
 	int mnt_id;
@@ -40,7 +40,7 @@ struct pidfd_fdinfo_t {
 	int ns_pid;
 };
 
-struct test_case_t {
+static struct test_case_t {
 	char *name;
 	int fork;
 	int want_pidfd_err;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 5173efcbc0..f45c8512df 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -46,7 +46,7 @@
 #ifdef HAVE_NAME_TO_HANDLE_AT
 
 static char event_buf[BUF_SIZE];
-int fd_notify;
+static int fd_notify;
 
 /* These expected FIDs are common to multiple tests */
 static struct fanotify_fid_t null_fid;
@@ -125,7 +125,7 @@ static struct test_case {
 	}
 };
 
-int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
+static int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
 				 const struct test_case *ex)
 {
 	struct file_handle *fh = (struct file_handle *) &fid->handle;
@@ -158,7 +158,7 @@ int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
 	return 0;
 }
 
-int check_error_event_info_error(struct fanotify_event_info_error *info_error,
+static int check_error_event_info_error(struct fanotify_event_info_error *info_error,
 				 const struct test_case *ex)
 {
 	int fail = 0;
@@ -178,7 +178,7 @@ int check_error_event_info_error(struct fanotify_event_info_error *info_error,
 	return fail;
 }
 
-int check_error_event_metadata(struct fanotify_event_metadata *event)
+static int check_error_event_metadata(struct fanotify_event_metadata *event)
 {
 	int fail = 0;
 
@@ -196,7 +196,7 @@ int check_error_event_metadata(struct fanotify_event_metadata *event)
 	return fail;
 }
 
-void check_event(char *buf, size_t len, const struct test_case *ex)
+static void check_event(char *buf, size_t len, const struct test_case *ex)
 {
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
