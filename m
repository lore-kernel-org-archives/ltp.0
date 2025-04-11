Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF68C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 06:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744352407; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=yLWaiwUUPAdwAFrcnntWapE27mq7mn6CJNfqfg4Ju+o=;
 b=cSgZAGPovwBGxVo5+dDbUB3t0ovZmLETV12TXHhcZbPB5JWbSAxk7ZA+qYNgoAyHHdUOe
 WdmuNGbOswy/vQSrUX4HiwgcUlTajh5XOS/X64U8m66uqTIKPrO3unhfexETaD5PY9uHM6c
 xEIJ+7F3sfUBE3XpFKB40dBLi/0mHv0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F28C03CB559
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 08:20:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F46E3CABDF
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 08:19:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F6E11000376
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 08:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1744352384; x=1775888384;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bxzWS7aS9iCG7zadQgPKhYLxWm/swXY5fzYsuBJ8G2g=;
 b=Z9dn2LftLxYKgWAjnCN8JxV7rHgbxfvfg0CX8Md7+Hh8R7t6TOiRLtmM
 sp/pc6mV7fn/yCSV8b3hztWzGllAy03idPnnCCb/KSS/lqUfADpkK+FLr
 4bbgcrY7bT7/Ju5rKuLcLIHQwXjdmoSD80skSiY/srbTNumrHVQnMxNN3
 qXCRTKcHaseyoO5eLXonfxmMB0vnUgVMs1redlgzecm8uTfHoGVd99m7Z
 cV9O9do65PevjNlSZxF7Uh/kywZZzRb2F3cdHmpM59pmil1ouAqcOw4u8
 mgSPmX+QgZuIG9E+LiApa5JBWYg6KxVLY0oNp1BtxLRaTPYJYhkzOs/iJ w==;
X-CSE-ConnectionGUID: taiBauzMT32tVC02zGc/OA==
X-CSE-MsgGUID: AqkO7S6lScCPWKZhthxdTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="198930217"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; d="scan'208";a="198930217"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 15:19:41 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E52ED6EA1
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:19:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E12FD9748
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:19:38 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D7C361A0078;
 Fri, 11 Apr 2025 14:19:37 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 14:19:50 +0800
Message-ID: <20250411061950.23024-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] timerfd02: Add a blank line to fit RST format
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
 testcases/kernel/syscalls/timerfd/timerfd02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index f89d41502..960ce63b0 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -4,8 +4,10 @@
  * Copyright (c) International Business Machines  Corp., 2009
  * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
+
 /*\
  * This test verifies that:
+ *
  * - TFD_CLOEXEC sets the close-on-exec file status flag on the new open  file
  * - TFD_NONBLOCK sets the O_NONBLOCK file status flag on the new open file
  */
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
