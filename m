Return-Path: <SRS0=8P1C=PD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821BFC433EF
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 07:30:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDE061073
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 07:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CDE061073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B6ED3C1B6E
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 09:30:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A88B3C1423
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 09:30:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3CD4B100099A
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 09:30:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 550031FD39;
 Fri, 15 Oct 2021 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634283036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8fz3sNVudYRHheX9fqR89oykXronaKq+nTTIQpjPmcI=;
 b=kowqLT+fbuFQPr2n8nK+gfirQBlKpY5ez2J2lh2NktaInoE83QeS/Fn47MQu0eKnesFWeb
 6sW7Zi+iWt/FrCDZ1ICRynKDkOzs9KSkJZSfBrTwu1wskJBF91xQ4ez+bsXEOBcJTIxB0Y
 mB/x1JkqzvhelJ7gxZCCid6TzMbARYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634283036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8fz3sNVudYRHheX9fqR89oykXronaKq+nTTIQpjPmcI=;
 b=D/AGnJTAY9yysAzbQe7vdi3btoP0LyhiAwiIpTgbKPBptJWOhWKA+vMEP5rXe4aS6YfTdT
 yqvmwd3QG7lfScCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 265B713B53;
 Fri, 15 Oct 2021 07:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sau+BhwuaWH5bAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Oct 2021 07:30:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Oct 2021 09:30:31 +0200
Message-Id: <20211015073031.18642-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] creat09: Run on all_filesystems
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

To make sure bug on XFS is detected on systems which use it.

Due setgid is test problematic on Microsoft filesystems:

creat09.c:81: TBROK: ntfs: Setgid bit not set
creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)

thus they're disabled.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* drop useless code creating directory (reported by Martin Doucha)

 testcases/kernel/syscalls/creat/creat09.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index 681b80c7d..1d6c1643c 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -33,13 +33,15 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <pwd.h>
+#include <stdio.h>
 #include "tst_test.h"
 #include "tst_uid.h"
 
 #define MODE_RWX        0777
 #define MODE_SGID       (S_ISGID|0777)
 
-#define WORKDIR		"testdir"
+#define MNTPOINT	"mntpoint"
+#define WORKDIR		MNTPOINT "testdir"
 #define CREAT_FILE	WORKDIR "/creat.tmp"
 #define OPEN_FILE	WORKDIR "/open.tmp"
 
@@ -51,6 +53,8 @@ static void setup(void)
 	struct stat buf;
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
+	SAFE_CHDIR(MNTPOINT);
+
 	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
 		(int)ltpuser->pw_gid);
 	free_gid = tst_get_free_gid(ltpuser->pw_gid);
@@ -119,6 +123,15 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char*[]) {
+		"exfat",
+		"ntfs",
+		"vfat",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0fa3ecd87848"},
 		{"CVE", "2018-13405"},
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
