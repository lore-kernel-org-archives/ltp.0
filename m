Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AFEC43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782903661; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=lWlJmlxfXUfqeWOMi4XcHMvskuZpORW9armCD7oY0rc=;
 b=cC9vjV9bqRVjxMprBGaFv1OXoFhb7tVC2WEe9qvlF3X4Yt1PIlZ5JtIkDHtW6cnKnw4HD
 Z6E2V4qXDTE/qSG/p8t/zVEI4dMqfl5WYpKtit2QMxvO8DQTMnK9LKJmnfq4FvT3YtbbKOQ
 ddLzlQ5zw9CGQEsdiYU8cpYzU36eEYI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95B4F3E9706
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 13:01:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7D1F3E215E
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 13:00:42 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 253B260077F
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 13:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=UNeK66H69djSADPpL2YgBrvYL1vP+xF0LX/VGLVg5Po=; b=tJ14Jhii2LbQ
 0YvfK4olXqJB9aDUlVolUzMUWZv3bsI2Q8XRTKaOX7hJLzB41YLjqLGUJEmlFST3EYdm1YpzYp43/
 FA6BeakcODPQoD/iUEOyjcS4W1lpQBpgO9NGDXaxjpPM+y6WLi38JBvWM2Ddk79OfYnAKskPj3T7K
 q4BxQfgvwrDNFRCYxB/NOH4SP+NGHgCGn5ixe9qZVMNDrfFK1tZp6NdVeHVU7eG+ggo6ByOn/K3Fc
 pw07PDXpssz8Z3X55QbIMFS7bEr5nAqCIGlhHkdsyXg2RaK8YaNSebeZQNEkhLK57EXIuzoCKN9k0
 B4FDBCbXu9v6kBpFqEbAjg==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1wesfT-00FRxy-0M; Wed, 01 Jul 2026 13:00:40 +0200
To: ltp@lists.linux.it
Date: Wed,  1 Jul 2026 11:00:28 +0000
Message-ID: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] df01: detect "fuse" fstype in addition to "fuseblk"
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

df01.sh derives DF_FS_TYPE by matching the test mount in /proc/mounts
against either the real FS type or "fuseblk", the type used when
ntfs-3g/FUSE mounts a block device via the privileged blkdev path.

However, when the filesystem is mounted from inside a user namespace or
an unprivileged/virtualized container, that path is unavailable: the
kernel's fuseblk file_system_type lacks FS_USERNS_MOUNT and requires
FS_REQUIRES_DEV, so libfuse/ntfs-3g falls back to a plain anonymous
mount and the kernel reports the type as "fuse" instead of "fuseblk":

  /dev/loop0 /mnt fuse rw,relatime,user_id=0,group_id=0,allow_other

In that case the grep matches nothing and DF_FS_TYPE becomes empty,
which breaks two subtests:

  test5:  "df -t $DF_FS_TYPE -P" collapses to "df -t -P"; -t consumes
          -P as its type argument -> "df: no file systems processed",
          non-zero exit -> TFAIL.
  test12: "df -x $DF_FS_TYPE -P" collapses to "df -x -P"; the device is
          no longer excluded and appears in the output -> TFAIL.

Add "fuse" so the containerized/userns FUSE mount is detected too.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 testcases/commands/df/df01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 5af4f68e6..72b02ce34 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -15,7 +15,7 @@ TST_NEEDS_ROOT=1
 
 setup()
 {
-	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)" /proc/mounts | awk 'NR==1{print $3}')"
+	DF_FS_TYPE="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk|fuse)" /proc/mounts | awk 'NR==1{print $3}')"
 }
 
 df_test()
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
