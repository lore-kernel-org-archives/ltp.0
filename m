Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC2C433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:40:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 345903CA513
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:40:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7069B3C6316
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:40:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA57D1400191
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649670023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ISTnt0ktdvGD3Y90oSmHULr5ZmPWq0HOQHOsBt1zVZw=;
 b=WDBd6yo3Ijh8jE3FsY+J4fjKtLflI+xB3VJcfFsZeoguCUdcEtnLV8bDvbu0uSRJDsjBHQ
 rcgaGuHzb6NBVKEhGwaOpB/gW19UuvfrcOvccUL/arXHQ0bBYMbWDBF/jfzvFhtGVEb193
 G0N4GqD4me0D0/2Bx3IqB6gTDV3JW7A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-RhuX731HMQG6TRIdE59ZQQ-1; Mon, 11 Apr 2022 05:40:22 -0400
X-MC-Unique: RhuX731HMQG6TRIdE59ZQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFD253C37F2A
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:40:21 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4B972024CCB
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:40:20 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 11 Apr 2022 17:40:19 +0800
Message-Id: <20220411094019.1143199-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fsync02: multiply the timediff if test in VM
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

Similar to 59e73f2 ("clock_gettime04: multiply the
timediff if test in VM"), extend tolerance for this test too.

  fsync02.c:93: TFAIL: fsync took too long: 167.000000 seconds;
                max_block: 17768; data_blocks: 2287

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/fsync/fsync02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index fcdc14f89..e6704b3a5 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -21,13 +21,13 @@
 
 #define BLOCKSIZE 8192
 #define MAXBLKS 65536
-#define TIME_LIMIT 120
 #define BUF_SIZE 2048
 
 char tempfile[40] = "";
 char pbuf[BUF_SIZE];
 int fd;
 off_t max_blks = MAXBLKS;
+int time_limit = 120;
 
 struct statvfs stat_buf;
 
@@ -35,6 +35,11 @@ static void setup(void) {
 	/* free blocks avail to non-superuser */
 	unsigned long f_bavail;
 
+	if (tst_is_virt(VIRT_ANY)) {
+		tst_res(TINFO, "Running in a VM, multiply the time_limit by 2.");
+		time_limit *= 2;
+	}
+
 	fd = SAFE_OPEN("tempfile", O_RDWR | O_CREAT | O_TRUNC, 0777);
 
 	if (fstatvfs(fd, &stat_buf) != 0) {
@@ -89,7 +94,7 @@ static void run(void) {
 		"timer broken end %ld < start %ld",
 		time_end, time_start);
 	} else if ((time_delta =
-		difftime(time_end, time_start)) > TIME_LIMIT) {
+		difftime(time_end, time_start)) > time_limit) {
 		tst_res(TFAIL,
 		"fsync took too long: %lf seconds; "
 		"max_block: %d; data_blocks: %d",
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
