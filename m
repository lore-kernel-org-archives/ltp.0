Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B74C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDA563CC7D1
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:30:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5CE63CE22E
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:29:58 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 880ED6005F2
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705908596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kcnyVGq3/mEUKD1xEMOBcBFJUr02ocyR5/8Pt3uZiQ=;
 b=RGltceQW9cy48VJjxmLG4jlbWsphuFCRumO2mmMDKfNIZd4Ikfi6CGaHDsNYY/t/7MlkEL
 shpK7W+JRHx0SVvjpvAyYEYejWS9e9SzMWPNO4NJHzK+pRtP5/IUzkJAeGrgRlla1trSS3
 8Y7Eoo6WzQ7zl6AQfGwjh3H9l9fnGs8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-CgQiQsl2OOumPGmcOb41aw-1; Mon, 22 Jan 2024 02:29:54 -0500
X-MC-Unique: CgQiQsl2OOumPGmcOb41aw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1218C185A780;
 Mon, 22 Jan 2024 07:29:54 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4D47492BC6;
 Mon, 22 Jan 2024 07:29:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 15:29:46 +0800
Message-Id: <20240122072948.2568801-2-liwang@redhat.com>
In-Reply-To: <20240122072948.2568801-1-liwang@redhat.com>
References: <20240122072948.2568801-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] swapon01: Test on all filesystems
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

From: Petr Vorel <pvorel@suse.cz>

Test on all filesystems to increase coverage.
Skip filesystems which does not support swap (currently bcachefs, btrfs
and tmpfs).

Tested on 5.10, 6.6 and 6.7.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index e59fb20a1..e1fe50459 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -8,6 +8,7 @@
  * [Description]
  *
  * Checks that swapon() succeds with swapfile.
+ * Testing on all filesystems which support swap file.
  */
 
 #include <unistd.h>
@@ -17,7 +18,8 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
-#define SWAP_FILE "swapfile01"
+#define MNTPOINT	"mntpoint"
+#define SWAP_FILE	MNTPOINT"/swapfile01"
 
 static void verify_swapon(void)
 {
@@ -36,8 +38,10 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
+	.all_filesystems = 1,
 	.test_all = verify_swapon,
 	.setup = setup
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
