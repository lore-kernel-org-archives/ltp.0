Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E452C433FE
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 13:24:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2D1F3C8C62
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 14:24:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F7E43C88E7
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 14:23:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 04A011000F25
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 14:23:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 40EBA212B6;
 Mon, 13 Dec 2021 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639401831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0ixrMPTmSGUJ/7ziNaEypkXN6aZVxcg32lZusTeWy8=;
 b=HuNKbUwL4UR80hrxao7UgI/gBk1a//T2mKQQyMgCBSxMNunbY31bJbzwDJDo03vl8eSuZq
 HUgwwn1AF+aZ2yfSCiuqPT7TvvoGNsbBBp90ZBAwFKu/WmOBd/sVa/avuW7xYPSWLOLX9y
 8LQFc9kukITdg/Rk+eTsvhWs6rwZ1gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639401831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0ixrMPTmSGUJ/7ziNaEypkXN6aZVxcg32lZusTeWy8=;
 b=FCL5vg8xe/yJtXyrpOEHdDGow/ZKSH9HtzR+YRlYZn7d/tqRwfTCYvAcjrh8a3jDemT3XM
 WUfJSdVx3cKdmEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0457513AFF;
 Mon, 13 Dec 2021 13:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gLyDOmZJt2GLDQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 13:23:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 14:23:39 +0100
Message-Id: <20211213132339.22770-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213132339.22770-1-pvorel@suse.cz>
References: <20211213132339.22770-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] chdir01.c: Minor cleanup
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

1) print tested item (readability)
2) define TESTUSER (DRY)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 5819998484..228f6daf44 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -25,6 +25,7 @@
 #define BLOCKED_NAME "keep_out"
 #define LINK_NAME1 "symloop"
 #define LINK_NAME2 "symloop2"
+#define TESTUSER  "nobody"
 
 static char *workdir;
 static int skip_symlinks, blocked_perm;
@@ -78,7 +79,7 @@ static void setup(void)
 	SAFE_CLOSE(fd);
 
 	if (!ltpuser)
-		ltpuser = SAFE_GETPWNAM("nobody");
+		ltpuser = SAFE_GETPWNAM(TESTUSER);
 }
 
 static void check_result(const char *user, const char *name, int retval,
@@ -106,6 +107,8 @@ static void run(unsigned int n)
 {
 	struct test_case *tc = testcase_list + n;
 
+	tst_res(TINFO, "Testing '%s'", tc->name);
+
 	if (tc->root_err == ELOOP && skip_symlinks) {
 		tst_res(TCONF, "Skipping symlink loop test, not supported");
 		return;
@@ -135,7 +138,7 @@ static void run(unsigned int n)
 	SAFE_SETEUID(ltpuser->pw_uid);
 	TEST(chdir(tc->name));
 	SAFE_SETEUID(0);
-	check_result("nobody", tc->name, tc->nobody_ret, tc->nobody_err);
+	check_result(TESTUSER, tc->name, tc->nobody_ret, tc->nobody_err);
 }
 
 static void cleanup(void)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
