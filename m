Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE76FC74A5B
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 17:15:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 637BD3CD5F8
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 18:15:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC0B03CA013
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 18:15:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 663B72002AD
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 18:15:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 726BE229F4
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678727708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cMyuo1bfJyMxefumNYM5ei99gNt2wJVD7YCK2ByT4CY=;
 b=1D5bZj2N3CkSY/EOlHgvQ/Amlg1D6PWaV9XmzC9Qd28LPyNr75AsIkV/ipU3bycyJU+NqM
 Knt9UCAblCCj9W4qXYD14D/dpKrLyFMBR9aE//Fk/t+t8xuAMpvjpuMqCBIypBoGO0Pu7b
 dITCZA6K+Ot5urfKvDyRTKRJmqFMoK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678727708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cMyuo1bfJyMxefumNYM5ei99gNt2wJVD7YCK2ByT4CY=;
 b=wjyKcsheQtcl2Y3AEXRXR+KgPNJv2NuDqmUTbISNFusUkfiRqkQKpJemSnkX7UQxsGitK8
 Ti7RM1SNOKlQHaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57B3313582
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 17:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cAeEFBxaD2Q9KgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 17:15:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Mar 2023 18:15:07 +0100
Message-Id: <20230313171507.1257-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] KVM: Fix ELF segment with RWX permissions warnings
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

Linker complains that some ASM bootstrap segments have both write
and execute permissions. Rename .data.gdt32 section because the ASM
compiler seems to make it writable regardless of section flags.
Also define new ELF segment for writable data sections.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/Makefile           | 2 +-
 testcases/kernel/kvm/bootstrap_x86.S    | 2 +-
 testcases/kernel/kvm/bootstrap_x86_64.S | 2 +-
 testcases/kernel/kvm/linker/x86.lds     | 5 +++--
 testcases/kernel/kvm/linker/x86_64.lds  | 5 +++--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index 6986844be..e12cb4e98 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -9,7 +9,7 @@ ASFLAGS =
 CPPFLAGS += -I$(abs_srcdir)/include
 GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
 GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
-GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector
+GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexecstack
 GUEST_LDLIBS =
 KVM_LD ?= $(LD)
 
diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
index 5ec4c0b7e..1aaf0a4d1 100644
--- a/testcases/kernel/kvm/bootstrap_x86.S
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -31,7 +31,7 @@ protected_mode_entry:
 	mov %eax, %es
 	jmp init_memlayout
 
-.section .data.gdt32, "a", @progbits
+.section .init.gdt32, "a", @progbits
 
 .macro gdt32_entry type:req l=0 d=0 dpl=0 limit=0xfffff g=1 p=1
 	.4byte \limit & 0xffff
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
index 9ddbd17ed..0cffd5a12 100644
--- a/testcases/kernel/kvm/bootstrap_x86_64.S
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -32,7 +32,7 @@ protected_mode_entry:
 	mov %eax, %es
 	jmp init_memlayout
 
-.section .data.gdt32, "a", @progbits
+.section .init.gdt32, "a", @progbits
 
 .macro gdt32_entry type:req l=0 d=0 dpl=0 limit=0xfffff g=1 p=1
 	.4byte \limit & 0xffff
diff --git a/testcases/kernel/kvm/linker/x86.lds b/testcases/kernel/kvm/linker/x86.lds
index 95edb0be0..6e69c4d0f 100644
--- a/testcases/kernel/kvm/linker/x86.lds
+++ b/testcases/kernel/kvm/linker/x86.lds
@@ -4,6 +4,7 @@ PHDRS
 {
 	headers PT_PHDR PHDRS ;
 	text PT_LOAD FILEHDR PHDRS ;
+	data PT_LOAD ;
 	bss PT_LOAD ;
 }
 
@@ -18,7 +19,7 @@ SECTIONS
 	.init.boot :
 	{
 		*(.init.protected_mode)
-		*(.data.gdt32)
+		*(.init.gdt32)
 		*(.init.memlayout)
 	} :text
 
@@ -40,7 +41,7 @@ SECTIONS
 	{
 		*(.data.strings)
 		*(.data)
-	}
+	} :data
 
 	.preinit_array :
 	{
diff --git a/testcases/kernel/kvm/linker/x86_64.lds b/testcases/kernel/kvm/linker/x86_64.lds
index ac372f863..9e62aa5ad 100644
--- a/testcases/kernel/kvm/linker/x86_64.lds
+++ b/testcases/kernel/kvm/linker/x86_64.lds
@@ -4,6 +4,7 @@ PHDRS
 {
 	headers PT_PHDR PHDRS ;
 	text PT_LOAD FILEHDR PHDRS ;
+	data PT_LOAD ;
 	bss PT_LOAD ;
 }
 
@@ -18,7 +19,7 @@ SECTIONS
 	.init.boot :
 	{
 		*(.init.protected_mode)
-		*(.data.gdt32)
+		*(.init.gdt32)
 		*(.init.memlayout)
 	} :text
 
@@ -40,7 +41,7 @@ SECTIONS
 	{
 		*(.data.strings)
 		*(.data)
-	}
+	} :data
 
 	.preinit_array :
 	{
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
