Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CE4E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 10:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA4903C3071
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 11:32:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9264E3C2F3F
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 117261BBFC87
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF52921119
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ytd84sQZb9rCeF2/0iacxaqfB6qxou3SAurnaRLL9s=;
 b=NgBm5p1gFOIogb2uqaQdktn7LuAJHWxQ9NHJqy9kl1ehehpeeReTs4aSvvQjOljReH/DO1
 jEjfiOgiQ05FHTPWXfxvMBoUsd8d7vVUPjvaFo/YJ0Y91x8qkY1iCU0l5d8KrFE7QBIylq
 8vejiF/RBMLNQ7HfU8mm05YcRXX4u/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ytd84sQZb9rCeF2/0iacxaqfB6qxou3SAurnaRLL9s=;
 b=lxe0JzsxvUcrlKHSFwSlQMUJX/SQ5vAClT1aJmf8EoC4eaHtCsaYtWIperLZt+TY8E3HrK
 xBvsRRD5xVh11mBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NgBm5p1g;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lxe0Jzsx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ytd84sQZb9rCeF2/0iacxaqfB6qxou3SAurnaRLL9s=;
 b=NgBm5p1gFOIogb2uqaQdktn7LuAJHWxQ9NHJqy9kl1ehehpeeReTs4aSvvQjOljReH/DO1
 jEjfiOgiQ05FHTPWXfxvMBoUsd8d7vVUPjvaFo/YJ0Y91x8qkY1iCU0l5d8KrFE7QBIylq
 8vejiF/RBMLNQ7HfU8mm05YcRXX4u/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ytd84sQZb9rCeF2/0iacxaqfB6qxou3SAurnaRLL9s=;
 b=lxe0JzsxvUcrlKHSFwSlQMUJX/SQ5vAClT1aJmf8EoC4eaHtCsaYtWIperLZt+TY8E3HrK
 xBvsRRD5xVh11mBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3617137DA
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 10:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEP6Lf2we2fGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 06 Jan 2025 10:31:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jan 2025 11:31:24 +0100
MIME-Version: 1.0
Message-Id: <20250106-fix_setsid_tests-v2-2-c43f57a2bab6@suse.com>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
In-Reply-To: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736159485; l=1413;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=r8sBvRzZI0eEQ2uwH2ssINncM5AQHEtoFNRsNtDnSfs=;
 b=bVhJHVXV8c5+JQyhEcogDlOOPUQ1xfmlwo2u+P0BSnRQ23F/SazOeIucl3G7OT4tRGKg8Avck
 sWH6NBJWTxxCGtQxcycaf6Qb4Zp8C93ww9RHf7A7oknYM7c5hYnfcQN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: DF52921119
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/11] Add SAFE_PTSNAME macro
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_safe_macros.h |  4 ++++
 lib/tst_safe_macros.c     | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index a9fa7dbe128f17eace381fdf9f2795684e55969b..6985aa4bd80af2ff8a7c606fdba9830bb5ccd195 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -528,4 +528,8 @@ ssize_t safe_writev(const char *file, const int lineno, char len_strict,
 	safe_writev(__FILE__, __LINE__, (len_strict), (fildes), \
 		(iov), (iovcnt))
 
+char *safe_ptsname(const char *const file, const int lineno, int masterfd);
+#define SAFE_PTSNAME(masterfd) \
+	safe_ptsname(__FILE__, __LINE__, (masterfd))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 633b00404a56aafce6322e43bd614070d085e643..a837d4582d4402a0aa0dd4f231d36439e1cd046f 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -796,3 +796,17 @@ ssize_t safe_writev(const char *file, const int lineno, char len_strict,
 
 	return rval;
 }
+
+char *safe_ptsname(const char *const file, const int lineno, int masterfd)
+{
+	char *name;
+
+	name = ptsname(masterfd);
+
+	if (name == NULL) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"ptsname(%d) failed", masterfd);
+	}
+
+	return name;
+}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
