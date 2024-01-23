Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C12CC47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8A513CFB7D
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:55:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96D933CD195
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:55:41 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E818660311C
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:55:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D00F71F78C;
 Tue, 23 Jan 2024 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706028940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e3GwyBJhWHKO8icI0MAo9PV3pI5C/Mr+lMKffY4Eknk=;
 b=0ik/teGuiKDuBHfQSKPpkWpFoFjoh8aZeAUqK83KtzvBJkzEW2fit/A5G622mEzQKu50t5
 8pU26L+F1QD/vwf6lhdNMxwva55A45Wso+hsy27D5qvJ/Sbw51RWqQmQ5XCio92+K5pnyH
 z19ydUVS/wPFKKlp8EMZR82h0AAGfsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706028940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e3GwyBJhWHKO8icI0MAo9PV3pI5C/Mr+lMKffY4Eknk=;
 b=Rd4omZG8+ruqy+eKa9dQkSf8PScoQBvJMP5iVzrE8946tbGQsUrh91KaDwOeo7m9VfkLb9
 9Y7x+dxaIQc7iHAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706028939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e3GwyBJhWHKO8icI0MAo9PV3pI5C/Mr+lMKffY4Eknk=;
 b=NPsINlbtik6ms5bQ6isk6OFl4fld5peYbP5F3x50+TVNb7oDxmFuGALP//tciD0vcR6lHe
 rABlXItPZJWu1ot++LqiHTvJ7oYq3kpTmtoeIOwQZJE/uq+gs5IVd7AKvxcUpMUmRif4Bv
 RSjnwaDyZYeMLBmlWoe41i14u6shf8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706028939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e3GwyBJhWHKO8icI0MAo9PV3pI5C/Mr+lMKffY4Eknk=;
 b=OCPLhx76PtgCQFuxUtXMg34kwmenJ3gVPdgENmaGv7tj8mgZ6E8CLlGQlomBZGCaeNkvtX
 UZkOQ7E4QV7REOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C38D413786;
 Tue, 23 Jan 2024 16:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3MQ+L4vvr2X6FAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 23 Jan 2024 16:55:39 +0000
From: Avinesh Kumar <akumar@suse.de>
To: mdoucha@suse.cz,
	ltp@lists.linux.it
Date: Tue, 23 Jan 2024 17:55:10 +0100
Message-ID: <20240123165539.32514-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap04.c: Avoid vma merging
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
---
 testcases/kernel/syscalls/mmap/mmap04.c | 49 +++++++++++++++----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
index f6f4f7c98..f0f87b7f5 100644
--- a/testcases/kernel/syscalls/mmap/mmap04.c
+++ b/testcases/kernel/syscalls/mmap/mmap04.c
@@ -17,28 +17,28 @@
 #include "tst_test.h"
 #include <stdio.h>
 
-#define MMAPSIZE 1024
-static char *addr;
+static char *addr1;
+static char *addr2;
 
 static struct tcase {
 	int prot;
 	int flags;
 	char *exp_perms;
 } tcases[] = {
-	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, "---p"},
-	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED, "---s"},
-	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, "r--p"},
-	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED, "r--s"},
-	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "-w-p"},
-	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "-w-s"},
-	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "rw-p"},
-	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "rw-s"},
-	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "r-xp"},
-	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "r-xs"},
-	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "-wxp"},
-	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "-wxs"},
-	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "rwxp"},
-	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "rwxs"}
+	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "---p"},
+	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "---s"},
+	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "r--p"},
+	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "r--s"},
+	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "-w-p"},
+	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "-w-s"},
+	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "rw-p"},
+	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "rw-s"},
+	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "r-xp"},
+	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "r-xs"},
+	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "-wxp"},
+	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "-wxs"},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "rwxp"},
+	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "rwxs"}
 };
 
 static void run(unsigned int i)
@@ -47,10 +47,21 @@ static void run(unsigned int i)
 	char addr_str[20];
 	char perms[8];
 	char fmt[1024];
+	unsigned int pagesize;
 
-	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
+	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
 
-	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr);
+	/* To avoid new mapping getting merged with existing mappings, we first
+	   create a 2-page mapping with the different permissions, and then remap
+	   the 2nd page with the perms being tested. */
+	if ((tc->prot == PROT_NONE) && (tc->flags == (MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED)))
+		addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_READ, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	else
+		addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags, -1, 0);
+
+	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr2);
 	sprintf(fmt, "%s-%%*x %%s", addr_str);
 	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
 
@@ -61,7 +72,7 @@ static void run(unsigned int i)
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
