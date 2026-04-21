Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5426F8FA84
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 14:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874FF3E53CC
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 16:41:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C4B03E1B27
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:41:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0A47F200B73
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:41:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57BAE5BCEE;
 Tue, 21 Apr 2026 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776782495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TqICN6pRz+DqXQaMdSbW2KQPkn7qemNxDNt6witJjxM=;
 b=v1stmGh4blL+T0DOb1mHWEcw9Tfpa92w9x9yYPgJ2bCA6xaRzk3ed6a3w5vFQUbxXBYIAL
 MM/CNWeJ3qp10/c+ApCmLXyIyTbtAISoE5oqa7HnXMMkijrtr3ViEoLBSa0czlX/EXZdf0
 07WNr7qTz6GkiJcfjpAj1657+so+iUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776782495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TqICN6pRz+DqXQaMdSbW2KQPkn7qemNxDNt6witJjxM=;
 b=gUau17rz7dfpu+xjjyeNPRwAs/k3lhhgtUnMpQOrkVJUjZd1Qutemg/PhBHFS3txTiOZ3Z
 2ZImgVAQQmB6nRBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v1stmGh4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gUau17rz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776782495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TqICN6pRz+DqXQaMdSbW2KQPkn7qemNxDNt6witJjxM=;
 b=v1stmGh4blL+T0DOb1mHWEcw9Tfpa92w9x9yYPgJ2bCA6xaRzk3ed6a3w5vFQUbxXBYIAL
 MM/CNWeJ3qp10/c+ApCmLXyIyTbtAISoE5oqa7HnXMMkijrtr3ViEoLBSa0czlX/EXZdf0
 07WNr7qTz6GkiJcfjpAj1657+so+iUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776782495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TqICN6pRz+DqXQaMdSbW2KQPkn7qemNxDNt6witJjxM=;
 b=gUau17rz7dfpu+xjjyeNPRwAs/k3lhhgtUnMpQOrkVJUjZd1Qutemg/PhBHFS3txTiOZ3Z
 2ZImgVAQQmB6nRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31086593AF;
 Tue, 21 Apr 2026 14:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eWlpCp+M52lHVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Apr 2026 14:41:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Apr 2026 16:41:26 +0200
Message-ID: <20260421144126.613547-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email,ozlabs.org:url];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 57BAE5BCEE
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] tst_test.h: Convert rest of doc to kerneldoc
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes in v2:
* Hopefully address all Cyril's comments in v1. @Cyril if not, please
  fix it and merge under your SOB, it's mostly your text anyway.
* Describe also tst_remaining_runtime() (that changes
  tst_remaining_runtime() mentioned in struct tst_test members clickable)

Link to v1:
https://lore.kernel.org/ltp/20260421143200.GA611911@pevik/T/#t
https://patchwork.ozlabs.org/project/ltp/patch/20260325120629.113245-1-pvorel@suse.cz/

 include/tst_test.h | 89 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index f12c59f393..c547037ccd 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -696,35 +696,87 @@ void tst_reinit(void);
  */
 int tst_run_script(const char *script_name, char *const params[]);
 
-/*
- * Sets entire timeout in seconds.
+/**
+ * tst_set_timeout() - Sets the timeout part of the overall timeout.
+ *
+ * Allows to set the overall timeout dynamically during the test setup phase.
+ *
+ * This is used only for rare cases that the test does something that runs for a
+ * long time and cannot be easily interrupted (otherwise it would set
+ * :c:type:`.runtime <tst_test>` and exit when runtime was exhausted).
+ *
+ * @timeout: A timeout in seconds, defines the total time allowed for a single
+ * test iteration, including the setup, runtime, and teardown phases.
  */
 void tst_set_timeout(int timeout);
 
+/**
+ * tst_multiply_timeout() - Uses heuristics to multiply a time interval based on
+ * expected CPU slowdowns.
+ *
+ * If a machine is expected to be running slow for some reason a user can export
+ * :doc:`LTP_TIMEOUT_MUL <../users/setup_tests>` variable that is used by this
+ * call to multiply the interval.
+ *
+ * Various kernel configuration (debugging) options that slow down the machine
+ * are also attempted to be detected and are taken into account.
+ *
+ * @timeout: A timeout.
+ *
+ * Return: timeout multiplied with LTP_TIMEOUT_MUL environment variable.
+ */
 unsigned int tst_multiply_timeout(unsigned int timeout);
 
-/*
- * Returns remaining test runtime. Test that runs for more than a few seconds
- * should check if they should exit by calling this function regularly.
+/**
+ * tst_remaining_runtime() - Returns the remaining test runtime.
  *
  * The function returns remaining runtime in seconds. If runtime was used up
  * zero is returned.
+ *
+ * Test that runs for more than a few seconds should check if they should exit
+ * by calling this function regularly.
+ *
+ * Return: the remaining test runtime in seconds.
  */
 unsigned int tst_remaining_runtime(void);
 
-/*
- * Sets maximal test runtime in seconds.
+/**
+ * tst_set_runtime() - Sets maximal test runtime in seconds.
+ *
+ * Allows for setting the runtime per test iteration dynamically during the test
+ * setup phase.  The runtime is specified in seconds and defines how long the
+ * test is allowed to execute its main workload, excluding the setup and
+ * teardown phases.
+ *
+ * This function is useful for tests where the duration of the main workload can
+ * be controlled or needs to be adjusted dynamically. For example, tests that
+ * run in a loop until the runtime expires can use this function to define how
+ * long they should execute.
+ *
+ * A test that sets a runtime must monitor the remaining time with
+ * tst_remaining_runtime() in the main loop.
+ *
+ * @runtime: A timeout in seconds.
  */
 void tst_set_runtime(int runtime);
 
-/*
- * Create and open a random file inside the given dir path.
- * It unlinks the file after opening and return file descriptor.
+/**
+ * tst_creat_unlinked() - Create and open a random file inside the given
+ * directory path, unlinks the file after opening and return file descriptor.
+ *
+ * @path: Path to the directory.
+ * @flags: :manpage:`open(2)` flags.
+ * @mode: :manpage:`open(2)` mode.
+ *
+ * Return: the file descriptor.
  */
 int tst_creat_unlinked(const char *path, int flags, mode_t mode);
 
-/*
- * Returns path to the test temporary directory root (TMPDIR).
+/**
+ * tst_get_tmpdir_root() - Returns path to the test temporary directory root
+ * (TMPDIR environment variable).
+ *
+ * Return: the path to TMPDIR.
  */
 const char *tst_get_tmpdir_root(void);
 
@@ -740,13 +792,16 @@ const char *tst_get_tmpdir_root(void);
  */
 bool tst_cmd_present(const char *cmd);
 
-/*
- * Validates exit status of child processes
- */
 int tst_validate_children_(const char *file, const int lineno,
 	unsigned int count);
-#define tst_validate_children(child_count) \
-	tst_validate_children_(__FILE__, __LINE__, (child_count))
+
+/**
+ * tst_validate_children() - Validates exit status of the child processes.
+ *
+ * @count: Number of the child processes.
+ */
+#define tst_validate_children(count) \
+	tst_validate_children_(__FILE__, __LINE__, (count))
 
 #ifndef TST_NO_DEFAULT_MAIN
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
