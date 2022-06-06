Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0C0C43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 11:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97EBD3C8D95
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 13:39:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 355ED3C1DB8
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 13:38:53 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1554660073B
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 13:38:51 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGs0C4tVyzfbVC
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 19:36:59 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 19:38:46 +0800
To: <ltp@lists.linux.it>
Date: Mon, 6 Jun 2022 19:36:49 +0800
Message-ID: <20220606113649.41600-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_kvercmp.sh: strip '+' when $(EXTRAVERSION) is
 blank
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

$(EXTRAVERSION) defines an even tinier sublevel for pre-patches
or additional patches. It is usually some non-numeric string
such as "-pre4", and is often blank. When $(EXTRAVERSION) is blank,
there may be a extra '+' which shoud be stripped.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/open_posix_testsuite/scripts/tst_kvercmp.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh b/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh
index 69466bb12..ce1d13c72 100755
--- a/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh
+++ b/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh
@@ -10,6 +10,7 @@ r1=$(echo ${ker_ver} | awk -F. '{print $1}')
 r2=$(echo ${ker_ver} | awk -F. '{print $2}')
 r3=$(echo ${ker_ver} | awk -F. '{print $3}')
 r3=${r3%%-*}
+r3=${r3%%+*}

 test_ver=$(($1 * 65536 + $2 * 256 + $3))
 curr_ver=$((${r1} * 65536 + ${r2} * 256 + ${r3}))
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
