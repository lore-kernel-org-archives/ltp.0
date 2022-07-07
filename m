Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C22CCA482
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 09:39:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 116A53C97C6
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:39:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C3653C6FF1
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:38:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 884E2200B00
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657186730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yLRCL4XGKszfScVF7CD0gpG5tFh57yr6o2BafUR/Q2M=;
 b=RoUrBw8XBxCxkC1Ofj53FUr9ZmWfB/lAsDQ7Ouikx1PKOOHewu77uxEo3cnMAsBUqB8w19
 eEr2fvbxL0oAmZ++zzt+GPjgwlvn+MmRB3JZPS/rJfgvdpFwuZCtJwA4uDTGPN5XX4breF
 hqQlJ1kKjuGV25By+5brYrWc5X5lbzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-KBUZara9PQm4I473XmMKKw-1; Thu, 07 Jul 2022 05:38:48 -0400
X-MC-Unique: KBUZara9PQm4I473XmMKKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F0F09425A1
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 09:38:48 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA362166B26
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 09:38:46 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 17:38:45 +0800
Message-Id: <20220707093845.946230-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mountns01: wait for umount completed in thread_b
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

To get rid of race condition (occurs with umount_folders):

    mountns01.c:42: TPASS: shared mount in parent passed
    mountns01.c:83: TPASS: shared mount in child passed
    tst_device.c:394: TWARN: umount('B') failed with EINVAL
    mountns.h:39: TWARN: umount(B) failed: EINVAL (22)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/containers/mountns/mountns01.c | 2 ++
 testcases/kernel/containers/mountns/mountns02.c | 2 ++
 testcases/kernel/containers/mountns/mountns03.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 452fe1d10..3e9c22ce3 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -86,6 +86,8 @@ static void run(void)
 
 	TST_CHECKPOINT_WAKE(0);
 
+	SAFE_WAIT(NULL);
+
 	SAFE_UMOUNT(DIRA);
 }
 
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index cbd435958..4ef1a61b8 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -87,6 +87,8 @@ static void run(void)
 
 	TST_CHECKPOINT_WAKE(0);
 
+	SAFE_WAIT(NULL);
+
 	SAFE_UMOUNT(DIRA);
 }
 
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 5c19a96a9..0d8b86f9d 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -97,6 +97,8 @@ static void run(void)
 
 	TST_CHECKPOINT_WAKE(0);
 
+	SAFE_WAIT(NULL);
+
 	SAFE_UMOUNT(DIRA);
 }
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
