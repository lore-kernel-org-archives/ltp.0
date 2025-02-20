Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C857C021AD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740036752; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=9rIxLP+YZP6mdrwiOwuwY63/cNqeecIpBgb4zB7ex1k=;
 b=q5zu5lecarTM5U17bQ80tym5H08UicdKxu0xYboFVbw44m4qABdusyeAwfYqNuvh3yk1J
 FEoR7HWESc+Mn71vkRZPArcp6SUbP6HBje8QgZdwP7YBUSasa8zhZj40PJwCyXWLUNiau8m
 VzsHPInFiKsGqiEG3hlb9hCZrXCxKGQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B72643C663A
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:32:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45F0A3C0FCF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:32:10 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AA4362D1EE
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740036730; x=1771572730;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qkR2aruCfNSQypdhdnqRuRyEp12u09Yw3cx/nW8Qg0Q=;
 b=bzUDPIkvCY55jqNI6Y0IuVij2vZWeXydZViC0LU/+WJUN64QY2VPRiA/
 7CwYQcDRbluheCdUmUeeDxe1nKLTn/+XfOaLLP3oJhv0KHiGMKH00OSET
 AlYL73LctgoqSPz4XqcfkZqqv3c9hbNvXrJQbd+dUZXkL0QuCLBOodT8X
 mcTm+hUiTYFj+21GgLM/r6L8gUqZqs8RJ1MBaMEfdq5kVuC66oyvzkp8o
 zEib7DY2hUUD4Yil4HbkARSuXYfN+FoiMGYjg4nekImX8ALS6Od+hQTwL
 T+Bd9Sy/KM9iNHYTWwFqzZFsaIMgyi5FYal4+rT6ZAwA9QUuuTcYQqvvT g==;
X-CSE-ConnectionGUID: l+wQ1PVkQOqf1Njmz1YuVw==
X-CSE-MsgGUID: fl1//uxqSKO0Ca2sPXhQ0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="190688211"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="190688211"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:32:08 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D527142CF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:32:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BC03DD560F
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:32:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2824A1A0003;
 Thu, 20 Feb 2025 15:32:05 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 15:32:07 +0800
Message-ID: <20250220073207.1121973-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pidns13: Add a blank line to fit RST format
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
 testcases/kernel/containers/pidns/pidns13.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 5b836c01f..1ea9f5cd3 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -13,6 +13,7 @@
  * triggered by peer namespace process.
  *
  * [Algorithm]
+ *
  * * create a pipe in parent namespace
  * * create two PID namespace containers(cinit1 and cinit2)
  * * in cinit1, set pipe read end to send SIGUSR1 for asynchronous I/O
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
