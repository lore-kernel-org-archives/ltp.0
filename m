Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F7DC25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 20:06:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E1A03CD985
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 22:06:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629B93C0831
 for <ltp@lists.linux.it>; Mon,  6 May 2024 22:06:06 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9227E63AA77
 for <ltp@lists.linux.it>; Mon,  6 May 2024 22:06:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 047E21FD6A;
 Mon,  6 May 2024 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715025964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p1zJTKF1TFpVeFzamGqQR/ymbZ2ZitbSmnJPOKhSGMg=;
 b=dnDSz18CcE/aL/mqS5F8zniRBZ/ve0TynawDfCJuUpcfdVNpJdYkvcJ+nCG6AKgbH0qncE
 EC71Msuf5nCNGWNTCiXF6Hykbul6NyhXcDxNRxjJmcDH0Y32FXX27IRYVCk0gW9YL5zvNp
 N86Z3jl+yG4cGHDQ9M0iFBuV2fPvdtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715025964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p1zJTKF1TFpVeFzamGqQR/ymbZ2ZitbSmnJPOKhSGMg=;
 b=MMYilQ+hCwDxw28B+WShJY9eANWveoCMmZyDKZer9+6N5o3r04fnSThtNAgNUMO2Rmddv9
 Oc9RiqTt2WNZHPAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dnDSz18C;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MMYilQ+h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715025964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p1zJTKF1TFpVeFzamGqQR/ymbZ2ZitbSmnJPOKhSGMg=;
 b=dnDSz18CcE/aL/mqS5F8zniRBZ/ve0TynawDfCJuUpcfdVNpJdYkvcJ+nCG6AKgbH0qncE
 EC71Msuf5nCNGWNTCiXF6Hykbul6NyhXcDxNRxjJmcDH0Y32FXX27IRYVCk0gW9YL5zvNp
 N86Z3jl+yG4cGHDQ9M0iFBuV2fPvdtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715025964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p1zJTKF1TFpVeFzamGqQR/ymbZ2ZitbSmnJPOKhSGMg=;
 b=MMYilQ+hCwDxw28B+WShJY9eANWveoCMmZyDKZer9+6N5o3r04fnSThtNAgNUMO2Rmddv9
 Oc9RiqTt2WNZHPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3A9113A25;
 Mon,  6 May 2024 20:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bcM8Mis4OWZ7XQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 20:06:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 May 2024 22:06:00 +0200
Message-ID: <20240506200600.47895-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 047E21FD6A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.95 / 50.00]; BAYES_HAM(-2.94)[99.75%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.h: Turn 1 bit tst_test members to
 unsigned
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

This fixes clang warning:

    test22.c:33:17: warning: implicit truncation from 'int' to a one-bit
    wide bit-field changes value from 1 to -1
    [-Wsingle-bit-bitfield-constant-conversion]

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index be09bce27..69587917f 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -476,26 +476,26 @@ struct tst_ulimit_val {
 
 	const char *tconf_msg;
 
-	int needs_tmpdir:1;
-	int needs_root:1;
-	int forks_child:1;
-	int needs_device:1;
-	int needs_checkpoints:1;
-	int needs_overlay:1;
-	int format_device:1;
-	int mount_device:1;
-	int needs_rofs:1;
-	int child_needs_reinit:1;
-	int needs_devfs:1;
-	int restore_wallclock:1;
-
-	int all_filesystems:1;
-
-	int skip_in_lockdown:1;
-	int skip_in_secureboot:1;
-	int skip_in_compat:1;
-
-	int needs_hugetlbfs:1;
+	unsigned int needs_tmpdir:1;
+	unsigned int needs_root:1;
+	unsigned int forks_child:1;
+	unsigned int needs_device:1;
+	unsigned int needs_checkpoints:1;
+	unsigned int needs_overlay:1;
+	unsigned int format_device:1;
+	unsigned int mount_device:1;
+	unsigned int needs_rofs:1;
+	unsigned int child_needs_reinit:1;
+	unsigned int needs_devfs:1;
+	unsigned int restore_wallclock:1;
+
+	unsigned int all_filesystems:1;
+
+	unsigned int skip_in_lockdown:1;
+	unsigned int skip_in_secureboot:1;
+	unsigned int skip_in_compat:1;
+
+	unsigned int needs_hugetlbfs:1;
 
 	const char *const *skip_filesystems;
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
