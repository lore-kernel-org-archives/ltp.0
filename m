Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE50C46CD2
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 02:51:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A389E3CE70B
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 03:51:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CDA33CE70B
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:49:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 53C0B1000F26
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706410138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldhElJT0G/3lc6jlpgrOHBx7SpfZOupzKY6bJNP8S4I=;
 b=SfvmCwIvuNNTCoVHuhMbWJgHSm6Xb171QnH3lca9ZJW6+ne5CIxDyspbSDVCvYd16v/9hb
 ZlLtpIZL0zY/1k71C2AyhObw89Hh7q4nPyI28bbfDruGhp2Xo1ApNkSoxcvuUiAN7w6c0A
 e9tRWhVzZ/DKnKSxJOU92TCbmwoIJW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-MJrpJ9jvMGyejjcgkDlu1w-1; Sat, 27 Jan 2024 21:48:56 -0500
X-MC-Unique: MJrpJ9jvMGyejjcgkDlu1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B372D827D85
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:56 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C98D71C060B1
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:55 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 28 Jan 2024 10:48:38 +0800
Message-Id: <20240128024838.2699248-9-liwang@redhat.com>
In-Reply-To: <20240128024838.2699248-1-liwang@redhat.com>
References: <20240128024838.2699248-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 8/8] libswap: Refactor is_swap_supported function
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
to return an integer status instead of void, allowing the function
to communicate success or failure to the caller. It introduces
checks and returns 0 on various failure conditions while logging
the failure without aborting the test case.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/libswap.h         |  2 +-
 libs/libltpswap/libswap.c | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index e67d65756..1e09db031 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -20,5 +20,5 @@ int make_swapfile(const char *swapfile, int blocks, int safe);
  * Check swapon/swapoff support status of filesystems or files
  * we are testing on.
  */
-void is_swap_supported(const char *filename);
+int is_swap_supported(const char *filename);
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 8aecad48d..14b7d9e3a 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -168,7 +168,7 @@ int make_swapfile(const char *swapfile, int blocks, int safe)
  * Check swapon/swapoff support status of filesystems or files
  * we are testing on.
  */
-void is_swap_supported(const char *filename)
+int is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
 	int ret = make_swapfile(filename, 10, 1);
@@ -188,23 +188,31 @@ void is_swap_supported(const char *filename)
 	}
 
 	if (ret != 0) {
-		if (fi_contiguous == 0 && sw_support == 0)
+		if (fi_contiguous == 0 && sw_support == 0) {
 			tst_brk(TCONF, "mkswap on %s not supported", fstype);
-		else
-			tst_brk(TFAIL, "mkswap on %s failed", fstype);
+		} else {
+			tst_res(TFAIL, "mkswap on %s failed", fstype);
+			return 0;
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
+			return 0;
+		}
 	}
 
 	TEST(tst_syscall(__NR_swapoff, filename, 0));
-	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
+		return 0;
+	}
+
+	return (TST_RET == 0);
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
