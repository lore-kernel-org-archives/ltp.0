Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD05C4345F
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713863524; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=KbTp7lRT20JZZ+v0w2YAVfsGIe6PK83GkXRvFrWUfLs=;
 b=FjJsOncbjMZb6shwnb6fVq8/57Dc8p1Vxs3XUlq3wcR5LBNp3N6BnlyauNe++r2iBjK0L
 8MQ0AZULmq+NOtYFNX07PCikqK3VhkslKu30oz3KSjXg8wQh4l+y5EYG/JJYjNwsPA9ZxmI
 swr+Jpo1ZQ0eQXsJEhjcyhgYWuBamg4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 688803CFFA2
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 11:12:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF4ED3CFEB3
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 11:11:42 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B976200B9A
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 11:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713863501; x=1745399501;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=evUWc+ZZNUahK7m0WWvhxtAZwjI3Xv92JdHTtpoVcfU=;
 b=lH8t5L0LhCkiFTdErI0xZTJ+LBGr1/b4Ki5ZvTKehUMAaCpdtPo0B4Ep
 8n4HppXNJXPBBEyjaU1XXXw3P75j786yIUoMv0wRWZ+qRywnGgPrC6fX7
 25L4RwXHUO9DAt/fBsn6PT17IZzcu2DG9vcvZUqgDK1f98qCRV/NlNneW
 rQhHIWBLqmILF/UrfCxOIc17wOcmW9k6ZK45ktI96Julo2PG0tbGjM/UH
 VIfbGr/opLbdfhuPsSbm8LiSrg357VVyC1GbIAGh8WwtmgDFM6JX6C2Gc
 /PEXOSxwyq5PS2wqpGkC+mc1FoFliFdVxnb31Yp7gzh6MbQFIYxU8ru+U Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="144032430"
X-IronPort-AV: E=Sophos;i="6.07,222,1708354800"; d="scan'208";a="144032430"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 18:11:38 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id AD204D4C2E
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 18:11:36 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DBE2FD53E0
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 18:11:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 78343E4775
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 18:11:35 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 27DC51A000A;
 Tue, 23 Apr 2024 17:11:35 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 23 Apr 2024 04:37:23 -0400
Message-Id: <20240423083723.66575-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28338.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28338.006
X-TMASE-Result: 10--7.745700-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWNSuJfEWZSQfGvOwg12ikVS0bdjqKOoG3f1xrH5kKK/rj13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatcfdkIlEiI2k8Jb881FGn9l9v5k7uQeUSGs/r1mvxNjTo8W
 MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbtuRXh7bFKB7sy/Y1DqsddXDOdgXlBYh7zZTa
 cEnPOKXFwZSrGtY+vtS4W/MRhJ1X4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlink09: Add _GNU_SOURCE feature macro to workaround
 the compile error
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

In CI environment, unlink09 compiling failed on alpine/latest because loff_t
type is not declared. Add _GNU_SOURCE feature macro to enable GNU extension
to solve the problem.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/unlink/unlink09.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..1472e9134 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -13,6 +13,8 @@
  * - EROFS when target file is on a read-only filesystem.
  */
 
+#define _GNU_SOURCE
+
 #include <sys/ioctl.h>
 #include "tst_test.h"
 #include "lapi/fs.h"
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
