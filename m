Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E3AC021B3
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 09:29:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F84C3C663B
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 10:29:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E86943C0463
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 10:29:38 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D7C16396EF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 10:29:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740043776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ilEDaBqe9lx8NWuoLwG24YSyP9eCMVuGrPdmkq2qiAU=;
 b=SVHoaaFwhHLtJtwv3g513qLmvuai4l+Jyg930eVSWv5lh8vAXDk62bOKOY6+wCTL2aG6NZ
 CSGa34KROoRCCQLOr9vtTjCLUg8z8lcWwkGziiAuatdTuAtlCB06ypRupV4zvgstGqGgGF
 h+ZTaW9KJ+a+K2LAJdDVtTqH+YAT7ss=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-tFuBDJOSNFikorQOmwsObQ-1; Thu,
 20 Feb 2025 04:29:34 -0500
X-MC-Unique: tFuBDJOSNFikorQOmwsObQ-1
X-Mimecast-MFC-AGG-ID: tFuBDJOSNFikorQOmwsObQ_1740043773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 835411800373
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 09:29:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.85])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50766180035F; Thu, 20 Feb 2025 09:29:31 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 10:28:30 +0100
Message-ID: <b379b9603036d9d4877f562f750e2d1515dfd962.1740042744.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MSpTOCgYAGoU3u8EBuzeYA855DVYSIyiHjqpEOfotnU_1740043773
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/utime03: relax the check for 1 second
 difference
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test is using tst_get_fs_timestamp() which is using REALTIME_COARSE
clock, which is slightly less accurate. Back in 2022 we added extra log
message to print also min and max time. In those rare instances where
it fails this extra log shows it failed by one second difference.

Relax the check a little. Tested on aarch64 VMs, where it's usually
reproducible after couple hundred iterations.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/utime/utime03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 564e1de3dd77..abc2e6338af6 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -70,7 +70,7 @@ static void run(void)
 	SAFE_SETEUID(user_uid);
 	mintime = tst_get_fs_timestamp();
 	TST_EXP_PASS(utime(TEMP_FILE, NULL));
-	maxtime = tst_get_fs_timestamp();
+	maxtime = tst_get_fs_timestamp() + 1;
 	SAFE_SETEUID(root_uid);
 	SAFE_STAT(TEMP_FILE, &statbuf);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
