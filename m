Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967E4C4707B
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:16:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 174F43CFE1F
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:16:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19F163CC136
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 08:29:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2862600A15
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 08:29:28 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="124085464"
X-IronPort-AV: E=Sophos;i="6.04,333,1695654000"; d="scan'208";a="124085464"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2024 16:29:26 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 79C04D64BC
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 16:29:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BB3A0D949D
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 16:29:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C07C22EAC3
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 16:29:22 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C501B1A0070;
 Fri,  5 Jan 2024 15:29:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri,  5 Jan 2024 15:28:41 +0800
Message-ID: <20240105072843.2098332-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28100.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28100.005
X-TMASE-Result: 10--1.392700-10.000000
X-TMASE-MatchedRID: OVdoBgHyl5DlWiNI/3lAD07nLUqYrlslFIuBIWrdOeOcbyawsiRjd6PF
 jJEFr+olKE0Je8DR/D4CU1PRf9o2s90H8LFZNFG76sBnwpOylLN0cvS7x+R0Ui/H6FNR4JcDnXI
 4djFZoxVDlT3qeK4YngpdQVKPqzIgs1UsYRX572YA1gJqDoy5MS61zNC23bm8yMv+oWlS2PEhya
 dlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jan 2024 10:15:32 +0100
Subject: [LTP] [PATCH 1/2] syscalls: setgroups: Add missing gitignore
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

setgroups{04,04_16} should be documented in .gitignore

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 testcases/kernel/syscalls/setgroups/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/setgroups/.gitignore b/testcases/kernel/syscalls/setgroups/.gitignore
index 9de928241f..0649a34251 100644
--- a/testcases/kernel/syscalls/setgroups/.gitignore
+++ b/testcases/kernel/syscalls/setgroups/.gitignore
@@ -4,3 +4,5 @@
 /setgroups02_16
 /setgroups03
 /setgroups03_16
+/setgroups04
+/setgroups04_16
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
