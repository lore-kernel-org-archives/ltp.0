Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B93BC48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708955709; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=091LgL/SFEugEyyuatur6j1M4drP2y2qwIQWTNWr2AU=;
 b=kBO/aCt77NyJwp8ZAaK/CXuneRHg/9SijpLVo9CVBaV93JnIyO0zETAb2yCdZ0kBmCwLR
 OSn7ExbVtsXOByYdLJDqRAoMso4ik3YsetwVBqWdabm3sVAHj8cGm7cgqAuGX8nf/XKAaFV
 fL4PYJc+B7BhOqoxCpoIUgjrj/lEmtU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2BA83CF004
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:55:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 726903CEFEF
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:19 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 837BF1000368
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708955656; x=1740491656;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8lEOZRSZEuC4MGWJXpCjWMn8/rEicupPj5lyquERKGw=;
 b=p4dytm+is5bEqUmtqP36atoDdyTchZ48Z7ug/IlzqDG5i6vz9XYul9G6
 E4MUi4MlmyReXoTrrOUUj81GqcsmHzao3iB5LdLrwRbdSK3yj/qSMU/c+
 b9xrciQ2vWz5TwuO+M+jebu2qi0RT5FWbXCnHD63pJ6hU6dExGoIyS+4/
 ZNX6ZN48nmZI06V72/10ocXPhYkPtLrKkJidSBkIMMVxZNtQLNgDQdpqZ
 BkKRWzE+eFWDZ3pK1Z/dARUUwoyYtuktultVudCAs5XRmEf4BMmx4uxj4
 jh17kETKzf9h+YUUr/+uEYEwgzGOTYuZ7Kv70hnz8vCqS7MNe62gYWx0v Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="150722455"
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="150722455"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:54:14 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 90F03D3EA9
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:12 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D7DADCF7C4
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CD046BC7C
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:11 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D5B481A006B;
 Mon, 26 Feb 2024 21:54:10 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 08:53:32 -0500
Message-Id: <20240226135336.19733-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28214.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28214.007
X-TMASE-Result: 10--7.893900-10.000000
X-TMASE-MatchedRID: 90G6ca/P0SOe/kF8Pup4HKzGfgakLdjawTlc9CcHMZerwqxtE531VIPc
 XuILVCbak2rNDhoFVtmq5anvU2i8LHk5VN4DJHKIh2VzUlo4HVM2LwvzxRX0gEA6+2WeJ60F8/e
 HChOsjzqBx0ShwZLio0dHbFW6uX0ZNYwYTEoASsF1e7Xbb6Im2sLiFiL0BG1umyiLZetSf8nyb6
 HMFK1qe3YJEUfDojP/IAcCikR3vq/3/ABbRNBfyAdY1v6hL6nfvyeLMKTfHG2IQUlhPMclIExnU
 GmM27Qp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/7] syscalls/swapon03: use tst_max_swapfiles() and
 GET_USED_SWAPFILES() API
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 44 ++++-----------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 2a0fc99e6..26385a5ae 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -19,7 +19,6 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "swaponoff.h"
 #include "libswap.h"
 
 #define MNTPOINT	"mntpoint"
@@ -104,47 +103,20 @@ static void verify_swapon(void)
 static int setup_swap(void)
 {
 	pid_t pid;
-	int j, fd;
 	int status;
+	int j, max_swapfiles, used_swapfiles;
 	int res = 0;
 	char filename[FILENAME_MAX];
-	char buf[BUFSIZ + 1];
 
-	/* Find out how many swapfiles (1 line per entry) already exist */
-	swapfiles = 0;
-
-	if (seteuid(0) < 0)
-		tst_brk(TFAIL | TERRNO, "Failed to call seteuid");
-
-	/* This includes the first (header) line */
-	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
-		tst_brk(TFAIL | TERRNO,
-			"Failed to find out existing number of swap files");
-	}
-	do {
-		char *p = buf;
-		res = read(fd, buf, BUFSIZ);
-		if (res < 0) {
-			tst_brk(TFAIL | TERRNO,
-				 "Failed to find out existing number of swap files");
-		}
-		buf[res] = '\0';
-		while ((p = strchr(p, '\n'))) {
-			p++;
-			swapfiles++;
-		}
-	} while (BUFSIZ <= res);
-	close(fd);
-	if (swapfiles)
-		swapfiles--;	/* don't count the /proc/swaps header */
-
-	if (swapfiles < 0)
-		tst_brk(TFAIL, "Failed to find existing number of swapfiles");
+	SAFE_SETEUID(0);
 
 	/* Determine how many more files are to be created */
-	swapfiles = MAX_SWAPFILES - swapfiles;
-	if (swapfiles > MAX_SWAPFILES)
-		swapfiles = MAX_SWAPFILES;
+	max_swapfiles = tst_max_swapfiles();
+	used_swapfiles = tst_count_swaps();
+	swapfiles = max_swapfiles - used_swapfiles;
+	if (swapfiles > max_swapfiles)
+		swapfiles = max_swapfiles;
+
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
