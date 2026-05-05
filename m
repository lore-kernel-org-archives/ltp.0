Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF70FF885A
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 13:16:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BAD3E61F4
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 15:16:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37E473E1FC7
 for <ltp@lists.linux.it>; Tue,  5 May 2026 15:15:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50BA3600938
 for <ltp@lists.linux.it>; Tue,  5 May 2026 15:15:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 815126B513;
 Tue,  5 May 2026 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777986943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NsW/sP4S3s6E7UeHy7vwi0hTmynJqCFBN9zPhHsEcyk=;
 b=unN0hYzjgIzseuTGpIsJnIJISNl00DbmgmDrvM9w/N9vSVD2rhgkDtaCrJcM7R7SSjkizH
 7mp9Y7GKZIXlZ2a1PJtgoE+n/MM4zTHRiisi6WfiMinunf5QgQXDw+x7c9wKoEvDoKwOZK
 6n2iZbzq7yVyoYYiTVp+wc5LvH0p/hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777986943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NsW/sP4S3s6E7UeHy7vwi0hTmynJqCFBN9zPhHsEcyk=;
 b=1y+sVAZAXbOtfwJAFQFmguy5inHREvYqf4A9zDLRSWuztS0cYnHryCrB9Q4044tWZ2REmw
 7w/Kxx2ggziddYDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777986942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NsW/sP4S3s6E7UeHy7vwi0hTmynJqCFBN9zPhHsEcyk=;
 b=BzcXjczMys3LVWkt7ZI2GjlwW4xEdiYuuJC7xuemPUnXoC7KOjdX3BP/ZnPMGrMM3Sy5WW
 I4jPKCYctTVr6+QHTltcls0IL0tOHSD2LfhOrEoJH3+wLd1K4IBVJy6cWnzTkDfHysnDB1
 he1j2mCYsC5p1Ug+u+zSNmAdU89JLEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777986942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NsW/sP4S3s6E7UeHy7vwi0hTmynJqCFBN9zPhHsEcyk=;
 b=Bun6CcbXiSnDLYYpZz84Z13CawLvqsn+P+EIL5Y2RIPme3S2Y4cpcZL2PXPQ/YRfkx51Y2
 +RroeMwmUmOcNEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3111593A3;
 Tue,  5 May 2026 13:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CYIVOH3t+Wn3QQAAD6G6ig
 (envelope-from <rbranco@suse.de>); Tue, 05 May 2026 13:15:41 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 May 2026 15:14:41 +0200
Message-ID: <20260505131538.21645-1-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] userfaultfd: Minor fixes
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

- Use POSIX semantics for thread function
- Set cleanup to call reset_pages
- Use long for page_size and use unsigned cast
- Call the SAFE_ versions of some system calls
- Use TFAIL consistently for unexpected UFFD_EVENTs

Signed-off-by: Ricardo Branco <rbranco@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/userfaultfd/userfaultfd01.c      | 27 +++++++++++------
 .../syscalls/userfaultfd/userfaultfd02.c      | 27 +++++++++++------
 .../syscalls/userfaultfd/userfaultfd03.c      | 29 ++++++++++++-------
 .../syscalls/userfaultfd/userfaultfd04.c      | 22 +++++++++-----
 .../syscalls/userfaultfd/userfaultfd05.c      | 22 +++++++++-----
 .../syscalls/userfaultfd/userfaultfd06.c      | 14 +++++----
 6 files changed, 91 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 7368d3863..3af0e8240 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -28,10 +28,10 @@ static struct tcase {
 	{ DESC(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY),  .kver = AFTER_5_11, },
 };
 
-static int page_size;
+static long page_size;
 static char *page;
 static void *copy_page;
-static int uffd;
+static int uffd = -1;
 static int kver;
 
 static void setup(void)
@@ -44,7 +44,7 @@ static void setup(void)
 
 static void set_pages(void)
 {
-	page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	copy_page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
@@ -53,11 +53,19 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(copy_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (copy_page) {
+		SAFE_MUNMAP(copy_page, page_size);
+		copy_page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_copy uffdio_copy = {};
@@ -74,18 +82,18 @@ static void *handle_thread(void)
 	SAFE_READ(1, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
-		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
 
 	memset(copy_page, 'X', page_size);
 
 	uffdio_copy.src = (unsigned long) copy_page;
 
 	uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address
-			& ~(page_size - 1);
+			& ~((unsigned long)page_size - 1);
 	uffdio_copy.len = page_size;
 	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
 
-	close(uffd);
+	SAFE_CLOSE(uffd);
 	return NULL;
 }
 
@@ -129,4 +137,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
index 2fd5ba5d8..70dd844b3 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
@@ -16,14 +16,14 @@
 #include "tst_safe_pthread.h"
 #include "lapi/userfaultfd.h"
 
-static int page_size;
+static long page_size;
 static char *page;
 static void *move_page;
-static int uffd;
+static int uffd = -1;
 
 static void set_pages(void)
 {
-	page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	move_page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
@@ -32,11 +32,19 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(move_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (move_page) {
+		SAFE_MUNMAP(move_page, page_size);
+		move_page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_move uffdio_move = {};
@@ -44,18 +52,18 @@ static void *handle_thread(void)
 	SAFE_READ(1, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
-		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
 
 	memset(move_page, 'X', page_size);
 
 	uffdio_move.src = (unsigned long) move_page;
 
 	uffdio_move.dst = (unsigned long) msg.arg.pagefault.address
-			& ~(page_size - 1);
+			& ~((unsigned long)page_size - 1);
 	uffdio_move.len = page_size;
 	SAFE_IOCTL(uffd, UFFDIO_MOVE, &uffdio_move);
 
-	close(uffd);
+	SAFE_CLOSE(uffd);
 	return NULL;
 }
 
@@ -94,4 +102,5 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.min_kver = "6.8",
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
index b65f39eca..8a720e41a 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
@@ -19,10 +19,10 @@
 #include "tst_safe_pthread.h"
 #include "lapi/userfaultfd.h"
 
-static int page_size;
+static long page_size;
 static char *page;
 static void *copy_page;
-static int uffd;
+static int uffd = -1;
 
 static void setup(void)
 {
@@ -48,7 +48,7 @@ static int open_userfaultfd(int flags)
 
 static void set_pages(void)
 {
-	page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	copy_page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
@@ -57,11 +57,19 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(copy_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (copy_page) {
+		SAFE_MUNMAP(copy_page, page_size);
+		copy_page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_copy uffdio_copy = {};
@@ -78,18 +86,18 @@ static void *handle_thread(void)
 	SAFE_READ(1, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
-		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
 
 	memset(copy_page, 'X', page_size);
 
 	uffdio_copy.src = (unsigned long) copy_page;
 
 	uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address
-			& ~(page_size - 1);
+			& ~((unsigned long)page_size - 1);
 	uffdio_copy.len = page_size;
 	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
 
-	close(uffd);
+	SAFE_CLOSE(uffd);
 	return NULL;
 }
 
@@ -132,5 +140,6 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USERFAULTFD=y",
 		NULL
-	}
+	},
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
index 4eb811e45..926812649 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
@@ -17,23 +17,28 @@
 #include "tst_safe_pthread.h"
 #include "lapi/userfaultfd.h"
 
-static int page_size;
+static long page_size;
 static char *page;
-static int uffd;
+static int uffd = -1;
 
 static void set_pages(void)
 {
-	page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 }
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_zeropage uffdio_zeropage = {};
@@ -50,15 +55,15 @@ static void *handle_thread(void)
 	SAFE_READ(1, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
-		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
 
 	uffdio_zeropage.range.start	= msg.arg.pagefault.address
-					& ~(page_size - 1);
+					& ~((unsigned long)page_size - 1);
 	uffdio_zeropage.range.len	= page_size;
 
 	SAFE_IOCTL(uffd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
 
-	close(uffd);
+	SAFE_CLOSE(uffd);
 	return NULL;
 }
 
@@ -98,4 +103,5 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index e25a227cf..59956d85d 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -17,14 +17,14 @@
 #include "tst_safe_pthread.h"
 #include "lapi/userfaultfd.h"
 
-static int page_size;
+static long page_size;
 static char *page;
-static int uffd;
+static int uffd = -1;
 static volatile int wp_fault_seen;
 
 static void set_pages(void)
 {
-	page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
@@ -33,10 +33,15 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_writeprotect uffdio_writeprotect = {};
@@ -70,12 +75,12 @@ static void *handle_thread(void)
 	wp_fault_seen = 1;
 
 	/* Resolve the fault by clearing WP so the writer can resume. */
-	uffdio_writeprotect.range.start	= msg.arg.pagefault.address & ~(page_size - 1);
+	uffdio_writeprotect.range.start	= msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
 	uffdio_writeprotect.range.len	= page_size;
 
 	SAFE_IOCTL(uffd, UFFDIO_WRITEPROTECT, &uffdio_writeprotect);
 
-	close(uffd);
+	SAFE_CLOSE(uffd);
 	return NULL;
 }
 
@@ -127,5 +132,6 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=y",
 		NULL
-	}
+	},
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index 5b1252c35..ec93d8ad6 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -19,9 +19,9 @@
 #include "tst_safe_pthread.h"
 #include "lapi/userfaultfd.h"
 
-static int page_size;
+static long page_size;
 static char *page;
-static int uffd;
+static int uffd = -1;
 static int poison_fault_seen;
 static volatile int sigbus_seen;
 static sigjmp_buf jmpbuf;
@@ -45,7 +45,7 @@ static void setup(void)
 
 static void set_pages(void)
 {
-	page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 }
@@ -56,9 +56,11 @@ static void reset_pages(void)
 		SAFE_MUNMAP(page, page_size);
 		page = NULL;
 	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_poison uffdio_poison = {};
@@ -79,12 +81,12 @@ static void *handle_thread(void)
 	tst_atomic_store(1, &poison_fault_seen);
 
 	/* Poison the page that triggered the fault */
-	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
+	uffdio_poison.range.start = msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
 	uffdio_poison.range.len = page_size;
 
 	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
 
-	close(uffd);
+	SAFE_CLOSE(uffd);
 	return NULL;
 }
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
