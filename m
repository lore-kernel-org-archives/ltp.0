Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AB1E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 04:57:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1338C3C1D61
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 05:57:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800E53C1DEB
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:54 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61E5F141CBCB
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736398552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rGMUpeimPaJ9dBFw2wtV7SK7xtvWNjj/0nwP8IL4GM=;
 b=gbZoTinZIm50lwl5OgYeFkW52YUnR85NMI8GNZxdNlXMyIF9Emi7k8twTX4b3dJgutRZBf
 mgruV7MgXTMLOPgCd/6g2xOyXHEvl/ehhhOkS5wa9GPbRK2Iq+PwhLUnxwDA8jjQ9YhSqW
 XGMes7N4BT3ymBQB1aNtTaCTRxoNKOk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-wpeXbylkM8qoMsdNoeZNdA-1; Wed,
 08 Jan 2025 23:55:51 -0500
X-MC-Unique: wpeXbylkM8qoMsdNoeZNdA-1
X-Mimecast-MFC-AGG-ID: wpeXbylkM8qoMsdNoeZNdA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDF171955F2D
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:50 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9578C19560AA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:49 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 12:55:32 +0800
Message-ID: <20250109045532.43017-5-liwang@redhat.com>
In-Reply-To: <20250109045532.43017-1-liwang@redhat.com>
References: <20250109045532.43017-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LLtabRWzldhT4uZuyxGk1BR3zM5zgfFtoMID8NcCJOU_1736398550
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] readahead02: reset timeout based the IO test
 elapsed
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
 testcases/kernel/syscalls/readahead/readahead02.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index de4eb406c..850866c28 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -321,16 +321,16 @@ static void test_readahead(unsigned int n)
 
 	/*
 	 * The time consuming of readahead quite depending on the platform IO
-	 * speed, sometime test timeout when the default runtime is used up.
+	 * speed, sometime test timed out when the default timeout is used up.
 	 *
 	 *  readahead02.c:221: TINFO: Test #2: POSIX_FADV_WILLNEED on file
 	 *  readahead02.c:285: TINFO: read_testfile(0) took: 26317623 usec
 	 *  readahead02.c:286: TINFO: read_testfile(1) took: 26101484 usec
 	 *
-	 * Here raise the maximum runtime dynamically.
+	 * Here extend the entire timeout dynamically.
 	 */
 	if ((tc+1)->readahead)
-		tst_set_runtime(test.runtime + (usec + usec_ra) / 1000000);
+		tst_set_timeout(test.timeout + (usec + usec_ra) / 1000000);
 }
 
 
@@ -422,7 +422,7 @@ static struct tst_test test = {
 	},
 	.test = test_readahead,
 	.tcnt = ARRAY_SIZE(tcases),
-	.runtime = 30,
+	.timeout = 30,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b833a3660394"},
 		{"linux-git", "5b910bd615ba"},
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
