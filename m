Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8B8C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 19:34:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 262FD3C8B0A
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 20:34:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A30163C1448
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 20:34:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DD959140116C
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 20:34:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A54E52112A;
 Mon, 13 Dec 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639424063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HkCQkr9k0Z4YkwuDxf+QGyzcR2R40otdL/poYPEdqDk=;
 b=muue3/XpRkA6WHnkHsYz1BQztoSteHdFFlxe19u7W7q2x7ax0oC3K2Zi4NTuZAU2fwtjbA
 v0g47i35uvaKsKYwMPGvZuQgvDEZlbKsm/9b4qxkuSoOECnTZgylbValel0TR7HYQB48MJ
 /Czk+3cseQvltwOpM2ZW7d/msG8ieZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639424063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HkCQkr9k0Z4YkwuDxf+QGyzcR2R40otdL/poYPEdqDk=;
 b=oLEP9lJK9ObS4FTR+XHGML8QRD1GZKY/77HqoZPUY6tzVopmj1DoukmvomBavKifC+mYNT
 Ivgm/kt/4w8yvODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 379F213EA5;
 Mon, 13 Dec 2021 19:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XQgkCz+gt2E/IAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 19:34:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 20:34:19 +0100
Message-Id: <20211213193419.13414-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Add support for debugging .all_filesystems
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

LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE environment variable tests only that
filesystem instead of all supported filesystems.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/user-guide.txt           | 2 ++
 lib/tst_supported_fs_types.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 6a9fb33005..098916d23d 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -15,6 +15,8 @@ For running LTP network tests see `testcases/network/README.md`.
                           'n' or '0': never colorize.
 | 'LTP_DEV'             | Path to the block device to be used
                           (C: '.needs_device = 1', shell: 'TST_NEEDS_DEVICE=1').
+| 'LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE' | Testing only specified filesystem instead all
+                          supported (for tests with '.all_filesystems').
 | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index fc072cadfd..f61c3e503d 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -139,8 +139,17 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	unsigned int i, j = 0;
 	int skip_fuse;
 	enum tst_fs_impl sup;
+	const char *only_fs;
 
 	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
+	only_fs = getenv("LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE");
+
+	if (only_fs) {
+		tst_res(TINFO, "WARNING: testing only %s", only_fs);
+		if (tst_fs_is_supported(only_fs))
+			fs_types[0] = only_fs;
+		return fs_types;
+	}
 
 	for (i = 0; fs_type_whitelist[i]; i++) {
 		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
