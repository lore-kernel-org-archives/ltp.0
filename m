Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A1606AAD1
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kcwz1k4X;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EYh+yMbi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gsdP2kZG;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ctc9a6sy
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6653F3CC7DB
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 17:23:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15CF93CC42C
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:23:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7E98F6008DE
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:23:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E41AA21E51;
 Wed,  4 Nov 2026 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793809398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=72fi3h4m07OdlB8v1gjDDNxO2zWo6Pf1ClF5E3a/mDI=;
 b=kcwz1k4XSN7YhRw5F59TFrujAos2W79NFR1VPGbxIA3/U9hLx/ad7O41zdNSaPJe4ZP8Lm
 jgiR+xEvVczszjhfNboAEt098rxUoR+wX9YjO0k2qFVb7hoYVEMxR7F3ftoM7619y/JSA9
 43FUpc3EOjJ7nGCZ0KMzvuuMPU/ZiMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793809398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=72fi3h4m07OdlB8v1gjDDNxO2zWo6Pf1ClF5E3a/mDI=;
 b=EYh+yMbiruy5EG1pHP6Jf525Ixunhr/IjpLKcWqXNxgHM6tDkgoxH7qMnMzjB7xNhMw3lt
 bUGd2PBX1A1XV2Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793809397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=72fi3h4m07OdlB8v1gjDDNxO2zWo6Pf1ClF5E3a/mDI=;
 b=gsdP2kZGtNsyd3EzDfows4fmOCEjqparkFTR1T7dzXMQGxygz8oYAAmx0aba/ZUqLOx8PX
 FpKKJbek7LpNxRlAi8Rw5Xc4D5KXEROX44lgTpSjMo8BmaOPM7Y56pIAUOGiWLrlg7nv0K
 y/2HBnhhCaLXXykILY9pHibb38ODAkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793809397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=72fi3h4m07OdlB8v1gjDDNxO2zWo6Pf1ClF5E3a/mDI=;
 b=Ctc9a6sySxx+0ZZpUKYr5LLhXG5XwOZ+i5eGKJyJN7DMEIfWH2ie4voRHIdFM9MNVDrood
 XCboRzMkvcKpw1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E5C134F0;
 Wed,  4 Nov 2026 16:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +qPfH/Vb62rdZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Nov 2026 16:23:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 17:23:05 +0100
Message-ID: <20261104162305.385749-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify.h: Print flag name in
 REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Call in REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS () functions directly
instead of other REQUIRE_*() macros. That allows to stringify the
arguments so that instead of printing a flag value:

    fanotify26.c:258: TCONF: 0x00000100 not supported in kernel?

the output is printing the flag itself:

    fanotify26.c:258: TCONF: FAN_MARK_FILESYSTEM not supported in kernel?

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 7977b4aa44..fb6147680a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -307,9 +307,11 @@ static inline int fanotify_handle_supported_by_kernel(int flag)
 
 #define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
 	if (mark_type)							\
-		REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(mark_type, fname);	\
+		fanotify_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
+			fanotify_mark_supported_on_fs(mark_type, fname)); \
 	if (init_flags)							\
-		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
+		fanotify_flags_err_msg(#init_flags, __FILE__, __LINE__, tst_brk_, \
+			fanotify_init_flags_supported_on_fs(init_flags, fname)); \
 	fanotify_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
 		fanotify_flags_supported_on_fs(init_flags, mark_type, mask, fname)); \
 } while (0)
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
