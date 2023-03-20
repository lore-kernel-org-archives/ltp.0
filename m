Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B63C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 06:31:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 116123CCC85
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 07:31:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7E33CCD24
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:31:05 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 72E6D10000EA
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1679293863; i=@fujitsu.com;
 bh=3Iw34bnV3ALpvCqfieRqmvQhGX3UFddqm8EgNkfVeVI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=FKCIl8RDptMcaPpZU1zCpL7XQ8xTlghaGJNIpmDT7xBqPIFJLm/KVqq7gELyhQbww
 QLsx1ttMbV4B5gjYWx5V7xmZLWA6kzlsaHDLuz3vewrVYLbU8jq+zi8o6PD1b36oki
 MNsLVmkUVxQB4sOhFQm8hMf2pRWfFbuxqWFt92CcuQiHI7KshefBontWcbx3yPxEch
 ItaVyk1/L5u+LnKDRfjZ78kjAusUgf5XLNkLUL3UhTRIVzAhDo7Ma51MPd9PT4FPWX
 zOQh6zs7rG1Jb8x0G2k6hNglOkYn4++Sxg4zdxYpDSIAYBXIM1KnlNt2swVFcpPJ7e
 lHL9Cmo7j6TUg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRWlGSWpSXmKPExsViZ8OxWXf5X/E
 Ug5P/WSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oxDv20LfrFWzLp8ia2BcS5rFyMXh5DAKUaJ
 vY+nsHcxcgI5e5kkvsz3h0jsZZT4vb4FLMEmoCnxrHMBM4gtIiAh0dHwFizOLKAusXzSLyYQW
 1jARuL2vZksXYwcHCwCqhIL2sRAwrwCnhIPp01nA7ElBBQkpjx8DzaGU8BLYte7H8wQez0ljl
 39xQZRLyhxcuYTFojxEhIHX7xghuhVkmhrvcIKYVdINE4/xARhq0lcPbeJeQKj4Cwk7bOQtC9
 gZFrFaFqcWlSWWqRrppdUlJmeUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOi
 l5dasokRGLYpxQw3djDO6furd4hRkoNJSZT3+BvxFCG+pPyUyozE4oz4otKc1OJDjDIcHEoSv
 Ed/AeUEi1LTUyvSMnOAMQSTluDgURLhtf4ElOYtLkjMLc5Mh0idYlSUEuf9/xsoIQCSyCjNg2
 uDxe0lRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8H0Gm8GTmlcBNfwW0mAlo8f1JIiCLSxI
 RUlINTJ2HRDcbrykofpq+3vOlwq3kMtvg+7tmvFRyP/JPsurWaanNRidUSj4/vH7iz9z4x2/7
 7rkfjnDRz5z7IWQ237U5qZdTAg3+sk+rl9npXXLZ/OvFZtaIhxsmXZLf1zj1xM9/xx4HWJ78o
 5mjpXNA+t2/6ZUx70J9HsQzeZhMP2z4uEvh3zz9gsv2s78f2t0+78nJtCulrT+v2vmu33Vcmk
 t7xcxPl0rPS91/0WQWO+HEvSk2QoHXbu5VOu/bfn8Fm9R+5vdn6uQ2vjaftfLZ0W1tr4yYcqK
 kzm4Kiz9a9f/H27fpMpP7j869O3legB0L20n3z/cDbD9MNrgv/VT3oTzjdteNyrcMZzgk5K40
 zWFLV2Ipzkg01GIuKk4EALAAFl5WAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-591.messagelabs.com!1679293862!321973!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2829 invoked from network); 20 Mar 2023 06:31:03 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-2.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Mar 2023 06:31:03 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id AD4C3157
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:31:02 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id A0202154
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:31:02 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Mar 2023 06:31:01 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Mar 2023 14:30:21 +0800
Message-ID: <1679293822-19378-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] libs/libnewipc: Add GET_USED_ARRAYS api
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

This api is used to get the semaphore arrays resource total.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libnewipc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/libnewipc.h b/include/libnewipc.h
index 1e126ca1c..969c93292 100644
--- a/include/libnewipc.h
+++ b/include/libnewipc.h
@@ -53,6 +53,8 @@ int get_used_sysvipc(const char *file, const int lineno, const char *sysvipc_fil
 	get_used_sysvipc(__FILE__, __LINE__, "/proc/sysvipc/msg")
 #define GET_USED_SEGMENTS() \
 	get_used_sysvipc(__FILE__, __LINE__, "/proc/sysvipc/shm")
+#define GET_USED_ARRAYS() \
+	get_used_sysvipc(__FILE__, __LINE__, "/proc/sysvipc/sem")
 
 void *probe_free_addr(const char *file, const int lineno);
 #define PROBE_FREE_ADDR() \
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
