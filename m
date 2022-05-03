Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D258C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:50:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 859C53CAD55
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:50:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 848F63CA988
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EA75600454
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9B041F74D;
 Tue,  3 May 2022 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxhkL+Ij5MfRe10XTlsdSTInT7Zog/VXU6Y3/N3ClXA=;
 b=UWcPKtla+D2jVTBujOXX9dvq7Jo5P4cF6+tbBzD7v0BGt+uHSB/ZpqyC+UUDm2V4mbbS7q
 tKfMKkomdSQYAEA55h9eDGXM7cqMaWMdwD96rp4P5YNDdwgwMg4dsRqEIvU4EtKUmXHr8K
 MgqqDJgNPnQfvLLR2iIVwpo4WuxNnjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxhkL+Ij5MfRe10XTlsdSTInT7Zog/VXU6Y3/N3ClXA=;
 b=eOShTG2LLy5RCVoZj6wVuHqE6jPfWFKPX4qzNOPvidn/HVJIZrMmmuScHeHIT7izTGx1+L
 nwDF7T2HLwgPmMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99B5F13ABE;
 Tue,  3 May 2022 17:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QGjMIi1qcWItPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:16 +0200
Message-Id: <20220503174718.21205-29-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 28/30] ltp-aiodio/aiodio_append: Convert to runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cap the test runtime on 30 minutes by default.

For this to work we have to run the process that issues the aio requests
in a child process and kill it when runtime is over.

CC: Andrea Cervesato <andrea.cervesato@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/io/ltp-aiodio/aiodio_append.c      | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 46cc74ee4..4bb95189c 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -141,7 +141,7 @@ static void run(void)
 {
 	char *filename = "aiodio_append";
 	int status;
-	int i;
+	int i, pid;
 
 	*run_child = 1;
 
@@ -152,9 +152,27 @@ static void run(void)
 		}
 	}
 
-	tst_res(TINFO, "Parent append to file");
+	pid = SAFE_FORK();
+	if (!pid) {
+		aiodio_append(filename, appends, alignment, writesize, numaio);
+		return;
+	}
+
+	tst_res(TINFO, "Child %i appends to a file", pid);
+
+	for (;;) {
+		if (SAFE_WAITPID(pid, NULL, WNOHANG))
+			break;
 
-	aiodio_append(filename, appends, alignment, writesize, numaio);
+		sleep(1);
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Test out of runtime, exitting");
+			kill(pid, SIGKILL);
+			SAFE_WAITPID(pid, NULL, 0);
+			break;
+		}
+	}
 
 	if (SAFE_WAITPID(-1, &status, WNOHANG))
 		tst_res(TFAIL, "Non zero bytes read");
@@ -172,6 +190,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.max_iteration_runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"s:", &str_writesize, "Size of the file to write (default 64K)"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
