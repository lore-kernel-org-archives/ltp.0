Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780EFC47073
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 01:23:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A729C3CE5B4
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 02:23:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EC013CE581
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 02:23:13 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0636D1000419
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 02:23:11 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="124748147"
X-IronPort-AV: E=Sophos;i="6.04,340,1695654000"; d="scan'208";a="124748147"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 10:23:10 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C5912D64B1
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 10:23:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F4002BF539
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 10:23:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 92FA0200968CC
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 10:23:06 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 345E21A0076;
 Mon,  8 Jan 2024 09:23:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jan 2024 09:22:51 +0800
Message-ID: <20240108012252.2496776-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240108012252.2496776-1-lizhijian@fujitsu.com>
References: <20240108012252.2496776-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28106.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28106.003
X-TMASE-Result: 10--1.464700-10.000000
X-TMASE-MatchedRID: WiDRxrFjYObFkNQYjukgj07nLUqYrlslFIuBIWrdOePfUZT83lbkEG3N
 GEaEXmnAzXNXdPmZxISAMuqetGVets1LqAsZOTL6avP8b9lJtWr6C0ePs7A07U9hWalM11Qabht
 CzQoH/K9iiwx1HSyFSHf7tEdrEkpRaxGdYpTPnCrAYLx7rnbR8rDQ8m3TqgloelpCXnG+JjvDGB
 Z1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RESEND PATCH 2/2] lib/newlib_tests: Add missing gitignore
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

st_res_flags should be documented in .gitignore

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 lib/newlib_tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 0256bef76c..a69b29e24a 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -56,3 +56,4 @@ tst_needs_cmds08
 test_runtime01
 test_runtime02
 test_children_cleanup
+tst_res_flags
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
