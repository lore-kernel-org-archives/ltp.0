Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D56AC47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 04:02:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF66C3D0107
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 05:02:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 946F13CFB1B
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 05:01:49 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 270EC601F66
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 05:01:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706241707; x=1737777707;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CrR7lvLpD153EvDUorqyatC0tlsoilUI0f/xqNCqnM4=;
 b=PokNLr1wDEOENBV0KWsABqJUJarkcpt4X27i9tLgFVa1u0dsAdAxVdjL
 8FYkEkwlNhVj0OzOGBprZJ5kCCx96d5g9tl3G6fHaolJzIOwKcR04Ba2D
 TiUXTvjZKbnrInuiB8HwEX42HdVNWqPFToHFL2VCDK5pHu1yNxpkIGg4p
 kavwnhRUAga+9Mr+fZKPVQgFiEKVY+n0FG4hQVCloIDITueQZI5yI1X6C
 vcI/noU3CrA2THQS63RdpTA5HMBqqbzaASHAB74rGqSf8O4H8LOWZGIw3
 YSzW5WSks5T6194EHEO1VWquuN6QzYFefzloa+7TdqnGl/FYRIyGL4UdF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="135724758"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; d="scan'208";a="135724758"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 13:01:44 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C759D64A7
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:42 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 08A0FD8BCF
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:41 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9BE9E2007C3E2
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:40 +0900 (JST)
Received: from irides.. (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 459F01A006E
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:01:40 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 12:01:39 +0800
Message-Id: <20240126040139.2534873-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
References: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.004
X-TMASE-Result: 10--6.705500-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cOOPHcS3uzQKazGfgakLdjawTlc9CcHMZerwqxtE531VIPc
 XuILVCbaxRnB4y+KJ+Rl+L/qU7bESyJMyaD9gw+Xqoeab9Xgz8+EpBVx5tWvLRe1yJq6HIhHE4L
 eIK6WkgroBNTOy2tS54Ay6p60ZV62To3UJuRLIoTdB/CxWTRRu25FeHtsUoHul8V3NT7JckDnnF
 7chyyk2M/L9YWZMHYt0iMueUVgByZfCOKFKuVYGg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] fdatasync03: add [Description] tag and cleanup
 code
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fdatasync/fdatasync03.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync03.c b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
index 5f3e0c96f..257e413d0 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync03.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
@@ -4,8 +4,8 @@
  * Author: Sumit Garg <sumit.garg@linaro.org>
  */
 
-/*
- * fdatasync03
+/*\
+ * [Description]
  *
  * It basically tests fdatasync() to sync test file data having large dirty
  * file pages to block device. Also, it tests all supported filesystems on a
@@ -37,10 +37,7 @@ static void verify_fdatasync(void)
 
 	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
 
-	TEST(fdatasync(fd));
-
-	if (TST_RET)
-		tst_brk(TFAIL | TTERRNO, "fdatasync(fd) failed");
+	TST_EXP_PASS_SILENT(fdatasync(fd));
 
 	written = tst_dev_bytes_written(tst_device->dev);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
