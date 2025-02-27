Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF35C19F2E
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 14:53:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BED143C9DE0
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 15:53:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F2483C9D44
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 13:43:40 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=ross.burton@arm.com; receiver=lists.linux.it)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 5177C20D1B7
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 13:43:39 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8102BCA
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 04:43:53 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCDA13F673
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 04:43:37 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Feb 2025 12:43:30 +0000
Message-ID: <20250227124330.949015-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 27 Feb 2025 15:52:46 +0100
Subject: [LTP] [PATCH] kernel/kvm: don't hardcode objcopy
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

testcases/kernel/kvm uses objcopy to contruct a payload binary, but in
cross builds the host objcopy may not know how to handle target
binaries:

 CC testcases/kernel/kvm/lib_host.o
 objcopy: Unable to recognise the format of the input file `kvm_svm03-payload.elf'
 make[3]: *** [ltp/testcases/kernel/kvm/Makefile:67: kvm_svm03-payload.o] Error 1

This is trivially fixed by searching for an objcopy tool (so
host-prefixed in cross builds) and using that instead.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 configure.ac                  | 1 +
 include/mk/config.mk.in       | 1 +
 testcases/kernel/kvm/Makefile | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 344b2ae2c..0f2b6f332 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,6 +30,7 @@ AC_PROG_RANLIB
 AC_DEFUN([AC_PROG_STRIP], [AC_CHECK_TOOL(STRIP, strip, :)])
 AC_PROG_STRIP
 AC_PROG_YACC
+AC_CHECK_TOOL([OBJCOPY], [objcopy], [:])
 
 m4_ifndef([PKG_CHECK_EXISTS],
 	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency), see INSTALL])])
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 2b7c8a071..4c3da304f 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -11,6 +11,7 @@ AR			:= @AR@
 CC			:= @CC@
 LEX			:= @LEX@
 RANLIB			:= @RANLIB@
+OBJCOPY			:= @OBJCOPY@
 STRIP			:= @STRIP@
 YACC			:= @YACC@
 
diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index 07bdd9705..e93528a33 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -60,11 +60,11 @@ include $(top_srcdir)/include/mk/generic_leaf_target.mk
 %-payload.o: %.c lib_guest.o $(ARCH_OBJ)
 ifdef VERBOSE
 	$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
-	objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
+	$(OBJCOPY) -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
 	$(KVM_LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
 else
 	@$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
-	@objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
+	@$(OBJCOPY) -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
 	@$(KVM_LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
 	@echo KVM_CC $(target_rel_dir)$@
 endif
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
