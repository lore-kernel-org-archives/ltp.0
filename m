Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C3CC47DDB
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 02:51:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9BB3CE19B
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 03:51:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8C2C3CE190
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:58 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 161CD1400E1A
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706410136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3M6REz9GxQuJi5aonXtxeKpC8hGY/uZOTFqKiTvYdY=;
 b=QAZcRuUAdi+af7hXHN+kLd5r0hV/CphbtOlkBbYYG+xpRpSTim0CY1wPyFWy4hT3MqbSyV
 /gHBHdwPrrBEMwPczy2KpCrCnz9o1yrUCD/Vf7BYIG9+YOe9o80o5AxU3AJSlBb5nCjBwl
 xo2j5C3jqpuBxyQrbXVnrgti30ogYlg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-IPwpRFoyMOi1ozA4ic9TUw-1; Sat, 27 Jan 2024 21:48:55 -0500
X-MC-Unique: IPwpRFoyMOi1ozA4ic9TUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A6B583B82A
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:55 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 508AD1C060B1
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:54 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 28 Jan 2024 10:48:37 +0800
Message-Id: <20240128024838.2699248-8-liwang@redhat.com>
In-Reply-To: <20240128024838.2699248-1-liwang@redhat.com>
References: <20240128024838.2699248-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 7/8] swapon/off: enable all_filesystem in swap test
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/swapoff/swapoff02.c | 11 ++++++-----
 testcases/kernel/syscalls/swapon/swapon02.c   |  4 ++++
 testcases/kernel/syscalls/swapon/swapon03.c   |  4 ++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index cd940b1e7..53060b320 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -18,6 +18,8 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+
 static int setup01(void);
 static void cleanup01(void);
 
@@ -84,14 +86,13 @@ static void setup(void)
 
 	is_swap_supported("./tstswap");
 
-	if (!tst_fs_has_free(".", 1, TST_KB))
-		tst_brk(TBROK, "Insufficient disk space to create swap file");
-
-	if (tst_fill_file("./swapfile01", 0x00, 1024, 1))
-		tst_brk(TBROK, "Failed to create swapfile");
+	if (make_swapfile("swapfile01", 10, 1))
+		tst_brk(TBROK, "Failed to create file for swap");
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.test = verify_swapoff,
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index f5b0d6d56..acb789fc4 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -20,6 +20,8 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+
 static uid_t nobody_uid;
 static int do_swapoff;
 
@@ -78,6 +80,8 @@ static void verify_swapon(unsigned int i)
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.test = verify_swapon,
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index e13009111..249cb12c3 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -22,6 +22,8 @@
 #include "swaponoff.h"
 #include "libswap.h"
 
+#define MNTPOINT	"mntpoint"
+
 static int setup_swap(void);
 static int clean_swap(void);
 static int check_and_swapoff(const char *filename);
@@ -265,6 +267,8 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
