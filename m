Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76326C61DA3
	for <ltp@archiver.kernel.org>; Sat,  4 Mar 2023 02:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 525933CC4D7
	for <ltp@archiver.kernel.org>; Sat,  4 Mar 2023 03:03:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 599593CAF16
 for <ltp@lists.linux.it>; Sat,  4 Mar 2023 03:03:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D6FF1400B88
 for <ltp@lists.linux.it>; Sat,  4 Mar 2023 03:03:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31A361F88E;
 Sat,  4 Mar 2023 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677895401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQF997iff205y0eP5fMkH3hvAzgBMW0cP5ZSvkn6EQE=;
 b=TFzv6IW+vLR+s8AHNDVlt8AHl/jm7s3fBIql2Vvhs67qHEUClJ2ibCM9YRT+eUusllwYSh
 7JDlJ9gkqtCFcprpHQbzKfIGsSnGr6vnY2hpWvNo7CzTwuYgT1kO82gy0KyBMxwsoVAIny
 TxYwAPbcK+gGfN+hBbahQd+G4ODBjts=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 293311346F;
 Sat,  4 Mar 2023 02:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FFHcOeemAmQlLwAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 04 Mar 2023 02:03:19 +0000
To: ltp@lists.linux.it
Date: Fri,  3 Mar 2023 21:03:15 -0500
Message-Id: <20230304020315.4958-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230302014519.31512-1-wegao@suse.com>
References: <20230302014519.31512-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] fsconfig03: SKIP check return value for old kernel
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

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/fsconfig/fsconfig03.c     | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index 7ee37f4ae..f421b5802 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -22,36 +22,47 @@
 #define MNTPOINT	"mntpoint"
 
 static int fd = -1;
+static long pagesize;
 
 static void setup(void)
 {
-	fsopen_supported_by_kernel();
-}
+	pagesize = sysconf(_SC_PAGESIZE);
 
-static void run(void)
-{
-	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
-	long pagesize;
+	if (pagesize == -1)
+		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
+
+	fsopen_supported_by_kernel();
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1)
 		tst_brk(TBROK | TTERRNO, "fsopen() failed");
+}
 
-	pagesize = sysconf(_SC_PAGESIZE);
-	if (pagesize == -1)
-		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
+static void do_fsconfig(size_t i)
+{
+	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
 
-	for (size_t i = 0; i < 5000; i++) {
-		/* use same logic in kernel legacy_parse_param function */
-		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
+	/* use same logic in kernel legacy_parse_param function */
+	const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
 
+	if ((tst_kvercmp(5, 17, 0)) >= 0) {
 		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
 			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
 		else
 			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
-					    EINVAL);
+					EINVAL);
+	} else {
+		fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0);
 	}
 
+}
+
+static void run(void)
+{
+
+	for (size_t i = 0; i < 5000; i++)
+		do_fsconfig(i);
+
 	if (fd != -1)
 		SAFE_CLOSE(fd);
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
