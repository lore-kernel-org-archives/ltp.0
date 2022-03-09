Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4F8C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 07:50:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26F963C60C2
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 08:50:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE8663C54EE
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 08:50:17 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C4EED1000DE4
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 08:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1646812216; i=@fujitsu.com;
 bh=Ax2ZG7hecBdZokBEU8aJvP0CDoC/PJrbQ/s40DBj+iM=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=xz1Z8LtRY+6hLbOHqgHSwZFv6fIj3Y+CzAlmZsfpmuPxFIv+M2NOB60Pd64/CGnAm
 /mwQz+UjrlKvg8dE7pzPxRfOYRd4VkfJTlkpdmskrdSxaiuP9THMCcVoB5nFZDnRRe
 D61nckPdLCgPizGMlp2DZSb6BhDWs/vn6dPUD09+aaag7fKSwkQNrZE4fPxQRYXXeA
 TbQguV5kgtin4TRJjvyxIrIApDXYTa/iTZO+nhW9ITixmOu2QnhKb1x90oeVL5ORg7
 6Z1XetvLnjtx4ynPG1si5O+BrpGw4iDUnTbNjPyXNyMpzhnTehBKk1KBQwpr4WnmmP
 MLsc58JsuJ0Cw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8ORqGseo5F
 ksKNT02LF9x2MDowe+36vYw1gjGLNzEvKr0hgzejYu56tYClLRceE1ewNjM+Zuxg5OYQEzjJK
 nLjP1cXIBWTvZJI4vnobI4Szj1Hi7Y4TrCBVbAIaEtcet4N1iAhISHQ0vGUHsZkF1CR2Xz3GB
 mILC1hJPD15hAXEZhFQkTi0aidYDa+Aq8SrmQeYQGwJAQWJKQ/fM0PEBSVOznzCAjFHQuLgix
 fMEDWKEvv3bmSEsCskZszYxgZhq0lcPbeJeQIj/ywk7bOQtC9gZFrFaJ1UlJmeUZKbmJmja2h
 goGtoaKprbKFraGKgl1ilm6iXWqpbnlpcomukl1herJdaXKxXXJmbnJOil5dasokRGJYpxWo9
 OxhPrPqpd4hRkoNJSZRXJlgjSYgvKT+lMiOxOCO+qDQntfgQowwHh5IEb2YUUE6wKDU9tSItM
 wcYIzBpCQ4eJRHeulCgNG9xQWJucWY6ROoUoy7Hg4V79zILseTl56VKifOeBZkvAFKUUZoHNw
 IWr5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNagFzCk5lXArfpFdARTEBH2BmpgRxRkoi
 Qkmpg2qm9+VnBUc52qaRlrC12qQeZpdVEpuZeZhBbZcfaEcoUvflsxMs5GfdSpfgnTbjleGqW
 h3aA6YzYw/rXHd8c0OlZkXSG46KMmuprvjtCBwxb9atuBhjI7p3SJbls0sb7Ic2XHloVHhe7E
 XlsqmzZmtTwEKGkSE+1bdnVlTNcb675/MT4Tu2PRcbMR1z03G4a3v5S6rLHoUnsj68j26vjLD
 POnZ60e//ZeT8nV80RnKS+r49pr/ixTTs85m6zNZ5X8f+a57yDNlv3CO1oTHVaue/npBvhwfE
 Hha8WLUnU3hRVtdL0V6mXakATR+qyHY+Ln9Vv2iLYL8Wyb1nDCwfPhZ9M5PSV7r36obdMUTv+
 hRJLcUaioRZzUXEiAPJq9PJSAwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-5.tower-548.messagelabs.com!1646812215!60334!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23708 invoked from network); 9 Mar 2022 07:50:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-5.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Mar 2022 07:50:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3B6A6100195
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 07:50:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2E97D100190
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 07:50:15 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 9 Mar 2022 07:49:53 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 9 Mar 2022 15:49:06 -0500
Message-ID: <1646858946-1470-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] runtest/syscalls: Add missing futex_waitv
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
 runtest/syscalls | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d679e7a..6186bfc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1736,6 +1736,9 @@ futex_wait02 futex_wait02
 futex_wait03 futex_wait03
 futex_wait04 futex_wait04
 futex_wait05 futex_wait05
+futex_waitv01 futex_waitv01
+futex_waitv02 futex_waitv02
+futex_waitv03 futex_waitv03
 futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
