Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA8FC3ABD8
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747227552; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=1Y9wUT7ApkbB7vJ4f2ki/UnSkJkOBHMsMLZOLLGszHY=;
 b=hbMXD6c2hL3Lpr55Qmo3kh/TI2lfiLQV9DMTHH3z3qJg1SG2FY5t3sGfyTs0OdZdvwUnm
 xseXY6Ij/1t9SzryzYflt162XLzsdXx3LY8cZJRKbi/b80SjSxO9FU5i+pcckd7HIEciTYt
 b6JW2azy3MzgGzby1I4xLLC+Mmw0I4A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B15DD3CC3BE
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 14:59:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C17063C0562
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:58:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B196100048F
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747227528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pGfRAq5wkWEQ/UIr3UReK3q73DY2r1GdiJMvAqvifaE=;
 b=KFB7kNVI43mRTcUtqCM/zPq9O2KM0cLXXJGSCr7E3ILBirchGrX8Nq2hKczdHLa6HGlae/
 CPnnyKfRmmfYCP9zPGCvYxDAJL7E7Xs9Z5liY/rDOrHmF4W13V7PAmnqh9ReJcADiST1Xo
 Lp6+W+6GXbJ9Ew42LIPd/ltBrjLOlrQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-oDKG23wHPSGdEbRzgRz3HQ-1; Wed,
 14 May 2025 08:58:46 -0400
X-MC-Unique: oDKG23wHPSGdEbRzgRz3HQ-1
X-Mimecast-MFC-AGG-ID: oDKG23wHPSGdEbRzgRz3HQ_1747227525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A2441955DBD
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:58:45 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE920180045B; Wed, 14 May 2025 12:58:43 +0000 (UTC)
To: ltp@lists.linux.it,
	liwan@redhat.com
Date: Wed, 14 May 2025 14:59:04 +0200
Message-ID: <08c85cf64d703dfaba31398ab9d9b480488fe338.1747227481.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T_oMJMN71RBusPRv5OZx3TTLr1FTDifC6kxMx0s5M_g_1747227525
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap22: set also memory.swap.max
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In some environments, the system appears to be able to
swap in faster pace than what's needed for allocation
to be DROPPED. So, set limit also for memory.swap.max to
avoid swap usage.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap22.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
index 0e589dfabf45..1507fdfa78c3 100644
--- a/testcases/kernel/syscalls/mmap/mmap22.c
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -32,6 +32,10 @@ static void test_mmap(void)
 
 	cg_child = tst_cg_group_mk(tst_cg, "child");
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
+	if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", 0);
+	else
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", MEM_LIMIT);
 	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
 	alloc = SAFE_MMAP(0, alloc_size, PROT_READ | PROT_WRITE,
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
