Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEC0C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739957276; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BW1pMIyglSVjltnrbsx2/qVdKAhTBmZ4mA9mQFWEoYA=;
 b=U3WL1d2vO3PAe4nkPZSBnfVLcLnC6EYsXObHjfC/omHUEj0PvKREkiYbsuX933uPXYSkg
 WdzY0DfXSyVbSqtVDUXp8eecqpSGD8SP91BRADPWLKCCxXEFMBRaFI2iTmGw/SrL/tX0PJG
 MmpYBGQqIbaKr1tjGjlqGQQRlGaMs3A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D7253C2B64
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:27:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BF993C264A
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:27:35 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AEDF0140120E
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739957254; x=1771493254;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LyBT7Ofow2Zrq/o0Sk6QcLOIE+AEUOn8Bt5qlhUuNFs=;
 b=N7wHqVhvds2lDw1RjiGZtqwoiiqLCLfRpohtNEj4qOcn2rfXOwOUrhzs
 K4SED6jk6cKg4ZesVrPoxu7dqqwQzZIlQyRKLQN9+g9cXehUSydJvQtzN
 e2Q0jqd6QJu64Z4P8uN4M1lUaOXRU11iQljVmRyQI9Pkpa8UWqJg1jq6I
 hxwEOW71dXZr6eNlRb5xchrhBf93Y64Mhgv2fMfNbi4p/5Wdl7a3KQxKl
 OazXVVHH431p/kwhvl6XBXEG9RrMa6JCqlE+lXmd1Y7utnGA1elcuyp6O
 afXfs88f368fWR1mU7XQ08E7hnUlGJ6KxYdfpzMffZSPBzAEyrYjfGNlq g==;
X-CSE-ConnectionGUID: dWw3yirbSK+7sP8SFixKLg==
X-CSE-MsgGUID: 4udyRqnXRuutBZ4GEfseog==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="178878723"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="178878723"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:27:31 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 65F73E60B9
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:27:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 27F86D52BD
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:27:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 84BF31A000B;
 Wed, 19 Feb 2025 17:27:28 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:27:33 +0800
Message-ID: <20250219092733.1046699-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fork10: Add a blank line to fit RST format
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
 testcases/kernel/syscalls/fork/fork10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index d6dc05d46..6751a8f85 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -13,6 +13,7 @@
  * [Algorithm]
  *
  * Test steps are the following:
+ *
  * - create a file made in three parts -> | aa..a | bb..b | cc..c |
  * - from parent, open the file
  * - from child, move file offset after the first part
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
