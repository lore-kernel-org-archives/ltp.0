Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D12606A321
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Cqgt+yY0;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TNtKxR0N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794389618; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dK9kNcC9IqaWKahnUWmEiNqg5oIG+QMV/4RkxFFEYdk=;
 b=Cqgt+yY0JPBOmMEWW5GQnbRYnKZahaHc7lXtnJIwhjjPkaAfBJUiFaEp9ZIEwXyXh5lT2
 PvzSAHk9DX5LfhetgvNL3Ux94QvzZhEBY7V+g4IRSPpPg7tGkam3YDMX33naiOvDcubZmpT
 XyAwj6qpAHDYxbbsk9dtoeTJCvdPSmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4993E94FE
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F40A03EA0BB
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:32:07 +0100 (CET)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 78CF22009B3
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:32:07 +0100 (CET)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2eaae8d29e0so39605005ad.2
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 01:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794389526; x=1794994326; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e+J5l3lV6RZH/HMpBFMGQZ/01IIrXF4vkvUwcdEoRtA=;
 b=TNtKxR0N1doS/nxC4MCtn4ssy8rN8cKAhbEAxm8QWN2SeI6Nut2YzPSnI6ERvvl/sG
 BI1vJ6cys3BbZp6jZuS+z4vuEJfd44i3BCzdOkTeB2UHY4RwgkT9eBMEr3qBZ8HKWclE
 mbECkg72+7OMWxVUrM3OPhhHVK5y3ADfBr637KFz5CHoj8h4xgfbd5x1VkfB5RvIXGAC
 /24V8MOoTTqCfWJEbnUldmR0LNI1cQ3zxlL9APKtcOgCQVH0Ihr3zoTTfgBTkFbX1SBn
 3p1dt8430gJ7WQLNGTFf7W/9lFzwFzciBSxZ/ctwhAxMGOYneAkaHqjFBamS47RRyMFC
 nbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389526; x=1794994326;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e+J5l3lV6RZH/HMpBFMGQZ/01IIrXF4vkvUwcdEoRtA=;
 b=GBrgHe/3/sTz4Q4S6S/7qPdeXUbVkVCWckYOsZOkZ3joFv0bZTsDPDI783SxQ7A6h2
 dIj8DXjCKI+NUAKdsHAdNn3VZpzaibArSAqLywKuMlLyPh6tOXuCFYVRm2eu1JkNrO+d
 LLvz6VKW8vk3MNLZuVNY28NEP37vjU4D3WItHRtNP3R2Zoyh81jrw5G590N4P7IL0lC/
 qo21nWDhn12wXqFIDFBN9yJN3glsN8qALqqE2LOuJdQ7W8VxunkW9f/p1h+l8CofRicH
 WjKkQbbHlN8bZgCAXWlhZ1ONNrRTsLGz3A8u74Ll+xpShB2q8H0aACJ0MkFeesRvzzN2
 Ywvw==
X-Gm-Message-State: APuU4Z9UTJ7Md2y0y9f4mYtGqmp7HhPjENZAjNcfUTPc1oCl+wqh/agR
 CEL3qW9VFRC2Ufer6b3dAGf5Dk0VsBFVP4Q3tOBGoSFIJaj1a4TmOszyRII7/YBwf6s264DT7yH
 FJgCkqgXmWKZ0atOZOHqBEPo93S4WCgJi6corP5MSDnBMWujUyuk6fhocoisyepWBIdJcMlXMrC
 QmdvnLBkV9gS+49Cxzr8Tf6AiGvw==
X-Received: from plqt12.prod.google.com ([2002:a17:902:a5cc:b0:2e5:379c:9ba6])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4690:b0:2e9:5b20:1c2b
 with SMTP id d9443c01a7336-2edd7474df1mr19386375ad.5.1794389525367; Wed, 11
 Nov 2026 01:32:05 -0800 (PST)
Date: Wed, 11 Nov 2026 09:31:51 +0000
In-Reply-To: <20261111093151.374731-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111093151.374731-5-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: [LTP] [PATCH 4/4] signal06: Allocate the alternate signal stack
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
2.56.0.567.gdb80ae8cd5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
