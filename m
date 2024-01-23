Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D6C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 13:22:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 174753CFB72
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 14:22:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 082D23CC78D
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 14:22:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35ED62009AD
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 14:22:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706016133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9KuxQPxUnoO2d8HwipdLyZxzIkqKNedsDUB7rGgveUk=;
 b=bTozSKw4DumCajqjIrzmGeok/ltxZfH4dD+0cjVf2x8U1/Dg3AMlu7lsQPwBIoE85oyFjm
 o04MeyCJRe/7ALNzHQDYM2fjGy1EVU/ef4PEjeiQw6Ay5PQ12640dVYNmK2qMKwzv+0oVy
 9EPT7up/dZJeHoYH0lIcWYoEHtX55sA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-cSqzlR-6NCOccIYsi3MeqA-1; Tue,
 23 Jan 2024 08:22:12 -0500
X-MC-Unique: cSqzlR-6NCOccIYsi3MeqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10CC91C0BA40;
 Tue, 23 Jan 2024 13:22:12 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B946B3C2E;
 Tue, 23 Jan 2024 13:22:10 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 21:22:07 +0800
Message-Id: <20240123132207.2646026-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapoff01: make use of make_swapfile
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

This patch updates the swapoff01 test setup by replacing the previous
swapfile creation method with a single call to make_swapfile, which
now creates a contiguous swap file.

This change simplifies the setup and fix failure on TMPDIR on btrfs.

Note: it is a single fix but better applied with behind the libswap updates.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index b27eecdad..f36f7f17c 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -44,11 +44,8 @@ static void setup(void)
 		tst_brk(TBROK,
 			"Insufficient disk space to create swap file");
 
-	if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
+	if (make_swapfile("swapfile01", 1))
 		tst_brk(TBROK, "Failed to create file for swap");
-
-	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
-		tst_brk(TBROK, "Failed to make swapfile");
 }
 
 static struct tst_test test = {
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
