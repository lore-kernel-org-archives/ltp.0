Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B62C6FA99
	for <ltp@archiver.kernel.org>; Sat, 11 Mar 2023 02:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 994103CD80C
	for <ltp@archiver.kernel.org>; Sat, 11 Mar 2023 03:34:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE4583CB5F9
 for <ltp@lists.linux.it>; Sat, 11 Mar 2023 03:33:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0399F1400964
 for <ltp@lists.linux.it>; Sat, 11 Mar 2023 03:33:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09A8B21836;
 Sat, 11 Mar 2023 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678502036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50BJscTp4VismM9lPR+BQGqK4srZvFILmKSy26wnt9M=;
 b=FjsY5srNkFA2xyl2buqd7qpi70NSoOD1HimO7Q++8qa1PIcBWQh3cTpTIuXHgLBkrIOyD8
 0QauQ8QMwWBWqEvHvLuyOuJ2WQb8AqG/WhvuTKkM+WhC+TZc0e9/9N86qqvs514gqwVnyg
 yr/HQVo8Mqu2t2vVTdBYH+fEIZdU9OI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DBD71377A;
 Sat, 11 Mar 2023 02:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5Z7zDJPoC2RSUwAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 11 Mar 2023 02:33:55 +0000
To: ltp@lists.linux.it
Date: Fri, 10 Mar 2023 21:33:43 -0500
Message-Id: <20230311023343.25177-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230310140407.20137-1-wegao@suse.com>
References: <20230310140407.20137-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] madvise11.c:Check loadable module before rmmod
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following fail msg will popup if we try to rmmod buildin module:
rmmod: ERROR: Module hwpoison_inject is builtin

Before rmmod we should check this module can be rmmod or not.
Every modules which can show in lsmod output, it means the module can be unload.

But for output of /proc/modules i am not sure it can contain ONLY loadable module.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 7e291d571..bac077fc8 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -33,6 +33,7 @@
 #define NUM_LOOPS	5
 #define NUM_PAGES	32
 #define NUM_PAGES_OFFSET	5
+#define MAX_BUF 4094
 
 /* Needed module to online back memory pages */
 #define HW_MODULE	"hwpoison_inject"
@@ -291,6 +292,31 @@ static void unpoison_this_pfn(unsigned long pfn, int fd)
 	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
 }
 
+static int is_loadable_module(const char *modname)
+{
+	char command[MAX_BUF];
+	char line[MAX_BUF];
+	char *token;
+
+	sprintf(command, "lsmod | grep '^%s'", modname);
+
+	FILE *fp = popen(command, "r");
+
+	if (fp == NULL)
+		tst_brk(TBROK, "Popen command %s failed", command);
+
+	if (fgets(line, MAX_BUF, fp) != NULL) {
+		token = strtok(line, " \t\n");
+		if (strcmp(token, modname) == 0) {
+			pclose(fp);
+			return 1;
+		}
+	}
+
+	pclose(fp);
+	return 0;
+}
+
 /* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
 static int open_unpoison_pfn(void)
 {
@@ -337,6 +363,7 @@ static void unpoison_pfn(char *begin_tag)
 	unsigned long *pfns;
 	const char *const cmd_rmmod[] = {"rmmod", HW_MODULE, NULL};
 	int found_pfns, fd;
+	int is_loadable = -1;
 
 	pfns = SAFE_MALLOC(sizeof(pfns) * maximum_pfns * run_iterations);
 
@@ -351,8 +378,9 @@ static void unpoison_pfn(char *begin_tag)
 
 		SAFE_CLOSE(fd);
 	}
-	/* remove hwpoison only if we probed it */
-	if (hwpoison_probe)
+	/* remove hwpoison only if we probed it and not built in*/
+	is_loadable = is_loadable_module(HW_MODULE);
+	if (hwpoison_probe && (is_loadable == 1))
 		SAFE_CMD(cmd_rmmod, NULL, NULL);
 }
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
