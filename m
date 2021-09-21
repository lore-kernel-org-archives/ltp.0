Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3989AC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 16:46:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8188761168
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 16:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8188761168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C4FA3CA2B8
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 18:46:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5327E3C821A
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 18:46:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B0D7B10006CD
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 18:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632242762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t9QZB405aVuJe6Y+MfDLHv0ldxauCNdpqwX2YOmsbOY=;
 b=TCedu1WwB/YkkzmV27+UEWYXAQQsNQZC7EFtQk5znwkaaOqvxxW2XwiPF36pgHZe+6oS4o
 RDOgmWSsKbZjqXGKgFWHQN2dFLpc9j02eCixdSZitIXfruIGmf6pj9P2Co/W8iClA8TcYu
 +Fi438R1pcKLGt2XoQ35tzRS9LDcRGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-ZBltXFMyMouja_TkXEM5fw-1; Tue, 21 Sep 2021 12:46:00 -0400
X-MC-Unique: ZBltXFMyMouja_TkXEM5fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BB910151E0
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:45:59 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF9F469FAE;
 Tue, 21 Sep 2021 16:45:58 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it,
	liwan@redhat.com
Date: Tue, 21 Sep 2021 18:45:54 +0200
Message-Id: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugeshmat04: don't attach at specific address
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

The test intermittently fails on ppc64le, when heap
happens to overlap with segment that the test is trying
to attach at 1GB boundary.

Let the kernel find suitable address.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index e9bb9fbf7b4b..75f61de066d7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -22,7 +22,6 @@
 #include "hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
-#define BOUNDARY (1024 * 1024 * 1024)
 
 static long huge_free;
 static long huge_free2;
@@ -54,7 +53,7 @@ static void shared_hugepage(void)
 	if (shmid < 0)
 		tst_brk(TBROK | TERRNO, "shmget");
 
-	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
+	buf = shmat(shmid, NULL, 0777);
 	if (buf == (void *)-1) {
 		shmctl(shmid, IPC_RMID, NULL);
 		tst_brk(TBROK | TERRNO, "shmat");
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
