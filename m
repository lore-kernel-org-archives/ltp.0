Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0136CD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 18:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70AB43E6A71
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 20:11:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0107D3C7F2A
 for <ltp@lists.linux.it>; Thu,  7 May 2026 20:10:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC7CD1000482
 for <ltp@lists.linux.it>; Thu,  7 May 2026 20:10:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D42666EA6;
 Thu,  7 May 2026 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778177449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zzWqHKtIfqNkNAn9hxwyxpHeHOoc5pCfpsY6/90Ko7g=;
 b=hWLVJv8h8WG6cv9Uj4d1PCu1BhIGrspsTReBuVzUloA7/sYiJWu909x6z2vaj6LdU0Gtar
 G0lBZXzfa7Flzz5LmSPQ/4nQbwUWWRFGG0rqtYevRcHLl7KMdKBv+o39ANnzGjad0j+Eic
 nskNbR0+ssXdO5atwCzcPXo1lwCOjhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778177449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zzWqHKtIfqNkNAn9hxwyxpHeHOoc5pCfpsY6/90Ko7g=;
 b=49o2WNuhHrhNGame+/SgGeBFhdqIamrAIknoTxMVebM8cRYDAIhtl6w6ZM8lsb5QdvYiqX
 4So5Urf9uZ4nk4Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778177449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zzWqHKtIfqNkNAn9hxwyxpHeHOoc5pCfpsY6/90Ko7g=;
 b=hWLVJv8h8WG6cv9Uj4d1PCu1BhIGrspsTReBuVzUloA7/sYiJWu909x6z2vaj6LdU0Gtar
 G0lBZXzfa7Flzz5LmSPQ/4nQbwUWWRFGG0rqtYevRcHLl7KMdKBv+o39ANnzGjad0j+Eic
 nskNbR0+ssXdO5atwCzcPXo1lwCOjhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778177449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zzWqHKtIfqNkNAn9hxwyxpHeHOoc5pCfpsY6/90Ko7g=;
 b=49o2WNuhHrhNGame+/SgGeBFhdqIamrAIknoTxMVebM8cRYDAIhtl6w6ZM8lsb5QdvYiqX
 4So5Urf9uZ4nk4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5198C593A7;
 Thu,  7 May 2026 18:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a9ukEKnV/Gm3EwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 18:10:49 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 20:10:39 +0200
Message-ID: <20260507181045.19489-1-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] memfd_create: move sys_memfd_create() to
 lapi/memfd.h
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

Add the static inline wrapper to include/lapi/memfd.h and include the
required headers so other tests can reuse it.

Also fix some minor issues detected by make check.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 include/lapi/memfd.h                                      | 8 ++++++++
 testcases/kernel/syscalls/memfd_create/memfd_create01.c   | 1 -
 .../kernel/syscalls/memfd_create/memfd_create_common.c    | 5 -----
 .../kernel/syscalls/memfd_create/memfd_create_common.h    | 4 +---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/lapi/memfd.h b/include/lapi/memfd.h
index 57b6cd83d..46ccb0a3f 100644
--- a/include/lapi/memfd.h
+++ b/include/lapi/memfd.h
@@ -6,6 +6,9 @@
 #ifndef LAPI_MEMFD_H__
 #define LAPI_MEMFD_H__
 
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
 /* flags for memfd_create(2) (unsigned int) */
 #ifndef MFD_CLOEXEC
 # define MFD_CLOEXEC             0x0001U
@@ -47,4 +50,9 @@
 #define MFD_HUGE_16GB (34 << 26)
 #endif
 
+static inline int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return tst_syscall(__NR_memfd_create, name, flags);
+}
+
 #endif /* LAPI_MEMFD_H__ */
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
index 73f6b01e8..28ad04a86 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -212,7 +212,6 @@ static void test_share_open(int fd)
 	SAFE_CLOSE(fd2);
 }
 
-
 static const struct tcase {
 	int flags;
 	void (*func)(int fd);
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index a52b02a56..63e8daac5 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -24,11 +24,6 @@
 
 #include "memfd_create_common.h"
 
-int sys_memfd_create(const char *name, unsigned int flags)
-{
-	return tst_syscall(__NR_memfd_create, name, flags);
-}
-
 int check_fallocate(const char *filename, const int lineno, int fd,
 			int mode, off_t offset, off_t len)
 {
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
index 60ad895fe..df809d6c7 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
@@ -50,7 +50,7 @@
 	check_munmap(__FILE__, __LINE__, (p), (length))
 
 #define CHECK_MFD_HAS_SEALS(fd, seals) \
-	check_mfd_has_seals(__FILE__, __LINE__, (fd), (seals));
+	check_mfd_has_seals(__FILE__, __LINE__, (fd), (seals))
 
 #define CHECK_MFD_ADD_SEALS(fd, seals) \
 	({int r = SAFE_FCNTL((fd), F_ADD_SEALS, (seals)); \
@@ -101,8 +101,6 @@ int mfd_flags_available(const char *filename, const int lineno,
 
 int get_mfd_all_available_flags(const char *filename, const int lineno);
 
-int sys_memfd_create(const char *name, unsigned int flags);
-
 int check_fallocate(const char *filename, const int lineno, int fd,
 			int mode, off_t offset, off_t len);
 int check_fallocate_fail(const char *filename, const int lineno, int fd,
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
