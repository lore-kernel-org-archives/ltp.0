Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14488C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712911243; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=UFpmY8WFz7jRq8EW7N5OWVxpxPiabZDcd6Qclpx4QsQ=;
 b=GdgrDboFlnJbBJPUPR1d8RH+EqTRhrESWiOinFhIwk5JYWGO7HeBRLoJNHaAYgUVu8MMV
 Pq/RmVcVhULZ4dX+dcuKywZMnjcFJuA/t2fGHNW1KI1OGB/o5lWWkGGG0bKZmv4hwlep7gy
 Xo1yjglLcjlB4JxbVrYYtk7xL1UhQNI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FED83CF8B7
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 10:40:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B2143CF865
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:40:21 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 385CA20B4CA
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712911222; x=1744447222;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TygRM2VK4h9TkD87Aux25LqUjJr//flghWU8GequvAY=;
 b=ZnDNrG0s47nd4Ef6Vw10wluy0oXzJfdTg7EWlEm4tg1X4yQMECGAlueS
 +qRFK756N0EFkWHFKJ375Jt/L4v52+afftKux/F2VJrEffsd959vcdv/v
 9I3dlqUlTuKj9kaxLGp7wUobj3doPwG8Sq1K1QsS1iyfea9Fa0AtSQ366
 WfxxPr+8gOn7I3oDS5shcr65n/DE45aYtZt4vDInzisHVe82akCQQkfTG
 R60FQZlVFXkqkbtq/XqFtTDfTHH+U6VzBI1rDYWimPeKrzRyEA0X6GGhj
 iKoZgFn3H8hSlO6/k9464qdIZ0MejfljdhFm9Nf0ApoJ6DdatDKKsne02 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="155386435"
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; d="scan'208";a="155386435"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 17:40:19 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E703E127CD5
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 17:40:15 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BF7C14CA6
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 17:40:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E08AD6B4EA
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 17:40:13 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8B0B21A000A;
 Fri, 12 Apr 2024 16:40:13 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 12 Apr 2024 04:05:57 -0400
Message-Id: <20240412080557.18922-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28314.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28314.006
X-TMASE-Result: 10--13.853800-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiJSuJfEWZSQfB1kSRHxj+Z59LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatT4xnGicftABGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoQo5ye27KXf5H+Kx4IA1XTXL7fGpDjikVZoMLOoNHsM9sowLXanB7ESF7XImrociEfjsZ
 3hTE7dSmWdS71W+uwVMBbXb6klnc03KXWd30Ii3RRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7l1Gq
 9CoB1RvfduZftD61LGIgmAWJfQaxabwdcTc1HnwaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] bind: Add negative tests for bind
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for bind(), when errno is EBADF or ENOTDIR

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/bind/.gitignore |  1 +
 testcases/kernel/syscalls/bind/bind07.c   | 81 +++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bind/bind07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3521047f4..71579cde4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -37,6 +37,7 @@ bind03 bind03
 bind04 bind04
 bind05 bind05
 bind06 bind06
+bind07 bind07
 
 bpf_map01 bpf_map01
 bpf_prog01 bpf_prog01
diff --git a/testcases/kernel/syscalls/bind/.gitignore b/testcases/kernel/syscalls/bind/.gitignore
index c85774441..8aff2456f 100644
--- a/testcases/kernel/syscalls/bind/.gitignore
+++ b/testcases/kernel/syscalls/bind/.gitignore
@@ -4,3 +4,4 @@
 /bind04
 /bind05
 /bind06
+/bind07
diff --git a/testcases/kernel/syscalls/bind/bind07.c b/testcases/kernel/syscalls/bind/bind07.c
new file mode 100644
index 000000000..dda6e8ad4
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/bind07.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that bind(2) fails with
+ *
+ * - EBADF when sockfd is not a valid file descriptor
+ * - ENOTDIR when a component of addr prefix is not a directory
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include "tst_test.h"
+#include "libbind.h"
+
+#define TEST_EBADF "test_ebadf"
+#define DIR_ENOTDIR "dir_enotdir"
+#define TEST_ENOTDIR "test_enotdir"
+
+static struct sockaddr_in sock_ebadf;
+static struct sockaddr_un sock_enotdir;
+
+static struct test_case_t {
+	int sockfd;
+	struct sockaddr *addr;
+	socklen_t addrlen;
+	char *sockfile;
+	int type;
+	int protocol;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{-1, (struct sockaddr *)&sock_ebadf, sizeof(sock_ebadf), TEST_EBADF,
+		SOCK_STREAM, IPPROTO_TCP, EBADF,
+		"bind() sockfd is not a valid file descriptor"},
+	{0, (struct sockaddr *)&sock_enotdir, sizeof(sock_enotdir),
+		DIR_ENOTDIR "/" TEST_ENOTDIR, SOCK_STREAM, 0, ENOTDIR,
+		"bind() a component of addr prefix is not a directory"},
+};
+
+static void setup(void)
+{
+	tst_init_sockaddr_inet(&sock_ebadf, IPV4_ADDRESS, 0);
+
+	SAFE_TOUCH(DIR_ENOTDIR, 0777, NULL);
+	sock_enotdir.sun_family = AF_UNIX;
+	strncpy(sock_enotdir.sun_path, DIR_ENOTDIR "/" TEST_ENOTDIR,
+		sizeof(sock_enotdir.sun_path));
+}
+
+static void verify_bind(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	int sockfd = tc->sockfd;
+
+	if (!sockfd)
+		sockfd = SAFE_SOCKET(tc->addr->sa_family, tc->type,
+			tc->protocol);
+
+	TST_EXP_FAIL(bind(sockfd, tc->addr, tc->addrlen), tc->expected_errno,
+		"%s", tc->desc);
+
+	if (sockfd > 0)
+		SAFE_CLOSE(sockfd);
+	if (!TST_RET)
+		SAFE_UNLINK(tc->sockfile);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_bind,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
