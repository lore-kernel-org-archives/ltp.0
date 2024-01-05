Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3385AC3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853C33CE537
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:16:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10C463CB9D4
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 08:29:30 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD904100187A
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 08:29:28 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="133695880"
X-IronPort-AV: E=Sophos;i="6.04,333,1695654000"; d="scan'208";a="133695880"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2024 16:29:27 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A5500D7AC6
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 16:29:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E42DBD9481
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 16:29:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8675822EAC3
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 16:29:23 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 21E1B1A0070;
 Fri,  5 Jan 2024 15:29:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri,  5 Jan 2024 15:28:42 +0800
Message-ID: <20240105072843.2098332-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105072843.2098332-1-lizhijian@fujitsu.com>
References: <20240105072843.2098332-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28100.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28100.005
X-TMASE-Result: 10--1.464700-10.000000
X-TMASE-MatchedRID: WiDRxrFjYObFkNQYjukgj07nLUqYrlslFIuBIWrdOePfUZT83lbkEG3N
 GEaEXmnAzXNXdPmZxISAMuqetGVets1LqAsZOTL6avP8b9lJtWr6C0ePs7A07U9hWalM11Qabht
 CzQoH/K9iiwx1HSyFSHf7tEdrEkpRaxGdYpTPnCrAYLx7rnbR8rDQ8m3TqgloelpCXnG+JjvDGB
 Z1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jan 2024 10:15:32 +0100
Subject: [LTP] [PATCH 2/2] lib/newlib_tests: Add missing gitignore
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
