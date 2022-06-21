Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A62C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 08:37:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07CF93C941D
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 10:37:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 810F33C2806
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 10:37:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9B3E560081C
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 10:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655800665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3xUSXcZw++MU+3Zp5bMzG+f1M/DgrWLC1oMVLz1hIk=;
 b=IsBpvicJ898mNCoW0479N3hCozKEMwgCAhsBNBpqNIDMPoWaUbhoQ9IIHR80ZrQbk/NmCq
 7P/5nrBhCnMH7q//0twy0Pl++IJtOzyc8SzRTrag3eBVR42D9OvWk3tARG4s+zSCpfGA+i
 3puHC9wmRpfsGd759U3lPqaR7tsCJfI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-59PvL5QHNZ-SfXZycfdU2Q-1; Tue, 21 Jun 2022 04:37:41 -0400
X-MC-Unique: 59PvL5QHNZ-SfXZycfdU2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7ACB3833289;
 Tue, 21 Jun 2022 08:37:40 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 399832026D64;
 Tue, 21 Jun 2022 08:37:40 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jun 2022 10:37:17 +0200
Message-Id: <6616c11cdf55d2fd89f6f3c8f9ab1a8c1a3916e7.1655800610.git.jstancek@redhat.com>
In-Reply-To: <2873e7f25ac44d2c103a030bfc5f1d30e0fe80a9.1655795105.git.jstancek@redhat.com>
References: <2873e7f25ac44d2c103a030bfc5f1d30e0fe80a9.1655795105.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/migrate_pages03: restore runtime to 5m
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

Arches with large pages have trouble completing all loops in 30s,
restore runtime to 5m. Also check for remaining runtime and
exit if we run out.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index c6afb4cce05d..2866c96e6b8d 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -127,6 +127,11 @@ static void migrate_test(void)
 			tst_res(TFAIL | TERRNO, "migrate_pages() failed");
 			return;
 		}
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Out of runtime, exitting...");
+			break;
+		}
 	}
 	SAFE_SETEUID(0);
 
@@ -134,6 +139,7 @@ static void migrate_test(void)
 }
 
 static struct tst_test test = {
+	.max_runtime = 300,
 	.min_kver = "2.6.32",
 	.needs_root = 1,
 	.setup = setup,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
