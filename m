Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519D4C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739959251; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0oLlWJA117VpGTeIgS10/wnSmR3wFGBFDB2eAjL+CWI=;
 b=j7ChJPlozKk9gN3OehlpeJC7xIZXaLp9glK0dM6OcfsPVQjoXjOTaNZZoanoNJyqK3zSw
 KW0mWtZ/wIR+Sskv/q9VO3jlKGyC97htDojB3Dvc5c08P/9OVUFhVq0aW37MkB52dSr0Mcx
 uouz7wtrxJg3D40I1/FRMXgoa1JRwjQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4C173C2CA2
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 11:00:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296DA3C2653
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 11:00:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5A85B6688A7
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 11:00:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739959230; x=1771495230;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6P3YAJHNrnI0l+pzxNj70RSBT1gJU6S3sjNl1/3SNug=;
 b=s/uVarl2B56wGzZJmZaV9bm11aCnD6v4VJtiRJeP4uzo1IH3YQi+yyea
 IM4xNECavNstzF/G2PkJ7bp7LYg++mjBndDzR22tsstxf7XNarOuGtrxD
 GzZpEt1sF/q6iLscIzmf7XlulD9edPSmLYnEJW/Guhd1A0aqgT2JL6qJI
 ZzABgryVSyfnm4MK9OpJrWolx+HfLYM54BEdQBqQ7DoXyd7uo6lHrqdWA
 9TQVbcxXAgsd+1oGQR2paj1KybIpoZEBg2jPNlx4nrqjRAuLG4IhG3md0
 HFiiKC+wsazS9YkrAwLYIo28pPr//pB4GwNDdrPFpCg217wiwj8KdoMT6 g==;
X-CSE-ConnectionGUID: lPA9ybH3SsOqqTWQOYn7NQ==
X-CSE-MsgGUID: 0342OSQFTrqxIoxVJmHxTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="190476127"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="190476127"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 19:00:26 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 85C61D5011
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 19:00:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 50517F313
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 19:00:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id AE1981A0003;
 Wed, 19 Feb 2025 18:00:22 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 18:00:27 +0800
Message-ID: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
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

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl08.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 115ad3323..78602f55a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -9,13 +9,13 @@
  * btrfs filesystem.
  *
  * 1. Sets the same contents for two files and deduplicates it.
- *	Deduplicates 3 bytes and set the status to
- *	FILE_DEDUPE_RANGE_SAME.
+ *    Deduplicates 3 bytes and set the status to
+ *    FILE_DEDUPE_RANGE_SAME.
  * 2. Sets different content for two files and tries to
- *	deduplicate it. 0 bytes get deduplicated and status is
- *	set to FILE_DEDUPE_RANGE_DIFFERS.
+ *    deduplicate it. 0 bytes get deduplicated and status is
+ *    set to FILE_DEDUPE_RANGE_DIFFERS.
  * 3. Sets same content for two files but sets the length to
- *	deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
+ *    deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
  */
 
 #include "config.h"
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
