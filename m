Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8C5C47422
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 04:47:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C143C3CE2FD
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 05:47:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A18A13CD195
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 05:46:06 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 014CE60485A
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 05:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706071564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3rat+qmgPkkfhV79s1V90eV03UFKKkWT6cCBv5XS8A=;
 b=JopU3JEsImVsjQ8zLnjClcDjd+MZn6kHTL4RcfHI9xuvGy/A6YrXq+LaZYHHPRtnQq1UDC
 bvZqiFpdSQQ5hYjZuIgO1Hyj6APsP5M8ErP9T195SBOcWjCs7bBB+XQ46Di2BePuFJ/PJ5
 bdTybS1vIpYCNsi+Cp/DCr4x37cPJds=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-H38ixkb3M86OBUVNVRpxMA-1; Tue,
 23 Jan 2024 23:46:02 -0500
X-MC-Unique: H38ixkb3M86OBUVNVRpxMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EDE429AA39A;
 Wed, 24 Jan 2024 04:46:02 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0AF01121312;
 Wed, 24 Jan 2024 04:46:00 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 24 Jan 2024 12:45:48 +0800
Message-Id: <20240124044548.2652626-7-liwang@redhat.com>
In-Reply-To: <20240124044548.2652626-1-liwang@redhat.com>
References: <20240124044548.2652626-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V4 6/6] swapoff01: make use of make_swapfile
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
