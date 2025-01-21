Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C478CC0218B
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:47:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66B893C2CA2
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:47:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F0B93C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8F1A6140C929
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C0361F395
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8/3EUGeLo1//WvMENl2i7XQlga+7dEZIp/nUnvscGI=;
 b=xBOV4otss0xlYymAsl7IOwtWQmPYfOEryI6uBWChyUjLahh2Clb9Cfh7/itQ+LTVuW0iS5
 Ou0kUFUIqyZCM3v51Hnvzk6pnnLek9F8ofgU0FXirZVehnpQhhzRvV/qNN0CkMu2zj9xsF
 btZoUfaFdcqd1ditpO2NUCXBP8qsZUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8/3EUGeLo1//WvMENl2i7XQlga+7dEZIp/nUnvscGI=;
 b=YF5AMJWkMCLiWF7N3q2B6giw/U4eTl1BT+/5dmTQL3UBu/uNYPGWNa6hTyYsT5pLXHAvVB
 ptY+28bX7Ls/iACA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xBOV4ots;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YF5AMJWk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8/3EUGeLo1//WvMENl2i7XQlga+7dEZIp/nUnvscGI=;
 b=xBOV4otss0xlYymAsl7IOwtWQmPYfOEryI6uBWChyUjLahh2Clb9Cfh7/itQ+LTVuW0iS5
 Ou0kUFUIqyZCM3v51Hnvzk6pnnLek9F8ofgU0FXirZVehnpQhhzRvV/qNN0CkMu2zj9xsF
 btZoUfaFdcqd1ditpO2NUCXBP8qsZUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8/3EUGeLo1//WvMENl2i7XQlga+7dEZIp/nUnvscGI=;
 b=YF5AMJWkMCLiWF7N3q2B6giw/U4eTl1BT+/5dmTQL3UBu/uNYPGWNa6hTyYsT5pLXHAvVB
 ptY+28bX7Ls/iACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C2BB139CB
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2B+eCu3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:16 +0100
Message-ID: <20250121164426.27977-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3C0361F395
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/10] kvm_svm_vmrun(): Simplify VM state save/load
 with macros
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/bootstrap_x86.S    | 57 +++++++++-----
 testcases/kernel/kvm/bootstrap_x86_64.S | 99 +++++++++++++++----------
 2 files changed, 98 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
index 79d2218d3..f08282461 100644
--- a/testcases/kernel/kvm/bootstrap_x86.S
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -361,6 +361,34 @@ kvm_svm_guest_entry:
 1:	hlt
 	jmp 1b
 
+/* vcpu structure address must be in %rdi */
+.macro load_vcpu_regs
+	movl 0x04(%edi), %eax
+	movl 0x0c(%edi), %ebx
+	movl 0x14(%edi), %ecx
+	movl 0x1c(%edi), %edx
+	/* save %edi last */
+	movl 0x2c(%edi), %esi
+	movl 0x34(%edi), %ebp
+	/* skip %esp */
+	movl 0x24(%edi), %edi
+.endm
+
+/* vcpu structure address must be on top of the stack */
+.macro save_vcpu_regs
+	push %edi
+	movl 4(%esp), %edi
+	movl %eax, 0x04(%edi)
+	movl %ebx, 0x0c(%edi)
+	movl %ecx, 0x14(%edi)
+	movl %edx, 0x1c(%edi)
+	pop %eax
+	movl %eax, 0x24(%edi)
+	movl %esi, 0x2c(%edi)
+	movl %ebp, 0x34(%edi)
+	/* skip %esp */
+.endm
+
 .global kvm_svm_vmrun
 kvm_svm_vmrun:
 	push %edi
@@ -377,17 +405,11 @@ kvm_svm_vmrun:
 	vmsave
 	push %eax
 
-	/* Load guest registers */
 	push %edi
-	movl (%edi), %eax
-	/* %eax is loaded by vmrun from VMCB */
-	movl 0x0c(%edi), %ebx
-	movl 0x14(%edi), %ecx
-	movl 0x1c(%edi), %edx
-	movl 0x2c(%edi), %esi
-	movl 0x34(%edi), %ebp
-	/* %esp is loaded by vmrun from VMCB */
-	movl 0x24(%edi), %edi
+	load_vcpu_regs
+	/* %eax = vcpu->vmcb; */
+	movl (%esp), %eax
+	movl (%eax), %eax
 
 	vmload
 	vmrun
@@ -395,8 +417,9 @@ kvm_svm_vmrun:
 
 	/* Clear guest register buffer */
 	push %edi
+	push %eax
 	push %ecx
-	movl 8(%esp), %edi
+	movl 12(%esp), %edi
 	addl $4, %edi
 	xorl %eax, %eax
 	mov $32, %ecx
@@ -404,17 +427,13 @@ kvm_svm_vmrun:
 	cld
 	rep stosl
 	popfl
-
-	/* Save guest registers */
 	pop %ecx
 	pop %eax
 	pop %edi
-	movl %ebx, 0x0c(%edi)
-	movl %ecx, 0x14(%edi)
-	movl %edx, 0x1c(%edi)
-	movl %eax, 0x24(%edi)
-	movl %esi, 0x2c(%edi)
-	movl %ebp, 0x34(%edi)
+
+	save_vcpu_regs
+	pop %edi
+
 	/* Copy %eax and %esp from VMCB */
 	movl (%edi), %esi
 	movl 0x5f8(%esi), %eax
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
index 32170f7c9..1e0a2952d 100644
--- a/testcases/kernel/kvm/bootstrap_x86_64.S
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -484,35 +484,16 @@ kvm_svm_guest_entry:
 1:	hlt
 	jmp 1b
 
-.global kvm_svm_vmrun
-kvm_svm_vmrun:
-	pushq %rbx
-	pushq %rbp
-	pushq %r12
-	pushq %r13
-	pushq %r14
-	pushq %r15
-
-	clgi
-
-	/* Save full host state */
-	movq $MSR_VM_HSAVE_PA, %rcx
-	rdmsr
-	shlq $32, %rdx
-	orq %rdx, %rax
-	vmsave
-	pushq %rax
-
-	/* Load guest registers */
-	pushq %rdi
-	movq (%rdi), %rax
-	/* %rax is loaded by vmrun from VMCB */
+/* vcpu structure address must be in %rdi */
+.macro load_vcpu_regs
+	movq 0x08(%rdi), %rax
 	movq 0x10(%rdi), %rbx
 	movq 0x18(%rdi), %rcx
 	movq 0x20(%rdi), %rdx
+	/* load %rdi last */
 	movq 0x30(%rdi), %rsi
 	movq 0x38(%rdi), %rbp
-	/* %rsp is loaded by vmrun from VMCB */
+	/* skip %rsp */
 	movq 0x48(%rdi), %r8
 	movq 0x50(%rdi), %r9
 	movq 0x58(%rdi), %r10
@@ -522,21 +503,21 @@ kvm_svm_vmrun:
 	movq 0x78(%rdi), %r14
 	movq 0x80(%rdi), %r15
 	movq 0x28(%rdi), %rdi
+.endm
 
-	vmload
-	vmrun
-	vmsave
-
-	/* Save guest registers */
-	movq %rdi, %rax
-	popq %rdi
+/* vcpu structure address must be on top of the stack */
+.macro save_vcpu_regs
+	pushq %rdi
+	movq 8(%rsp), %rdi
+	movq %rax, 0x08(%rdi)
 	movq %rbx, 0x10(%rdi)
 	movq %rcx, 0x18(%rdi)
 	movq %rdx, 0x20(%rdi)
-	/* %rax contains guest %rdi */
+	popq %rax
 	movq %rax, 0x28(%rdi)
 	movq %rsi, 0x30(%rdi)
 	movq %rbp, 0x38(%rdi)
+	/* skip %rsp */
 	movq %r8,  0x48(%rdi)
 	movq %r9,  0x50(%rdi)
 	movq %r10, 0x58(%rdi)
@@ -545,6 +526,52 @@ kvm_svm_vmrun:
 	movq %r13, 0x70(%rdi)
 	movq %r14, 0x78(%rdi)
 	movq %r15, 0x80(%rdi)
+.endm
+
+.macro push_local
+	pushq %rbx
+	pushq %rbp
+	pushq %r12
+	pushq %r13
+	pushq %r14
+	pushq %r15
+.endm
+
+.macro pop_local
+	popq %r15
+	popq %r14
+	popq %r13
+	popq %r12
+	popq %rbp
+	popq %rbx
+.endm
+
+.global kvm_svm_vmrun
+kvm_svm_vmrun:
+	push_local
+	clgi
+
+	/* Save full host state */
+	movq $MSR_VM_HSAVE_PA, %rcx
+	rdmsr
+	shlq $32, %rdx
+	orq %rdx, %rax
+	vmsave
+	pushq %rax
+
+	pushq %rdi
+	load_vcpu_regs
+	/* %rax = vcpu->vmcb; */
+	movq (%rsp), %rax
+	movq (%rax), %rax
+
+	vmload
+	vmrun
+	vmsave
+
+	save_vcpu_regs
+	popq %rdi
+
 	/* copy guest %rax and %rsp from VMCB*/
 	movq (%rdi), %rsi
 	movq 0x5f8(%rsi), %rax
@@ -557,13 +584,7 @@ kvm_svm_vmrun:
 	vmload
 
 	stgi
-
-	popq %r15
-	popq %r14
-	popq %r13
-	popq %r12
-	popq %rbp
-	popq %rbx
+	pop_local
 	retq
 
 .section .bss.pgtables, "aw", @nobits
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
