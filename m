Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6E3C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:41:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79A7A3CAA07
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:41:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D61F53CA9C2
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A9981000B54
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16EDE1F893;
 Thu, 12 May 2022 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcQNNwrZ/PB+L5Xe7BnLv+EL+ON2302NtoNu4l8i1x4=;
 b=fcoQA2aY4yGsrb9zDHFABNV01CMKFvVaM0GRVstVmtUW0vIcXfki5RxH3F8Hm3OYoEihhP
 nfWqkYO8meubXBSO4R/iiGYusmTna1YXSOjPIzlTiTTqmCzJ4qEQd4LW2WxRQVDrGFjbTp
 5LQHgFqs23wYf8wtOpQ4ojjmdO9otWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcQNNwrZ/PB+L5Xe7BnLv+EL+ON2302NtoNu4l8i1x4=;
 b=p82m6gUzKyxZep72LJ9qkrKPYhPJQfq9DQjZ8CDybL4EGDSFHq90KebC14h8Rq/GhsVjyi
 MOl0YD3MaeRr2vDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04BA413ABE;
 Thu, 12 May 2022 12:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XftCAEH/fGJmGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:15 +0200
Message-Id: <20220512123816.24399-29-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 28/29] ltp-aiodio/aiodio_append: Convert to runtime
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
index 46cc74ee4..bf1665e0c 100644
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
+	.max_runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"s:", &str_writesize, "Size of the file to write (default 64K)"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
