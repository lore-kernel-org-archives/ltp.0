Return-Path: <SRS0=YkbW=OY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F5BC433F5
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 08:40:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4576115C
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 08:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F4576115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 519F23C8009
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 10:40:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E8F73C6815
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 10:40:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D886C600E4E
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 10:40:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 271D820181;
 Mon,  4 Oct 2021 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633336824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+fNYdbY+Ue4HWKNIuqvGXYqipLhpDZYE+vUvfUsm6+Y=;
 b=SDmUBMMqz/H4rwJYgmnntbV3P7LKQmbC9sbimZ06lgN64n5pVA3VLiqYAVISeVJVatFZYk
 LXvfluH0PRcjEoROWcFAn2KlUsNknfClU0dtgs5t/HX9tOnNh+YtaBiXNBs+QMKV8TvKYs
 F2tzyvyR2Fyj/XLDlUl6/yKPJfaco0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633336824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+fNYdbY+Ue4HWKNIuqvGXYqipLhpDZYE+vUvfUsm6+Y=;
 b=9BKM6nCQWmg5VT5+IAMsu1NuYhWvjRMQds/TuIbdrQc0Fbo1S68dTsVjaOxre2kdNFc7EF
 Z3b5RfJUF9LSwvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEA8D139C1;
 Mon,  4 Oct 2021 08:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uypRJve9WmFmIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 04 Oct 2021 08:40:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  4 Oct 2021 10:40:15 +0200
Message-Id: <20211004084015.16100-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] setgroups03: Fix running more iterations (-i 2)
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
[ pvorel: Add const char *uid parameter to use single function, use
SAFE_GETPWNAM() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/setgroups/setgroups03.c   | 37 ++++++++-----------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 490b06996..ecf335a3a 100644
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
+void setup1(const char *uid);	/* setup function to test error EPERM */
 void setup();			/* setup function for the test */
 void cleanup();			/* cleanup function for the test */
 
@@ -95,7 +93,7 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	int list;
 	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
+	void (*setupfunc)(const char *uid);
 } Test_cases[] = {
 	{
 	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
@@ -126,7 +124,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			if (Test_cases[i].setupfunc != NULL) {
-				Test_cases[i].setupfunc();
+				Test_cases[i].setupfunc(nobody_uid);
 			}
 
 			gidsetsize = ngroups_max + Test_cases[i].gsize_add;
@@ -156,8 +154,11 @@ int main(int ac, char **av)
 					 gidsetsize, test_desc, TEST_ERRNO,
 					 Test_cases[i].exp_errno);
 			}
-		}
 
+			if (Test_cases[i].setupfunc != NULL) {
+				Test_cases[i].setupfunc("root");
+			}
+		}
 	}
 
 	cleanup();
@@ -177,7 +178,6 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
-
 }
 
 /*
@@ -187,29 +187,22 @@ void setup(void)
  *  Get the user info. from /etc/passwd file.
  *  This function returns 0 on success.
  */
-int setup1(void)
+void setup1(const char *uid)
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
+	ltpuser = SAFE_GETPWNAM(cleanup, uid);
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
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
