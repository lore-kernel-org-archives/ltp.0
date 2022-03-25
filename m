Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C701C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 01:48:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4113C6983
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 02:48:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6719E3C06A9
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 02:48:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA9741401159
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 02:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648172913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RWyuLX0ZDxXEyu4ZXYzBgEDFATy1A5G6or3dBusF8xM=;
 b=Tpla06jdclgSwuYj5t3W/9Og8+9xAR2UoT3ozU+UVZo3IIzaWdiFyj4vKfrkW6DGc2gNfc
 nroTBqeztmrOZ5ml94gftJxI+Te9/9gRl+uHwAssRlwaph61bTSdNBqtYaKeLRkMrXNrSZ
 quhu99MOZ2+U9U+09YjgmDRexkRFUU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-jFaeIVtZObCN7uxl597qDQ-1; Thu, 24 Mar 2022 21:48:32 -0400
X-MC-Unique: jFaeIVtZObCN7uxl597qDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01086811E78
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 01:48:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6DE200C0E3;
 Fri, 25 Mar 2022 01:48:26 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 09:48:21 +0800
Message-Id: <20220325014821.2286280-1-chuhu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=chuhu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] futex_waitv03: fix SIGSEGV in TCONF cleanup
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

When futex_time64 is not supported, TCONF will do the test cleanup
and test quit, in this case, the waitv array and shms are not allocated,
we can get a segment fault if accessing the waitv[*]. Add the flag
to record if the memory allocation is done, so the cleanup can do
correctly in TCONF case.

We can hit the issue on ppc64le:

tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
futex_waitv03.c:36: TINFO: Testing variant: syscall with old kernel spec
tst_buffers.c:55: TINFO: Test is using guarded buffers
futex_waitv03.c:108: TPASS: futex_waitv returned correctly
tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
futex_waitv03.c:36: TINFO: Testing variant: syscall time64 with kernel spec
../../../../include/tst_timer.h:271: TCONF: syscall(422) __NR_futex_time64 not supported on your arch
tst_test.c:1512: TBROK: Test killed by SIGSEGV!

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/syscalls/futex/futex_waitv03.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
index 1f53addac..ffe5c66cd 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv03.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -26,6 +26,7 @@ static char *str_numfutex;
 static int numfutex = 30;
 
 static struct futex_waitv *waitv;
+static unsigned int waitv_allocated;
 static int *shmids;
 
 static void setup(void)
@@ -50,12 +51,16 @@ static void setup(void)
 		waitv[i].flags = FUTEX_32;
 		waitv[i].val = 0;
 	}
+	waitv_allocated = tst_variant + 1;
 }
 
 static void cleanup(void)
 {
 	int i;
 
+	if (waitv_allocated != (tst_variant + 1))
+		return;
+
 	for (i = 0; i < numfutex; i++) {
 		if (!waitv[i].uaddr)
 			continue;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
