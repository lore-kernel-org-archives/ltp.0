Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06617C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713777013; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=3kq+T8RJiU+fZzOvFTP+geT/pHGVWhGqszUNvArQAF8=;
 b=NNtPNPlOWu74h7q40s38scqe2eZ0RYMPCxprKg2QX0nEfjMLgmGwB3X/pXzAeY6ypqQ35
 idmnTlJnziy67zb4ge2Wg0wmHaKA+6jBYJ/pTcPFnnqgoGxvM9nXOEzxULevnp9x76Y8CBP
 YJqa74bDEw4YsvfWAeEEcI2lzZIEXEU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07AA63CFF11
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 11:10:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0C933CE61A
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 11:09:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A977E100287A
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 11:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713776989; x=1745312989;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WTOEGDDFvLen6ugSCHqbVx6gg2DLsabaHs4cfacV8jk=;
 b=ifaLfOGOWo/EehC1XM4yJiCvs2ajXByfkINrYcAdStF6afU/LZipsQTo
 0C69HKRthkM7+kdzr+qIhcsd7Ol/oMLzsHgKq8CzxPDH70Hz572+fx0jl
 Mc9RIax1yGbTsIfPyWdnMIvbQI0HOKzwgU2NjJAD8WLXohuxjO1yGYND5
 hjHh/xfgAM/cWmDh3AGGCnYeHU0Py48tQpKFNDwtNIfAPAwdR4sTg0cB+
 8jkiG9riBzEw0j1WrWkN1XJlIOzcEFZknvn9bGccThkcYr5i1ZRX+jrMm
 dq0FCfeYEAEF/Iy00gobRUEIxxAC01MZnbw8vN5v2dmnvOY9Q46v7eXFn Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="143912211"
X-IronPort-AV: E=Sophos;i="6.07,220,1708354800"; d="scan'208";a="143912211"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 18:09:47 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CBB8D4C2E
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 18:09:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A670BF3D5
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 18:09:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C3BE6BB79
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 18:09:44 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 867461A000B;
 Mon, 22 Apr 2024 17:09:43 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 22 Apr 2024 04:35:28 -0400
Message-Id: <20240422083528.28355-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28336.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28336.006
X-TMASE-Result: 10--7.316900-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWPX54Vmcx7RYAXtykVcrvpNKQNhMboqZlpgPgeggVwCFr8F
 Hrw7frluf146W0iUu2sUU1QqiMTlE4dhJvvq7rh/Ss47mbT7SARWW6DqEhLyMG6GwmAY/AUv+rE
 c9YP7ZaPi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSkj80Za3RRg8GRAWVHGL/gfeiVYFpVWNYRcL0
 N4fB471reUw+9P6dS182v4UvmrKrc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getsockname01: Add case for errno EINVAL
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

Currently there is no case for EINVAL, so a new case is added.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/getsockname/getsockname01.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index 111065469..5d921f4ad 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -12,6 +12,7 @@
  * - EBADF on a not open file
  * - ENOTSOCK on a file descriptor not linked to a socket
  * - EFAULT on invalid socket buffer o invalid socklen
+ * - EINVALI on an invalid addrlen
  */
 
 #include "tst_test.h"
@@ -19,6 +20,7 @@
 static struct sockaddr_in sin0, fsin1;
 static int sock_null, sock_bind, sock_fake;
 static socklen_t sinlen;
+static socklen_t sininval;
 
 static struct test_case {
 	int *sock;
@@ -37,6 +39,8 @@ static struct test_case {
 		.experrno = EFAULT, "invalid aligned salen"},
 	{ .sock = &sock_bind, .sockaddr = &fsin1, .addrlen = (socklen_t *) 1,
 		.experrno = EFAULT, "invalid unaligned salen"},
+	{ .sock = &sock_bind, .sockaddr = &fsin1, .addrlen = &sininval,
+		.experrno = EINVAL, "invalid socklen"},
 };
 
 static void check_getsockname(unsigned int nr)
@@ -57,6 +61,7 @@ static void setup(void)
 	sock_bind = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	SAFE_BIND(sock_bind, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(sin0);
+	sininval = -1;
 }
 
 static struct tst_test test = {
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
