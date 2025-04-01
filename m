Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC92FC36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743500372; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=V0cqP/FZr+fzwYjXoglK1dhyckrovFN+0Uz5jKZJ3lw=;
 b=YP7MFiqEohYlEKj/RBzQ/OrelnCgWzMor1PZz+qpydhn9qNQiy1X71XdDkIYu0vAmwjHI
 W5kQpj3Z/P2Eg6Zz8IjAVtgiHiPG8GE9RXQb3L7Dz28VrgA5Zrk38/RmPgI6iIc2iVICNlC
 gi1/5d/+RkpAJmr8y3IadjsJLkqsqLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 224F43CAFBD
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 11:39:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 236CA3CAEAF
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 11:39:10 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 273C8680421
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 11:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1743500350; x=1775036350;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IbCXBxq3Sq7zAS3KM0VLHSGMcsnAwVx8qgAoWj5tDl4=;
 b=qoKdrjpKG5HJQ4drsJw85libCIuc6b7ZWi6d/jk21gh6TnyEL0Or9H11
 eYHqJUZwojNrv+JBI2Do7A6MkUu3Llcr4rj2j90X7e0BwxuEKegjtsWB7
 RRj0qct95J1ZqRIESFK4T6ExkqjUQ9jEk8FU7jg01o5pxYYqp5fJXqCEu
 h4vmHM19vEy0WyjcbyjP6WygJQnszWn71PlwSViaY9UCnzF0f+u6oM8cM
 7/XWtcNYvihQqwOqemgl2TrmFjmmVwV9nqnPk1a/SzBkjvVqPv3ORa5fK
 p1DAkimyD+QQT4tF9k5R9PZBCbZpfDVdhDbw6IcoGh5Meh9AfNsODtPH4 g==;
X-CSE-ConnectionGUID: xtAnWu5AQamOjZc/RdYbNg==
X-CSE-MsgGUID: 6BmFlp7AQeyKRpqeXu1Rhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="195111579"
X-IronPort-AV: E=Sophos;i="6.14,293,1736780400"; d="scan'208";a="195111579"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 18:39:08 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1ADCADBB80
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 18:39:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D1F7DD4F7C
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 18:39:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 228C41A0078;
 Tue,  1 Apr 2025 17:39:05 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue,  1 Apr 2025 17:39:10 +0800
Message-ID: <20250401093910.136401-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pwritev202: Fix the doc to fit RST format
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
 testcases/kernel/syscalls/pwritev2/pwritev202.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev2/pwritev202.c b/testcases/kernel/syscalls/pwritev2/pwritev202.c
index b17d84067..30345fa79 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev202.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev202.c
@@ -9,10 +9,10 @@
  *
  * - pwritev2() fails and sets errno to EINVAL if iov_len is invalid.
  * - pwritev2() fails and sets errno to EINVAL if the vector count iovcnt is
- *    less than zero.
+ *   less than zero.
  * - pwritev2() fails and sets errno to EOPNOTSUPP if flag is invalid.
  * - pwritev2() fails and sets errno to EFAULT when writing data from invalid
- *    address.
+ *   address.
  * - pwritev2() fails and sets errno to EBADF if file descriptor is invalid.
  * - pwritev2() fails and sets errno to EBADF if file descriptor is open for
  *   reading.
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
