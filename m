Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC39C433EF
	for <ltp@archiver.kernel.org>; Thu, 30 Dec 2021 10:37:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30D323C2FBE
	for <ltp@archiver.kernel.org>; Thu, 30 Dec 2021 11:37:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE8423C0BA7
 for <ltp@lists.linux.it>; Thu, 30 Dec 2021 11:37:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4837D653A69
 for <ltp@lists.linux.it>; Thu, 30 Dec 2021 11:37:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 994961F37C;
 Thu, 30 Dec 2021 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1640860657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhtCt9DqFjiQEs5Lg29ifaNJXPWgtAmp13zqJKdy43w=;
 b=YElFIp3ChyTys7TvlfOtu56BDxivlienineNWAs8xtH6vkPj+TzuXkseeM6pmPAQcnUIxr
 ErLblRkX2Caup57l3SIeezrXF7D9cbfiwKMoHbJ0DgdGs5EsgjN1MmD/wkCeRwZgImV4JC
 yQUS2GPi5zkau+SDlx/rAPV1d0jclNM=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id 60516A3B88;
 Thu, 30 Dec 2021 10:37:37 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 30 Dec 2021 10:37:16 +0000
Message-Id: <20211230103718.369-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211230103718.369-1-rpalethorpe@suse.com>
References: <20211220131043.18894-1-rpalethorpe@suse.com>
 <20211230103718.369-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] API/fs: Add exfat magic
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
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
