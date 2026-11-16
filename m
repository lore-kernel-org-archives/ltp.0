Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C30606A330
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=RHrIwast;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZgkcypLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794839033; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+8QYO13bxoCt6ivqqjoMJkg7YJqhWYGmONgA2rAvhYM=;
 b=RHrIwastZYNFvGjhCyIp8Dfm82cmchbHZy6Qx+MmzL1Kng7N+imO7eD6Sn4cFjDE85fJw
 TfY8UkUMcuyUVY/Es9vm3XJd/pZR674sLDg9axlp3Mkz4Yjrt3CcQP8+1BMpyMP+vfI9HwF
 rjg0ZuVx1rC3VX0ufWfOS/kkS6aSYF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 782D83EA9DA
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:23:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B967F3EAA17
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:21 +0100 (CET)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 722FF600828
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:21 +0100 (CET)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-89f84753b43so2376631b3a.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838940; x=1795443740; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hS9YYMdNOXUlIc3bZ4UnI6gc5Z3hMKNej5ZFVEbiVQQ=;
 b=ZgkcypLXId8oNXl37+xo/Nw6xRiGJEYtumoZzG4OUa4SVrJwoeEgbuoflLBha5+mVQ
 G98QnCY7JgGeKoxvzwM+SFees6ubkUdIA8y0HweqfYAJJ1ehf7/I2AbQh+VbxfAA27U/
 NR2jKevpJLIRYbImK2M2HRwRTIgFyhaaHT3eG2++kOdzgIMKadmaj09CLw+UPjigig9/
 lVgLfMgyV0BUI9nDQLFD9Imhbyrp0D/ofYAoJ52KYVe49xIdi7mNhEgzo/mhOH1STVc+
 n1RH4rLMc8/WFaNRSo0N5k/fUAcjQ196MPb9TTspxKLfgt2xsfCuZpnwXS7yKvGAf6Vm
 ygoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838940; x=1795443740;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hS9YYMdNOXUlIc3bZ4UnI6gc5Z3hMKNej5ZFVEbiVQQ=;
 b=2uvT86/mRXaAr5t/ReGRXoF97ddy616RI5YefBAKW6X9KUbOyzWeaOM1kBHbhN0mLN
 xABfmVcP8mbTWA1g8ZHWBx3Pfy5I68UCbBvpbdFwDPZEwYfHTDpe1SnBhyw/zbM76m+v
 xWyOnIZir9CJC5EysJjqusohJBJVfAylfyf1VyCbMzVJaX0v4o7nNBVx3tuposOsldox
 1o3m28ajC8oOqHDS785uFazJ7EScsbRXI7CDR5vbxcySXqWuE1TKwc3EbQ4u++abIzIg
 cUHx7KsqzK58J3oUVM90nU8Ar/H1h3IXEpjMo/SqrgcruXetAZbvbGjCC9xxV4CZkC54
 zBfA==
X-Gm-Message-State: APuU4Z/N5z2vCqG6xbJKizu9XpT8zGDsCo2Ag2ELA4A2e2RbpgVY7ve+
 WccMfvTTHvrduzIfvC0gSbNAWVszyGDnC3Exquu29AkR4vug2avfUd/RWjXWUyXlojcIaE6NYQs
 4/lOTXJDEZxV7rGcym5r47dkRUiidlOd7tDjoud8kZbVLfWNb2iECQ2VtuBdds74woOsWWcYS8U
 s85Axs3jgicKveYFtZPf5e/gf8ZQ==
X-Received: from pfew2-n2.prod.google.com
 ([2002:a05:6a00:c1c2:20b0:89d:3267:4348])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2392:b0:8a0:3685:23a5
 with SMTP id d2e1a72fcca58-8beb7d1c7dfmr9668489b3a.53.1794838939397; Mon, 16
 Nov 2026 06:22:19 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:06 +0000
In-Reply-To: <20261116142206.3151308-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
 <20261116142206.3151308-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142206.3151308-5-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] signal06: Allocate the alternate signal stack
 with mmap()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test mprotect()s the alternate signal stack, which is a statically
allocated array of 4096 * 10 bytes aligned to 4096 bytes. That only
works if the page size is 4096 bytes. With a larger page size,
mprotect() either fails with EINVAL because the stack is not page
aligned or, since the length gets rounded up to the page size, also
write protects the variables placed after the array. The main thread
then faults on them over and over again and the test hangs until it
times out.

That happens with the 16K page size emulation that Android uses on
x86_64. With the stack at 0x53c000, mprotect() of its 40960 bytes
covers memory up to 0x548000 and the main thread keeps faulting right
after the end of the stack:

  --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_ACCERR, si_addr=0x546008}

Allocate the stack with mmap() and size it based on getpagesize().
Nothing changes with a 4096 byte page size.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/signal/signal06.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
index cf0706ea4..e464fc661 100644
--- a/testcases/kernel/syscalls/signal/signal06.c
+++ b/testcases/kernel/syscalls/signal/signal06.c
@@ -48,6 +48,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "tso_safe_macros.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "signal06";
@@ -61,7 +62,8 @@ int TST_TOTAL = 5;
 volatile double D;
 volatile int FLAGE;
 
-char altstack[4096 * 10] __attribute__((aligned(4096)));
+static char *altstack;
+static size_t altstack_size;
 
 void test(void)
 {
@@ -99,12 +101,12 @@ void *tfunc(void *arg LTP_ATTRIBUTE_UNUSED)
 
 	for (i = -1; ; i *= -1) {
 		if (i == -1) {
-			TEST(mprotect(altstack, sizeof(altstack), PROT_READ));
+			TEST(mprotect(altstack, altstack_size, PROT_READ));
 			if (TEST_RETURN == -1)
 				tst_brkm(TBROK | TTERRNO, NULL, "mprotect failed");
 		}
 
-		TEST(mprotect(altstack, sizeof(altstack), PROT_READ | PROT_WRITE));
+		TEST(mprotect(altstack, altstack_size, PROT_READ | PROT_WRITE));
 		if (TEST_RETURN == -1)
 			tst_brkm(TBROK | TTERRNO, NULL, "mprotect failed");
 
@@ -120,9 +122,14 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
+	/* mprotect() needs the stack to be aligned to the runtime page size */
+	altstack_size = getpagesize() * 10;
+	altstack = SAFE_MMAP(NULL, NULL, altstack_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
 	stack_t st = {
 		.ss_sp = altstack,
-		.ss_size = sizeof(altstack),
+		.ss_size = altstack_size,
 		.ss_flags = SS_ONSTACK,
 	};
 
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
