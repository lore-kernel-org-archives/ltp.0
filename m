Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E51C54788
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 15:32:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3540F3D007C
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 16:32:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28BA33CD507
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 16:32:19 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78468603460
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 16:32:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70FC122193;
 Thu, 22 Feb 2024 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708615938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUKW6VEGnciLE78LecHCakFEk6mCM0IdJ35XAXwNphw=;
 b=dEZ2xJ4n0IUZmbKyYsbbBZWq/93h+0pTyKxHMwd0HpTk6nBknJoDJnSa16tm9h0glARsVj
 0xa8ygU2lk5H+0MBOdZsd678KW2NTZuBdu9CC5AcAgTXw8ZcM4gpGGWY5xsSX4V7MEb1Yy
 sIAGCtFW+oEIj1gW8thnCxloCrgXoT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708615938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUKW6VEGnciLE78LecHCakFEk6mCM0IdJ35XAXwNphw=;
 b=c3WnDD8VD59CVpahaelkcp5d78HG90nR7N4H9qmI65QB20PTlGK4Y9GnPI4OjhwN2jXCbp
 cUnxK3IilfDiexBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708615938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUKW6VEGnciLE78LecHCakFEk6mCM0IdJ35XAXwNphw=;
 b=dEZ2xJ4n0IUZmbKyYsbbBZWq/93h+0pTyKxHMwd0HpTk6nBknJoDJnSa16tm9h0glARsVj
 0xa8ygU2lk5H+0MBOdZsd678KW2NTZuBdu9CC5AcAgTXw8ZcM4gpGGWY5xsSX4V7MEb1Yy
 sIAGCtFW+oEIj1gW8thnCxloCrgXoT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708615938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUKW6VEGnciLE78LecHCakFEk6mCM0IdJ35XAXwNphw=;
 b=c3WnDD8VD59CVpahaelkcp5d78HG90nR7N4H9qmI65QB20PTlGK4Y9GnPI4OjhwN2jXCbp
 cUnxK3IilfDiexBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54EA113A8C;
 Thu, 22 Feb 2024 15:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iFVYEwJp12UeWAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 22 Feb 2024 15:32:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 22 Feb 2024 16:32:17 +0100
Message-Id: <20240222153217.1046-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dEZ2xJ4n;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c3WnDD8V
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.82 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.67)[98.53%]
X-Rspamd-Queue-Id: 70FC122193
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add more testcases in mkdir03
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

We add more test cases in mkdir03 in order to check that mkdir()
can't overwrite certain types of files, such as simlinks, directories,
pipes, devices, etc.
These test cases come from symlink01 refactoring.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
EEXIST test on /dev/null

 runtest/syscalls                          |  1 -
 testcases/kernel/syscalls/mkdir/mkdir03.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index ef90076e4..e913eeecd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -757,7 +757,6 @@ mkdir02 mkdir02
 mkdir03 mkdir03
 mkdir04 mkdir04
 mkdir05 mkdir05
-mkdir05A symlink01 -T mkdir05
 mkdir09 mkdir09
 
 #mkdirat test cases
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index d5141bb64..736c91ae2 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -9,6 +9,8 @@
  *	EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, ELOOP and EROFS
  */
 
+#include <paths.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -19,6 +21,10 @@
 #include "tst_test.h"
 
 #define TST_EEXIST	"tst_eexist"
+#define TST_PIPE	"tst_pipe"
+#define TST_FOLDER	"tst_folder"
+#define TST_SYMLINK "tst_symlink"
+#define TST_NULLDEV	_PATH_DEVNULL
 #define TST_ENOENT	"tst_enoent/tst"
 #define TST_ENOTDIR_FILE "tst_enotdir"
 #define TST_ENOTDIR_DIR	"tst_enotdir/tst"
@@ -41,6 +47,10 @@ static struct tcase {
 	{NULL, EFAULT},
 	{long_dir, ENAMETOOLONG},
 	{TST_EEXIST, EEXIST},
+	{TST_FOLDER, EEXIST},
+	{TST_PIPE, EEXIST},
+	{TST_SYMLINK, EEXIST},
+	{TST_NULLDEV, EEXIST},
 	{TST_ENOENT, ENOENT},
 	{TST_ENOTDIR_DIR, ENOTDIR},
 	{loop_dir, ELOOP},
@@ -70,7 +80,13 @@ static void verify_mkdir(unsigned int n)
 static void setup(void)
 {
 	unsigned int i;
+	char *tmpdir = tst_get_tmpdir();
 
+	SAFE_SYMLINK(tmpdir, TST_SYMLINK);
+	free(tmpdir);
+
+	SAFE_MKFIFO(TST_PIPE, 0777);
+	SAFE_MKDIR(TST_FOLDER, 0777);
 	SAFE_TOUCH(TST_EEXIST, MODE, NULL);
 	SAFE_TOUCH(TST_ENOTDIR_FILE, MODE, NULL);
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
