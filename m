Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4C6CD54A8
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 08:39:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F7E03CE46F
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 10:39:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0EEF3CA70E
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 10:39:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE67F1BB9C26
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 10:39:20 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0293E22930;
 Tue, 19 Sep 2023 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695112760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yAA2/QESHCvoevvThGRQsxl0m25WypHWKxWBc3QV/+U=;
 b=Ah2/phgfH97Pft2XRmdUlUvjokL3qm55m2CTBt9r6d/K+cEfgG0lwSC3AKOxoP8P08gsNb
 wdxgLfy2laBUqCqKoPcsJiGFYybVTpNR6jghFpTst55Uc6et6F1HIwJ8Wrqijo/i+xB2Dw
 3AJ9DdriViJlmYjFAm1XxcLEGshDsrk=
Received: from g78.cable.virginm.net (rpalethorpe.tcp.ovpn1.nue.suse.de
 [10.163.17.14]) by relay2.suse.de (Postfix) with ESMTP id A374B2C142;
 Tue, 19 Sep 2023 08:39:19 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 09:38:27 +0100
Message-ID: <20230919083827.8423-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kvm: Fix Nix build failure by moving
 -fno-stack-protector to CFLAGS
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

Nix (and by extension NixOS) uses a binutils wrapper of some sort to
allow switching between toolchains. This seems to be causing a problem
for the KVM tests although it may not be unique to Nix.

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

__stack_chk_fail is added to lib_x86.o which means that
-fstack-protector somehow gets added to the compilation of lib_x86.o.

Swapping -fno-stack-protector from the LD flags to the C flags ensures
it is disabled when compiling lib_x86.o.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/kvm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index d9eb10728..ce4a5ede2 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -8,8 +8,8 @@ include $(top_srcdir)/include/mk/testcases.mk
 ASFLAGS =
 CPPFLAGS += -I$(abs_srcdir)/include
 GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
-GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
-GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexecstack
+GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -fno-stack-protector -mno-mmx -mno-sse
+GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -z noexecstack
 GUEST_LDLIBS =
 KVM_LD ?= $(LD)
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
