Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE56C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 05:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744351039; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+gNwFbKL3Gr4P26YeFq4fc9r5Wge6Ymwe++/6LVH2ac=;
 b=SS61a2IGtDO12/ZM7Z8Tqn8qhHolR/0VeVgDHQdva8xpWHgOv41TjwQ43C/2dLzk1wJHY
 QpUja2hI/0ejh3TbTRrrOE9A0/YUtQHZ4gxjb6ri2VKIdMnSWH/UP8GBgdhoEoDrI1hZhAA
 KXC5UVYntmB9EO+T6Ij1wZuizc1eVHU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8D83C9775
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 07:57:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D1233C9775
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 07:56:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB5FB1A006B0
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 07:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1744351017; x=1775887017;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P+6Pb6yg++ea9pQPL/7JEaRzpY3qXeImEgyJ8N/ail8=;
 b=rf67tMH00lcDACzKE8UE6ehEYXTci1AgcMPaTzhb2eACDRMXYNPDTbxJ
 FCyZfiR1l0dUaKNf73+pccIMTKZnngWv6NXQF5WK7T9Un93yolySlXFDo
 StRtcV462M+tDHeu0ZRYpXP/FFcJJDhyBZUUcHQneM4pcJV4w6DYJXfcz
 uxbGL/+2FkSaSJoEZp/hZj2HcI0yAwgl7DYQe1cmJK0qc4VMUCpnySrHL
 gn74xFHACtxfEIJr5hFr5NnRkjXB6WTPsYH/atcNR8C1BNI4zQ4aRmoMK
 YeWoeOcXRpBdQSrwxns1fYCz4EZJcT3v0NqQAX7QPNLfPJ+HYoLAzzYMc A==;
X-CSE-ConnectionGUID: mWRqekIPR4CyNaRB8nXaMA==
X-CSE-MsgGUID: s1wq8t/qSoyglz2aq35GMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="198926001"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; d="scan'208";a="198926001"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 14:56:54 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A0CEC2269
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 14:56:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2687FD53F4
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 14:56:52 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 819DB1A0078;
 Fri, 11 Apr 2025 13:56:51 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 13:57:00 +0800
Message-ID: <20250411055700.22364-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] splice02: Add a blank line to fit RST format
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
 testcases/kernel/syscalls/splice/splice02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index e9aba47cc..53d243db1 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -12,6 +12,7 @@
  * http://lkml.org/lkml/2009/4/2/55
  *
  * [ALGORITHM]
+ *
  * - create pipe
  * - fork(), child replace stdin with pipe
  * - parent write to pipe
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
