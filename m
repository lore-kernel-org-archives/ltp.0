Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1DBCA0EC3
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 09:10:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9330B3CE7EE
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 11:10:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C59973CBFDB
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 11:10:02 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F5DE60563E
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 11:10:00 +0200 (CEST)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RlHk54lSpztSWp
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 17:05:49 +0800 (CST)
Received: from huawei.com (10.175.100.195) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 17:09:54 +0800
To: <ltp@lists.linux.it>
Date: Fri, 15 Sep 2023 02:22:59 +0800
Message-ID: <20230914182259.29435-1-limin154@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.175.100.195]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] stress/udp/multi-diffip: bugfix for
 multi-diffip/udp4-multi-diffip01
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
From: Li Min via ltp <ltp@lists.linux.it>
Reply-To: Li Min <limin154@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

udp4-multi-diffip01: line 233: ret: unbound variable

Signed-off-by: Min Li <limin154@huawei.com>
---
 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
index 92af9e438..c0d50efaf 100644
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
+++ b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
@@ -230,7 +230,7 @@ while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
 	# Set IPv6 addresses to the interfaces
 	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname

-	if [ $ret -eq 2 ]; then
+	if [ $? -eq 2 ]; then
 	ip addr del ${lhost_addr}/${network_mask} dev $lhost_ifname  2>&1
 	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
 	fi
--
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
