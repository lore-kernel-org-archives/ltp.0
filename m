Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FE4C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:46:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 794CB3C2A84
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:46:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38E3E3C296A
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 935F01BD79FA
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 799BC1F455
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sl7d9W9RRubswhelFj4i/jbUdXPKQj95y9GYIobaiUE=;
 b=AWq/Wmu9NOMbOoaOmUl22fjzuzATwe34ssusxYoo98X+gO+UqN/gdZgfDObiHHpqOwlFqT
 zwqbGyNw+frMuFhfflVJlVA3MRo7PeNlyK2E2vDBpZ4x5EqvZvCy8IqZxRB1nsuGvYYVT/
 MZ5IcJ4wVC6eXHXF3Y6JNuLLnJIJ5SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sl7d9W9RRubswhelFj4i/jbUdXPKQj95y9GYIobaiUE=;
 b=7f0IdsMDKzyt8XwyylLOQba9vyvjNMDpugID61w9ac58/X9ijS8+R1Ew5zB08abp7BC5xr
 e2vgXT4N7p6pyPCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="AWq/Wmu9";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7f0IdsMD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sl7d9W9RRubswhelFj4i/jbUdXPKQj95y9GYIobaiUE=;
 b=AWq/Wmu9NOMbOoaOmUl22fjzuzATwe34ssusxYoo98X+gO+UqN/gdZgfDObiHHpqOwlFqT
 zwqbGyNw+frMuFhfflVJlVA3MRo7PeNlyK2E2vDBpZ4x5EqvZvCy8IqZxRB1nsuGvYYVT/
 MZ5IcJ4wVC6eXHXF3Y6JNuLLnJIJ5SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sl7d9W9RRubswhelFj4i/jbUdXPKQj95y9GYIobaiUE=;
 b=7f0IdsMDKzyt8XwyylLOQba9vyvjNMDpugID61w9ac58/X9ijS8+R1Ew5zB08abp7BC5xr
 e2vgXT4N7p6pyPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F14E13ABC
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8GbtGu3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:24 +0100
Message-ID: <20250121164426.27977-11-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 799BC1F455
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/10] KVM: Add functional test for emulated
 VMREAD/VMWRITE instructions
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
 testcases/kernel/kvm/kvm_vmx01.c | 282 +++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 testcases/kernel/kvm/kvm_vmx01.c

diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
new file mode 100644
index 000000000..c413b4148
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_vmx01.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * Basic functional test for VMREAD/VMWRITE instructions in KVM environment.
+ * Verify that VMWRITE instruction changes the contents of current VMCS and
+ * the values written into shadow VMCS can be read in both parent and nested
+ * VM.
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#if defined(__i386__) || defined(__x86_64__)
+
+#include "kvm_x86_vmx.h"
+
+#define GUEST_READ_ERROR 1
+#define GUEST_WRITE_ERROR 2
+#define SHADOW_DATA_LENGTH 37
+#define VMCS_FIELD(x) x, #x
+
+struct vmcs_field_table {
+	unsigned long field_id;
+	const char *name;
+	uint64_t value;
+};
+
+/* Data written into shadow VMCS by the parent VM and read by the nested VM */
+static struct vmcs_field_table host_data[SHADOW_DATA_LENGTH] = {
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES), 0xe5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS), 0xc5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS), 0x55},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS), 0xd5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS), 0xf5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS), 0x65},
+	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR), 0x1d72},
+	{VMCS_FIELD(VMX_VMCS_GUEST_TR), 0x72},
+	{VMCS_FIELD(VMX_VMCS_HOST_ES), 0x5e},
+	{VMCS_FIELD(VMX_VMCS_HOST_CS), 0x5c},
+	{VMCS_FIELD(VMX_VMCS_HOST_SS), 0x55},
+	{VMCS_FIELD(VMX_VMCS_HOST_DS), 0x5d},
+	{VMCS_FIELD(VMX_VMCS_HOST_FS), 0x5f},
+	{VMCS_FIELD(VMX_VMCS_HOST_GS), 0x56},
+	{VMCS_FIELD(VMX_VMCS_HOST_TR), 0x27},
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES_LIMIT), 0xe51},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS_LIMIT), 0xc51},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS_LIMIT), 0x551},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS_LIMIT), 0xd51},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS_LIMIT), 0xf51},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS_LIMIT), 0x651},
+	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR_LIMIT), 0x1d721},
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES_ACCESS), 0xa0e5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS_ACCESS), 0xa0c5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS_ACCESS), 0xa055},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS_ACCESS), 0xa0d5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS_ACCESS), 0xa0f5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS_ACCESS), 0xa065},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SYSENTER_CS), 0x65c},
+	{VMCS_FIELD(VMX_VMCS_HOST_SYSENTER_CS), 0x45c},
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES_BASE), 0xe5b},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS_BASE), 0xc5b},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS_BASE), 0x55b},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS_BASE), 0xd5b},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS_BASE), 0xf5b},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS_BASE), 0x65b},
+	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR_BASE), 0x1d72b}
+};
+
+/* Data written into shadow VMCS by the nested VM and read by the parent VM */
+static struct vmcs_field_table guest_data[SHADOW_DATA_LENGTH] = {
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES), 0x5e},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS), 0x5c},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS), 0x55},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS), 0x5d},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS), 0x5f},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS), 0x56},
+	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR), 0x721d},
+	{VMCS_FIELD(VMX_VMCS_GUEST_TR), 0x27},
+	{VMCS_FIELD(VMX_VMCS_HOST_ES), 0xe5},
+	{VMCS_FIELD(VMX_VMCS_HOST_CS), 0xc5},
+	{VMCS_FIELD(VMX_VMCS_HOST_SS), 0x55},
+	{VMCS_FIELD(VMX_VMCS_HOST_DS), 0xd5},
+	{VMCS_FIELD(VMX_VMCS_HOST_FS), 0xf5},
+	{VMCS_FIELD(VMX_VMCS_HOST_GS), 0x65},
+	{VMCS_FIELD(VMX_VMCS_HOST_TR), 0x72},
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES_LIMIT), 0x1e5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS_LIMIT), 0x1c5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS_LIMIT), 0x155},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS_LIMIT), 0x1d5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS_LIMIT), 0x1f5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS_LIMIT), 0x165},
+	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR_LIMIT), 0x11d72},
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES_ACCESS), 0xa05e},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS_ACCESS), 0xa05c},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS_ACCESS), 0xa055},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS_ACCESS), 0xa05d},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS_ACCESS), 0xa05f},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS_ACCESS), 0xa056},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SYSENTER_CS), 0x5c6},
+	{VMCS_FIELD(VMX_VMCS_HOST_SYSENTER_CS), 0x5c4},
+	{VMCS_FIELD(VMX_VMCS_GUEST_ES_BASE), 0xbe5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_CS_BASE), 0xbc5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_SS_BASE), 0xb55},
+	{VMCS_FIELD(VMX_VMCS_GUEST_DS_BASE), 0xbd5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_FS_BASE), 0xbf5},
+	{VMCS_FIELD(VMX_VMCS_GUEST_GS_BASE), 0xb65},
+	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR_BASE), 0xb1d72}
+};
+
+static uint64_t vmread_buffer[SHADOW_DATA_LENGTH];
+
+int guest_main(void)
+{
+	int i;
+
+	/* kvm_vmx_vmread() calls tst_brk(), don't use it in nested VM */
+	for (i = 0; i < SHADOW_DATA_LENGTH; i++) {
+		asm goto(
+			"vmread %1, (%0)\n"
+			"jna %l[read_error]\n"
+			"vmwrite %2, %3\n"
+			"jna %l[write_error]\n"
+			:
+			: "r" (&vmread_buffer[i]), "r" (host_data[i].field_id),
+				"r" (guest_data[i].value),
+				"r" (guest_data[i].field_id)
+			: "cc", "memory"
+			: read_error, write_error
+		);
+	}
+
+	return 0;
+
+read_error:
+	return GUEST_READ_ERROR;
+
+write_error:
+	return GUEST_WRITE_ERROR;
+}
+
+void main(void)
+{
+	struct kvm_vmx_vcpu *vcpu;
+	struct kvm_vmcs *shadow_vmcs;
+	char *vmcs_backup;
+	int i, errors;
+	uint64_t val;
+
+	kvm_set_vmx_state(1);
+
+	/* Check secondary VMCS execctl support */
+	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS)
+		val = kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK2);
+	else
+		val = kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK);
+
+	if (!((val >> 32) & VMX_EXECCTL_ENABLE_CTL2))
+		tst_brk(TCONF, "CPU does not support shadow VMCS");
+
+	/* Create and configure guest VMCS */
+	shadow_vmcs = kvm_alloc_vmcs();
+	kvm_vmx_vmclear(shadow_vmcs);
+	shadow_vmcs->version |= VMX_SHADOW_VMCS;
+	vcpu = kvm_create_vmx_vcpu(guest_main, 1);
+	kvm_vmx_vmptrld(vcpu->vmcs);
+	val = kvm_vmx_vmread(VMX_VMCS_VMEXEC_CTL);
+	val |= VMX_EXECCTL_ENABLE_CTL2;
+	kvm_vmx_vmwrite(VMX_VMCS_VMEXEC_CTL, val);
+	val = kvm_rdmsr(MSR_IA32_VMX_EXECCTL2_MASK);
+
+	if (!((val >> 32) & VMX_EXECCTL2_SHADOW_VMCS))
+		tst_brk(TCONF, "CPU does not support shadow VMCS");
+
+	val = VMX_EXECCTL2_SHADOW_VMCS | (uint32_t)val;
+	kvm_vmx_vmwrite(VMX_VMCS_VMEXEC_CTL2, val);
+	kvm_vmx_vmwrite(VMX_VMCS_LINK_POINTER, (uintptr_t)shadow_vmcs);
+
+	/* Configure shadow VMCS */
+	vmcs_backup = tst_heap_alloc(sizeof(struct kvm_vmcs));
+	memcpy(vmcs_backup, shadow_vmcs, sizeof(struct kvm_vmcs));
+	kvm_vmx_vmptrld(shadow_vmcs);
+
+	for (i = 0; i < SHADOW_DATA_LENGTH; i++)
+		kvm_vmx_vmwrite(host_data[i].field_id, host_data[i].value);
+
+	/* Flush shadow VMCS just in case */
+	kvm_vmx_vmptrld(vcpu->vmcs);
+
+	if (!memcmp(vmcs_backup, shadow_vmcs, sizeof(struct kvm_vmcs)))
+		tst_res(TFAIL, "VMWRITE did not modify raw VMCS data");
+
+	/* Run nested VM */
+	memcpy(vmcs_backup, shadow_vmcs, sizeof(struct kvm_vmcs));
+	kvm_vmx_vmrun(vcpu);
+	val = kvm_vmx_vmread(VMX_VMCS_EXIT_REASON);
+
+	if (val != VMX_EXIT_HLT) {
+		tst_res(TFAIL, "Unexpected guest exit reason %llx", val);
+		return;
+	}
+
+	if (vcpu->regs.rax == GUEST_READ_ERROR) {
+		tst_res(TFAIL, "Guest failed to read shadow VMCS");
+		return;
+	}
+
+	if (vcpu->regs.rax == GUEST_WRITE_ERROR) {
+		tst_res(TFAIL, "Guest failed to write shadow VMCS");
+		return;
+	}
+
+	if (!memcmp(vmcs_backup, shadow_vmcs, sizeof(struct kvm_vmcs)))
+		tst_res(TFAIL, "Nested VMWRITE did not modify raw VMCS data");
+
+	/* Check values read by the nested VM from shadow VMCS */
+	for (i = 0, errors = 0; i < SHADOW_DATA_LENGTH; i++) {
+		if (vmread_buffer[i] == host_data[i].value)
+			continue;
+
+		errors++;
+		tst_res(TFAIL, "Shadow %s guest mismatch: %llx != %llx",
+			host_data[i].name, vmread_buffer[i],
+			host_data[i].value);
+	}
+
+	if (!errors)
+		tst_res(TPASS, "Guest read correct values from shadow VMCS");
+
+	/* Check values written by the nested VM to shadow VMCS */
+	kvm_vmx_vmptrld(shadow_vmcs);
+
+	for (i = 0, errors = 0; i < SHADOW_DATA_LENGTH; i++) {
+		val = kvm_vmx_vmread(guest_data[i].field_id);
+
+		if (val == guest_data[i].value)
+			continue;
+
+		errors++;
+		tst_res(TFAIL, "Shadow %s parent mismatch: %llx != %llx",
+			guest_data[i].name, val, guest_data[i].value);
+	}
+
+	if (!errors)
+		tst_res(TPASS, "Parent read correct values from shadow VMCS");
+}
+
+#else /* defined(__i386__) || defined(__x86_64__) */
+TST_TEST_TCONF("Test supported only on x86");
+#endif /* defined(__i386__) || defined(__x86_64__) */
+
+#else /* COMPILE_PAYLOAD */
+
+#include "tst_module.h"
+
+#define NESTED_INTEL_SYSFILE "/sys/module/kvm_intel/parameters/nested"
+
+static void setup(void)
+{
+	if (!tst_read_bool_sys_param(NESTED_INTEL_SYSFILE)) {
+		tst_module_reload("kvm_intel",
+			(char *const[]){"nested=1", NULL});
+	}
+
+	tst_kvm_setup();
+}
+
+static struct tst_test test = {
+	.test_all = tst_kvm_run,
+	.setup = setup,
+	.cleanup = tst_kvm_cleanup,
+	.needs_root = 1,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"x86",
+		NULL
+	},
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
