Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D41C54788
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 15:00:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C769C3D0081
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 16:00:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37F103CD103
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 16:00:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9864603A50
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 16:00:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E302C1F74D;
 Thu, 22 Feb 2024 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708614038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E6/m+DEs59Z64Yu1qELAqb+2DLRpiYxTO8zPwqVWF0o=;
 b=Q9dEkIIQBWz3yGKSJqsYhfyGx76OXs9xtqvdQAExGhyw3Mk5oZt9A8P8lNPvkd0H1GO39D
 Rx5H4NdBoF+cAbkIFaUUFgUJh5KTYvKTBJ6xCEU+g3nAUFknwL67u0kWNFAwflUPamPbdj
 hCmcSsrRuMRCJ6wx/CHRrvBVYwCjEQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708614038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E6/m+DEs59Z64Yu1qELAqb+2DLRpiYxTO8zPwqVWF0o=;
 b=dm+ae8rcdPFptwjBzljf6IHcPENHdY4TSgkuAbI7E8T0tsfrsEl6FSiJqKhFYoKYJMm6JA
 jloxZiyr4CnQTTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708614037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E6/m+DEs59Z64Yu1qELAqb+2DLRpiYxTO8zPwqVWF0o=;
 b=ALcl+Pk6xU7s6qI+r3am1u4GHJ5Th+OCg8bsmeyg8zVLnR5rYfX+i4AfZh1vUhQCkewgMk
 YGsnUCRTBTXJ0g9rsnwOigQNATooxIKobgfizyLbh9W65kM0ivCYXJ/2aiOryCKSJa2jyC
 vNLuo4Gndc/EbDk9g3WXL1yQja+huew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708614037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E6/m+DEs59Z64Yu1qELAqb+2DLRpiYxTO8zPwqVWF0o=;
 b=zdiGFd8sT8eJ8Ce4bslD3FEVcLYfxIArAEji5QeHdLZMRyzbN8A6Dhgl6JY0/Ct+sZLo/3
 cUu3aAh6CT/ooZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6B6C133DC;
 Thu, 22 Feb 2024 15:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hTUdL5Vh12XCUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 22 Feb 2024 15:00:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 22 Feb 2024 16:00:36 +0100
Message-Id: <20240222150036.30594-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ALcl+Pk6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zdiGFd8s
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.03 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-2.52)[97.82%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: E302C1F74D
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add more testcases in mkdir03
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
Removed mkdir10
free() tmpdir

 runtest/syscalls                          |  1 -
 testcases/kernel/syscalls/mkdir/mkdir03.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index d5141bb64..fe847bdca 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -9,6 +9,7 @@
  *	EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, ELOOP and EROFS
  */
 
+#include <stdlib.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -19,6 +20,9 @@
 #include "tst_test.h"
 
 #define TST_EEXIST	"tst_eexist"
+#define TST_PIPE	"tst_pipe"
+#define TST_FOLDER	"tst_folder"
+#define TST_SYMLINK "tst_symlink"
 #define TST_ENOENT	"tst_enoent/tst"
 #define TST_ENOTDIR_FILE "tst_enotdir"
 #define TST_ENOTDIR_DIR	"tst_enotdir/tst"
@@ -41,6 +45,9 @@ static struct tcase {
 	{NULL, EFAULT},
 	{long_dir, ENAMETOOLONG},
 	{TST_EEXIST, EEXIST},
+	{TST_FOLDER, EEXIST},
+	{TST_PIPE, EEXIST},
+	{TST_SYMLINK, EEXIST},
 	{TST_ENOENT, ENOENT},
 	{TST_ENOTDIR_DIR, ENOTDIR},
 	{loop_dir, ELOOP},
@@ -70,7 +77,13 @@ static void verify_mkdir(unsigned int n)
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
