Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB498C04A97
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 15:32:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C34BB3CE3E0
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 17:31:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89D23CA8C7
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:31:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ECE681A005E9
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:31:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F12721FAE;
 Wed, 20 Sep 2023 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695223907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wYejQuGhv980296BGhVibjQBNET8tSs0mXeXEDQrUz4=;
 b=l0r5+Z3yKX4eoLEBJY2eOgbnaOvZpBS/DQ6ocZboJJqHrnjecjpQn8N2rGHX4WAYNYiVCE
 v/g2zIVE2UPVD0x2xMTVbzLmy6zCRELOgdD/Z7mbOGLUwMMXpEUdR/EAbO7zF5Vf800gj1
 E3Pzq8K3VaVeLTsT+9Rg6fDoj0tHWOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695223907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wYejQuGhv980296BGhVibjQBNET8tSs0mXeXEDQrUz4=;
 b=8iSc30PCQIMGrpgXCw+iXJw6NNo03XapKbuDyv6Q5aGsGOuYxiESq7qRRvj9hN/wrWn0Io
 GMSFL/6V5PZvPTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0B7132C7;
 Wed, 20 Sep 2023 15:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YcIvDWMQC2UpSAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 20 Sep 2023 15:31:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
	ltp@lists.linux.it
Date: Wed, 20 Sep 2023 17:31:40 +0200
Message-ID: <20230920153145.30891-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pidns05: Use tst_getpid()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Older glibc versions cache getpid() results. Calling clone() through
the direct syscall interface (bypassing glibc) with the CLONE_NEWPID
argument will result in stale getpid() cache and the test will fail.
Use tst_getpid() instead to get the correct PID value.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/containers/pidns/pidns05.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index ec9ce9bf2..0e7739aaa 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -28,7 +28,7 @@ static void child_func(int *level)
 {
 	pid_t cpid, ppid;
 
-	cpid = getpid();
+	cpid = tst_getpid();
 	ppid = getppid();
 
 	TST_EXP_EQ_LI(cpid, 1);
@@ -55,7 +55,7 @@ static int find_cinit_pids(pid_t *pids)
 	int next = 0;
 	pid_t parentpid, pgid, pgid2;
 
-	parentpid = getpid();
+	parentpid = tst_getpid();
 	pgid = SAFE_GETPGID(parentpid);
 
 	for (pid = 2; pid < pid_max; pid++) {
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
