Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0186AC43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783521767; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=mr33gkD4Hog2xyvhRVJAOHhEN/H0UwYJEQOIsSsNdZ8=;
 b=FmMgDloviyGVvKOafzds0D1i2GR2y6u0p6g3p8OqHYQjYA039mxeGGm4MwqJ+bM0V5A4A
 S3M8WCR6t/YxVm1bGpphQgNXKkPt4TzzlBDQMZENJ25ro4bAxE9lQy6GKBvjBA31xGxZdUq
 eFDM3SzQ0rnOFQKNBwuksdpojqGaZ4U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D3B33E5CF1
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 16:42:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95C5C3E49D2
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 16:42:28 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AF3F46008F0
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 16:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=B0+AlQfRQJz+0SJhOJFbdNtYOHLEwQCcwaE+SwhJLk0=; b=wH7ay2IPyd4m
 1KZZTcSqfCBv7hCp876mipdSurBTU/SscL4/MxbZtkIj9w6BzDMVW6ahwka/igIyQwx2Ga3pd6rgG
 uC/fuBRqJQkF0QCxwloQy9VsoCe/d5o9Xv80qz6O6gHuMxZOm2hh51TXfU8KWtf+mshGJwuaAi/pu
 ZhyIYyIVWqotgT6nm6gmoh8ra4TNXcv8ZC+6i3jnvzMowWR0R7HIjjaSwLkAnTiJaim4F7pSUuHqo
 2NpyP0/yQf9Uxx0jXHNhq7efexQkLChJmEBfVPelPwIRp9B4xzwVR+ANLlu7f9wbvf4RUeqT5CNBi
 jBlduXM1zXc6bTEiErfoPg==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1whTSj-005Bj8-2K; Wed, 08 Jul 2026 16:42:25 +0200
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 14:42:10 +0000
Message-ID: <20260708144223.833263-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] commands/df01.sh: Drop redundant fuseblk pattern
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The regular expression already matches "fuseblk" through the unanchored
"fuse" alternative, making the explicit "fuseblk" alternative
unnecessary. Let's drop it.

Fixes: dbc966d4adb6 ("df01: detect "fuse" fstype in addition to "fuseblk"")
Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 testcases/commands/df/df01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 72b02ce34..6f0ad71ac 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -15,7 +15,7 @@ TST_NEEDS_ROOT=1
 
 setup()
 {
-	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk|fuse)" /proc/mounts | awk 'NR==1{print $3}')"
+	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuse)" /proc/mounts | awk 'NR==1{print $3}')"
 }
 
 df_test()
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
