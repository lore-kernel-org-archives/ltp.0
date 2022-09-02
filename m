Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591BEC38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 13:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19B303CA844
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 15:37:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 606123C65EB
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F08FE1000F4F
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ED4C5BF1D;
 Fri,  2 Sep 2022 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662125836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUug+Lkk1PgvulyCtvlR+u8U9Y1cn2xLZp7bwvnsjoM=;
 b=ghUnjWBq5dRpr394ejb9IN8hFul9Jo4eXpivnmRU0mDAPIn2TD0i4UtOX4TbWKZFuyGaPS
 9yj0gy70m5rOqd+S881abamDiBZT00u4kvOksOdqX+1YvQ55nHOufv6NMIvNIvmvG3DiBV
 vJn+hX1c3oSvo4QlX8+CUmujp3i9diU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662125836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUug+Lkk1PgvulyCtvlR+u8U9Y1cn2xLZp7bwvnsjoM=;
 b=7lrdOvv+bb3qeF9DDb6fK7mlpIpivX99a/NbdwmtCv07d3bP5Equy/B6b2s9zhtSsVDh55
 OnpDGPBkrK/LKKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4252E1330E;
 Fri,  2 Sep 2022 13:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AMlGDgwHEmObBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 13:37:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 15:37:05 +0200
Message-Id: <20220902133710.1785-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902133710.1785-1-pvorel@suse.cz>
References: <20220902133710.1785-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/9] tst_supported_fs: Support skip list when query
 single fs
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

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fs.h                 | 10 ++++++++++
 lib/tst_supported_fs_types.c     | 18 ++++++++++++++++++
 testcases/lib/tst_supported_fs.c |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index cc6d9b547..e399aef54 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -183,6 +183,16 @@ enum tst_fs_impl {
  */
 enum tst_fs_impl tst_fs_is_supported(const char *fs_type);
 
+/*
+ * Check filesystem support (@see tst_fs_is_supported()), but consider also
+ * filesystems to skip.
+ *
+ * @fs_type A filesystem name to check the support for.
+ * @skiplist A NULL terminated array of filesystems to skip.
+ */
+enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
+					      *const *skiplist);
+
 /*
  * Returns NULL-terminated array of kernel-supported filesystems.
  *
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 9726d193a..8c9379c1b 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
 	return TST_FS_UNSUPPORTED;
 }
 
+enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
+					      *const *skiplist)
+{
+	int ret;
+
+	ret = tst_fs_is_supported(fs_type);
+
+	if (!ret)
+		return ret;
+
+	if (tst_fs_in_skiplist(fs_type, skiplist)) {
+		tst_brk(TCONF, "%s is not supported by the test",
+			fs_type);
+	}
+
+	return ret;
+}
+
 const char **tst_get_supported_fs_types(const char *const *skiplist)
 {
 	unsigned int i, j = 0;
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 87be2b759..75945c809 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (optind < argc)
-		return !tst_fs_is_supported(argv[optind]);
+		return !tst_fs_is_supported_skiplist(argv[optind], (const char * const*)skiplist);
 
 	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 	for (i = 0; filesystems[i]; i++)
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
