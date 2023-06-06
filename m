Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33CBC77B7A
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 07:19:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C4D73CCAC6
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 09:19:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 789093CB526
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 09:19:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7294760069D
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 09:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686035967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ZDegfh2aWp1mIahwXEWe5RUVD42djPCgCxMMf/IVWw=;
 b=Kox7glrxvwAfXXNZDyk35cZOVV2GnVdA9yKVGRqF/e5houRQ5B7/laMBO1GfGsuGcljZHI
 CQhgtxx7Y74x28SP5935BrpcMTAoL1S8AIpEJrwOGyN43v+Y8SFWSyF7rqyb4zzgXXjqIW
 8Jbv6mWe8sVR5HGKmRaHiwIbHVo48BM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-cMRo2jSXNHSpEPKtIwloxg-1; Tue, 06 Jun 2023 03:19:26 -0400
X-MC-Unique: cMRo2jSXNHSpEPKtIwloxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A88F3C0F425
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 07:19:25 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8182026D49
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 07:19:24 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  6 Jun 2023 15:19:22 +0800
Message-Id: <20230606071922.89447-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readahead02: set dynamic run time
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

The readahead time-consuming is quit depending on the platform IO
speed, test get timeout once the default max_runtime is used up.

  readahead02.c:223: TINFO: Test #1: readahead on overlayfs file
  ...
  readahead02.c:286: TINFO: read_testfile(0) took: 63382903 usec
  readahead02.c:287: TINFO: read_testfile(1) took: 47943122 usec
  ...
  readahead02.c:312: TPASS: using cache as expected
  readahead02.c:223: TINFO: Test #2: POSIX_FADV_WILLNEED on file
  readahead02.c:128: TINFO: creating test file of size: 67108864
  readahead02.c:241: TINFO: read_testfile(0)
  Test timeouted, sending SIGKILL!

Let's raise the maximum runtime dynamically.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index b6c097b31..dc03c5931 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -318,6 +318,19 @@ static void test_readahead(unsigned int n)
 		tst_res(TCONF, "Page cache on your system is too small "
 			"to hold whole testfile.");
 	}
+
+	/*
+	 * The time consuming of readahead quite depending on the platform IO
+	 * speed, sometime test timeout when the default max_runtime is used up.
+	 *
+	 *  readahead02.c:221: TINFO: Test #2: POSIX_FADV_WILLNEED on file
+	 *  readahead02.c:285: TINFO: read_testfile(0) took: 26317623 usec
+	 *  readahead02.c:286: TINFO: read_testfile(1) took: 26101484 usec
+	 *
+	 * Here raise the maximum runtime dynamically.
+	 */
+	if ((tc+1)->readahead)
+		tst_set_max_runtime(test.max_runtime + (usec + usec_ra) / 1000000);
 }
 
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
