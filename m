Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FE0C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 08:57:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 897323C9B7C
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:57:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BDFC3C23B0
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:57:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B84232001CD
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644397042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vY+X8CVFd7ea/tc0a4A/4LzhI1KKFOHcBl11ZnpLrrs=;
 b=FwgOx2V0lBVvticf8o23Dn4U+/XjV0qTWKfWM1d5f1liMdmi6sUyOPr5maGDcspwryTouq
 phfw/mALlxDz4bIj+NAx0hO8H06uPG5mGSu3lZn2OPJlQk4NIxlR3CakcYHXBXP5jvZwL7
 rAwPrW+5bTIaRWXyYlx/n2Tp7QVZE4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-L680V1JvMpqG037nLrD7OA-1; Wed, 09 Feb 2022 03:57:20 -0500
X-MC-Unique: L680V1JvMpqG037nLrD7OA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 657AD1018744
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:57:02 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7CD4F84B
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:57:01 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  9 Feb 2022 16:56:59 +0800
Message-Id: <20220209085700.2882422-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: add .min_mem_avail in tst_test struct
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

As the name implies, this new field is mainly to set the minimum size
of MemAvailable for LTP testcase. If system available memory are less
than .min_mem_avail, test will be exit with TCONF.

And, it also helps to reduce OOM occurring in test parallel run. Due
to running more than one process that consumes a significant amount
of memory at the same time.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/c-test-api.txt | 6 ++++++
 include/tst_test.h | 3 +++
 lib/tst_test.c     | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 51dac58ae..dfbb453e1 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2321,6 +2321,12 @@ static struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+1.40 Require minimum size of MemAvailable for a testcase
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some tests require more than specific size(MB) of MemAvailable. It can be defined
+with `.min_mem_avail = N`.
+
 2. Common problems
 ------------------
 
diff --git a/include/tst_test.h b/include/tst_test.h
index a7aaedcff..bac5e52ba 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -185,6 +185,9 @@ struct tst_test {
 	/* Minimum number of online CPU required by the test */
 	unsigned long min_cpus;
 
+	/* Minimum size(MB) of MemAvailable required by the test */
+	unsigned long min_mem_avail;
+
 	/*
 	 * If set non-zero number of request_hugepages, test will try to reserve the
 	 * expected number of hugepage for testing in setup phase. If system does not
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1fd238cf5..191a9deab 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1090,6 +1090,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_cpus > (unsigned long)tst_ncpus())
 		tst_brk(TCONF, "Test needs at least %lu CPUs online", tst_test->min_cpus);
 
+	if (tst_test->min_mem_avail > (unsigned long)(tst_available_mem() / 1024))
+		tst_brk(TCONF, "Test needs at least %luMB MemAvailable", tst_test->min_mem_avail);
+
 	if (tst_test->request_hugepages)
 		tst_request_hugepages(tst_test->request_hugepages);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
