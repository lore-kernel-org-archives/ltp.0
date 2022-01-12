Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EE0C433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 13:23:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BA243C9534
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 14:23:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 149CA3C94AA
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 17:20:14 +0100 (CET)
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 471C62001D5
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 17:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=9/3hr+Dr7XbVSBz4JGfgVWwnYj5nFi/A329OH3uaPSg=; b=QLCZBskIz2HJ
 xH+1YJ1BFKT/EDJdJoolSjTg2dWiOhbt24vR96Jt3rDST3IuQW4OEMTmcNCsCaQ8ckGc1cbqJATjH
 vdcCKL+vQAUc5Xgx4NvYSuM08zZiuf/B1nGls413fCCpDNORjb/Vd+ZBO3n2Ac3SHiGE5seO4Mrvd
 yvBNo=;
Received: from [192.168.15.37] (helo=cobook.home)
 by relay.sw.ru with esmtp (Exim 4.94.2)
 (envelope-from <nikita.yushchenko@virtuozzo.com>)
 id 1n7gLn-0065uv-ED; Wed, 12 Jan 2022 19:19:51 +0300
To: ltp@lists.linux.it
Date: Wed, 12 Jan 2022 19:19:41 +0300
Message-Id: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 13 Jan 2022 14:23:20 +0100
Subject: [LTP] [PATCH] nfs_flock: fail the test if lock/unlock ops fail
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
From: Nikita Yushchenko via ltp <ltp@lists.linux.it>
Reply-To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since nfs_flock is testing locking operations, ignoring errors returned
from those operations is nonsense.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 testcases/network/nfs/nfslock01/nfs_flock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
index a7673c751..a13ddd251 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock.c
@@ -63,16 +63,20 @@ int main(int argc, char **argv)
 				continue;
 		}
 
-		if (writeb_lock(fd, offset, SEEK_SET, BYTES) < 0)
-			printf("failed in writeb_lock, Errno = %d", errno);
+		if (writeb_lock(fd, offset, SEEK_SET, BYTES) < 0) {
+			printf("failed in writeb_lock, Errno = %d\n", errno);
+			exit(1);
+		}
 
 		lseek(fd, offset, SEEK_SET);
 
 		/* write to the test file */
 		write(fd, buf, BYTES);
 
-		if (unb_lock(fd, offset, SEEK_SET, BYTES) < 0)
-			printf("failed in unb_lock, Errno = %d", errno);
+		if (unb_lock(fd, offset, SEEK_SET, BYTES) < 0) {
+			printf("failed in unb_lock, Errno = %d\n", errno);
+			exit(1);
+		}
 	}
 	exit(0);
 }
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
