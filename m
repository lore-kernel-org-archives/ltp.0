Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764EDC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 12:35:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905A53CE955
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 13:35:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F344D3CA697
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 13:34:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 27A6E602A0E
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 13:34:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E73D1FD6B;
 Fri,  3 Nov 2023 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699014871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZowYb/0w37vIvT3syy0XCsyWRn3AKuQ6oUVvjeqD5Y=;
 b=GF8sinpy303odqlS5anEROrulyusKfuT4Sn0B7+iZnQhVdzGjqlJ8/b/8f6W+SymNbl6Ln
 tY+GXNkbDqR9ZYnaqeKU81OIES/r8pF2Y1HhLBEfVD9wAsFZM2/S9pXryRfSUp0ZCtIsJg
 O8Zt7+Uc3rHkZjE+7OE3C1gTktCMkSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699014871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZowYb/0w37vIvT3syy0XCsyWRn3AKuQ6oUVvjeqD5Y=;
 b=nErBlTu6DzVeXiiaKKgDcR/SzeaW2DSDTGA7GMhgjifan4f/cL8P7DiXBYT+Jpd5a3K6iA
 wRX9+n40dxOB+6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E84531348C;
 Fri,  3 Nov 2023 12:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CFxVN9boRGViWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 12:34:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  3 Nov 2023 13:34:27 +0100
Message-ID: <20231103123427.1072050-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103123427.1072050-1-pvorel@suse.cz>
References: <20231103123427.1072050-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] include/tst_cmd.h: Improve programming doc
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
 include/tst_cmd.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 1f39f690f..939825646 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -18,14 +18,16 @@ enum tst_cmd_flags {
 
 /*
  * vfork() + execvp() specified program.
- * @argv: a list of two (at least program name + NULL) or more pointers that
+ *
+ * @param argv A list of two (at least program name + NULL) or more pointers that
  * represent the argument list to the new program. The array of pointers
  * must be terminated by a NULL pointer.
- * @stdout_fd: file descriptor where to redirect stdout. Set -1 if
+ * @param stdout_fd File descriptor where to redirect stdout. Set -1 if
  * redirection is not needed.
- * @stderr_fd: file descriptor where to redirect stderr. Set -1 if
+ * @param stderr_fd File descriptor where to redirect stderr. Set -1 if
  * redirection is not needed.
- * @flags: enum tst_cmd_flags
+ * @param flags enum tst_cmd_flags.
+ * @return The exit status of the program.
  */
 int tst_cmd_fds_(void (cleanup_fn)(void),
 			const char *const argv[],
@@ -33,12 +35,15 @@ int tst_cmd_fds_(void (cleanup_fn)(void),
 			int stderr_fd,
 			enum tst_cmd_flags flags);
 
-/* Executes tst_cmd_fds() and redirects its output to a file
- * @stdout_path: path where to redirect stdout. Set NULL if redirection is
+/*
+ * Executes tst_cmd_fds() and redirects its output to a file.
+ *
+ * @param stdout_path Path where to redirect stdout. Set NULL if redirection is
  * not needed.
- * @stderr_path: path where to redirect stderr. Set NULL if redirection is
+ * @param stderr_path Path where to redirect stderr. Set NULL if redirection is
  * not needed.
- * @flags: enum tst_cmd_flags
+ * @param flags enum tst_cmd_flags.
+ * @return The exit status of the program.
  */
 int tst_cmd_(void (cleanup_fn)(void),
 		const char *const argv[],
@@ -87,7 +92,7 @@ static inline int tst_cmd(void (cleanup_fn)(void),
 #endif
 
 /* Wrapper function for system(3), ignorcing SIGCHLD signal.
- * @command: the command to be run.
+ * @param command The command to be run.
  */
 int tst_system(const char *command);
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
