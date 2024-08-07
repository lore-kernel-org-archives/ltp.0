Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C147CC3DA7F
	for <ltp@archiver.kernel.org>; Wed,  7 Aug 2024 09:01:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 889BB3D1FFD
	for <ltp@archiver.kernel.org>; Wed,  7 Aug 2024 11:01:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD70E3D1FDF
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 11:01:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F7131400B77
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 11:00:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 111971FB7A;
 Wed,  7 Aug 2024 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723021250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbi/Vkk4FJSrp6c3/9a0RgAv8U1aSe9fb/Jh6M7b3wc=;
 b=bqrbtulkn8Nz/jKc9BZnRs/mZ7MiG0Nzd5NZsk5kXki7DcyzTpWC0JhmsS5x7M1tAZCgyC
 FLXwS1CDdmzUz41/rYDGv9Qmp4u2QVD88hT7/vCqAXSd9f5gDkC/a5cghzTKU0EgkCHywd
 KpndtGSMJJ5DOy5kEBx/Ixz/7VMlOaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723021250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbi/Vkk4FJSrp6c3/9a0RgAv8U1aSe9fb/Jh6M7b3wc=;
 b=ZLs2LfzW3mTzmnJ4zFW4PvKMLEECvHisJtCz6F86LVkIbqcFoxibdIj96LdCSQ1mMGTEVu
 nXL7+drL/p7+jlAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bqrbtulk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZLs2LfzW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723021250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbi/Vkk4FJSrp6c3/9a0RgAv8U1aSe9fb/Jh6M7b3wc=;
 b=bqrbtulkn8Nz/jKc9BZnRs/mZ7MiG0Nzd5NZsk5kXki7DcyzTpWC0JhmsS5x7M1tAZCgyC
 FLXwS1CDdmzUz41/rYDGv9Qmp4u2QVD88hT7/vCqAXSd9f5gDkC/a5cghzTKU0EgkCHywd
 KpndtGSMJJ5DOy5kEBx/Ixz/7VMlOaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723021250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbi/Vkk4FJSrp6c3/9a0RgAv8U1aSe9fb/Jh6M7b3wc=;
 b=ZLs2LfzW3mTzmnJ4zFW4PvKMLEECvHisJtCz6F86LVkIbqcFoxibdIj96LdCSQ1mMGTEVu
 nXL7+drL/p7+jlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D461413297;
 Wed,  7 Aug 2024 09:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SMLHMsE3s2aFAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Aug 2024 09:00:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Aug 2024 11:00:43 +0200
Message-ID: <20240807090043.229889-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 111971FB7A
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] pkey01: Add .test_variants
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

Test both pkey_{alloc,mprotect() raw syscall and libc wrapper.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

not sure if testing libc wrappers makes ATM sense, because (if I read
glibc code correctly), there is only pkey_mprotect() very thin wrapper
in sysdeps/unix/sysv/linux/pkey_mprotect.c [1]:

int
pkey_mprotect (void *addr, size_t len, int prot, int pkey)
{
  if (pkey == -1)
    /* If the key is -1, the system call is precisely equivalent to
       mprotect.  */
    return __mprotect (addr, len, prot);
  return INLINE_SYSCALL_CALL (pkey_mprotect, addr, len, prot, pkey);
}

pkey_alloc() and others [2]:

	This adds system call wrappers for pkey_alloc, pkey_free, pkey_mprotect,
	and x86-64 implementations of pkey_get and pkey_set, which abstract over
	the PKRU CPU register and hide the actual number of memory protection
	keys supported by the CPU.  pkey_mprotect with a -1 key is implemented
	using mprotect, so it will work even if the kernel does not support the
	pkey_mprotect system call.

	The system call wrapers use unsigned int instead of unsigned long for
	parameters, so that no special treatment for x32 is needed.  The flags
	argument is currently unused, and the access rights bit mask is limited
	to two bits by the current PKRU register layout anyway.

Besides, something like SYSCALL_VARIANT could be added to include/tst_test_macros.h,
to be reused.

Kind regards,
Petr

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/pkey_mprotect.c;h=b7afa7946d016ddaa8d4dea5b000dfb04b45491e;hb=c2a05c99e34539d16ebf2bb6234c8d2f2fdaa1f9
[2] https://sourceware.org/git/?p=glibc.git;a=commit;h=446d22e91d3113be57a4b0d1151cf337458c3bec

 testcases/kernel/syscalls/pkeys/pkey01.c | 43 +++++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index f1ecfec0bb..52b29b1783 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -51,11 +51,40 @@ static struct tcase {
 	{0, PKEY_DISABLE_WRITE, "PKEY_DISABLE_WRITE"},
 };
 
+#define PKEY_ALLOC(...) \
+	SYSCALL_VARIANT(TST_EXP_POSITIVE, pkey_alloc, __VA_ARGS__)
+
+#define PKEY_MPROTECT(...) \
+	SYSCALL_VARIANT(TST_EXP_PASS_SILENT, pkey_mprotect, __VA_ARGS__)
+
+#define SYSCALL_VARIANT(TST, SCALL, ...)                                 \
+	({                                                                     \
+		if (tst_variant)                                    \
+			TST(SCALL(__VA_ARGS__));	\
+		else							\
+			TST(tst_syscall(__NR_ ## SCALL, __VA_ARGS__));	\
+		TST_RET;                                                       \
+	})
+
+static void variant_check(void)
+{
+	if (tst_variant) {
+		tst_res(TINFO, "Testing variant: libc pkey_{alloc,mprotect()");
+#ifndef HAVE_PKEY_MPROTECT
+		tst_brk(TCONF, "libc pkey_{alloc,mprotect() wrappers not available");
+#endif
+	} else {
+		tst_res(TINFO, "Testing variant: syscall __NR_pkey_{alloc,mprotect}");
+	}
+
+	check_pkey_support();
+}
+
 static void setup(void)
 {
 	int i, fd;
 
-	check_pkey_support();
+	variant_check();
 
 	if (tst_hugepages == test.hugepages.number)
 		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
@@ -146,14 +175,10 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 		fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
 
 	buffer = SAFE_MMAP(NULL, size, mpa->prot, mpa->flags, fd, 0);
-
-	pkey = pkey_alloc(tc->flags, tc->access_rights);
-	if (pkey == -1)
-		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
+	pkey = PKEY_ALLOC(tc->flags, tc->access_rights);
 
 	tst_res(TINFO, "Set %s on (%s) buffer", tc->name, flag_to_str(mpa->flags));
-	if (pkey_mprotect(buffer, size, mpa->prot, pkey) == -1)
-		tst_brk(TBROK | TERRNO, "pkey_mprotect failed");
+	PKEY_MPROTECT(buffer, size, mpa->prot, pkey);
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
@@ -181,8 +206,7 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
                 tst_res(TFAIL, "Child: %s", tst_strstatus(status));
 
 	tst_res(TINFO, "Remove %s from the buffer", tc->name);
-	if (pkey_mprotect(buffer, size, mpa->prot, 0x0) == -1)
-		tst_brk(TBROK | TERRNO, "pkey_mprotect failed");
+	PKEY_MPROTECT(buffer, size, mpa->prot, 0x0);
 
 	switch (mpa->prot) {
 	case PROT_READ:
@@ -230,4 +254,5 @@ static struct tst_test test = {
 	.test = verify_pkey,
 	.setup = setup,
 	.hugepages = {1, TST_REQUEST},
+	.test_variants = 2,
 };
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
