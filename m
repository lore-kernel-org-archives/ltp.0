Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816D3C47DDF
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74333CE19E
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:27:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509FB3CE0CE
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:38 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BAE0600F9C
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706696736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWpIvld1X+kAWO332JoaH2ABa1fLkUTXwqHQTVTpTWw=;
 b=MXCh566H9vpkE3szLJbVwAdq+OSsksnebNSdT2wPkgtmLUMX54WS31EAe1xCiZm793xEM1
 Mezq68IZYC32gZ1RSDYw3KB5tDNiXgDeXJPyp/ZquX8P1aqaOFyRLKqmgWtEy/pge1RDxj
 iuoRC9P3Fx/txU50Sj7xi3sLDj2IZ1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-6qgTfAisPR-wjUWigRQq-Q-1; Wed, 31 Jan 2024 05:25:33 -0500
X-MC-Unique: 6qgTfAisPR-wjUWigRQq-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6FA9185A781;
 Wed, 31 Jan 2024 10:25:32 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 836B0157;
 Wed, 31 Jan 2024 10:25:31 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 18:25:14 +0800
Message-Id: <20240131102514.2739270-9-liwang@redhat.com>
In-Reply-To: <20240131102514.2739270-1-liwang@redhat.com>
References: <20240131102514.2739270-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v6 8/8] libswap: Refactor is_swap_supported function
 to return status
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

This updates the is_swap_supported function in the libltpswap
to return an bool status instead of void, allowing the function
to communicate success or failure to the caller. It introduces
checks and returns false on various failure conditions while
logging the failure without aborting the test case.

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/libswap.h         |  2 +-
 libs/libltpswap/libswap.c | 36 +++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index e67d65756..bdc5aacc6 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -20,5 +20,5 @@ int make_swapfile(const char *swapfile, int blocks, int safe);
  * Check swapon/swapoff support status of filesystems or files
  * we are testing on.
  */
-void is_swap_supported(const char *filename);
+bool is_swap_supported(const char *filename);
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 8aecad48d..06537231d 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <linux/fiemap.h>
 #include <stdlib.h>
+#include <stdbool.h>
 
 #define TST_NO_DEFAULT_MAIN
 
@@ -127,9 +128,6 @@ out:
 	return contiguous;
 }
 
-/*
- * Make a swap file
- */
 int make_swapfile(const char *swapfile, int blocks, int safe)
 {
 	struct statvfs fs_info;
@@ -164,11 +162,7 @@ int make_swapfile(const char *swapfile, int blocks, int safe)
 				   TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
 }
 
-/*
- * Check swapon/swapoff support status of filesystems or files
- * we are testing on.
- */
-void is_swap_supported(const char *filename)
+bool is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
 	int ret = make_swapfile(filename, 10, 1);
@@ -188,23 +182,31 @@ void is_swap_supported(const char *filename)
 	}
 
 	if (ret != 0) {
-		if (fi_contiguous == 0 && sw_support == 0)
+		if (fi_contiguous == 0 && sw_support == 0) {
 			tst_brk(TCONF, "mkswap on %s not supported", fstype);
-		else
-			tst_brk(TFAIL, "mkswap on %s failed", fstype);
+		} else {
+			tst_res(TFAIL, "mkswap on %s failed", fstype);
+			return false;
+		}
 	}
 
 	TEST(tst_syscall(__NR_swapon, filename, 0));
 	if (TST_RET == -1) {
-		if (errno == EPERM)
+		if (errno == EPERM) {
 			tst_brk(TCONF, "Permission denied for swapon()");
-		else if (errno == EINVAL && fi_contiguous == 0 && sw_support == 0)
+		} else if (errno == EINVAL && fi_contiguous == 0 && sw_support == 0) {
 			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
-		else
-			tst_brk(TFAIL | TTERRNO, "swapon() on %s failed", fstype);
+		} else {
+			tst_res(TFAIL | TTERRNO, "swapon() on %s failed", fstype);
+			return false;
+		}
 	}
 
 	TEST(tst_syscall(__NR_swapoff, filename, 0));
-	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
+		return false;
+	}
+
+	return true;
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
