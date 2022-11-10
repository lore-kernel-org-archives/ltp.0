Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788A2C433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 13:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE9613CD619
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 14:55:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EDCA3CD619
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 14:54:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0006C600468
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 14:54:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B14422AA1
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668088498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mz9I9QWPxueFDhdE2r9nIV+h6CwFjNWwVoEXfsh73kA=;
 b=qcQ7ii6VUJZfq/8ghVHqsbwB0mrl9ZQxcengD5ugO+4e3ETQJ8ceeFvcjWGe1WYpAAxWrd
 jV56UKZ3JtXNZtZLS3zFvQeNSpJl6meXSqra4EKuJjFTor1onI/rnvwYElr1SpZF/45odE
 IU8my7NZJHt//+G/uIppHhbaZxyHeVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668088498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mz9I9QWPxueFDhdE2r9nIV+h6CwFjNWwVoEXfsh73kA=;
 b=8oJ0vWfhdEPH+R4u78iTTU12shti67aId4ROspYjt4LZkeXOvC0OfKzqSJ6igFubB1LUIu
 VOnEf5nFMx5g+qCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF7D91332F
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 13:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E3CcObECbWOxDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 13:54:57 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Nov 2022 14:54:42 +0100
Message-Id: <20221110135442.14501-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Allow graceful subtest cleanup in shell tests
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

The new shell test timeout code sends SIGTERM to any subprocesses when
the main script hits timeout. SIGTERM isn't handled by the LTP library
which means that tools like netstress will be instantly killed without
performing any cleanup. Handle SIGTERM like SIGINT in LTP library
to allow graceful cleanup.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Note: The current lack of graceful cleanup causes random failures in shell
tests which run the same tool many times (e.g. netstress). When the PID
counter wraps around and the tool accidentally gets the same PID as another
process that got killed by SIGTERM, the new test process will fail during IPC
setup.

 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b225ba082..1732fd058 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1568,6 +1568,7 @@ static int fork_testrun(void)
 	int status;
 
 	SAFE_SIGNAL(SIGINT, sigint_handler);
+	SAFE_SIGNAL(SIGTERM, sigint_handler);
 
 	alarm(results->timeout);
 
@@ -1579,6 +1580,7 @@ static int fork_testrun(void)
 		tst_disable_oom_protection(0);
 		SAFE_SIGNAL(SIGALRM, SIG_DFL);
 		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
+		SAFE_SIGNAL(SIGTERM, SIG_DFL);
 		SAFE_SIGNAL(SIGINT, SIG_DFL);
 		SAFE_SETPGID(0, 0);
 		testrun();
@@ -1586,6 +1588,7 @@ static int fork_testrun(void)
 
 	SAFE_WAITPID(test_pid, &status, 0);
 	alarm(0);
+	SAFE_SIGNAL(SIGTERM, SIG_DFL);
 	SAFE_SIGNAL(SIGINT, SIG_DFL);
 
 	if (tst_test->taint_check && tst_taint_check()) {
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
