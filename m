Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D62C61DA4
	for <ltp@archiver.kernel.org>; Sun, 12 Mar 2023 00:44:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7B703CD747
	for <ltp@archiver.kernel.org>; Sun, 12 Mar 2023 01:44:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D7EC3CA8D8
 for <ltp@lists.linux.it>; Sun, 12 Mar 2023 01:44:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2781B1000524
 for <ltp@lists.linux.it>; Sun, 12 Mar 2023 01:44:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 913641FDE7;
 Sun, 12 Mar 2023 00:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678581873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOGHGY7GGt2fOFNPwP4VZKmameiKP3iUpRXygA5/4Q8=;
 b=OtUnGA9kGPH7+rsMDwR5nkJ6pu36s/p8ZaibmaKd0oWSqg3VB2SPF5s5Los04gFFltmcIG
 ChjLoDMpEtQQysJt2jYT/BEMEdcjRAYLP5eAc7st5Ed+kqCybVmIk4ao8xzXHvAJPWkdZj
 x4fxSL3AVYtNCquOrn4pSE1kco1BCm0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA2AD1377A;
 Sun, 12 Mar 2023 00:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wyoWMHAgDWTYPQAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 12 Mar 2023 00:44:32 +0000
To: ltp@lists.linux.it
Date: Sat, 11 Mar 2023 19:44:20 -0500
Message-Id: <20230312004420.16457-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230311023343.25177-1-wegao@suse.com>
References: <20230311023343.25177-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] madvise11.c:Check loadable module before rmmod
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

So need add extra check.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 7e291d571..18e120115 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -33,6 +33,7 @@
 #define NUM_LOOPS	5
 #define NUM_PAGES	32
 #define NUM_PAGES_OFFSET	5
+#define MAX_BUF 4094
 
 /* Needed module to online back memory pages */
 #define HW_MODULE	"hwpoison_inject"
@@ -291,6 +292,29 @@ static void unpoison_this_pfn(unsigned long pfn, int fd)
 	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
 }
 
+static int is_builtin(const char *modname)
+{
+	char command[MAX_BUF];
+	char line[MAX_BUF];
+
+	sprintf(command, "modinfo %s | grep '^filename'", modname);
+
+	FILE *fp = popen(command, "r");
+
+	if (fp == NULL)
+		tst_brk(TBROK, "Popen command %s failed", command);
+
+	if (fgets(line, MAX_BUF, fp) != NULL) {
+		if (strstr(line, "builtin")) {
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
@@ -300,7 +324,7 @@ static int open_unpoison_pfn(void)
 	struct mntent *mnt;
 	FILE *mntf;
 
-	if (!find_in_file("/proc/modules", HW_MODULE))
+	if (!find_in_file("/proc/modules", HW_MODULE) && !is_builtin(HW_MODULE))
 		hwpoison_probe = 1;
 
 	/* probe hwpoison only if it isn't already there */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
