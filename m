Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B239AE77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 04:56:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F1313C1DB7
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 05:56:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26DB83C1DE2
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7186B64E8FB
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736398551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1/CU+iXD7usHeJtqo9WPeoaw0qwJ/K7vdsQX30C9mM=;
 b=OfCrohbQKnl/u42jFCUuKKKRHu2bCr4TtsoWic7eaGcBJBdlZpf2rNliilDIhaFoOMG63z
 56h4KqSibMhasbtgI5gpCcGOCJld9Bwl4mg5LE4nX2l0RhsMvf0uzDAstamueSyfGc9sCv
 JPVQx+9S/v1+3okKmFOx4w3BuhTPLcE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-jTR6G-NZNFeY2U9Q0dKKgA-1; Wed,
 08 Jan 2025 23:55:49 -0500
X-MC-Unique: jTR6G-NZNFeY2U9Q0dKKgA-1
X-Mimecast-MFC-AGG-ID: jTR6G-NZNFeY2U9Q0dKKgA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A67531955BED
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:48 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C6A119560AA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:47 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 12:55:31 +0800
Message-ID: <20250109045532.43017-4-liwang@redhat.com>
In-Reply-To: <20250109045532.43017-1-liwang@redhat.com>
References: <20250109045532.43017-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1QlILkHhgZ7_v__iHVJ4cKiEjRa_L_kiYIM1lcGN8ns_1736398549
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] set_mempolicy01: make use of tst_set_timeout
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
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index cd39c6c41..39e7156d0 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -41,9 +41,9 @@ static void setup(void)
 	 * has multiple NUMA nodes, the test matrix combination grows exponentially
 	 * and bring about test time to increase extremely fast.
 	 *
-	 * Here reset the maximum runtime according to the NUMA nodes.
+	 * Here reset the entire timeout according to the NUMA nodes.
 	 */
-	tst_set_runtime(test.runtime * (1 << nodes->cnt/16));
+	tst_set_timeout(test.timeout * (1 << nodes->cnt/16));
 }
 
 static void cleanup(void)
@@ -119,7 +119,7 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.runtime = 600,
+	.timeout = 600,
 };
 
 #else
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
