Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7E5C433F5
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 11:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FD723CA50C
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 13:26:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17FE33C287F
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 13:26:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1BE4B2000F0
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 13:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649417202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qj+ZFdj4415asbf3k/yRYEQBBlP/Z92VkcbkNREBxXI=;
 b=YXpg0VhUNjbJg6xjSX0iIw4J/dW9RJWIJXsL9i0HtmNgdn1oea1vxlrKiY3SEB8+UD7lR2
 BWvBwyos5QF6wSOIWy/YggbPTmGkPNBvDqCBeafZsyP5Nb2FGBUoiX5h/V+Iln29XQbMCr
 lR5AXwcd8PP0ji5VQ6Et0QREQ5uNze0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-RYziB6wqOsS6Cue5z1K2PQ-1; Fri, 08 Apr 2022 07:26:41 -0400
X-MC-Unique: RYziB6wqOsS6Cue5z1K2PQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0865E802819
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 11:26:41 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 927C7403367
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 11:26:40 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  8 Apr 2022 13:26:36 +0200
Message-Id: <d4a52829247d2c2e09544c62c842f70238afac80.1649416881.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] netns_netlink: ensure child opens socket before
 parent creates tap if
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

There's a race, that allows parent to create/destroy tap interface
before child manages to open a netlink socket, and then child
will miss all events and test fails:
  tst_kconfig.c:82: TINFO: Parsing kernel config '/lib/modules/5.18.0-rc1/build/.config'
  tst_test.c:1456: TINFO: Timeout per run is 0h 10m 00s
  netns_netlink.c:88: TFAIL: failed to detect interface changes

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/containers/netns/netns_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 7c90fb075ff9..6f60ff94ef6c 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -57,7 +57,7 @@ static void child_func(void)
 	SAFE_BIND(fd, (struct sockaddr *) &sa, sizeof(sa));
 
 	/* waits for parent to create an interface */
-	TST_CHECKPOINT_WAIT(0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	/*
 	 * To get rid of "resource temporarily unavailable" errors
@@ -98,6 +98,9 @@ static void test_netns_netlink(void)
 	if (SAFE_FORK() == 0)
 		child_func();
 
+	/* wait until child opens netlink socket */
+	TST_CHECKPOINT_WAIT(0);
+
 	/* creates TAP network interface dummy0 */
 	if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")))
 		tst_brk(TBROK, "adding interface failed");
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
