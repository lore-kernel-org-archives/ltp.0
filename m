Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C942C79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788859397; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=JpykQhoxmgIj0el5rp/oSAZYnDBH8AszSnWiY5kqHOM=;
 b=QEmpVEyQGxhzMsAWUNB8hjoZ+3+XbQVQ4NGrddERKCb7LmMkFgpMs7uMz/AVbsGWIgSPH
 NdOq2WDquDjXFuMk1Y61RdYiZbetyl1yN3o4yn9m4L81iNDhxMDCFQ3rIkCszTIj3gPAtv0
 QxT6Zpuc3IXuA7a4OEh2a55z49zb/AM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 692E13E7356
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 11:23:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3FD13E2024
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 11:22:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D99B20009C
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 11:22:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788859375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+DCCiL6NgsrC8RkyzGdr8ftNj4eGhkNs9Q0smoGRHWk=;
 b=ePnWWoP3NCd9De3K47yaJPiHTobsFKn8uOdafAS6C/TPsWPZf6VhDVtt4FmAN6YEMmFo61
 MXR/UTwfsfBGOxUDJVeIAQbv9RTv5uaLl+YTafUB8DEhgFq1OkPhmGCNn/ddyS0hL/boGh
 Q+f4zT9kFASv3U9fkQj+fHoSQS81TtA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-IR-YCEmOOPGqRuDA5im3zQ-1; Tue,
 08 Sep 2026 05:22:53 -0400
X-MC-Unique: IR-YCEmOOPGqRuDA5im3zQ-1
X-Mimecast-MFC-AGG-ID: IR-YCEmOOPGqRuDA5im3zQ_1788859373
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C38183F9F6
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 09:22:52 +0000 (UTC)
Received: from mmenashe-thinkpadp16vgen1.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBD40180059E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 09:22:51 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 12:22:48 +0300
Message-ID: <20260908092248.15774-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h7DPWi79BmVY1ztYZJYlXktBtbxocAvikkmehFFpf3o_1788859373
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] read_all: Fix buffer too small for long paths
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

queue_pop() copies each path into popped[BUFFER_SIZE], but BUFFER_SIZE
was 1024 while visit_dir() builds paths up to PATH_MAX. Any path longer
than 1023 bytes aborted the test with TBROK.

Use PATH_MAX for BUFFER_SIZE and MAX_PATH, and drop the extra -1 from
the queue_pop() bound so a PATH_MAX - 1 character path fits.

Tested on smaller boards and then on local machines with deeply nested
directories under /sys.

Fixes: 67c95fbbfc3a ("Add read_all file systems test")
Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 5720ffb99..ec9454fc9 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -51,8 +51,8 @@
 #include "tst_timer.h"
 
 #define QUEUE_SIZE 16384
-#define BUFFER_SIZE 1024
-#define MAX_PATH 4096
+#define BUFFER_SIZE PATH_MAX
+#define MAX_PATH PATH_MAX
 #define MAX_DISPLAY 40
 
 struct queue {
@@ -131,7 +131,7 @@ static int queue_pop(struct queue *q)
 	while (q->data[i]) {
 		q->popped[j] = q->data[i];
 
-		if (++j >= BUFFER_SIZE - 1)
+		if (++j >= BUFFER_SIZE)
 			tst_brk(TBROK, "Buffer is too small for path");
 
 		 i = (i + 1) % QUEUE_SIZE;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
