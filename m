Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22194C54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 07:01:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 804B13CE6AE
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 08:01:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C98D13C06AC
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 08:00:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 280F71000C21
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 08:00:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710831646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t94CniJxH4jAHuij2HilvqUCUD2ATawQKi7v4AO9rHY=;
 b=PzShdeMHjVSH7Aw6ih/Klzhk7nhbag74butC1tG/0DJJdYeLO9ExKDDN9M+mBD0AtBBwYW
 eADoj/v4Q+oeX6TpBWTdmBkdgZWR+3LCPjuXmmAI0glZ4PiWPiAcpsOnQsX/5d4qVtyEA/
 VHg2uk7Yom2o0ephQlwil+6Wd7zgc4k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-CPt5vlNyOPOONGhpEKaYJg-1; Tue, 19 Mar 2024 03:00:44 -0400
X-MC-Unique: CPt5vlNyOPOONGhpEKaYJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7565480F7E9
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 07:00:44 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82D4E492BC8
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 07:00:43 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 19 Mar 2024 15:00:38 +0800
Message-Id: <20240319070040.3239539-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] libswap: add two method to create swapfile
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

This introduces new functionality to the libswap library by adding
two methods for creating a swapfile: SWAPFILE_BY_SIZE and SWAPFILE_BY_BLOCKS.
The make_swapfile function is updated to accept an additional enum
swapfile_method parameter to specify the creation method.

Two macros, MAKE_SWAPFILE_SIZE and MAKE_SWAPFILE_BLKS, are defined
to simplify the interface for creating swapfiles by size and by
blocks respectively.
---
 include/libswap.h         | 16 ++++++++++++++--
 libs/libltpswap/libswap.c | 30 ++++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index 8c75e20ae..1dee907f0 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -11,10 +11,22 @@
 #ifndef __LIBSWAP_H__
 #define __LIBSWAP_H__
 
+enum swapfile_method {
+    SWAPFILE_BY_SIZE,
+    SWAPFILE_BY_BLOCKS
+};
+
 /*
- * Make a swap file
+ * Create a swapfile of a specified size or number of blocks.
  */
-int make_swapfile(const char *swapfile, int blocks, int safe);
+int make_swapfile(const char *swapfile, unsigned int num,
+			int safe, enum swapfile_method method);
+
+#define MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
+    make_swapfile(swapfile, size, safe, SWAPFILE_BY_SIZE)
+
+#define MAKE_SWAPFILE_BLKS(swapfile, blocks, safe) \
+    make_swapfile(swapfile, blocks, safe, SWAPFILE_BY_BLOCKS)
 
 /*
  * Check swapon/swapoff support status of filesystems or files
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index a26ea25e4..6a0f24ed2 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -133,23 +133,37 @@ out:
 	return contiguous;
 }
 
-int make_swapfile(const char *swapfile, int blocks, int safe)
+int make_swapfile(const char *swapfile, unsigned int num, int safe, enum swapfile_method method)
 {
 	struct statvfs fs_info;
 	unsigned long blk_size, bs;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
 	char mnt_path[100];
+	unsigned int blocks;
 
 	if (statvfs(".", &fs_info) == -1)
 		return -1;
 
 	blk_size = fs_info.f_bsize;
 
-	/* To guarantee at least one page can be swapped out */
-	if (blk_size * blocks < pg_size)
-		bs = pg_size;
-	else
-		bs = blk_size;
+	switch (method) {
+	case SWAPFILE_BY_BLOCKS:
+		blocks = num;
+		if (blk_size * blocks < pg_size)
+			bs = pg_size;
+		else
+			bs = blk_size;
+	break;
+	case SWAPFILE_BY_SIZE:
+		if (num * 1024 * 1024 < pg_size)
+			bs = pg_size;
+		else
+			bs = blk_size;
+		blocks = (num * 1024 * 1024) / blk_size;
+	break;
+	default:
+		return -1;
+	}
 
 	if (sscanf(swapfile, "%[^/]", mnt_path) != 1)
 		tst_brk(TBROK, "sscanf failed");
@@ -175,13 +189,13 @@ int make_swapfile(const char *swapfile, int blocks, int safe)
 	argv[2] = NULL;
 
 	return tst_cmd(argv, "/dev/null", "/dev/null", safe ?
-				   TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
+			TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
 }
 
 bool is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
-	int ret = make_swapfile(filename, 10, 1);
+	int ret = MAKE_SWAPFILE_BLKS(filename, 10, 1);
 	int fi_contiguous = file_is_contiguous(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
