Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A484EA4FA1
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771844321; h=references :
 date : in-reply-to : to : message-id : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZfDpvBBTyoJPBivkktgqyLiLu7kNl8425IH1TE14ymk=;
 b=P1g6IIifqbAjQb9FKBj6saLSJPAVRoUxDidB+EQ0J6wgcjzREZt6OCe70sbL08PTTc/yj
 J/HBwCDoP+7ucfcoyw0flEGQvW0zC09ErXAEvYGkZiKy5hcagfgqCtWepRMfCgJ2whVkfVU
 bYCseBC3GYl3SvrJHsUTKSpoqcHQFUE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 017C03CAF9C
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:58:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 934FB3CBBE1
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:31 +0100 (CET)
Received: from lf-1-131.ptr.blmpb.com (lf-1-131.ptr.blmpb.com
 [103.149.242.131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 94EED1000480
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1771816702; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=c6f7APRbJk4XiU9/hOnM1PApJeCDjD64Pf/Gkb7q03A=;
 b=NmxTV/fbl6rrIAG1hBLoSnAW5qEW91R+wjsQlYtxcC2+QGg39J2aoAST/gFFZ6X65jUcdJ
 V0SbeJQ+mGOHx+s4wsiATjk8PBC1PhWPgwRWMMjwskYLMa9QH7/841/6TGE17MF7xjw0ls
 RgS72Jks0xCdKPdr+CiQ5hXO/AaIlgeZeCDVZe/Oi04HogEbrEoC9WtvqPtkILINKQMk4D
 XNuh9+lY6N2EXnV34bVeG2qysJushj/QB2jXsO91nX4ANZjKz5pqxt7zWYv6X3ZTqJ/Sud
 ZXupCih7lTUhopzCvv0zt9viykuR0Z+B4AaR01m6wD8S+QkPOcp4CtjrRXFq/g==
References: <20260223031903.4037526-1-weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+2699bc6fc+3f8540+lists.linux.it+weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Date: Mon, 23 Feb 2026 11:19:00 +0800
In-Reply-To: <20260223031903.4037526-1-weiguixiong@bytedance.com>
To: <ltp@lists.linux.it>
Message-Id: <20260223031903.4037526-2-weiguixiong@bytedance.com>
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:57:56 +0100
Subject: [LTP] [PATCH 1/4] syscalls/ipc: shmctl04: Parse /proc/sysvipc/shm
 size as unsigned long
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
From: Guixiong Wei via ltp <ltp@lists.linux.it>
Reply-To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The size column in /proc/sysvipc/shm may exceed int range on
some systems. Parse it as unsigned long.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 3ba05f9b5..908cd2926 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -57,7 +57,8 @@ static void parse_proc_sysvipc(struct shm_info *info)
 			break;
 	}
 
-	int shmid, size, rss, swap;
+	int shmid, rss, swap;
+	unsigned long size;
 
 	/*
 	 * Sum rss, swap and size for all elements listed, which should equal
@@ -66,7 +67,7 @@ static void parse_proc_sysvipc(struct shm_info *info)
 	 * Note that the size has to be rounded up to nearest multiple of page
 	 * size.
 	 */
-	while (fscanf(f, "%*i %i %*i %i %*i %*i %*i %*i %*i %*i %*i %*i %*i %*i %i %i",
+	while (fscanf(f, "%*i %i %*i %lu %*i %*i %*i %*i %*i %*i %*i %*i %*i %*i %i %i",
 			&shmid, &size, &rss, &swap) > 0) {
 		used_ids++;
 		shm_rss += rss/page_size;
-- 
2.20.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
