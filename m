Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BBC433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 06:00:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3511060F92
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 06:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3511060F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEEA83C9521
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:00:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509723C2532
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 08:00:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E943E2001DF
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 08:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630908025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RQhpTobqpYowBsAXhNYziQjZCcZCZz9fmnbJDiEIM+8=;
 b=aAiYUZ2pBOtIuQ4ZaTJhqbmjpu0IYopN2sm9cIUI6plbMeBYBgQTuTlGB+hnNWikgAE7dI
 IVuDWyeQfm7DIRbdODnCe+mCs21sKI65U+8Ksy5BObDd6neWGBvNIxbWq4CBy7KxeyQycw
 N6yFoH2bkK7VMx8m21fNORx03oTvoIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-kO35IdJhPV2wJHZ8iA3erg-1; Mon, 06 Sep 2021 02:00:23 -0400
X-MC-Unique: kO35IdJhPV2wJHZ8iA3erg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF115835DEC
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 06:00:22 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28B525D740
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 06:00:21 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Sep 2021 14:00:20 +0800
Message-ID: <20210906060020.3219023-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
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
Message-ID: <20210906060020.Q4c2SRSNjzf_w4nIHWjrjShGbRjQcR0lnBWBfCg1NuI@z>

The st_mtime field is defined as st_mtim.tv_sec for backward
compatibility in struct stat, which might not precise enough
for timestamp comparing.

Here switch to timespec diff (with compare nanosecond as well) to
get rid of this kind of rare faliure:

   7	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
   8	copy_file_range.h:36: TINFO: Testing libc copy_file_range()
   9	copy_file_range03.c:48: TPASS: copy_file_range sucessfully updated the timestamp
   10	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
   11	copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
   12	copy_file_range03.c:46: TFAIL: copy_file_range did not update timestamp.

Also, raise the sleep time to 1.5 sec to make test more robust.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../copy_file_range/copy_file_range03.c         | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 253eb57ad..5950c80c1 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -12,26 +12,27 @@
 #define _GNU_SOURCE
 
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "copy_file_range.h"
 
 static int fd_src;
 static int fd_dest;
 
-unsigned long get_timestamp(int fd)
+struct timespec get_timestamp(int fd)
 {
 	struct stat filestat;
 
 	fstat(fd, &filestat);
-	return filestat.st_mtime;
+	return filestat.st_mtim;
 }
 
 static void verify_copy_file_range_timestamp(void)
 {
 	loff_t offset;
-	unsigned long timestamp, updated_timestamp;
+	struct timespec timestamp1, timestamp2, diff;
 
-	timestamp = get_timestamp(fd_dest);
-	usleep(1000000);
+	timestamp1 = get_timestamp(fd_dest);
+	usleep(1500000);
 
 	offset = 0;
 	TEST(sys_copy_file_range(fd_src, &offset,
@@ -40,9 +41,11 @@ static void verify_copy_file_range_timestamp(void)
 		tst_brk(TBROK | TTERRNO,
 				"copy_file_range unexpectedly failed");
 
-	updated_timestamp = get_timestamp(fd_dest);
+	timestamp2 = get_timestamp(fd_dest);
 
-	if (timestamp == updated_timestamp)
+	diff = tst_timespec_diff(timestamp1, timestamp2);
+
+	if (!diff.tv_sec && !diff.tv_nsec)
 		tst_brk(TFAIL, "copy_file_range did not update timestamp.");
 
 	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
