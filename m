Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F88C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 13:26:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 102B53CFB38
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:26:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A05253C5815
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 14:26:05 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE86B601935
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 14:26:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44C2821F7C;
 Wed, 24 Jan 2024 13:26:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3812813786;
 Wed, 24 Jan 2024 13:26:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T/mpDewPsWUuRQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 24 Jan 2024 13:26:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 24 Jan 2024 14:26:02 +0100
Message-ID: <20240124132603.16199-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
References: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 44C2821F7C
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap04.c: Avoid vma merging
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

We hit a scenario where new mapping was merged with existing mapping of
same permission and the return address from the mmap was hidden in the
merged mapping in /proc/self/maps, causing the test to fail.
To avoid this, we first  create a 2-page mapping with the different
permissions, and then remap the 2nd page with the perms being tested.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap04.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
index f6f4f7c98..fa85deed1 100644
--- a/testcases/kernel/syscalls/mmap/mmap04.c
+++ b/testcases/kernel/syscalls/mmap/mmap04.c
@@ -17,8 +17,8 @@
 #include "tst_test.h"
 #include <stdio.h>
 
-#define MMAPSIZE 1024
-static char *addr;
+static char *addr1;
+static char *addr2;
 
 static struct tcase {
 	int prot;
@@ -44,14 +44,23 @@ static struct tcase {
 static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
-	char addr_str[20];
 	char perms[8];
 	char fmt[1024];
+	unsigned int pagesize;
+	int flag;
 
-	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
+	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
 
-	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr);
-	sprintf(fmt, "%s-%%*x %%s", addr_str);
+	/* To avoid new mapping getting merged with existing mappings, we first
+	 * create a 2-page mapping with the different permissions, and then remap
+	 * the 2nd page with the perms being tested.
+	 */
+	flag = (tc->flags & MAP_PRIVATE) ? MAP_SHARED : MAP_PRIVATE;
+	addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | flag, -1, 0);
+
+	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags | MAP_FIXED, -1, 0);
+
+	sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
 	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
 
 	if (!strcmp(perms, tc->exp_perms)) {
@@ -61,7 +70,7 @@ static void run(unsigned int i)
 						tc->exp_perms, perms);
 	}
 
-	SAFE_MUNMAP(addr, MMAPSIZE);
+	SAFE_MUNMAP(addr1, pagesize * 2);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
