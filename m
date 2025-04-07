Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24629C369A3
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E451A3CB1E9
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:25:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D8203CB16B
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:06 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7AFCD600857
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B77252115A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TD5BmEl0t6f0syyNFIFel+Kl/L7+ggb0ADcnjcUPrsg=;
 b=H0cwzwcQusjnljN3TJ0siruetcA8RA3HfQhcUXRjqYdEIHqFF8QzE7Ck/FdR0vWvWITeCu
 LlMo0uVdmJjFQUf/tU3ntw1+GH3Z1BnmEu//oyygjiHAkaBorQJgQ7HSiBRAK7ZhCqDTsM
 52rNf4ZcKSRFyRrVAcYfVQ+C036RxBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TD5BmEl0t6f0syyNFIFel+Kl/L7+ggb0ADcnjcUPrsg=;
 b=A+JdZYEXhzZZx0yEqGI56mAkLbCUpuK5XO27YDDtgSO2lyHYuctiY2yfXFH7j0OpDXy4jF
 MvLvMxTlXVLeHzDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rzPU0uOI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vdZbraF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TD5BmEl0t6f0syyNFIFel+Kl/L7+ggb0ADcnjcUPrsg=;
 b=rzPU0uOIQNdzZVMe3vO6Ll7myRKOZ145HcLUxyffI3q0RxR+nOeZvVkg/40VDLlt0zLQll
 ceLJeumOkVWjxjytnYBpbqXE6EAoftnDAfI9VTaA+j8wfMTYrtg4g6Ma6jPVyyJloAupBV
 rAGNNJhxr9g1SedTmyP8UQLwVS3svBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TD5BmEl0t6f0syyNFIFel+Kl/L7+ggb0ADcnjcUPrsg=;
 b=vdZbraF32UOI5AtBBX7znEgjoa2svtjANu3j4QFVbCv5DwdHJfyrLRXDOh+L4+RlOAOnN8
 KSdB8TSnB4JFhKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C83F13ACB
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WKv+Jf/f82e5KAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 14:23:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 16:23:47 +0200
Message-ID: <20250407142351.25900-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407142351.25900-1-mdoucha@suse.cz>
References: <20250407142351.25900-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B77252115A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] KVM: Simplify reading VMX control field masks
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

Some VMX control fields have two different MSRs holding supported bit
masks. Add a helper function to read the correct MSR.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/include/kvm_x86_vmx.h | 10 +++++
 testcases/kernel/kvm/kvm_vmx01.c           |  7 +---
 testcases/kernel/kvm/lib_x86.c             | 48 +++++++++++++++++-----
 3 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/kvm/include/kvm_x86_vmx.h b/testcases/kernel/kvm/include/kvm_x86_vmx.h
index 180a114e7..92e3c683e 100644
--- a/testcases/kernel/kvm/include/kvm_x86_vmx.h
+++ b/testcases/kernel/kvm/include/kvm_x86_vmx.h
@@ -28,6 +28,15 @@
 #define MSR_IA32_VMX_EXECCTL_MASK2 0x48e
 #define MSR_IA32_VMX_EXITCTL_MASK2 0x48f
 #define MSR_IA32_VMX_ENTRYCTL_MASK2 0x490
+#define MSR_IA32_VMX_EXECCTL3_MASK 0x492
+
+#define VMX_CTLMASK_PINX 0
+#define VMX_CTLMASK_EXECCTL 1
+#define VMX_CTLMASK_EXECCTL2 2
+#define VMX_CTLMASK_EXECCTL3 3
+#define VMX_CTLMASK_EXITCTL 4
+#define VMX_CTLMASK_ENTRYCTL 5
+#define VMX_CTLMASK_MAX 6
 
 #define IA32FC_LOCK (1 << 0)
 #define IA32FC_VMXON_SMX (1 << 1)
@@ -174,6 +183,7 @@ struct kvm_vmcs *kvm_alloc_vmcs(void);
 void kvm_vmcs_copy_gdt_descriptor(unsigned int gdt_id,
 	unsigned long vmcs_selector, unsigned long vmcs_flags,
 	unsigned long vmcs_limit, unsigned long vmcs_baseaddr);
+uint64_t kvm_vmx_read_vmctl_mask(unsigned int ctl_id);
 void kvm_init_vmx_vcpu(struct kvm_vmx_vcpu *cpu, uint16_t ss, void *rsp,
 	int (*guest_main)(void));
 struct kvm_vmx_vcpu *kvm_create_vmx_vcpu(int (*guest_main)(void),
diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
index 31ad75137..5bffbe946 100644
--- a/testcases/kernel/kvm/kvm_vmx01.c
+++ b/testcases/kernel/kvm/kvm_vmx01.c
@@ -152,10 +152,7 @@ void main(void)
 	kvm_set_vmx_state(1);
 
 	/* Check secondary VMCS execctl support */
-	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS)
-		val = kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK2);
-	else
-		val = kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK);
+	val = kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL);
 
 	if (!((val >> 32) & VMX_EXECCTL_ENABLE_CTL2))
 		tst_brk(TCONF, "CPU does not support shadow VMCS");
@@ -169,7 +166,7 @@ void main(void)
 	val = kvm_vmx_vmread(VMX_VMCS_VMEXEC_CTL);
 	val |= VMX_EXECCTL_ENABLE_CTL2;
 	kvm_vmx_vmwrite(VMX_VMCS_VMEXEC_CTL, val);
-	val = kvm_rdmsr(MSR_IA32_VMX_EXECCTL2_MASK);
+	val = kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL2);
 
 	if (!((val >> 32) & VMX_EXECCTL2_SHADOW_VMCS))
 		tst_brk(TCONF, "CPU does not support shadow VMCS");
diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
index e6acc0797..c3363e033 100644
--- a/testcases/kernel/kvm/lib_x86.c
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -119,6 +119,24 @@ static const char *vmx_error_description[VMX_VMINST_ERR_COUNT] = {
 	"Invalid operand to INVEPT/INVVPID"
 };
 
+static const unsigned int vmx_ctl_masks_old[VMX_CTLMASK_MAX] = {
+	MSR_IA32_VMX_PINX_MASK,
+	MSR_IA32_VMX_EXECCTL_MASK,
+	MSR_IA32_VMX_EXECCTL2_MASK,
+	MSR_IA32_VMX_EXECCTL3_MASK,
+	MSR_IA32_VMX_EXITCTL_MASK,
+	MSR_IA32_VMX_ENTRYCTL_MASK
+};
+
+static const unsigned int vmx_ctl_masks_new[VMX_CTLMASK_MAX] = {
+	MSR_IA32_VMX_PINX_MASK2,
+	MSR_IA32_VMX_EXECCTL_MASK2,
+	MSR_IA32_VMX_EXECCTL2_MASK,
+	MSR_IA32_VMX_EXECCTL3_MASK,
+	MSR_IA32_VMX_EXITCTL_MASK2,
+	MSR_IA32_VMX_ENTRYCTL_MASK2
+};
+
 static void kvm_set_intr_handler(unsigned int id, uintptr_t func)
 {
 	memset(kvm_idt + id, 0, sizeof(kvm_idt[0]));
@@ -711,6 +729,21 @@ void kvm_vmcs_copy_gdt_descriptor(unsigned int gdt_id,
 	kvm_vmx_vmwrite(vmcs_baseaddr, baseaddr);
 }
 
+uint64_t kvm_vmx_read_vmctl_mask(unsigned int ctl_id)
+{
+	unsigned int msr;
+
+	if (ctl_id >= VMX_CTLMASK_MAX)
+		tst_brk(TBROK, "Invalid VMX control ID %u", ctl_id);
+
+	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS)
+		msr = vmx_ctl_masks_new[ctl_id];
+	else
+		msr = vmx_ctl_masks_old[ctl_id];
+
+	return kvm_rdmsr(msr);
+}
+
 void kvm_init_vmx_vcpu(struct kvm_vmx_vcpu *cpu, uint16_t ss, void *rsp,
 	int (*guest_main)(void))
 {
@@ -730,17 +763,10 @@ void kvm_init_vmx_vcpu(struct kvm_vmx_vcpu *cpu, uint16_t ss, void *rsp,
 	kvm_vmx_vmptrld(cpu->vmcs);
 
 	/* Configure VM execution control fields */
-	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS) {
-		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK2);
-		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK2);
-		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK2);
-		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK2);
-	} else {
-		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK);
-		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK);
-		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK);
-		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK);
-	}
+	pinxctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_PINX);
+	execctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL);
+	exitctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXITCTL);
+	entryctl = (uint32_t)kvm_vmx_read_vmctl_mask(VMX_CTLMASK_ENTRYCTL);
 
 	execctl |= VMX_INTERCEPT_HLT;
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
