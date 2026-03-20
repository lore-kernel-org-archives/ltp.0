Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA9210987B6
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 17:01:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1A8A3E5F3F
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 18:01:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74D083E1FFC
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 18:01:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 586C31A0100B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 18:01:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCDC95BCF8;
 Fri, 20 Mar 2026 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774026063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jBy+rVnwU98GZbaM0jTFJz54FG6OTClwXCpIiuj46Qw=;
 b=Xe9r5gyRxv/eb/JbVyS/20qFuz50xHANu+Pj+JuhwMZJ/841015FhWRpN4oPdUXGDL+naR
 jDXDO2KPt+rumeilApu0aAHcj9z18Kg9uofunXB4w5tzshJbcKF4IGsfhn2w7Rwqg76tsI
 w9Mq8TSuA0BOLTDMxky6HtEbbvqFpJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774026063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jBy+rVnwU98GZbaM0jTFJz54FG6OTClwXCpIiuj46Qw=;
 b=SP3eKDVtK91oX0g057krURHR2ZQMwi+23uOIcPuc8YRSP+QrmidrKwGC+lPeLrE+0ycLtX
 ldsvHFY5VB6toFBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774026062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jBy+rVnwU98GZbaM0jTFJz54FG6OTClwXCpIiuj46Qw=;
 b=ywmdcQezlYPnJw8VJCuXi3Y9JfgBv5gLcXQiL8Zgs1DvSVijuUIDjMG38rx/MzbFC3/6pI
 fYh6X/zmnoOvnEWDDBQqJQD739Tb9MqFMwo/Ev9v63+xnnbZA1gje8x4BMVnOKz9a2Mi0l
 lEXrOA9Hruf6JGjLjXivb2FAzdeNwaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774026062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jBy+rVnwU98GZbaM0jTFJz54FG6OTClwXCpIiuj46Qw=;
 b=4mO7lxj4fQK703DrnWOrHyyDl35+5P6tXWm0RzMnSwdLiDps/E/c3D2AXItHDCz4OHCsyk
 qMH4G/EjKUsDtTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94B7428DE;
 Fri, 20 Mar 2026 17:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cGx4J059vWnaWQAAD6G6ig
 (envelope-from <rbranco@suse.de>); Fri, 20 Mar 2026 17:01:02 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 18:00:56 +0100
Message-ID: <20260320170058.433730-1-rbranco@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd: Minor fixes
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

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 .../kernel/syscalls/userfaultfd/userfaultfd01.c      | 10 +++++++---
 .../kernel/syscalls/userfaultfd/userfaultfd02.c      |  9 ++++++---
 .../kernel/syscalls/userfaultfd/userfaultfd03.c      | 12 ++++++++----
 .../kernel/syscalls/userfaultfd/userfaultfd04.c      |  8 ++++++--
 .../kernel/syscalls/userfaultfd/userfaultfd05.c      | 10 +++++++---
 .../kernel/syscalls/userfaultfd/userfaultfd06.c      |  2 +-
 6 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 7368d3863..b481e5a15 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -53,11 +53,14 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(copy_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		SAFE_MUNMAP(copy_page, page_size);
+		page = NULL;
+	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_copy uffdio_copy = {};
@@ -129,4 +132,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
index 2fd5ba5d8..db9ce4da4 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
@@ -32,11 +32,13 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(move_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		SAFE_MUNMAP(move_page, page_size);
+	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_move uffdio_move = {};
@@ -94,4 +96,5 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.min_kver = "6.8",
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
index b65f39eca..463dfba0b 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
@@ -57,11 +57,14 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(copy_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		SAFE_MUNMAP(copy_page, page_size);
+		page = NULL;
+	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_copy uffdio_copy = {};
@@ -132,5 +135,6 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USERFAULTFD=y",
 		NULL
-	}
+	},
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
index 4eb811e45..3273d20cb 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
@@ -30,10 +30,13 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_zeropage uffdio_zeropage = {};
@@ -98,4 +101,5 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index e25a227cf..4434f9b9f 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -33,10 +33,13 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_writeprotect uffdio_writeprotect = {};
@@ -127,5 +130,6 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=y",
 		NULL
-	}
+	},
+	.cleanup = reset_pages,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index 5b1252c35..238556ba4 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -58,7 +58,7 @@ static void reset_pages(void)
 	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_poison uffdio_poison = {};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
