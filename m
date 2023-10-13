Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B944FCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5012B3CD3A9
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:48:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C22693C8DBE
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 12C2D14088EC
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 46B061FD81;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697183289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYrFtcGjDBRzzLXM2dPhmbJGCleL4m974Qcz4pE3tnI=;
 b=ytoCp9huFG2Eyq37HUEC7EDjh0WoLGou4E44nHru5/I9zhQo0SvLexMxl4IgUKCwD7Sc9Q
 JC54BIkYkCueuU7Z2YuNNfWLxa8O3zvWYkHGkY6GucydhkbjxV+pzZlKtKX81HSezqr5xa
 tbxaKzwH16uwyQmanCfRs/YDKMbHx5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697183289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYrFtcGjDBRzzLXM2dPhmbJGCleL4m974Qcz4pE3tnI=;
 b=DFfEKPx9HPu8mGXk2VuFh17/NwDWwN7WXsQNZ+jqOvBRuABvS5WpUVkF2sXbY/5LV/v5WR
 kt7U9UfTKbDZBLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 265E113AA5;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uLBwCDn2KGVqXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 07:48:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 09:47:46 +0200
Message-ID: <20231013074748.702214-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013074748.702214-1-pvorel@suse.cz>
References: <20231013074748.702214-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[17.23%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] madvise11: Replace .needs_drivers with .modprobe
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 36 +------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 3cde85ef5..68f801610 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -47,7 +47,6 @@ static pthread_mutex_t sigbus_received_mtx = PTHREAD_MUTEX_INITIALIZER;
 
 static long pagesize;
 static char beginning_tag[BUFSIZ];
-static int hwpoison_probe;
 
 static void my_yield(void)
 {
@@ -266,22 +265,6 @@ static int populate_from_klog(char *begin_tag, unsigned long *pfns, int max)
  * Read the given file to search for the key.
  * Return 1 if the key is found.
  */
-static int find_in_file(char *path, char *key)
-{
-	char line[4096];
-	int found = 0;
-	FILE *file = SAFE_FOPEN(path, "r");
-
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, key)) {
-			found = 1;
-			break;
-		}
-	}
-	SAFE_FCLOSE(file);
-	return found;
-}
-
 static void unpoison_this_pfn(unsigned long pfn, int fd)
 {
 	char pfn_str[19];
@@ -294,18 +277,10 @@ static void unpoison_this_pfn(unsigned long pfn, int fd)
 static int open_unpoison_pfn(void)
 {
 	char *added_file_path = "/hwpoison/unpoison-pfn";
-	const char *const cmd_modprobe[] = {"modprobe", HW_MODULE, NULL};
 	char debugfs_fp[4096];
 	struct mntent *mnt;
 	FILE *mntf;
 
-	if (!find_in_file("/proc/modules", HW_MODULE) && tst_check_builtin_driver(HW_MODULE))
-		hwpoison_probe = 1;
-
-	/* probe hwpoison only if it isn't already there */
-	if (hwpoison_probe)
-		SAFE_CMD(cmd_modprobe, NULL, NULL);
-
 	/* debugfs mount point */
 	mntf = setmntent("/etc/mtab", "r");
 	if (!mntf) {
@@ -349,7 +324,6 @@ static int open_unpoison_pfn(void)
 static void unpoison_pfn(char *begin_tag)
 {
 	unsigned long *pfns;
-	const char *const cmd_rmmod[] = {"rmmod", HW_MODULE, NULL};
 	int found_pfns, fd;
 
 	pfns = SAFE_MALLOC(sizeof(pfns) * maximum_pfns * run_iterations);
@@ -365,9 +339,6 @@ static void unpoison_pfn(char *begin_tag)
 
 		SAFE_CLOSE(fd);
 	}
-	/* remove hwpoison only if we probed it */
-	if (hwpoison_probe)
-		SAFE_CMD(cmd_rmmod, NULL, NULL);
 }
 
 /*
@@ -417,15 +388,10 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_drivers = (const char *const []) {
+	.modprobe = (const char *const []) {
 		HW_MODULE,
 		NULL
 	},
-	.needs_cmds = (const char *[]) {
-		"modprobe",
-		"rmmod",
-		NULL
-	},
 	.max_runtime = 30,
 	.needs_checkpoints = 1,
 	.setup = setup,
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
