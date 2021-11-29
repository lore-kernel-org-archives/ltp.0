Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAE0C433F5
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 13:32:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7070E3C5AF0
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 14:32:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F9113C0BB2
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 14:32:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CC1A1A01173
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 14:32:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638192734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mo0DKu9409XkzKio8DpSRZhdXSgo8eES4ayg54NlZ+s=;
 b=USFv5NX6DSryoDTrYuviOfmIuta2BfCwhAG+rhr6ok8hOtSTr4YYJvir2/lUNjgpS6+Wj1
 3t1BrmQ5suiHi7AAAa9itKXP2STkpm9ndVrP3kBULfxrKyo+nC29XGjQb+fiiDriojT46t
 bYW4kfeuaG/tvhKxAVZ9/kI3qgRDkkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-Xre7zW3IMoCH58CGP31nkQ-1; Mon, 29 Nov 2021 08:32:12 -0500
X-MC-Unique: Xre7zW3IMoCH58CGP31nkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D56F36393
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 13:32:11 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CCF9694C0
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 13:32:10 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 29 Nov 2021 14:32:02 +0100
Message-Id: <bd1156e573b0ea8bbf1feeee2cc2b5f84953c1ae.1638192701.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open_posix_testsuite/lio_listio/2-1: increase number
 of requests
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

Some systems appear to be able to complete all requests before
test checks 'received_all':
  conformance/interfaces/lio_listio/lio_listio_2-1: execution: FAILED: Output:
  lio_listio/2-1.c Error lio_listio() waited for list completion

Increase number of requests, and also make test use different
file offset for each.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/lio_listio/2-1.c                   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
index 4f458a06bdaf..72a1113e06a3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
@@ -34,7 +34,7 @@
 
 #define TNAME "lio_listio/2-1.c"
 
-#define NUM_AIOCBS	10
+#define NUM_AIOCBS	256
 #define BUF_SIZE	1024
 
 static volatile int received_selected;
@@ -98,7 +98,7 @@ int main(void)
 		memset(aiocbs[i], 0, sizeof(struct aiocb));
 
 		aiocbs[i]->aio_fildes = fd;
-		aiocbs[i]->aio_offset = 0;
+		aiocbs[i]->aio_offset = i * BUF_SIZE;
 		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
 		aiocbs[i]->aio_nbytes = BUF_SIZE;
 		aiocbs[i]->aio_lio_opcode = LIO_WRITE;
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
