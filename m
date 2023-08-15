Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4787DC001DE
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 08:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474583CD2C7
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 10:56:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACEFD3C65F4
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 10:56:45 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 557D71A00153
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 10:56:42 +0200 (CEST)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ4p1179CzVjlp
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 16:54:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 16:56:36 +0800
To: <ltp@lists.linux.it>
Date: Tue, 15 Aug 2023 16:57:06 +0800
Message-ID: <20230815085706.1077725-1-xusenmiao@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ipneigh01.sh: Fix an issue where ipneigh01_arp test
 case fail due to ARP timeout
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
From: Xu Senmiao via ltp <ltp@lists.linux.it>
Reply-To: Xu Senmiao <xusenmiao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When the ARP status of the rhost is stale,
lhost ping rhost and the lhost deletes the ARP record,
the record in the rhost changes from stale to delay.
Then, the probe request is sent to the lhost, and the lhost ARP information is updated.

   rhost(10.0.0.1)      lhost(10.0.0.2)
t1 10.0.0.2 STALE       ping 10.0.0.1
                        10.0.0.1 REACHABLE
                        arp -d 10.0.0.1
t2 10.0.0.2 DELAY
t3 probe 10.0.0.2
t4                      10.0.0.1 REACHABLE

Clear the ARP entries of rhost before each round of test.

Signed-off-by: Xu Senmiao <xusenmiao@huawei.com>
---
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index e67ff5cc8..4db675f8f 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -56,6 +56,7 @@ do_test()
 	tst_res TINFO "stress auto-creation $entry_name cache entry deleted with '$CMD' $NUMLOOPS times"
 
 	for i in $(seq 1 $NUMLOOPS); do
+		tst_rhost_run -c "arp -d $(tst_ipaddr lhost)"
 
 		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null || \
 			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
