Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A19ECAAD4
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 00:29:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147EA3CA503
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 02:29:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82A813C136F
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC3691000654
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3641F1F9AC;
 Sat, 27 Aug 2022 00:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661560101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkHOMCgteBaqkUHJLwtS9lLMQwIPe7zjThZ34GlLVjg=;
 b=pFtCjH88UuGgZVI98KBXwDTablD3NbxKYy0efxWzPjBOOrHy2q1BfJ9cBKoZlINMya2EuY
 OVYQh+p7pGccJW8A5yB/QGVcapS9YkU+Z8j9uhwbznrQEbEKFy6mlCPG4TmuDhZm+LgmwV
 e0D1di1OEoFaTtxMh71afwj9THcLBRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661560101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkHOMCgteBaqkUHJLwtS9lLMQwIPe7zjThZ34GlLVjg=;
 b=sn4D/Kks/d2bW/pVeOvdSpcDwye2zZSfsCAhXEa6My+hAOvkGt1WH3UqmOlJJoR6ZZE+RL
 jd/qwXfqoYJXBPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E363133A6;
 Sat, 27 Aug 2022 00:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MHjSESRlCWNQCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sat, 27 Aug 2022 02:28:10 +0200
Message-Id: <20220827002815.19116-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] tst_fs_type: Add nsfs, vfat,
 squashfs to tst_fs_type_name()
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fs.h  | 5 ++++-
 lib/tst_fs_type.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 8159b99eb..a6f934b0f 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -5,7 +5,7 @@
 #ifndef TST_FS_H__
 #define TST_FS_H__
 
-/* man 2 statfs or kernel-source/include/linux/magic.h */
+/* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
 #define TST_BTRFS_MAGIC    0x9123683E
 #define TST_NFS_MAGIC      0x6969
 #define TST_RAMFS_MAGIC    0x858458f6
@@ -32,6 +32,9 @@
 #define TST_FUSE_MAGIC     0x65735546
 #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
 #define TST_EXFAT_MAGIC    0x2011BAB0UL
+#define TST_SQUASHFS_MAGIC 0x73717368
+/* kernel-source/fs/ntfs/ntfs.h */
+#define TST_NTFS_MAGIC     0x5346544e
 
 enum {
 	TST_BYTES = 1,
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 9de80224b..de4facef5 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -88,6 +88,12 @@ const char *tst_fs_type_name(long f_type)
 		return "fuse";
 	case TST_EXFAT_MAGIC:
 		return "exfat";
+	case TST_NTFS_MAGIC:
+		return "ntfs";
+	case TST_SQUASHFS_MAGIC:
+		return "squashfs";
+	case TST_VFAT_MAGIC:
+		return "vfat";
 	default:
 		return "unknown";
 	}
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
