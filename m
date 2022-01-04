Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F381C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:21:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 263A13C924F
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 13:21:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02FA93C1D3C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 13:20:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F4BA60070B
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 13:20:36 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E8258212BC;
 Tue,  4 Jan 2022 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641298835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sYeoKKpnhi4mpeY1vDQ6zf1kRJKCdBDOUnRXgbLAOU=;
 b=IH1CP3z5yM/zek0Y4mdOutY4HWYEY4696cMTRsJWrp7ugSiqvaeonWl6CjHuzYVnIr0iUC
 2tX/fsvO1YlCRWPGDtMwCv1RX4DZTCius5rZPexHiI038GOzhLjrxQF7LVsrAk8rOjS4tl
 Eo1TKrL/MvnOVjbBTddVTsAPxQ8HgZw=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id AFB49A3B84;
 Tue,  4 Jan 2022 12:20:35 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  4 Jan 2022 12:20:08 +0000
Message-Id: <20220104122010.23069-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104122010.23069-1-rpalethorpe@suse.com>
References: <20220104122010.23069-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] API/fs: Add exfat magic
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fs.h  | 1 +
 lib/tst_fs_type.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 36d4b46f0..efcdff608 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -30,6 +30,7 @@
 #define TST_EXOFS_MAGIC    0x5DF5
 #define TST_OVERLAYFS_MAGIC 0x794c7630
 #define TST_FUSE_MAGIC     0x65735546
+#define TST_EXFAT_MAGIC    0x2011BAB0UL
 
 enum {
 	TST_BYTES = 1,
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 8475f4c78..9de80224b 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -86,6 +86,8 @@ const char *tst_fs_type_name(long f_type)
 		return "overlayfs";
 	case TST_FUSE_MAGIC:
 		return "fuse";
+	case TST_EXFAT_MAGIC:
+		return "exfat";
 	default:
 		return "unknown";
 	}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
