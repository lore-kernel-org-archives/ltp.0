Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC0EC433EF
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 09:15:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 697FA3CA8C7
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 11:15:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 228F63C053F
 for <ltp@lists.linux.it>; Fri,  6 May 2022 11:14:56 +0200 (CEST)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.133.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E0D09140027B
 for <ltp@lists.linux.it>; Fri,  6 May 2022 11:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651828494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vph5GLzhb89eiVrUKOZXcqX7Utt6mtATZG4CGBoWejM=;
 b=IaM3z6ZzdOtvxJ/fbAfMy/tMqS5kPkxntgvO8ygUOjlkB0jBtuniGHaSXtWnDF44n+LH53
 mzMS+V3+/B/6cRf3DGdSA25uvreujRnEfLzcyeRrIfDExZnOihKTLvwsrv9fLpmnq6obgV
 2EFPBtLsxz4HfObEU941YmOwPLvkHcY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-SVPmqXOUP2OBOoQQA4ZbWA-1; Fri, 06 May 2022 05:14:53 -0400
X-MC-Unique: SVPmqXOUP2OBOoQQA4ZbWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C292B18019CE
 for <ltp@lists.linux.it>; Fri,  6 May 2022 09:14:52 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 684F040D2820
 for <ltp@lists.linux.it>; Fri,  6 May 2022 09:14:52 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  6 May 2022 11:14:46 +0200
Message-Id: <46c22201fe644cd7e96d24ef9110e2c643c8ec33.1651828441.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/recvmsg01: wait for server to finish
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

When test finishes, cleanup of temporary directory (by library)
can be racing with server process still running sender() function
and trying to clean temp file "smtXXXXXX":
    ...
    recvmsg01   12  TPASS  :  large cmesg length successful
    recvmsg01    0  TWARN  :  tst_tmpdir.c:343: tst_rmdir: rmobj(/mnt/testarea/ltp-jj3j87RyWN/recnDC6uq)
                              failed: unlink(/mnt/testarea/ltp-jj3j87RyWN/recnDC6uq/smtlCpMTv)
                              failed; errno=2: ENOENT

Wait for server pid before proceeding with test cleanup.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 13bcaa4e07c4..6b78a230ba04 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -268,8 +268,10 @@ void setup(void)
 
 void cleanup(void)
 {
-	if (pid > 0)
+	if (pid > 0) {
 		(void)kill(pid, SIGKILL);	/* kill server */
+		wait(NULL);
+	}
 	if (tmpsunpath[0] != '\0')
 		(void)unlink(tmpsunpath);
 	tst_rmdir();
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
