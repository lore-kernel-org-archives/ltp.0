Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BB1C4708D
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 06:58:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 032C33CC216
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 07:58:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7097B3CC1E6
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:40 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 916E310005FA
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:39 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NQZ8x2lv4z15N5b
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 14:56:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 14:57:35 +0800
To: <ltp@lists.linux.it>
Date: Mon, 5 Dec 2022 14:54:32 +0800
Message-ID: <20221205065432.242539-4-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221205065432.242539-1-zhaogongyi@huawei.com>
References: <20221205065432.242539-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] lib: Adjust the position of the checking of
 the return value
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

we need to check the return value before the checking of the endptr,
otherwise, it will report out of range when calling of
SAFE_STRTOUL("a100", 1, 10000000):

  TBROK: strtoul(a100): 0 is out of range 1 - 10000000

and it is expected that reported as:

  TBROK: Invalid value: 'a100'

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/safe_macros.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 0fb5580ac..1ade829aa 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -614,16 +614,16 @@ unsigned long safe_strtoul(const char *file, const int lineno,
 		return rval;
 	}

-	if (rval > max || rval < min) {
+	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
-			"strtoul(%s): %lu is out of range %lu - %lu",
-			str, rval, min, max);
+			"Invalid value: '%s'", str);
 		return 0;
 	}

-	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
+	if (rval > max || rval < min) {
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
-			"Invalid value: '%s'", str);
+			"strtoul(%s): %lu is out of range %lu - %lu",
+			str, rval, min, max);
 		return 0;
 	}

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
