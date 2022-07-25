Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D3BC43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 15:37:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEB303C9480
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:37:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CCD43C071B
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:37:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8FE9410005F8
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:37:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5831E3504D
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658763448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j6r3uiMKAyJSjfQttTBAwwVjdTc0LTOP0N/+BAXjF7Y=;
 b=ICTnr6awpzJ3eQDMPhrF5gT7JZncUxjsq3shHIzLdv1X9KioPwPhbJtoaK/DTph7lUCRcA
 +KExv6KFamT/teidE94u+AAnuXy0pQ2H957ia60EMoGuC9fPKFxml1D6keK4nHgTKbb4k7
 6Y9Q98KCuRHAZEJq3Dq3plT9pDJZ2xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658763448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j6r3uiMKAyJSjfQttTBAwwVjdTc0LTOP0N/+BAXjF7Y=;
 b=FVF/pa0OB2KI7z1iqMIF8A3YS8yzaxO2QDf72CXw4N+6GI7KUMhZqrx/wHfP4rcJLg9v9E
 jchMzyAjX9jpvhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4925713ABB
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 15:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h40FEbi43mK+NgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 15:37:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Jul 2022 17:37:27 +0200
Message-Id: <20220725153727.30418-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add KVM_LD Makefile variable for building KVM payload
 binaries
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

KVM linker needs to be configurable for cross-compiling but some
linkers don't support the linker script for wrapping arbitrary files
into linkable resource files. Allow KVM linker to be changed
independently of $LD via $KVM_LD.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This should solve the issues with
https://github.com/linux-test-project/ltp/pull/948

 doc/build-system-guide.txt    | 5 +++++
 testcases/kernel/kvm/Makefile | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/build-system-guide.txt b/doc/build-system-guide.txt
index 166f7fb92..b8d267b4b 100644
--- a/doc/build-system-guide.txt
+++ b/doc/build-system-guide.txt
@@ -145,6 +145,11 @@ $(CPPFLAGS)		: Preprocessor flags, e.g. -I arguments.
 
 $(DEBUG_CFLAGS)		: Debug flags to pass to $(CC), -g, etc.
 
+$(KVM_LD)		: Special linker for wrapping KVM payload binaries
+			  into linkable object files. Defaults to $(LD).
+			  Change this variable if the KVM Makefile fails
+			  to build files named *-payload.o.
+
 $(LD)			: The system linker (typically $(CC), but not
 			  necessarily).
 
diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index 22a840da6..6986844be 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -11,6 +11,7 @@ GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
 GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
 GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector
 GUEST_LDLIBS =
+KVM_LD ?= $(LD)
 
 FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
 
@@ -53,11 +54,11 @@ include $(top_srcdir)/include/mk/generic_leaf_target.mk
 ifdef VERBOSE
 	$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
 	objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
-	$(LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+	$(KVM_LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
 else
 	@$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
 	@objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
-	@$(LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+	@$(KVM_LD) -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
 	@echo KVM_CC $(target_rel_dir)$@
 endif
 	@rm $*-payload.elf $*-payload.bin
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
