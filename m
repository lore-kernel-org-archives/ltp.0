Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85CEC021B0
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739958012; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=bvVOVfJ0iN7LHNFkXQEzWczFjFwrl0+1pFE8UhT6R+4=;
 b=aKlTpwhfnzlHywJYtr/ibWuFS9roenmTVSkPFYmP+RA0qH5Z7e5ylDJxmhL4FCa65/UIB
 MVmxlKi6BiL/VPT3rruwoRuct4KE9zXqYq8MKwMtGGZ3hnkt3wlm2HP8nslw33D6RNVOS4k
 u3/E/i5lqw6Q7Jj03I6ZU8L2qnYCE9A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FBB53C2B53
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:40:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57ADE3C0503
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:39:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 378C7635344
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:39:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739957988; x=1771493988;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jChU73NY3cDOunSz1EIjDuu6e6r0RRjKqSaWSbMWBD0=;
 b=VI8ORogyQ7HYdLAqAyVOiyz6yMoO4oKiRiBUI9/Zm84Ocpoqh4C2Ya/Q
 9rpCBl/l183SDEHIty6GOQ1ZcgoG5Evv3wyiHOLcTu/SbQJr5c9ahMjcX
 cOZmHVl/KN8bbfycYDxdPQx62KeIMveQ12Ugj9aBGoNjWuty/6qBL0l9A
 qj2RttjnM4uthPDX+vCIqd38mJPbal6VhHuUiCvF5ZBoxXNW7S1jsmAOJ
 Y21tzn8LQMuX2S34hjsY1kDK0fvyL7++bFUyh5RRP9rZXxLZkCT/LKC6B
 dqbx2uz0Q+wFZng/zoKQ/+LUoedMktP4j2TS7zSDLQw60bu/eP2cPWfYv g==;
X-CSE-ConnectionGUID: +dnYGVBVTHS5cpB9rD3vzA==
X-CSE-MsgGUID: DpT+4AnbS2+NMbtT4W+68A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="169971822"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="169971822"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:39:45 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 72704DBB81
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:39:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C38DBDB6D
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:39:43 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 98CE31A0003;
 Wed, 19 Feb 2025 17:39:42 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:39:47 +0800
Message-ID: <20250219093947.1047597-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getgid03: Add a blank line to fit RST format
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
 testcases/kernel/syscalls/getgid/getgid03.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/getgid/getgid03.c b/testcases/kernel/syscalls/getgid/getgid03.c
index 3e406ce64..80b0a0fc4 100644
--- a/testcases/kernel/syscalls/getgid/getgid03.c
+++ b/testcases/kernel/syscalls/getgid/getgid03.c
@@ -8,6 +8,7 @@
  * Testcase to check the basic functionality of getgid().
  *
  * [Algorithm]
+ *
  * For functionality test the return value from getgid() is compared to passwd
  * entry.
  */
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
