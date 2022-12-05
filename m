Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0B7C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 06:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67D43CC1DD
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 07:58:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE2C43CC1E6
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:39 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 72A661A0C00C
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:36 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQZ8s4T8JzmWNM
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 14:56:45 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 14:57:32 +0800
To: <ltp@lists.linux.it>
Date: Mon, 5 Dec 2022 14:54:29 +0800
Message-ID: <20221205065432.242539-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Add handling of abnormal input for parse_opts()
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

Changes in v3:
  1. Modify the checking of SAFE_STRTOF as suggested by Cyril
  2. Adjust the position of the checking of the return value for
     SAFE_STRTOUL

Changes in v2:
  1. Add range checking for SAFE_STRTOF as suggested by Cyril

Changes in v1:
  1. Add SAFE_STRTOF
  2. Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF to deal with abnormal
     input for parse_opts()

Zhao Gongyi (3):
  lib/safe_macros: Add SAFE_STRTOF
  lib: Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF
  lib: Adjust the position of the checking of the return value

 include/safe_macros_fn.h  |  3 +++
 include/tst_safe_macros.h |  3 +++
 lib/safe_macros.c         | 33 +++++++++++++++++++++++++++++++++
 lib/tst_test.c            |  9 ++++-----
 4 files changed, 43 insertions(+), 5 deletions(-)

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
