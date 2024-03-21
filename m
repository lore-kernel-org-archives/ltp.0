Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F33C54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 03:00:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318BA3D0088
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 04:00:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18C9B3CD943
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 04:00:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 23093600856
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 03:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710989998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rf0YoZ70sUw9kCaikfFVEdeAIF8YoiS8lhWOQyOpSkI=;
 b=KvOYbfeL/5V7zQURhPdaaInqOgmcP82pGLTwicbmE08sImpMgNj/iZIU5yLrNOC3VZ/lQ0
 Y0l9Ss8mnu7RdGhgVY8KL02AN+EbomRUeyLmP5XCWnQJsmBvDjrLiFTxwrcYgEs0uFcOlm
 TAUIViu77YOQ7RrMR45tSNO2Gsl1Dlo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-UVZ-BEfxPHqRvhzwexGoLw-1; Wed,
 20 Mar 2024 22:59:56 -0400
X-MC-Unique: UVZ-BEfxPHqRvhzwexGoLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 216EC3C02B6C
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 02:59:56 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E37813C20;
 Thu, 21 Mar 2024 02:59:54 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 21 Mar 2024 10:59:51 +0800
Message-Id: <20240321025951.3263265-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] madvise06: set max_runtime to 60
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
Cc: Fendy Tjahjadi <ftjahjad@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The madvise06 test includes two loops, each potentially waiting up
to 10 seconds. In scenarios with slow I/O, these loops can lead to
the test exceeding the default maximum runtime of 30 seconds.

To prevent the test from failing under these conditions, this patch
increases the `max_runtime` parameter from 30 seconds to 60 seconds,
providing ample time for completion even on systems with slow I/O.

   7  tst_test.c:1709: TINFO: LTP version: 20240129
   8  tst_test.c:1593: TINFO: Timeout per run is 0h 00m 30s
      ....
  43  madvise06.c:77: TINFO: memory.swap.current: 289664 Kb
  44  madvise06.c:201: TINFO: less than 102400 Kb were moved to the swap cache
  45  Test timeouted, sending SIGKILL!
  46  tst_test.c:1647: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  47  tst_test.c:1649: TBROK: Test killed! (timeout?)

Reported-by: Fendy Tjahjadi <ftjahjad@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index be22318ea..b227840df 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -242,6 +242,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.max_runtime = 60,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/vm/swappiness", NULL,
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
