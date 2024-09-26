Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BA7CCFA15
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 04:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727324008; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=A9X2obK0L2YMZoIdHvecVxfWRFMF7PqJRY1n0AOVBrM=;
 b=Y6TploVc9dtTiwvS11P+5j+XiB5XPBIdK6kF0KwuNMxLykx3W7eciuV5nB1VWBB2LuNdx
 Ff/pEFp5kwKCHY5mXJfn/GE7m1Llrn0ggALMjmeOctdiQy9CYrGvJi6HzyyrkcY4bVCU+2N
 w25ke3s5zs1QJuHPek/vCNLEzN7SQVY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8451A3C4E1A
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 06:13:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 774A63C1DC1
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 06:13:06 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D78E610236
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 06:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1727323985; x=1758859985;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZMMjiNd6Yjrcy5kMsJhesRn88Ehejm5qM50SH7nhA90=;
 b=slrn7TdXs300uf8h8KEsYfhbw3DdCUsl83gB3P3TkrdrZ/iJZoPta3vc
 TUS3vvoxxwY/Z713saCbusO3n+rj21+PWOXhfnL0Vdt3X1+pD2gzHp9IN
 OFAPHHdNW0lwYnwkqEDLPkRVo901n5CXud68u8HxBJNxViyrbIBfBdX9e
 5YfdAK40UQEezR9e+s39rE4dIk/yzgADfiqlS+Xr60JYg1XRAM0ii6Tne
 B28dMIqHV9BPQ+kM3GBNDGHjs7TO4TPVK3NVSIGUepdKEU/pYuvHWloqO
 uDvIlOUhexIoLmPU6VnnQZqSVB3VHlYdX3I/Hv2Qgeeydj4mQMm6oA1NU A==;
X-CSE-ConnectionGUID: TWGC164tQJmRAqkZnGDrEA==
X-CSE-MsgGUID: Yi75HERkQ2mBqemVvV25rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="174064064"
X-IronPort-AV: E=Sophos;i="6.10,259,1719846000"; d="scan'208";a="174064064"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 13:13:02 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 39233D29E6
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:13:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 65A79D55F0
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:12:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id EA1716CB39
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:12:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 40DAC1A000A;
 Thu, 26 Sep 2024 12:12:58 +0800 (CST)
To: ltp@lists.linux.it,
	chuck.lever@oracle.com,
	chenhx.fnst@fujitsu.com
Date: Thu, 26 Sep 2024 12:13:58 +0800
Message-ID: <20240926041358.951923-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28688.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28688.004
X-TMASE-Result: 10--1.645700-10.000000
X-TMASE-MatchedRID: B9+tX7Glxm7xQQLsu/VcFR1kSRHxj+Z5H4pppXAAbjffUZT83lbkELSn
 Jfu7KIKtK3CH47GnTkgfc60DKktRRsNrtcT2qp8mxDiakrJ+Spl9LQinZ4QefCP/VFuTOXUTPvB
 STRncWKuOhzOa6g8KrWcodF9QdyE/0+q1b9fS27YKUDDgCFEHW6BHnvSI0L7eI7SU+4NYp+nBdL
 u2/1isHKyect7QF6BH4iXaK+ULy5vv6CuO1zoZzRXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
 0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tirpc_clnt_destroy: Determine the return value of
 clnt_create()
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Determine the return value of clnt_create() to avoid segmentation fault
when executing clnt_destroy() when the return value of create is NULL.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
index 939ff3e4a..bb9a47503 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy.c
@@ -58,6 +58,13 @@ int main(int argn, char *argc[])
 	//first create client
 	clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//then call destroy macro
 	clnt_destroy(clnt);
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
