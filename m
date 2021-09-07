Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB6C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:32:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7867F6109F
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7867F6109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1F93C9396
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 13:32:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10ACE3C231C
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 13:32:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E0DC600C97
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 13:32:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 966381FF72
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631014343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bj4HvapsdhHQ0pekipTeU3ajfJCpC18wAn8QRoExi90=;
 b=bYj1A/ccecEooniYupBiTHTwsZ3+7ZhbEexnXoiFw1be7NOAVQ525qQHx+G6j6cNqfgY4m
 zrwK3akhpmhXqoY924bfT4IHKqO98QXaEldTzFeCLRP6PMAtrl3V0fu7Wja7UaisEbWzgr
 +EGRNM8dYm3ChcW5wOvpHPPAsWScYIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631014343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bj4HvapsdhHQ0pekipTeU3ajfJCpC18wAn8QRoExi90=;
 b=OEtEEqRJZ6kAJN3Z00xMZC5/iX6SKClBu6izR8J6JO1jGGhs1UvK0nxGKooGpOikRD/6i6
 kKFfjGGGRGCLJ/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A7013C59
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +AVbH8dNN2EyBQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 07 Sep 2021 11:32:23 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Sep 2021 13:32:19 +0200
Message-ID: <20210907113222.5156-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907113222.5156-1-mdoucha@suse.cz>
References: <20210907113222.5156-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] syscalls/kill05: Use any two unprivileged users
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
Message-ID: <20210907113219.q_Ij5yerRi1nypwCorWzDsFQvrhz_HnopII3C0_niJs@z>

Usernames such as "bin" may not exist on some systems. Find and use any two
unprivileged user IDs for the test instead of specific named users.

Includes minor code style cleanup in wait_for_flag().

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Update to new tst_uid API

 testcases/kernel/syscalls/kill/kill05.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index e694126f6..8ec71be49 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -24,8 +24,9 @@
 #include "libnewipc.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tst_safe_macros.h"
+#include "tst_uid.h"
 
-static uid_t nobody_uid, bin_uid;
+static uid_t test_users[2];
 static int *flag;
 static int shm_id = -1;
 static key_t shm_key;
@@ -35,8 +36,8 @@ static void wait_for_flag(int value)
 	while (1) {
 		if (*flag == value)
 			break;
-		else
-			usleep(100);
+
+		usleep(100);
 	}
 }
 
@@ -47,14 +48,14 @@ static void do_master_child(void)
 	*flag = 0;
 	pid1 = SAFE_FORK();
 	if (pid1 == 0) {
-		SAFE_SETREUID(nobody_uid, nobody_uid);
+		SAFE_SETREUID(test_users[0], test_users[0]);
 		*flag = 1;
 		wait_for_flag(2);
 
 		exit(0);
 	}
 
-	SAFE_SETREUID(bin_uid, bin_uid);
+	SAFE_SETREUID(test_users[1], test_users[1]);
 	wait_for_flag(1);
 	TEST(kill(pid1, SIGKILL));
 
@@ -85,17 +86,10 @@ static void verify_kill(void)
 
 static void setup(void)
 {
-	struct passwd *pw;
-
 	shm_key = GETIPCKEY();
 	shm_id = SAFE_SHMGET(shm_key, getpagesize(), 0666 | IPC_CREAT);
 	flag = SAFE_SHMAT(shm_id, 0, 0);
-
-	pw = SAFE_GETPWNAM("nobody");
-	nobody_uid = pw->pw_uid;
-
-	pw = SAFE_GETPWNAM("bin");
-	bin_uid = pw->pw_uid;
+	tst_get_uids(test_users, 0, 2);
 }
 
 static void cleanup(void)
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
