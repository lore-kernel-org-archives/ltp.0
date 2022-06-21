Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D50CCA480
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 07:41:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CF693C9441
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:41:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5653C1BAD
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:41:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B33C0140004E
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655797269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/6g9BLMblO48PzrWhdhFgS73dFiubBsgZNcFGO7uNNM=;
 b=NDWLjFaW1PCrN4+Oax6U70r30fruDeYFASo3/Z+yzqzNWnyPv6O/W9uGwXmiHKza1Bn61S
 YuyhfHGukGSAvlbc72tp2RzV0gWsX0lBRoSJrusvivYIlQDNIIknQrJcsS2WrX/yAp0hJb
 dEmgma9fyLJFeWaHstKg91RN+lIR7xE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-JygxGa7jMyKMYIcpm5WFTg-1; Tue, 21 Jun 2022 03:41:06 -0400
X-MC-Unique: JygxGa7jMyKMYIcpm5WFTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46D01801756
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 07:41:06 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC7F59D7F
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 07:41:05 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jun 2022 09:41:00 +0200
Message-Id: <e942179576028d20ad2c381d442fefec1af6a556.1655797247.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/utime03: print more details when test fails
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

Test is sporadically failing in past couple months on upstream
kernels. Print more data when that happens to see by how much
we are failing the checks.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/utime/utime03.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 2358fd70b4db..8c1167fdbd84 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -79,10 +79,14 @@ static void run(void)
 	SAFE_STAT(TEMP_FILE, &statbuf);
 
 	if (statbuf.st_atime < mintime || statbuf.st_atime > maxtime)
-		tst_res(TFAIL, "utime() did not set expected atime");
+		tst_res(TFAIL, "utime() did not set expected atime, "
+			"mintime: %ld, maxtime: %ld, st_atime: %ld",
+			mintime, maxtime, statbuf.st_atime);
 
 	if (statbuf.st_mtime < mintime || statbuf.st_mtime > maxtime)
-		tst_res(TFAIL, "utime() did not set expected mtime");
+		tst_res(TFAIL, "utime() did not set expected mtime, "
+			"mintime: %ld, maxtime: %ld, st_mtime: %ld",
+			mintime, maxtime, statbuf.st_mtime);
 }
 
 static struct tst_test test = {
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
