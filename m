Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E0CCD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3709E3CC6A7
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:29:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 551393CBC10
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:29:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B91B21A005EB
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:29:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06EFE6C30C;
 Thu,  7 May 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF0D7593A7;
 Thu,  7 May 2026 12:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CAZYK5GF/Gk9OgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 12:29:05 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:28:54 +0200
Message-ID: <20260507122858.19670-2-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507122858.19670-1-rbranco@suse.de>
References: <20260507122858.19670-1-rbranco@suse.de>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 06EFE6C30C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] userfaultfd: Use two-step handshake to probe
 features
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

userfaultfd05 and userfaultfd06 assume that
UFFD_FEATURE_PAGEFAULT_FLAG_WP and UFFD_FEATURE_POISON are available
when setting up userfaultfd.

On kernels where either feature is unavailable at runtime,
UFFDIO_API fails with EINVAL and the tests end up as TBROK instead of
being skipped.

Fix this by using the required two-step handshake and skip with TCONF
if the required feature bit is absent.

Fixes: 1840ee23d172b5ab04cca7c2acfa48755b041911
Link: https://github.com/linux-test-project/ltp/issues/1289

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 8 +++++++-
 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index 59956d85d..a42ac09bd 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -22,6 +22,11 @@ static char *page;
 static int uffd = -1;
 static volatile int wp_fault_seen;
 
+static void setup(void)
+{
+	CHECK_UFFD_FEATURE(UFFD_FEATURE_PAGEFAULT_FLAG_WP);
+}
+
 static void set_pages(void)
 {
 	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
@@ -87,7 +92,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 static void run(void)
 {
 	pthread_t thr;
-	struct uffdio_api uffdio_api;
+	struct uffdio_api uffdio_api = {};
 	struct uffdio_register uffdio_register;
 	struct uffdio_writeprotect uffdio_writeprotect;
 
@@ -127,6 +132,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = run,
 	.min_kver = "5.7",
 	.needs_kconfigs = (const char *[]) {
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index ec93d8ad6..1ab288e64 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -38,6 +38,8 @@ static void setup(void)
 {
 	struct sigaction sa = {};
 
+	CHECK_UFFD_FEATURE(UFFD_FEATURE_POISON);
+
 	sa.sa_handler = sigbus_handler;
 	sigemptyset(&sa.sa_mask);
 	SAFE_SIGACTION(SIGBUS, &sa, NULL);
@@ -99,6 +101,7 @@ static void run(void)
 
 	poison_fault_seen = 0;
 	sigbus_seen = 0;
+
 	set_pages();
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
@@ -108,9 +111,6 @@ static void run(void)
 
 	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
 
-	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
-		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
-
 	uffdio_register.range.start = (unsigned long) page;
 	uffdio_register.range.len = page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
