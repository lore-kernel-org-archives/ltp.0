Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4CBE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:11:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06FE23C2644
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:11:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F7D63C2573
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3AE9863CCFA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD86D1F393;
 Thu,  9 Jan 2025 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=nJLhshHgklbVFt5fY0h8FtH5b3aDzr1+avidusf4BZXE0fG7rOC0AYP1dCLKj2TC00/4EW
 XBVZWiNc1+qRsg4neIrHl+FUEY/Ew+cIBZUSExM0mba+qpUyvAp1LBRhaFrXEJjuAQtbnh
 bJ3f06mihtd3w+4vVirNScdx5iWe3pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=Yn+pJgULeIs5SrV34MN2V8migS10n2bjQEgL9bqXTVyIFnJyp9GCI+4iyned1F6R4iQrHJ
 GMUULzNH2zBNEwDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=nJLhshHgklbVFt5fY0h8FtH5b3aDzr1+avidusf4BZXE0fG7rOC0AYP1dCLKj2TC00/4EW
 XBVZWiNc1+qRsg4neIrHl+FUEY/Ew+cIBZUSExM0mba+qpUyvAp1LBRhaFrXEJjuAQtbnh
 bJ3f06mihtd3w+4vVirNScdx5iWe3pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=Yn+pJgULeIs5SrV34MN2V8migS10n2bjQEgL9bqXTVyIFnJyp9GCI+4iyned1F6R4iQrHJ
 GMUULzNH2zBNEwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F62C13A9E;
 Thu,  9 Jan 2025 14:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QHk9HQXZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 09 Jan 2025 14:11:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:05 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-2-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=1493;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MOW9g7ThrqyeXo3INqKzpNnj2Sx+zobF04WcJfdPnws=;
 b=SPWLhbO5Z3ajf/BE85aL69cpF+JNq8BCjSv3n8s6EYOiO6qwpUZwQOgmZfBnAX1yq/7Y0tNiX
 xltHb6qIQ58DjqjSiHuOw1eojAxQa2+jkWZ7GZHtkCnGa6WmBc20SHe
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/12] Add SAFE_PTSNAME macro
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
index 633b00404a56aafce6322e43bd614070d085e643..ba095a6215a8a053ad7397b4a541b26f02439b0f 100644
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
+	if (!name) {
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
