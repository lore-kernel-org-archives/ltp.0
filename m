Return-Path: <SRS0=B/OF=O4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B8C433F5
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 10:00:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F8D61027
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 10:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88F8D61027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BB823C7A10
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 12:00:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6273C1C56
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 12:00:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84EAA1001564
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 12:00:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF2E71FD74;
 Fri,  8 Oct 2021 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633687228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=n3D7azYCtTXHDZ4ZL2o0UPywLukUxjZICB/0Y/RY5XM=;
 b=OyAJk1uLMvBDqB/KinSq9IZXGbo4ImAoXVTKyQyTV6InKSEhSrAuzOwNC+xuJdOFARjduO
 m0lzl6fq0HA06Yy6PuXrNTS0PAy71pK33KIlasuESUBAhq1M6t0c713M2SCkv2eq3W+C7c
 Rf2KzT4ps+Tge1UTdUQDH74IGGYkn5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633687228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=n3D7azYCtTXHDZ4ZL2o0UPywLukUxjZICB/0Y/RY5XM=;
 b=QvhYBTaCa/WdfP/bGb02/bWqYLhb57bPP7WM6NLOhz6oE5Qm03lMf6e+lKVtvLjqVQnUBF
 V90XzyYdF/oHk6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FEE013E50;
 Fri,  8 Oct 2021 10:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BkSQHbwWYGF3FgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 10:00:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Oct 2021 12:00:24 +0200
Message-Id: <20211008100024.24351-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] setgroups03: Fix running more iterations (-i 2)
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

From: Zhao Gongyi <zhaogongyi@huawei.com>

When run the test with option "-i 2", test will fail and
report "setgroups03.c:157: setgroups(65537) fails, Size
is > sysconf(_SC_NGROUPS_MAX), errno=1, expected errno=22".

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
[ pvorel: Add parameters to setup1() to use single function, use
SAFE_GETPWNAM() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3.
* move ltpuser = SAFE_GETPWNAM(cleanup, uid); to setup() (Cyril)
* add second parameter uid_t euid to setup1() (Cyril)

Kind regards,
Petr

 .../kernel/syscalls/setgroups/setgroups03.c   | 38 ++++++++-----------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 490b06996..21894d5af 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -73,11 +73,9 @@
 #include <grp.h>
 
 #include "test.h"
-
+#include "safe_macros.h"
 #include "compat_16.h"
 
-#define TESTUSER	"nobody"
-
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
 
@@ -86,7 +84,7 @@ int TST_TOTAL = 2;
 
 GID_T *groups_list;		/* Array to hold gids for getgroups() */
 
-int setup1();			/* setup function to test error EPERM */
+void setup1(const char *uid, uid_t euid);	/* setup function to test error EPERM */
 void setup();			/* setup function for the test */
 void cleanup();			/* cleanup function for the test */
 
@@ -95,7 +93,7 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	int list;
 	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
+	void (*setupfunc)(const char *uid, uid_t euid);
 } Test_cases[] = {
 	{
 	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
@@ -126,7 +124,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			if (Test_cases[i].setupfunc != NULL) {
-				Test_cases[i].setupfunc();
+				Test_cases[i].setupfunc(nobody_uid, ltpuser->pw_uid);
 			}
 
 			gidsetsize = ngroups_max + Test_cases[i].gsize_add;
@@ -156,8 +154,11 @@ int main(int ac, char **av)
 					 gidsetsize, test_desc, TEST_ERRNO,
 					 Test_cases[i].exp_errno);
 			}
-		}
 
+			if (Test_cases[i].setupfunc != NULL) {
+				Test_cases[i].setupfunc("root", ltpuser->pw_uid);
+			}
+		}
 	}
 
 	cleanup();
@@ -176,8 +177,9 @@ void setup(void)
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM(cleanup, uid);
 
+	TEST_PAUSE;
 }
 
 /*
@@ -187,29 +189,21 @@ void setup(void)
  *  Get the user info. from /etc/passwd file.
  *  This function returns 0 on success.
  */
-int setup1(void)
+void setup1(const char *uid, uid_t euid)
 {
-	struct passwd *user_info;	/* struct. to hold test user info */
-
-/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setreuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setreuid");
-	}
+	struct passwd *user_info;
 
-	if ((user_info = getpwnam(TESTUSER)) == NULL) {
-		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
-	}
+	SAFE_SETEUID(cleanup, euid);
+
+	user_info = SAFE_GETPWNAM(cleanup, uid);
 
 	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
 		tst_brkm(TBROK,
 			 cleanup,
 			 "gid returned from getpwnam is too large for testing setgroups16");
 	}
+
 	groups_list[0] = user_info->pw_gid;
-	return 0;
 }
 
 /*
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
