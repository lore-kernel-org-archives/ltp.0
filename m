Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7002109C033
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:47:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E3673E3000
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:47:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36EEE3C2C33
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:47:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 929F91A007E3
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:47:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED3894D22F;
 Wed, 25 Mar 2026 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774453638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dga3VmpTQwCPm/YGGkK558jVz3od1j5R/JKwFuLUMwM=;
 b=ddYT2mLyRc87p8lpGmc/Iz7/CBD9jhAvE2ZsGgW/FsuEQov9JMINTbuLTj0ZtJ3AKJGGCT
 4cQTUk1jc6oqc2xGgOWm+mi+NeC7Ra3qgjbp2tRgU8dRKmDq/mzNhtlYm9zzjViH0+doYz
 tSl4SrZOR3ruFDdnjpsQ9XhARtNpEEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774453638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dga3VmpTQwCPm/YGGkK558jVz3od1j5R/JKwFuLUMwM=;
 b=/fAvgy7pv/L3rBlQsuGauLohCTWA+QUujL24AeFd4V9lTW0WS0GOvM+MVE5ESWojUEbjvN
 6eYkZI4XWmXWAWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774453636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dga3VmpTQwCPm/YGGkK558jVz3od1j5R/JKwFuLUMwM=;
 b=cRyPinCS1q/HmbHIuKDvKzXOWkCGtkxo/m5FgJPcKWGM0tB+uUcj//aHgYDzoKO8SwSFKv
 CUgblZ3t23pr6ihjS03lZ9f6vKMMXif7kDRr7HWE+DF0NCDv0pKbvNDWCXdWQjCTGWOJ49
 h8lOqhawy1e4Mb8qYRZuyrxdIL7cxyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774453636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dga3VmpTQwCPm/YGGkK558jVz3od1j5R/JKwFuLUMwM=;
 b=QGytza/j1JUHN3/5gCAUAf0Evspy70/umVeG1/ehfKkBzAaI96LISwBhURfgqaxokGpXoZ
 uBBL+yDfSiBGRBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C893A44496;
 Wed, 25 Mar 2026 15:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1r+UL4QDxGnnGwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 25 Mar 2026 15:47:16 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Wed, 25 Mar 2026 16:47:13 +0100
Message-ID: <20260325154714.102467-1-rbranco@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] userfaultfd: Minor fixes
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/userfaultfd/userfaultfd01.c      | 10 +++++++---
 .../kernel/syscalls/userfaultfd/userfaultfd02.c      | 10 +++++++---
 .../kernel/syscalls/userfaultfd/userfaultfd03.c      | 12 ++++++++----
 .../kernel/syscalls/userfaultfd/userfaultfd04.c      |  8 ++++++--
 .../kernel/syscalls/userfaultfd/userfaultfd05.c      | 10 +++++++---
 .../kernel/syscalls/userfaultfd/userfaultfd06.c      |  2 +-
 6 files changed, 36 insertions(+), 16 deletions(-)

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
index 2fd5ba5d8..bedb5d080 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
@@ -32,11 +32,14 @@ static void set_pages(void)
 
 static void reset_pages(void)
 {
-	SAFE_MUNMAP(page, page_size);
-	SAFE_MUNMAP(move_page, page_size);
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		SAFE_MUNMAP(move_page, page_size);
+		page = NULL;
+	}
 }
 
-static void *handle_thread(void)
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	static struct uffd_msg msg;
 	struct uffdio_move uffdio_move = {};
@@ -94,4 +97,5 @@ static void run(void)
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
