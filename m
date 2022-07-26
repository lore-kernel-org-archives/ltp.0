Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539A7C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:33:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 581893CA008
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 15:33:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED2CA3C87C6
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:33:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 50CFA2009A0
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658842404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H/xEXpZKQSOWgowJwQGcTGwUSsyavwKAFWmIgYGKeeA=;
 b=I/VVb6BEEfclFz9tYXbiyg8OYzXoLRj5Y/PoyUirvme9gPzVnJEcJApLs/+s1i1GyH2uPQ
 jB+gOpsk9cMkguJjGEyAe0HWU8oZAIhQvxYsW23YNSa1ubxDOiqpt5nVgLcO14CLUPtY7J
 v1Z9VAUV9joCSpKPLtnsgcogcWeGrJI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-OmRw39-pMO2ZcM3Sv__uMw-1; Tue, 26 Jul 2022 09:33:23 -0400
X-MC-Unique: OmRw39-pMO2ZcM3Sv__uMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 193A43821C07
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:33:23 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.22.34.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCAB840E80E0
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:33:22 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 26 Jul 2022 15:33:15 +0200
Message-Id: <6a56618714e577c437a489a6050e3d29c2236022.1658842322.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/accept4_01: don't hardcode port number for
 test
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

Leave it to bind() to pick a free port number.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/accept4/accept4_01.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index 58115ea43213..b2f785d0a6aa 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -22,8 +22,6 @@
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
-#define PORT_NUM 33333
-
 static const char *variant_desc[] = {
 	"libc accept4()",
 	"__NR_accept4 syscall",
@@ -54,7 +52,7 @@ static int create_listening_socket(void)
 	memset(&svaddr, 0, sizeof(struct sockaddr_in));
 	svaddr.sin_family = AF_INET;
 	svaddr.sin_addr.s_addr = htonl(INADDR_ANY);
-	svaddr.sin_port = htons(PORT_NUM);
+	svaddr.sin_port = 0;
 
 	lfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
 
@@ -68,14 +66,16 @@ static int create_listening_socket(void)
 
 static void setup(void)
 {
+	socklen_t slen = sizeof(*conn_addr);
+
 	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
 
+	listening_fd = create_listening_socket();
+
 	memset(conn_addr, 0, sizeof(*conn_addr));
-	conn_addr->sin_family = AF_INET;
+	SAFE_GETSOCKNAME(listening_fd, (struct sockaddr *)conn_addr, &slen);
 	conn_addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	conn_addr->sin_port = htons(PORT_NUM);
-
-	listening_fd = create_listening_socket();
+	tst_res(TINFO, "server listening on: %d", ntohs(conn_addr->sin_port));
 }
 
 static void cleanup(void)
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
