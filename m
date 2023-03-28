Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0F1C6FD18
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 14:40:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643913CCB96
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 16:40:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CF5E3CA33C
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 16:40:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75BF21A006EB
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 16:40:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38DDB21A2E;
 Tue, 28 Mar 2023 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680014435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fVFZvyNchICZzslacihJCXq/GLk9zqVn44ydLsYCRxk=;
 b=i4iMVmAHKvczfHC1ygLk13IVNNQJ9zWyDaVjLmKmiKLqjzESqtWi1uPKzW48X/c8SuG9Fq
 pF7fO0pPhzB0xi8cbxT/zQ+YVxsMXt0AARW5h8uoBg84XyI3z0EKOhLUE7A5feG9fct848
 3t5/U/rBAXyWAsaX3RJ6cHfvut6Eh7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680014435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fVFZvyNchICZzslacihJCXq/GLk9zqVn44ydLsYCRxk=;
 b=236cL7s7fl7Zw3jZ5y1r78zunRwkqZsKrbe2tk+niEHNpHqFcJabygE1QkZeCxZLSxTwOB
 KbL/uSrkCubSCTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 073951390D;
 Tue, 28 Mar 2023 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /i4xAGP8ImQDfgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 14:40:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 16:40:31 +0200
Message-Id: <20230328144031.791212-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fsconfig03: Skip on FUSE
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

fsconfig03 is broken not only on vfat and ntfs, but also over FUSE:

tst_supported_fs_types.c:120: TINFO: FUSE does support exfat
tst_supported_fs_types.c:55: TINFO: mkfs.exfat does exist
...
tst_test.c:1634: TINFO: === Testing on exfat ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
fsconfig03.c:38: TBROK: fsopen() failed: ENODEV (19)

NOTE: it actually works on vfat which is not over FUSE:
tst_supported_fs_types.c:90: TINFO: Kernel supports vfat
tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
...
tst_test.c:1634: TINFO: === Testing on vfat ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
fsconfig03.c:72: TPASS: kernel seems to be fine on vfat

Reported-by: Wei Gao <wegao@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Verifying NTFS as kernel module (I'd be surprised if it was not
working). The setup is the same as for fsconfig01.c (fsconfig02.c is for
expected errors, thus has less strict requirements).

Kind regards,
Petr

 testcases/kernel/syscalls/fsconfig/fsconfig03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index e891c9f98..0ba5355d3 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -88,7 +88,7 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "722d94847de29"},
 		{"CVE", "2022-0185"},
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
