Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E9C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:50:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6878D61152
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6878D61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C6633C8F79
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:50:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F5893C1D4E
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:50:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F7F4600076
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632387031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOqzIA6p/e3zq4zk/iE+fp6qri8TMIwfeHZQDPygA0Q=;
 b=h+jjq4Fcdy05NsTgJCIb7/Yj5RX5ODFznxvuJ67gnd/1+aiRWAWOmew8IfMKnFcQMEsZk0
 1SyAekQDDC6rLd9ypieM/C6yskWJ0wAxkmfHeRR9IlHuxS277/xJZQSLU8OcbUNMxspWlh
 jbO6G6oGNkI5IWSeTjQGQ44Xgabarn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-YZCkmT_MNpagWbov3-wnxg-1; Thu, 23 Sep 2021 04:50:30 -0400
X-MC-Unique: YZCkmT_MNpagWbov3-wnxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7671E83DBC3
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:50:29 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 704C05BAEA;
 Thu, 23 Sep 2021 08:50:27 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it,
	liwan@redhat.com
Date: Thu, 23 Sep 2021 10:50:23 +0200
Message-Id: <3190c9a0b45411eb9d6024267c264825c9faa32e.1632386756.git.jstancek@redhat.com>
In-Reply-To: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
References: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] hugeshmat04: try to find unmapped range for test
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

Try to find unmapped range. In my testing, address above 1GB appears
to be needed for reproducer to work. Also add kernel commit that fixed
it to metadata.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index e9bb9fbf7b4b..b76da93a197e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -23,6 +23,7 @@
 
 #define SIZE	(1024 * 1024 * 1024)
 #define BOUNDARY (1024 * 1024 * 1024)
+#define BOUNDARY_MAX (3U * 1024 * 1024 * 1024)
 
 static long huge_free;
 static long huge_free2;
@@ -49,12 +50,20 @@ static void shared_hugepage(void)
 	int status, shmid;
 	size_t size = (size_t)SIZE;
 	void *buf;
+	unsigned long boundary = BOUNDARY;
 
 	shmid = shmget(IPC_PRIVATE, size, SHM_HUGETLB | IPC_CREAT | 0777);
 	if (shmid < 0)
 		tst_brk(TBROK | TERRNO, "shmget");
 
-	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
+	while (boundary <= BOUNDARY_MAX
+		&& range_is_mapped(boundary, boundary+SIZE))
+		boundary += 128*1024*1024;
+	if (boundary > BOUNDARY_MAX)
+		tst_brk(TCONF, "failed to find free unmapped range");
+
+	tst_res(TINFO, "attaching at 0x%lx", boundary);
+	buf = shmat(shmid, (void *)boundary, SHM_RND | 0777);
 	if (buf == (void *)-1) {
 		shmctl(shmid, IPC_RMID, NULL);
 		tst_brk(TBROK | TERRNO, "shmat");
@@ -104,6 +113,10 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "c5c99429fa57"},
+		{}
+	},
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_tmpdir = 1,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
