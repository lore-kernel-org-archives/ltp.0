Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DF8C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:24:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 802683CB20B
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:24:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89BB23CA983
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:24:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C9EC141CE99
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:24:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8F5DB21AE4;
 Mon, 18 Sep 2023 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695036275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KBlP1z+kuWxfvRvLY6aRXwNnZpUfajrlgOt06t4A3SU=;
 b=Y0H5UlIe3a96GRIoRiEFo2ck0m2597f2DFca0jX62XxK0ckuprM3CDJ+BhPjXZXHk3MUNI
 BedpbJV3yx8VsAzKqfKH/4vNbRbdeCVK4uqKX0mTtg3/BmCZLjl0fBCP5oTBNRYvKJroWM
 pSiQM4/aHAZwRXz5IksCTs81L3MTP4g=
Received: from g78.cable.virginm.net (unknown [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id 3F6C02C142;
 Mon, 18 Sep 2023 11:24:35 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 12:23:58 +0100
Message-ID: <20230918112358.25858-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] kvm: Fix Nix build failure by specifying
 -fno-stack-protector again
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: mdoucha@suse.com, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Nix uses a binutils wrapper of some sort to allow switching between
toolchains. This seems to be causing a problem for the KVM tests
although it may not be unique to Nix.

gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -DCOMPILE_PAYLOAD -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx\
 -mno-sse -fno-pie -c -o lib_guest.o lib_guest.c
as  -c -o bootstrap_x86_64.o bootstrap_x86_64.S
gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -DCOMPILE_PAYLOAD -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx\
 -mno-sse -fno-pie -c -o lib_x86.o lib_x86.c
gcc -I/home/rich/kernel/ltp/testcases/kernel/kvm/include -I../../../include -I../../../include -I../../../include/old/ -DCOMPILE_PAYLOAD -ff\
reestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse -fno-pie -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexe\
cstack -no-pie -Wl,-T/home/rich/kernel/ltp/testcases/kernel/kvm/linker/x86_64.lds -o kvm_pagefault01-payload.elf kvm_pagefault01.c lib_guest\
.o bootstrap_x86_64.o lib_x86.o
/nix/store/inq79dwl8sz1ygmfbgsmg77i5cwmdjpz-binutils-2.40/bin/ld: lib_x86.o: in function `kvm_init_guest_vmcb':
lib_x86.c:(.text+0x7b3): undefined reference to `__stack_chk_fail'
collect2: error: ld returned 1 exit status
make: *** [Makefile:58: kvm_pagefault01-payload.o] Error 1

IIUC __stack_chk_fail is added to lib_x86.o which means that
-fstack-protector somehow gets added to the compilation of lib_x86.o.

I found that adding the GUEST_LDFLAGS to the lib_*.o compilations
fixes the issue on Nix.
---
 testcases/kernel/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index d9eb10728..ddb24fabe 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -46,7 +46,7 @@ MAKE_TARGETS =
 endif
 
 lib_guest.o $(ARCH_OBJ): CPPFLAGS	:= $(GUEST_CPPFLAGS)
-lib_guest.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS)
+lib_guest.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS) $(GUEST_LDFLAGS)
 
 kvm_svm03: CFLAGS += -pthread
 kvm_svm03: LDLIBS += -pthread
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
