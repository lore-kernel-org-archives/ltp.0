Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49884C2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 10:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AD693CC4A6
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 12:31:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B041D3C1A7F
 for <ltp@lists.linux.it>; Thu, 15 May 2025 12:31:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA15C1401263
 for <ltp@lists.linux.it>; Thu, 15 May 2025 12:31:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EF6221201;
 Thu, 15 May 2025 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747305067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JHn5rQFtdpMccUitdJclGyQTd+EGxLNA9Gud6A2y2Sc=;
 b=m290u/rrcD19Ds0hqFdSoI2rhb7JOYWHpNtdsHsvc9P4Bbyl6RJ/5wX/WiCF95LV5bnlI/
 nFx3YBs8iGTYg5Z52tmVSTWJAjXdIF4KcP7FzySlUPzKfM15B96Bw6OQW24VAeuvv3FdC0
 AJrfp5smzWg0LbbXtafSGLh7F6D9OKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747305067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JHn5rQFtdpMccUitdJclGyQTd+EGxLNA9Gud6A2y2Sc=;
 b=XKeOuVsLxTJXIRwl2Ez5dKDY5WTpT9wLBG2ItR6l6LwQ9wMlsBw9vCIcKF8gBjxeZIJUoY
 wzmDS7+OnhLQEWAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747305067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JHn5rQFtdpMccUitdJclGyQTd+EGxLNA9Gud6A2y2Sc=;
 b=m290u/rrcD19Ds0hqFdSoI2rhb7JOYWHpNtdsHsvc9P4Bbyl6RJ/5wX/WiCF95LV5bnlI/
 nFx3YBs8iGTYg5Z52tmVSTWJAjXdIF4KcP7FzySlUPzKfM15B96Bw6OQW24VAeuvv3FdC0
 AJrfp5smzWg0LbbXtafSGLh7F6D9OKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747305067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JHn5rQFtdpMccUitdJclGyQTd+EGxLNA9Gud6A2y2Sc=;
 b=XKeOuVsLxTJXIRwl2Ez5dKDY5WTpT9wLBG2ItR6l6LwQ9wMlsBw9vCIcKF8gBjxeZIJUoY
 wzmDS7+OnhLQEWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C1CE137E8;
 Thu, 15 May 2025 10:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJrrIWvCJWi/YgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 15 May 2025 10:31:07 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 May 2025 12:31:46 +0200
Message-ID: <20250515103146.14950-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email, suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] lib: tst_test: Add reproducible output.
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
Cc: valgrind-developers@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit adds an environment variable LTP_REPRODUCIBLE_OUTPUT that
when set to 1 or y skips printing parts of the test messages that may
contain data that differ on subsequent runs (e.g. pids).

With this you can run a test twice under a different conditions and
check if the test codeflow was identical by simply doing diff of the
outputs from the two runs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Avinesh Kumar <akumar@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
CC: valgrind-developers@lists.sourceforge.net
---
 doc/users/setup_tests.rst |  4 ++++
 lib/tst_test.c            | 33 ++++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 2766ed719..2cce85fdf 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -42,6 +42,10 @@ users.
      - Path to the block device to be used. C Language: ``.needs_device = 1``.
        Shell language: ``TST_NEEDS_DEVICE=1``.
 
+   * - LTP_REPRODUCIBLE_OUTPUT
+     - When set to ``1`` or ``y`` discards the actual content of the messages
+       printed by the test (suitable for a reproducible output).
+
    * - LTP_SINGLE_FS_TYPE
      - Testing only - specifies filesystem instead all supported
        (for tests with ``.all_filesystems``).
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 923ecf7be..297c376da 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -63,6 +63,7 @@ static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
 static int tdebug;
+static int reproducible_output;
 
 struct results {
 	int passed;
@@ -316,6 +317,9 @@ static void print_result(const char *file, const int lineno, int ttype,
 	str += ret;
 	size -= ret;
 
+	if (reproducible_output)
+		goto print;
+
 	ssize = size - 2;
 	ret = vsnprintf(str, size, fmt, va);
 	str += MIN(ret, ssize);
@@ -333,6 +337,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 				"Next message is too long and truncated:");
 	}
 
+print:
 	snprintf(str, size, "\n");
 
 	/* we might be called from signal handler, so use write() */
@@ -606,17 +611,18 @@ static void print_help(void)
 	/* see doc/users/setup_tests.rst, which lists also shell API variables */
 	fprintf(stderr, "Environment Variables\n");
 	fprintf(stderr, "---------------------\n");
-	fprintf(stderr, "KCONFIG_PATH         Specify kernel config file\n");
-	fprintf(stderr, "KCONFIG_SKIP_CHECK   Skip kernel config check if variable set (not set by default)\n");
-	fprintf(stderr, "LTPROOT              Prefix for installed LTP (default: /opt/ltp)\n");
-	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
-	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
-	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
-	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
-	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
-	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
-	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
-	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
+	fprintf(stderr, "KCONFIG_PATH            Specify kernel config file\n");
+	fprintf(stderr, "KCONFIG_SKIP_CHECK      Skip kernel config check if variable set (not set by default)\n");
+	fprintf(stderr, "LTPROOT                 Prefix for installed LTP (default: /opt/ltp)\n");
+	fprintf(stderr, "LTP_COLORIZE_OUTPUT     Force colorized output behaviour (y/1 always, n/0: never)\n");
+	fprintf(stderr, "LTP_DEV                 Path to the block device to be used (for .needs_device)\n");
+	fprintf(stderr, "LTP_DEV_FS_TYPE         Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
+	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT When set to 1 or y discards the actual content of the messages printed by the test\n");
+	fprintf(stderr, "LTP_SINGLE_FS_TYPE      Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
+	fprintf(stderr, "LTP_TIMEOUT_MUL         Timeout multiplier (must be a number >=1)\n");
+	fprintf(stderr, "LTP_RUNTIME_MUL         Runtime multiplier (must be a number >=1)\n");
+	fprintf(stderr, "LTP_VIRT_OVERRIDE       Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
+	fprintf(stderr, "TMPDIR                  Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
 	fprintf(stderr, "\n");
 
 	fprintf(stderr, "Timeout and runtime\n");
@@ -1298,6 +1304,7 @@ static const char *default_fs_type(void)
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
+	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
 
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
@@ -1316,6 +1323,10 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
 
+	if (reproducible_env &&
+	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
+		reproducible_output = 1;
+
 	assert_test_fn();
 
 	TCID = tid = get_tid(argv);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
