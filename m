Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4FFECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EA953CAA64
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:19:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A38943CA9DB
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D3BA1400E15
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2B4021F3D;
 Fri,  9 Sep 2022 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0pDL19Oe5bCwg0vwLI3n9f0/UkgLmpVRH2HZBz+9fk=;
 b=PdGwUcEKI/TUOIrgfwnz4bZ8YRW2LDJa1ea9htXxEsHadRDmu9vE1Lg+Umkp/RuP7yImfX
 lRu696WXoZaEx+fpS/iTxvG5kujSaKqqJZwmnKf/ceNeHlRmJxVjedbBADMYONKr43p1ez
 J1kXvX76Jww98KyRau3bxYszfjvIaMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0pDL19Oe5bCwg0vwLI3n9f0/UkgLmpVRH2HZBz+9fk=;
 b=/YjyQsM/CizpbGhBCnBW6Msg+R9MEEPOH8ZanGw6v0jYylFO9oiykmUYVEtTZouHFSm9rv
 jd0pB7ValooMQ1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30C8813A93;
 Fri,  9 Sep 2022 14:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sJmBB0ZLG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:33 +0200
Message-Id: <20220909141840.18327-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 03/10] tst_supported_fs: Print TCONF if no
 filesystem supported
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Although this is unlikely, it can happen.
This means 32 (TCONF) instead of 0 exit code when searching for all
filesystems and 32 instead of 1 when searching for a particular
filesystem.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5

NOTE:

Although this will later leads to duplicating message (see below) it's
IMHO better because LVM scripts and zram01.sh use this helper directly.

Tests added in later commits which demonstrates TCONF:

# ./tst_skip_filesystems_skip.sh
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:52: TINFO: mkfs.ext4 does exist
tst_supported_fs.c:88: TCONF: ext4 is skipped or not supported
tst_skip_filesystems_skip 1 TCONF: ext4 is not supported

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0

# ./tst_all_filesystems_skip.sh
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:173: TINFO: Skipping ext2 as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping ext3 as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping ext4 as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping xfs as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping btrfs as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping ntfs as requested by the test
tst_supported_fs_types.c:173: TINFO: Skipping tmpfs as requested by the test
tst_supported_fs.c:96: TCONF: There are no supported filesystems or all skipped
tst_all_filesystems_skip 1 TCONF: There are no supported filesystems or all skipped

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0

 testcases/lib/tst_supported_fs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 43eac194f..6e544070c 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -24,7 +24,7 @@ int main(int argc, char *argv[])
 {
 	const char *skiplist[] = {"tmpfs", NULL};
 	const char *const *filesystems;
-	int i;
+	int i, ret;
 
 	if (argc > 2) {
 		fprintf(stderr, "Can't specify multiple fs_type\n");
@@ -37,10 +37,20 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
-	if (argv[1])
-		return !tst_fs_is_supported(argv[1]);
+	if (argv[1]) {
+		ret = tst_fs_is_supported(argv[1]);
+
+		if (ret == TST_FS_UNSUPPORTED)
+			tst_brk(TCONF, "%s is not supported", argv[optind]);
+
+		return !ret;
+	}
 
 	filesystems = tst_get_supported_fs_types(skiplist);
+
+	if (!filesystems[0])
+		tst_brk(TCONF, "There are no supported filesystems");
+
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
