Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD00FD68BC8
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 15:45:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387BE3D77C4
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 16:44:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AFF13C08CF
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:44:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95B4F1420367
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:44:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1696B21196
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731685478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y3pRPLSxl6tRs6RIDw+liuTHy8CRWcun+tWY/RWlpBs=;
 b=ZEGrd+uj7fJXIVmNl9ct+Ddlp5LEBVYlonQ3s83fnFzQhDkJqvriAUFzk9hGChQMUi1M5h
 9huEF+JQMPCuQ5OmyhTBVeUQZgJ8H7JmSED8RBkys0Vt9uFrY7KiILutJSqtIG+SSd7rOM
 DHTX3vB4UL+Fd2HWqokRrmrlu4sBal0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731685478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y3pRPLSxl6tRs6RIDw+liuTHy8CRWcun+tWY/RWlpBs=;
 b=SMDqbDWVKvKvDASKE33Cyf2s1owFtX5OA/5E6yev74frSWM79hEoO6AQYp+yA+OI3TbaGc
 7X+BBGpN6PXCVxDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731685478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y3pRPLSxl6tRs6RIDw+liuTHy8CRWcun+tWY/RWlpBs=;
 b=ZEGrd+uj7fJXIVmNl9ct+Ddlp5LEBVYlonQ3s83fnFzQhDkJqvriAUFzk9hGChQMUi1M5h
 9huEF+JQMPCuQ5OmyhTBVeUQZgJ8H7JmSED8RBkys0Vt9uFrY7KiILutJSqtIG+SSd7rOM
 DHTX3vB4UL+Fd2HWqokRrmrlu4sBal0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731685478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y3pRPLSxl6tRs6RIDw+liuTHy8CRWcun+tWY/RWlpBs=;
 b=SMDqbDWVKvKvDASKE33Cyf2s1owFtX5OA/5E6yev74frSWM79hEoO6AQYp+yA+OI3TbaGc
 7X+BBGpN6PXCVxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08EB6134B8
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oGaPAWZsN2euQQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:44:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 16:44:33 +0100
Message-ID: <20241115154434.39461-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Revert "pkey01: Adding test for PKEY_DISABLE_EXECUTE"
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

This reverts commit d2b8a476c29d52c484b387454082bbc906b0b4f8.

Remove the PKEY_DISABLE_EXECUTE subtest. The function_size() code
is broken in a way that I cannot easily fix. The function tries
to calculate the size of a function by finding the first RET
instruction. However, in 32bit LTP builds, the code gets compiled
to this:

0804b690 <function_size>:
 804b690:       8b 4c 24 04             mov    0x4(%esp),%ecx
 804b694:       0f b6 01                movzbl (%ecx),%eax
 804b697:       83 c0 3e                add    $0x3e,%eax
 804b69a:       3c 01                   cmp    $0x1,%al
 804b69c:       76 1a                   jbe    804b6b8 <function_size+0x28>
 804b69e:       89 c8                   mov    %ecx,%eax
 804b6a0:       83 c0 01                add    $0x1,%eax
 804b6a3:       0f b6 10                movzbl (%eax),%edx
 804b6a6:       83 c2 3e                add    $0x3e,%edx
 804b6a9:       80 fa 01                cmp    $0x1,%dl
 804b6ac:       77 f2                   ja     804b6a0 <function_size+0x10>
 804b6ae:       29 c8                   sub    %ecx,%eax
 804b6b0:       83 c0 10                add    $0x10,%eax
 804b6b3:       c3                      ret
 804b6b4:       8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi
 804b6b8:       b8 10 00 00 00          mov    $0x10,%eax
 804b6bd:       c3                      ret
 804b6be:       66 90                   xchg   %ax,%ax

If you look closely enough, you'll notice a C2 byte in add $0x3e,%edx
instruction on address 804b6a6. The function will assume this byte is
a RET instruction, return a size that's 22 bytes too short and then
the code execution inside the executable buffer will run past the end
of buffer, resulting in a segfault.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/pkeys/pkey01.c | 52 ++----------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index c041cbcfd..e49e48846 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019-2024 Red Hat, Inc.
+ * Copyright (c) 2019 Red Hat, Inc.
  */
 
 /*\
@@ -41,7 +41,6 @@
 #define PATH_VM_NRHPS "/proc/sys/vm/nr_hugepages"
 
 static int size;
-static int execute_supported = 1;
 
 #define PERM_NAME(x) .access_rights = x, .name = #x
 static struct tcase {
@@ -51,26 +50,14 @@ static struct tcase {
 } tcases[] = {
 	{PERM_NAME(PKEY_DISABLE_ACCESS)},
 	{PERM_NAME(PKEY_DISABLE_WRITE)},
-	{PERM_NAME(PKEY_DISABLE_EXECUTE)} /* keep it the last */
 };
 
 static void setup(void)
 {
-	int i, fd, pkey;
+	int i, fd;
 
 	check_pkey_support();
 
-	pkey = pkey_alloc(0, PKEY_DISABLE_EXECUTE);
-	if (pkey == -1) {
-		if (errno == EINVAL) {
-			tst_res(TINFO, "PKEY_DISABLE_EXECUTE not implemented");
-			execute_supported = 0;
-		} else {
-			tst_brk(TBROK | TERRNO, "pkey_alloc failed");
-		}
-	}
-	pkey_free(pkey);
-
 	if (tst_hugepages == test.hugepages.number)
 		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	else
@@ -144,17 +131,6 @@ static char *flag_to_str(int flags)
 	}
 }
 
-static size_t function_size(void (*func)(void))
-{
-	unsigned char *start = (unsigned char *)func;
-	unsigned char *end = start;
-
-	while (*end != 0xC3 && *end != 0xC2)
-		end++;
-
-	return (size_t)(end - start + 1);
-}
-
 /*
  * return: 1 if it's safe to quit testing on failure (all following would be
  * TCONF, O otherwise.
@@ -165,13 +141,6 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 	char *buffer;
 	int pkey, status;
 	int fd = mpa->fd;
-	size_t (*func)();
-	size_t func_size = 0;
-
-	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE)) {
-		tst_res(TCONF, "skip PKEY_DISABLE_EXECUTE test");
-		return 1;
-	}
 
 	if (!tst_hugepages && (mpa->flags & MAP_HUGETLB)) {
 		tst_res(TCONF, "Skip test on (%s) buffer", flag_to_str(mpa->flags));
@@ -183,11 +152,6 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 
 	buffer = SAFE_MMAP(NULL, size, mpa->prot, mpa->flags, fd, 0);
 
-	if (mpa->prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
-		func_size = function_size((void (*)(void))function_size);
-		memcpy(buffer, (void *)function_size, func_size);
-	}
-
 	pkey = pkey_alloc(tc->flags, tc->access_rights);
 	if (pkey == -1)
 		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
@@ -210,10 +174,6 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 			tst_res(TFAIL | TERRNO,
 				"Write buffer success, buffer[0] = %d", *buffer);
 		break;
-		case PKEY_DISABLE_EXECUTE:
-			func = (size_t (*)())buffer;
-			tst_res(TFAIL | TERRNO, "Execute buffer result = %zi", func(func));
-		break;
 		}
 		exit(0);
 	}
@@ -238,16 +198,10 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 		tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
 	break;
 	case PROT_READ | PROT_WRITE:
+	case PROT_READ | PROT_WRITE | PROT_EXEC:
 		*buffer = 'a';
 		tst_res(TPASS, "Read & Write buffer success, buffer[0] = %d", *buffer);
 	break;
-	case PROT_READ | PROT_WRITE | PROT_EXEC:
-		func = (size_t (*)())buffer;;
-		if (func_size == func(func))
-			tst_res(TPASS, "Execute buffer success, result = %zi", func_size);
-		else
-			tst_res(TFAIL, "Execute buffer with unexpected result: %zi", func(func));
-	break;
 	}
 
 	if (fd >= 0)
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
