Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AF4C001B0
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:56:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2418F3CD054
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:56:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A790E3C89B6
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C9421400452
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC4A81F459
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQS8Uzww3HQ0/XobznIZGyRe79qMWJo2hX3T+geqwY4=;
 b=VnOI96o1FmpWezyTgDn7yGuYpBzX3fLjwi46a3aVN4xKpows413c8qzjmZFrhUDDH8XV9R
 s3fYTsoqo+MiYwQ99yf8dEM2RIRVffwM+X14tncbGA/EBTRUaDnDBem8u1I9lB5FFhYkxq
 Ja1prbFsIWgqWWITGSxjWEASAjNdX68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQS8Uzww3HQ0/XobznIZGyRe79qMWJo2hX3T+geqwY4=;
 b=w15TK23G0p8ab063qTujGzme31RYmjTzNosRTdiinroYyOn8/oCRksXVy1LPegaRgpTQaf
 3MlL5jAI+delryBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8179138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NaOeL8Mh1mQFWwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:43 +0200
Message-ID: <20230811115647.32387-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] syscalls/access04: Make use of guarded buffers
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/access/access04.c | 36 +++++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index 424fe6f10..b5764a5dd 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -40,26 +40,32 @@
 #define SNAME1	"symlink1"
 #define SNAME2	"symlink2"
 #define MNT_POINT	"mntpoint"
+#define LONGPATHSIZE (PATH_MAX + 2)
 
 static uid_t uid;
-static char longpathname[PATH_MAX + 2];
+static char *longpathname;
+static char *fname1;
+static char *fname2;
+static char *sname1;
+static char *empty_fname;
+static char *mnt_point;
 
 static struct tcase {
-	const char *pathname;
+	char **pathname;
 	int mode;
 	int exp_errno;
 } tcases[] = {
-	{FNAME1, -1, EINVAL},
-	{"", W_OK, ENOENT},
-	{longpathname, R_OK, ENAMETOOLONG},
-	{FNAME2, R_OK, ENOTDIR},
-	{SNAME1, R_OK, ELOOP},
-	{MNT_POINT, W_OK, EROFS}
+	{&fname1, -1, EINVAL},
+	{&empty_fname, W_OK, ENOENT},
+	{&longpathname, R_OK, ENAMETOOLONG},
+	{&fname2, R_OK, ENOTDIR},
+	{&sname1, R_OK, ELOOP},
+	{&mnt_point, W_OK, EROFS}
 };
 
 static void access_test(struct tcase *tc, const char *user)
 {
-	TST_EXP_FAIL(access(tc->pathname, tc->mode), tc->exp_errno,
+	TST_EXP_FAIL(access(*tc->pathname, tc->mode), tc->exp_errno,
 	             "access as %s", user);
 }
 
@@ -87,7 +93,8 @@ static void setup(void)
 
 	uid = pw->pw_uid;
 
-	memset(longpathname, 'a', sizeof(longpathname) - 1);
+	memset(longpathname, 'a', LONGPATHSIZE - 1);
+	longpathname[LONGPATHSIZE-1] = 0;
 
 	SAFE_TOUCH(FNAME1, 0333, NULL);
 	SAFE_TOUCH(DNAME, 0644, NULL);
@@ -104,4 +111,13 @@ static struct tst_test test = {
 	.mntpoint = MNT_POINT,
 	.setup = setup,
 	.test = verify_access,
+	.bufs = (struct tst_buffers []) {
+		{&fname1, .str = FNAME1},
+		{&fname2, .str = FNAME2},
+		{&sname1, .str = SNAME1},
+		{&empty_fname, .str = ""},
+		{&longpathname, .size = LONGPATHSIZE},
+		{&mnt_point, .str = MNT_POINT},
+		{}
+	}
 };
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
