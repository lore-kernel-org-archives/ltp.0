Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F47CCFA1A
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4CFB3CEF79
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:30:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AA043C0EFB
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA041200C7E
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 540651F74C;
 Fri,  7 Nov 2025 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zje+nL9iO5xcRhDYuzKWdsYjzXg84O2LV6kbiDIvQ6g=;
 b=u3DL1nStqC/0saNzBMjd+vSNeUOSZ/cKQ6SrfMqDhsID3LqsncYi3EH0rYP7y4Eg92vPAn
 4ODDPV28gfOnW4ic6feAAdvYQC5QSnitjGnriAPzl9e1322FqxbM1QSfHdbLMr2wT2WTGh
 K2ViNl1l8xeHZZiDY8e+uhlZUO+UK78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zje+nL9iO5xcRhDYuzKWdsYjzXg84O2LV6kbiDIvQ6g=;
 b=FcpJdGoEx872d214HYtomgTz6+1HyY71gNC4QGV85+y6JvDaVa3PYPQUdU4yGFdsR9RSv4
 Sxz6ESfJWeoSM/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zje+nL9iO5xcRhDYuzKWdsYjzXg84O2LV6kbiDIvQ6g=;
 b=u3DL1nStqC/0saNzBMjd+vSNeUOSZ/cKQ6SrfMqDhsID3LqsncYi3EH0rYP7y4Eg92vPAn
 4ODDPV28gfOnW4ic6feAAdvYQC5QSnitjGnriAPzl9e1322FqxbM1QSfHdbLMr2wT2WTGh
 K2ViNl1l8xeHZZiDY8e+uhlZUO+UK78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zje+nL9iO5xcRhDYuzKWdsYjzXg84O2LV6kbiDIvQ6g=;
 b=FcpJdGoEx872d214HYtomgTz6+1HyY71gNC4QGV85+y6JvDaVa3PYPQUdU4yGFdsR9RSv4
 Sxz6ESfJWeoSM/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F18E13A60;
 Fri,  7 Nov 2025 10:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KB1yAhfKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:32 +0100
Message-ID: <20251107102939.1111074-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.982]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] tst_test.c: Fix tst_check_cmd() use
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

9bb94efa39 changed tst_check_cmd() from int to bool. But it reverted the
values (0 became true), which logical (false means not supported) than
the original return codes from 257394e4e3. But then the only use of
tst_check_cmd() needs to update to expect false instead of true.

Also document the return code in tst_private.h.

Fixes: 9bb94efa39 ("tst_cmd: Change tst_check_cmd() return type to int")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Fixing my own error.

 include/tst_private.h | 5 +++++
 lib/tst_test.c        | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/tst_private.h b/include/tst_private.h
index 87ec8829a1..482b68fba2 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2020-2025
  * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
  *
  * Internal helper functions for the shell library. Do not use directly
@@ -41,9 +42,13 @@ char tst_kconfig_get(const char *confname);
 /*
  * If cmd argument is a single command, this function just checks command
  * whether exists. If not, case breaks if brk_nosupp is defined.
+ *
  * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
  * function checks command version whether meets this requirement.
  * If not, case breaks if brk_nosupp is defined.
+ *
+ * return: true if command presented, optionally with high enough version, false
+ * otherwise.
  */
 bool tst_check_cmd(const char *cmd, const int brk_nosupp);
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index da5314c502..bda66c4672 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1960,7 +1960,7 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	tst_res(TINFO, "=== Testing on %s ===", fs_type);
 	tdev.fs_type = fs_type;
 
-	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
+	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
 		return TCONF;
 
 	if (fs->min_kver && check_kver(fs->min_kver, 0))
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
