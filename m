Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B68C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713777097; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+Lx+VH9Zl68Ia4qsYYtuTVBywTdozPZDrylnrD+Gl0g=;
 b=FxmTKuCiz/GnmJIir8naeKzfDtz0goQ5KUJNtbNqPKlNMkvWhxmIZSakbBQM95ZjkINr0
 +suPkOhse0/VvRfygmMlM1vwlZGdLWxmEmNe8SltMI2nSyVav4viGjyb1m5qiIbATk79Aj4
 sjUasQJ1NrzisUjI9/b6kuW/khXijsY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C0DB3CFE59
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 11:11:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E9093CFA0D
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 11:11:14 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C7261400F92
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 11:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713777075; x=1745313075;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6yABOFeFkhyh4A7ubhcNdGKPjx9GL1EsosVaqkdBBVI=;
 b=JMUyo6+cs5bP9zRiHS0DF80P3i/ME5tyP+Wp9KX5zakMbELgJiuxJpi7
 mztEVOqK1VHSlBwWyCJrrwBBMfeUgSE3rzkHnuAMJGdBUuZ183bGsuH1L
 WvadwtpXLi0B+EPnKjmBhcvOvq/cuyQ7lI/UKssOg1f77pMnRAVBawzIJ
 GKMgh7fvvq5BQbgSjp5+DUmOxcLwNu+FSazs3h3mf1QOehgi/N4J3aFa1
 ovXu+jg/Tu61uUKo7BaFZwQXNqB6I03ORtgfys194aaka8hikQ1f2HUbh
 OBRK79NzQZ//+gdVkjdFbMcKnS77pCeM2YqcT1B3kqAiBS236Jm7efWNj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="155754005"
X-IronPort-AV: E=Sophos;i="6.07,220,1708354800"; d="scan'208";a="155754005"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 18:11:13 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id ED5B1E8FBD
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 18:11:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 28A8ED4C0F
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 18:11:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BF6C46BA78
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 18:11:08 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 626661A000B;
 Mon, 22 Apr 2024 17:11:08 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 22 Apr 2024 04:36:57 -0400
Message-Id: <20240422083657.28363-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28336.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28336.006
X-TMASE-Result: 10--4.739900-10.000000
X-TMASE-MatchedRID: Dkfyeyxtv0bX54Vmcx7RYAXtykVcrvpNKQNhMboqZlpgPgeggVwCFr8F
 Hrw7frluf146W0iUu2uD0fiPNa0yFtqoygGFfC1Gqoeab9Xgz885wZ3E8gtLAHepM/I+teqco8W
 MkQWv6iXBcIE78YqRWo6HM5rqDwqt7md1XybQdTrRrIfcAOqkzxDqvYA54nbAt5ZNwkBbOTQjeV
 IEKbTFig/qoQShF7O3aubTeLSu433inVzvzCmkOt0ltvkCaeX/FcG3+ZRETICP9kUX1Z+buE3Lu
 mkbQiNwVCqTSPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getsockopt01: Add case for errno EINVAL
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
 testcases/kernel/syscalls/getsockopt/getsockopt01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index 4da9bd0ea..05f2be890 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -15,6 +15,7 @@
  * - ENOTSOCK on a file descriptor not linked to a socket
  * - EFAULT on invalid address of value or length
  * - EOPNOTSUPP on invalid option name or protocol
+ * - EINVAL on an invalid optlen
  */
 
 #include "tst_test.h"
@@ -24,6 +25,7 @@ static struct sockaddr_in sin0;
 static int sinlen;
 static int optval;
 static socklen_t optlen;
+static socklen_t optleninval;
 
 static struct test_case {
 	int *sockfd;
@@ -56,7 +58,10 @@ static struct test_case {
 	.optlen = &optlen, .experrno = ENOPROTOOPT, .desc =  "invalid option name (IP)"},
 
 	{.sockfd = &sock_bind, .level = IPPROTO_TCP, .optname = -1, .optval = &optval,
-	.optlen = &optlen, .experrno = ENOPROTOOPT, .desc = "invalid option name (TCP)"}
+	.optlen = &optlen, .experrno = ENOPROTOOPT, .desc = "invalid option name (TCP)"},
+
+	{.sockfd = &sock_bind, .level = SOL_SOCKET, .optname = SO_OOBINLINE, .optval = &optval,
+	.optlen = &optleninval, .experrno = EINVAL, .desc = "invalid optlen"},
 };
 
 
@@ -79,6 +84,7 @@ static void setup(void)
 	SAFE_BIND(sock_bind, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(sin0);
 	optlen = sizeof(optval);
+	optleninval = -1;
 }
 
 static struct tst_test test = {
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
