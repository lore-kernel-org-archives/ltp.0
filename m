Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EF5106B506
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 12:06:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 648B03E2FFF
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 13:06:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 919493E143F
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:06:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1C141400993
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:06:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4C965BCCF;
 Wed, 25 Mar 2026 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774440393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0jebzcFYuJi/2LEhKGAURZSL3KhxqqII9zrdHtPmbPM=;
 b=s0OapVbHZ+W9DFJkzL/RwJxi3lFpHehic7+BBz+LFUfQIKl5nRbHmGp0c2TlOmy5e8rg4D
 4R13wjZNJiEgwijc0wZqxucZCjSdjupDhZEl6OUMrYXItIuXZzoNwC7N3JgKGy/mUq1rBI
 tPcj4ldQ6dsZ5IFUCRWTttIiBFY92Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774440393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0jebzcFYuJi/2LEhKGAURZSL3KhxqqII9zrdHtPmbPM=;
 b=kOhWT7SR5Imb+8P+kqYsKVQ9QF3uwlNOC8XMBO/Dhg7aOZvIkd2llHp2dd6+j2uM+zCEoT
 YM6jObgan+o9Q8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774440393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0jebzcFYuJi/2LEhKGAURZSL3KhxqqII9zrdHtPmbPM=;
 b=s0OapVbHZ+W9DFJkzL/RwJxi3lFpHehic7+BBz+LFUfQIKl5nRbHmGp0c2TlOmy5e8rg4D
 4R13wjZNJiEgwijc0wZqxucZCjSdjupDhZEl6OUMrYXItIuXZzoNwC7N3JgKGy/mUq1rBI
 tPcj4ldQ6dsZ5IFUCRWTttIiBFY92Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774440393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0jebzcFYuJi/2LEhKGAURZSL3KhxqqII9zrdHtPmbPM=;
 b=kOhWT7SR5Imb+8P+kqYsKVQ9QF3uwlNOC8XMBO/Dhg7aOZvIkd2llHp2dd6+j2uM+zCEoT
 YM6jObgan+o9Q8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98E67443B9;
 Wed, 25 Mar 2026 12:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E56UI8nPw2klMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 25 Mar 2026 12:06:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Mar 2026 13:06:29 +0100
Message-ID: <20260325120629.113245-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.h: Convert rest of doc to kerneldoc
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
 include/tst_test.h | 66 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index ddfe9d4d6c..fa336207e9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -694,11 +694,25 @@ void tst_reinit(void);
  */
 int tst_run_script(const char *script_name, char *const params[]);
 
-/*
- * Sets entire timeout in seconds.
+/**
+ * tst_set_timeout() - Sets entire timeout in seconds.
+ *
+ * Allows to sett the overall timeout dynamically during the test setup phase.
+ * The timeout is specified in seconds and defines the total time allowed for a
+ * single test iteration, including the setup, runtime, and teardown phases.
+ *
+ * @timeout: A timeout in seconds.
  */
 void tst_set_timeout(int timeout);
 
+/**
+ * tst_multiply_timeout() - Multiply the timeout with LTP_TIMEOUT_MUL
+ * environment variable.
+ *
+ * @timeout: A timeout in seconds.
+ *
+ * Return: timeout multiplied with LTP_TIMEOUT_MUL environment variable.
+ */
 unsigned int tst_multiply_timeout(unsigned int timeout);
 
 /*
@@ -710,19 +724,40 @@ unsigned int tst_multiply_timeout(unsigned int timeout);
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
 
@@ -738,13 +773,16 @@ const char *tst_get_tmpdir_root(void);
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
