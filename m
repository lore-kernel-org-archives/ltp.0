Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78F3C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 13:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD09C3C951E
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 14:24:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBCDA3C94AA
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 17:20:27 +0100 (CET)
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 799CF1000F46
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 17:20:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=G2oMji5+tKY6Dil6FZfOtV4m1yR0of2cxZlz6SkEpRk=; b=AiCCuts77e7n
 PfoY/O9SUpBMHwfxICtjCrl4u5KhYkjSI2I9x16+ZanRpADDxX6GwHD1Svq8bUSfh9BN1YRB3TYhn
 Xgijpps+kDyXTHsJIDr//98wMyrdwj/ql7dTqSA4VYOR2Pv/hDuRogTviQPAJ/GwTkghCAY4ycim7
 nrrB8=;
Received: from [192.168.15.37] (helo=cobook.home)
 by relay.sw.ru with esmtp (Exim 4.94.2)
 (envelope-from <nikita.yushchenko@virtuozzo.com>)
 id 1n7gM2-0065uv-Uy; Wed, 12 Jan 2022 19:20:07 +0300
To: ltp@lists.linux.it
Date: Wed, 12 Jan 2022 19:19:42 +0300
Message-Id: <20220112161942.4065665-2-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 13 Jan 2022 14:23:20 +0100
Subject: [LTP] [PATCH] nfs_lib.sh: run exportfs at "server side" in
 LTP_NETNS case
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

In LTP_NETNS case, nfs server is the root namespace and nfs client is
the ltp namespace.

Then, exportfs shall be executed locally, without tst_rhost_run.

Otherwise, things implicitly depend on /var/lib/nfs being the same in
the root namespace and the ltp namespace.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index b01215136..b50ccf196 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -81,8 +81,14 @@ nfs_setup_server()
 {
 	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
 
-	if ! tst_rhost_run -c "test -d $remote_dir"; then
-		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
+	if [ -n "$LTP_NETNS" ]; then
+		if ! test -d $remote_dir; then
+			mkdir -p $remote_dir; $export_cmd
+		fi
+	else
+		if ! tst_rhost_run -c "test -d $remote_dir"; then
+			tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
+		fi
 	fi
 }
 
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
