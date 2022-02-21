Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4192CC433F5
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 03:12:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 973223CA145
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 04:12:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07A193C945D
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 04:12:12 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68B05600540
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 04:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645413130; i=@fujitsu.com;
 bh=bRRZCwpVC4EjPbvTaPQADqx8lixiw+JcVCIEpOEQxK4=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=dmcHVRcH4KXoTXaX2dYpK6qsj3fjW/2RPXBDQZGhGvlugcTe6DVzCEEbyh/F6+oyX
 LG9Hkv6tg9A2CtGAV5mh4ukhaNAPp8cDuHg2Onr5Km9gUnDfxs/RqiiAt2WKIqmpEz
 XNNVJV0gQzWnnaOZKCxTeWj7asF22Cjz+/fmDozx9agr8rY9D3LD5yZMA9VOvo0bns
 UMRNGuk0Ay5WJRsGSoOd1XrLLkF+id1CTCFg+MU9BF1OTq4HdYo5lIatYpVKC24l3n
 t9b/t31W2YMc6t3iMO2+CEknD18DhDrL3i5sipnA9CeClfR5HNLQiSMwk7MrtWqs4y
 HZUzHkK7HFebQ==
Received: from [100.115.32.10] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 67/F5-29321-90303126;
 Mon, 21 Feb 2022 03:12:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8MxSZeTWTj
 J4N5pKYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePxmwtMBSuYK7adfszawPiJqYuRk0NI4Cyj
 xJtF7l2MXED2TiaJy68OM0E4+xklmhYtYgSpYhPQkLj2uJ0ZxBYRkJDoaHjLDmIzC6hJ7L56j
 A3EFhawlnj47AALiM0ioCpx8PpfsA28Aq4SC9taweISAgoSUx6+Z4aIC0qcnPmEBWKOhMTBFy
 +YIWoUJfbv3cgIYVdIzJixjQ3CVpO4em4T8wRG/llI2mchaV/AyLSK0TqpKDM9oyQ3MTNH19D
 AQNfQ0FTX2ELXyNBIL7FKN1EvtVS3PLW4RBfILS/WSy0u1iuuzE3OSdHLSy3ZxAgMy5RitSs7
 GPes+ql3iFGSg0lJlNesRShJiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSv2FegnGBRanpqRVpmD
 jBGYNISHDxKIrzdH4DSvMUFibnFmekQqVOMuhwPFu7dyyzEkpeflyolzuvBKJwkJABSlFGaBz
 cCFq+XGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzcjABTeHJzCuB2/QK6AgmoCOmZIEdUZK
 IkJJqYNLVPvY1rDyiOfSGgcPN0OJFnekPo+flSnxeUdaZpPJm49HMjPCDGmFG/lvmcPyY8KRy
 3vcVF269nt4+6VFd9qLH2qV878IsEvJ703VsBYTkDa7OPWAWbKt0Vd+5aIMs+53F0zdvnzA/b
 UHLdS7lde/vbnqkNF1e+xiTyH2m99n/9R5EbmI2yfR4yrT96P/fX+Srf89YuMm4ZdlJu3PLtz
 H85nCxWbLy+YZth2s8O6RDytT4Vy4J2ZdXbuO8dkLkzXUbfv7jsCniEH96gnvv95XvbINu2Dz
 VOKJkfOBn9883bu8SZ3n/iHg2Q8DdeVXolrCHQrxiSdxxhT88XI5fyfLq/ClqKau2u0+G+che
 /29KLMUZiYZazEXFiQCnW1FsUgMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-2.tower-565.messagelabs.com!1645413129!99691!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17531 invoked from network); 21 Feb 2022 03:12:09 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-2.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 21 Feb 2022 03:12:09 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 13ADD10033B
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 03:12:09 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 07062100047
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 03:12:09 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Mon, 21 Feb 2022 03:11:47 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 21 Feb 2022 11:10:42 -0500
Message-ID: <1645459842-1609-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/fsmount.h: remove useless sys/mount.h
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

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 include/lapi/fsmount.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index fa25306..eb98c97 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -7,7 +7,6 @@
 #ifndef LAPI_FSMOUNT_H__
 #define LAPI_FSMOUNT_H__
 
-#include <sys/mount.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
