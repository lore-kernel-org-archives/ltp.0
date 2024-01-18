Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D8C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 09:00:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 194833CE2E8
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 10:00:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E2123C0349
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 10:00:18 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 082F260101C
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 10:00:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AA1E1F76E;
 Thu, 18 Jan 2024 09:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705568415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0p7urB7wmsb6dkQLoDkW2Eq0MLph5IqLA7LzKlWVtQ=;
 b=MFiPLupXoI/IjAFBOm+i8VxEFvE9hLE3jyvyjnNE/brjFelGGsBJ/qWJeTOxsVV8rbGJ/z
 d4cMfqJqapzeMt+uQ8P0Ixp8oA2xeMYKR6HRe68hrpk7+zA009qPshBkMd4AxOblvAVj0V
 0F7ICy23Y+uSdMciISIVpjhKXKBChug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705568415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0p7urB7wmsb6dkQLoDkW2Eq0MLph5IqLA7LzKlWVtQ=;
 b=+KWY0Bk5LOi9Mi7trAeQusRxYkvp4JhbEGiwIBz0jjJjLSENlymcBTrwI72vUjgaICh6P9
 uEIwkx8t44gJ7yBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705568414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0p7urB7wmsb6dkQLoDkW2Eq0MLph5IqLA7LzKlWVtQ=;
 b=zh48p0VG8fbrBt+T/qJYdSzf9+Zf1O3R5Ya1py1kJPTrO7LyZcWz0hChYPE3uvjR4qu21H
 68N/l7jcI5zQBHOgTCYIXFr9YHD5nx6CUXbVcGisHIYkV8GjiQPenxdne73RwqiFdvhcX6
 osVjNH5dqLBuHN2YQMS9HhEZuMoCJh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705568414;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=B0p7urB7wmsb6dkQLoDkW2Eq0MLph5IqLA7LzKlWVtQ=;
 b=uRfGgje1H/VAtaqD68L+XB03JUuvQ52sO6hza1OrSr2gfeAA+fKHMNaFqkUwuldrT4qJWd
 p5a1J89zF+1IACDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DBDA136F5;
 Thu, 18 Jan 2024 09:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pq1aCZ3oqGVnMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jan 2024 09:00:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 10:00:04 +0100
Message-ID: <20240118090004.2748107-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.54 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.36)[76.67%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_supported_fs_types: Disable FUSE bcachefs
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

bcachefs got into the kernel in 6.7 therefore it's not much useful for
testing FUSE version.

NOTE: The original purpose for this was a failure with bcachefs-tools on
kernel without bcachefs support (e.g. kernel < 6.7):

    # LTP_SINGLE_FS_TYPE=bcachefs ./chdir01
    ...
    tst_supported_fs_types.c:57: TINFO: mkfs.bcachefs does exist
    tst_test.c:1669: TINFO: === Testing on bcachefs ===
    tst_test.c:1117: TINFO: Formatting /dev/loop0 with bcachefs opts=''
    extra opts=''
    tst_test.c:1131: TINFO: Mounting /dev/loop0 to
    /tmp/LTP_chdwqhGtZ/mntpoint fstyp=bcachefs flags=0
    tst_test.c:1131: TBROK: mount(/dev/loop0, mntpoint, bcachefs, 0, (nil))
    failed: ENODEV (19)

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_supported_fs_types.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 369836717..bbbb8df19 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -33,6 +33,11 @@ static const char *const fs_type_whitelist[] = {
 	NULL
 };
 
+static const char *const fs_type_fuse_blacklist[] = {
+	"bcachefs",
+	NULL,
+};
+
 static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];
 
 static int has_mkfs(const char *fs_type)
@@ -96,6 +101,11 @@ static enum tst_fs_impl has_kernel_support(const char *fs_type)
 
 	SAFE_RMDIR(template);
 
+	if (tst_fs_in_skiplist(fs_type, fs_type_fuse_blacklist)) {
+		tst_res(TINFO, "Skipping %s because of FUSE blacklist", fs_type);
+		return TST_FS_UNSUPPORTED;
+	}
+
 	/* Is FUSE supported by kernel? */
 	if (fuse_supported == -1) {
 		ret = open("/dev/fuse", O_RDWR);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
