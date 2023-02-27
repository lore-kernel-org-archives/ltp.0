Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864BC64ED6
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 07:21:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48F353CDE35
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 08:21:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E55443CAC68
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 08:21:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7021260564B
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 08:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677482474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h21l1O6tUtF8U6ph5sygNAS7cv9YoSxMxVMEaNKLcys=;
 b=WKssZffmVwHdnNFsIbyvEgzMVlXtDxpcz4Mw369+A+bgaGERhmg0HXTuxh9i8AwBcxPMvE
 EN+1GTrxCOKicWat3s5gkFnqcpK9N3UnPegonKoHhN9JXn+E+OGVXgD8dP2k+AzWkBuuzY
 acSusaxD4hKxg/5msNe1EEckLbECad4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-2taGeyR9OTGI5Iz7PCHgig-1; Mon, 27 Feb 2023 02:21:12 -0500
X-MC-Unique: 2taGeyR9OTGI5Iz7PCHgig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9639629ABA07
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 07:21:12 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32860404BEC5;
 Mon, 27 Feb 2023 07:21:04 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 27 Feb 2023 15:21:03 +0800
Message-Id: <20230227072103.264317-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mount03: flip to the next second before doing the
 access
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
Cc: llong@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Mount03 occasionally reports failure on tmpfs:

  170	mount03.c:214: TINFO: Testing flag MS_STRICTATIME
  171	mount03.c:140: TFAIL: st.st_atime(1677086243) < atime(1677086243)
  172	mount03.c:151: TFAIL: dir_st.st_atime(1677086243) < dir_atime(1677086243)

From Waiman Long:

  Looking at the mount03.c test, it is reading a directory in tmpfs, sleeping for
  1 second and read the directory again. The test fails because the reported atime
  didn't change. Since tmpfs is in memory, access to them can be much faster and I
  believe that a race condition may happen that the two directory reads can happen
  within the same atime even though one second is supposed to have passed. The same
  test pass when applying to a real filesystem. So I believe the assumption made in
  the test may not be totally correct as the time lag can happen in different
  subsystems inside the kernel for time tracking. I believe it is more a test problem
  than a real kernel problem.

  There may be some slight discrepancy in how sleep and the tmpfs file system is
  keeping track of time. If the first access is right at the beginning of a second
  from the tmpfs perspective, the 2nd access may be at the end of that second, but
  not flip to the next second yet. What I would suggest is to sleep a little more
  like usleep(10 000) to make sure that it will flip to the next second before doing
  the access.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 60f9963da..98d5933b7 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -122,7 +122,7 @@ static void test_file_dir_noatime(int update_fatime, int update_datime)
 	SAFE_CLOSEDIR(test_dir);
 	dir_atime = dir_st.st_atime;
 
-	sleep(1);
+	usleep(1001000);
 
 	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
 	SAFE_FSTAT(otfd, &st);
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
