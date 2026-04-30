Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B06DFF886F
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:10:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B6F73E65B4
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:10:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AB6E3DC1F0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:42:21 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E3BAF1000DA3
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:42:18 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777542137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aGgUsgklJsmh66n3UcBLXMJdt6+vywG2GBFBQQ8kRcw=;
 b=PxJUjFHa8SxS4mcId5ztEGj/9Z/PwR7jbDzYhJFxtEos+BTHHtxx12iYa8Gyru+rBA/67Q
 y/ahz1w5tBgYqakRD8t2sPUd9sLWuc4upu/7wRXW1H/Omx4mzOJPa4XDK+onMOfTWbgXiK
 CepGZrrQZdzOuCYRrGfhVbaQ9VzmBw0=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: andrea.cervesato@suse.com, chrubis@suse.cz, jstancek@redhat.com,
 pvorel@suse.cz, liwang@redhat.com, xuyang2018.jy@fujitsu.com,
 yangx.jy@fujitsu.com
Date: Thu, 30 Apr 2026 17:41:42 +0800
Message-Id: <20260430094142.37777-1-fushuai.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Apr 2026 12:10:19 +0200
Subject: [LTP] [PATCH] read_all: Add /dev/fuse to default blacklist
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
Cc: ltp@lists.linux.it, wangfushuai@baidu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Fushuai Wang <wangfushuai@baidu.com>

Reading /dev/fuse without a corresponding FUSE daemon process
will make the test hang. So add "/dev/fuse" to blacklist.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 testcases/kernel/fs/read_all/read_all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index e18945a34..5720ffb99 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -99,6 +99,7 @@ static char *blacklist[] = {
 	"/sys/devices/platform/*/eeprom",
 	"/sys/devices/platform/*/nvmem",
 	"/sys/*/cpu??*(?)/*",	/* cpu* entries with 2 or more digits */
+	"/dev/fuse",
 	NULL
 };
 
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
