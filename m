Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF0D44177
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 15:48:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D963D8A3B
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 16:48:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE1B43D89F0
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 16:47:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 13A471431CD9
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 16:47:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732031262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCyoQCEBMwf9fO5e/i4xDz+zzuFxiIiCek9KmMy1LUE=;
 b=WE8AfLErylL6QH36mu3VMygF4QIbF4YqfpmMZW+/nl3r8pvAan7nn9wV4LpBcaICrsWpgO
 fiERgRpr0cEUcvKrggf0EZL3kaBNOtgb9tLQE1v1HPWuH1w+2oqc9P6iT6HNuVSCJj6ibD
 Y1x7Aw0W3YgS3wZsZQlJM/H71zEi3TY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-FF1m8szCPuaI32iWu77n3w-1; Tue,
 19 Nov 2024 10:47:41 -0500
X-MC-Unique: FF1m8szCPuaI32iWu77n3w-1
X-Mimecast-MFC-AGG-ID: FF1m8szCPuaI32iWu77n3w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11B3219560AE
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 15:47:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E80519560A3
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 15:47:38 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 19 Nov 2024 16:47:34 +0100
Message-ID: <7cdc48ed109ee67af12d0bc74eb32c0b7f862430.1732031092.git.jstancek@redhat.com>
In-Reply-To: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
References: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sHmgZ4K1ECq7wY-pWy1-7uoLw0Kr_yR0xJd74k1jP1M_1732031260
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pkeys01: use a dummy function instead of
 function_size
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

As Martin found:
  The function_size() code
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

Use a dummy function and copy entire page, similar to what we do
in mprotect04.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/pkeys/Makefile |  2 ++
 testcases/kernel/syscalls/pkeys/pkey01.c | 31 ++++++++++--------------
 2 files changed, 15 insertions(+), 18 deletions(-)

Notes:

This could be an alternative to reverting PKEY_DISABLE_EXECUTE test.
I haven't tested it yet on 32bit, but since it doesn't rely on any
instruction codes I don't expect it to break. An important test
would also be ppc64le.

diff --git a/testcases/kernel/syscalls/pkeys/Makefile b/testcases/kernel/syscalls/pkeys/Makefile
index 9ee2c2ea57b0..814593f3c720 100644
--- a/testcases/kernel/syscalls/pkeys/Makefile
+++ b/testcases/kernel/syscalls/pkeys/Makefile
@@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+pkey01: CFLAGS += -falign-functions=64
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index c041cbcfd969..b10760b5bd2f 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -144,15 +144,9 @@ static char *flag_to_str(int flags)
 	}
 }
 
-static size_t function_size(void (*func)(void))
+static long __attribute__ ((noinline)) dummy_func(void)
 {
-	unsigned char *start = (unsigned char *)func;
-	unsigned char *end = start;
-
-	while (*end != 0xC3 && *end != 0xC2)
-		end++;
-
-	return (size_t)(end - start + 1);
+	return 0xdead;
 }
 
 /*
@@ -165,8 +159,11 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 	char *buffer;
 	int pkey, status;
 	int fd = mpa->fd;
-	size_t (*func)();
-	size_t func_size = 0;
+	long (*func)(void) = 0;
+	uintptr_t page_mask = ~(getpagesize() - 1);
+	uintptr_t offset_mask = (getpagesize() - 1);
+	uintptr_t func_page_offset = (uintptr_t)&dummy_func & offset_mask;
+	void *page_to_copy = (void *)((uintptr_t)&dummy_func & page_mask);
 
 	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE)) {
 		tst_res(TCONF, "skip PKEY_DISABLE_EXECUTE test");
@@ -184,8 +181,8 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 	buffer = SAFE_MMAP(NULL, size, mpa->prot, mpa->flags, fd, 0);
 
 	if (mpa->prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
-		func_size = function_size((void (*)(void))function_size);
-		memcpy(buffer, (void *)function_size, func_size);
+		memcpy(buffer, page_to_copy, getpagesize());
+		func = (long (*)(void))(buffer + func_page_offset);
 	}
 
 	pkey = pkey_alloc(tc->flags, tc->access_rights);
@@ -211,8 +208,7 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 				"Write buffer success, buffer[0] = %d", *buffer);
 		break;
 		case PKEY_DISABLE_EXECUTE:
-			func = (size_t (*)())buffer;
-			tst_res(TFAIL | TERRNO, "Execute buffer result = %zi", func(func));
+			tst_res(TFAIL | TERRNO, "Execute buffer result = %ld", func());
 		break;
 		}
 		exit(0);
@@ -242,11 +238,10 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
 		tst_res(TPASS, "Read & Write buffer success, buffer[0] = %d", *buffer);
 	break;
 	case PROT_READ | PROT_WRITE | PROT_EXEC:
-		func = (size_t (*)())buffer;;
-		if (func_size == func(func))
-			tst_res(TPASS, "Execute buffer success, result = %zi", func_size);
+		if (dummy_func() == func())
+			tst_res(TPASS, "Execute buffer success, result = %ld", dummy_func());
 		else
-			tst_res(TFAIL, "Execute buffer with unexpected result: %zi", func(func));
+			tst_res(TFAIL, "Execute buffer with unexpected result: %zi", func());
 	break;
 	}
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
