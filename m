Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE740C43334
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 10:43:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94513C97C6
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 12:43:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F94A3C189A
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 12:43:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DCD86601225
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 12:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658313803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y9F7/So/JQwCziXkw1er72zSrE1/EP6IRAaNi17n0Uo=;
 b=RO/56WqdELgQTK/UENuToSAVLeXnOSQ2QLhmuSwHjtMFDo7JnlpYnoiwaJZIFf/Jqung0R
 71L3+ZS9UqAP430PQ6GPMMapjdRjd8BnZRYdguRUqZkR+AIlNWtqNrlsOxynIABU1kHx2G
 X3XwlLqJTI84xCO/1nEVcJQMRB/kV2I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-zEJOe8xWOnyftNpFdJ8eTA-1; Wed, 20 Jul 2022 06:43:21 -0400
X-MC-Unique: zEJOe8xWOnyftNpFdJ8eTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE1A1294EDD0
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 10:43:21 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.22.34.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D6C51121314
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 10:43:21 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 20 Jul 2022 12:43:18 +0200
Message-Id: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fsync02: restore runtime to 5m
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

Test allows up to 240 seconds for PASS result (depending if its VM or not),
but on slower systems library now kills it after a minute. Restore
runtime to 5 minutes.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/fsync/fsync02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index e13ba89f1b63..55c7a71c1d65 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -114,5 +114,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_tmpdir = 1
+	.needs_tmpdir = 1,
+	.max_runtime = 300,
 };
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
