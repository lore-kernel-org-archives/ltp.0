Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F6ECCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 11:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7383CEA04
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 13:30:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AD273CE9C7
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 13:30:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 860781400254
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 13:30:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92CBC21BB9;
 Fri, 10 Oct 2025 11:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760095818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=18wDRMPkqXjKS9SzBXXv9in6sXsNqorwz3/somZnndo=;
 b=tU4o8ZrWKIH/rFMpmMveTZUx8aA7um8dhnrp8EdhRdZa2Dpo9U/6cHt1/lUgnf5IMvJu5e
 P78xl8doNbjcZZ2NWuXf5mZ9p4bL5NCNN5iRNCQL/t6ncVoa3lKSoX8MoflXE9/26R5/fE
 yoX9w1KgdIP4KGbsKL9YbH9Hoj/WXmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760095818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=18wDRMPkqXjKS9SzBXXv9in6sXsNqorwz3/somZnndo=;
 b=2jOlEFiYi6ymaUQw5GqB3S3xRnItQ2JvI2DnkgaE3gLuq0jTEEEqJeMYeA28jOP/DQG9Pc
 iAYyPZRTw7Z4CNDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tU4o8ZrW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2jOlEFiY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760095818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=18wDRMPkqXjKS9SzBXXv9in6sXsNqorwz3/somZnndo=;
 b=tU4o8ZrWKIH/rFMpmMveTZUx8aA7um8dhnrp8EdhRdZa2Dpo9U/6cHt1/lUgnf5IMvJu5e
 P78xl8doNbjcZZ2NWuXf5mZ9p4bL5NCNN5iRNCQL/t6ncVoa3lKSoX8MoflXE9/26R5/fE
 yoX9w1KgdIP4KGbsKL9YbH9Hoj/WXmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760095818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=18wDRMPkqXjKS9SzBXXv9in6sXsNqorwz3/somZnndo=;
 b=2jOlEFiYi6ymaUQw5GqB3S3xRnItQ2JvI2DnkgaE3gLuq0jTEEEqJeMYeA28jOP/DQG9Pc
 iAYyPZRTw7Z4CNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C1871375D;
 Fri, 10 Oct 2025 11:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EF3ECEru6GhPaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Oct 2025 11:30:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 13:30:14 +0200
Message-ID: <20251010113014.309433-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 92CBC21BB9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_cmd.h: Convert the rest of comments to kerneldoc
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

Move docs from the private function implementations (functions with
trailing underscore) to functions used into functions used in the new
API.

This avoids to document private functions.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
FYI I dared to merge the obvious part of the conversion:

https://github.com/linux-test-project/ltp/commit/58708049bb24000af947e00fa611501aa284999a

Kind regards,
Petr

 include/tst_cmd.h | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index cf63829550..8397510ed6 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -19,38 +19,12 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
-/*
- * vfork() + execvp() specified program.
- *
- * @param argv A list of two (at least program name + NULL) or more pointers that
- * represent the argument list to the new program. The array of pointers
- * must be terminated by a NULL pointer.
- * @param stdout_fd File descriptor where to redirect stdout. Set -1 if
- * redirection is not needed.
- * @param stderr_fd File descriptor where to redirect stderr. Set -1 if
- * redirection is not needed.
- * @param flags enum tst_cmd_flags.
- * @return The exit status of the program.
- */
 int tst_cmd_fds_(void (cleanup_fn)(void),
 			const char *const argv[],
 			int stdout_fd,
 			int stderr_fd,
 			enum tst_cmd_flags flags);
 
-/*
- * Executes tst_cmd_fds() and redirects its output to a file.
- *
- * @param argv A list of two (at least program name + NULL) or more pointers that
- * represent the argument list to the new program. The array of pointers
- * must be terminated by a NULL pointer.
- * @param stdout_path Path where to redirect stdout. Set NULL if redirection is
- * not needed.
- * @param stderr_path Path where to redirect stderr. Set NULL if redirection is
- * not needed.
- * @param flags enum tst_cmd_flags.
- * @return The exit status of the program.
- */
 int tst_cmd_(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
@@ -58,6 +32,20 @@ int tst_cmd_(void (cleanup_fn)(void),
 		enum tst_cmd_flags flags);
 
 #ifdef TST_TEST_H__
+/**
+ * tst_cmd_fds() - :man2:`vfork` + :man2:`execvp` specified program.
+ *
+ * @argv: A list of two (at least program name + NULL) or more pointers that
+ * represent the argument list to the new program. The array of pointers
+ * must be terminated by a NULL pointer.
+ * @stdout_fd: File descriptor where to redirect stdout. Set -1 if
+ * redirection is not needed.
+ * @stderr_fd: File descriptor where to redirect stderr. Set -1 if
+ * redirection is not needed.
+ * @flags: enum tst_cmd_flags.
+ *
+ * Return: The exit status of the program.
+ */
 static inline int tst_cmd_fds(const char *const argv[],
 				  int stdout_fd,
 				  int stderr_fd,
@@ -67,6 +55,18 @@ static inline int tst_cmd_fds(const char *const argv[],
 	                        stdout_fd, stderr_fd, flags);
 }
 
+/**
+ * tst_cmd() - Executes tst_cmd_fds() and redirects its output to a file.
+ *
+ * @argv: A list of two (at least program name + NULL) or more pointers that
+ * @stdout_path: Path where to redirect stdout. Set NULL if redirection is
+ * not needed.
+ * @stderr_path: Path where to redirect stderr. Set NULL if redirection is
+ * not needed.
+ * @flags: enum tst_cmd_flags.
+ *
+ * Return: The exit status of the program.
+ */
 static inline int tst_cmd(const char *const argv[],
 			      const char *stdout_path,
 			      const char *stderr_path,
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
