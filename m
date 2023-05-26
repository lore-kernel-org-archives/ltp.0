Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECE1C7EE23
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 13:36:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153C03CEF1C
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 15:36:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00ADE3CA154
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 452E01A003FF
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A79E1FD76;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685108076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waylLa20IFfwLc/fBEh1f30FhSBX9nN1LdEJHKpXSl4=;
 b=wFZcsWitQKM6SHtGznso5arHVVxuMlOMgpOFk4yCiVUVLiXcprI6eH6KS86SNhmaAKk54k
 hjSHXyqihDiaX8pfV7nVY8KPIs/Gin8aws6H5XqlutTm7YKItzqTXD/CBtvVv/SqE7KO1b
 WGTOpH+mxcciKrZkJl9remCGIPFQ6MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685108076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waylLa20IFfwLc/fBEh1f30FhSBX9nN1LdEJHKpXSl4=;
 b=836bLjEJ78kh0X9TleLo0RQIcTj9Klat4u61f7QP8bWRexvS75t3Fk/bZqFgifQtNtE72f
 NOoTabbTf2IjPXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63585138E6;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gKKJF2y1cGTMZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 26 May 2023 13:34:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 May 2023 15:34:30 +0200
Message-Id: <20230526133435.7369-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526133435.7369-1-mdoucha@suse.cz>
References: <20230526133435.7369-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] Add test for CVE 2021-3656
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
Cc: Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Acked-by: Petr Vorel <pvorel@suse.cz>
---

The reproducer was verified on vulnerable SLE kernels.

Change since v1:
- Removed unused AVIC constants

 runtest/kvm                      |   1 +
 testcases/kernel/kvm/.gitignore  |   1 +
 testcases/kernel/kvm/kvm_svm02.c | 152 +++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 testcases/kernel/kvm/kvm_svm02.c

diff --git a/runtest/kvm b/runtest/kvm
index 726d72f0a..59e410beb 100644
--- a/runtest/kvm
+++ b/runtest/kvm
@@ -1,2 +1,3 @@
 kvm_pagefault01 kvm_pagefault01
 kvm_svm01 kvm_svm01
+kvm_svm02 kvm_svm02
diff --git a/testcases/kernel/kvm/.gitignore b/testcases/kernel/kvm/.gitignore
index b284b9528..c757cd3f4 100644
--- a/testcases/kernel/kvm/.gitignore
+++ b/testcases/kernel/kvm/.gitignore
@@ -1,2 +1,3 @@
 /kvm_pagefault01
 /kvm_svm01
+/kvm_svm02
diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
new file mode 100644
index 000000000..e6ff5e874
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * CVE 2021-3656
+ *
+ * Check that KVM correctly intercepts VMSAVE and VMLOAD instructions
+ * in a nested virtual machine even when the parent guest disables
+ * intercepting either instruction. If KVM does not override the disabled
+ * intercepts, it'll give the nested VM read/write access to a few bytes
+ * of an arbitrary physical memory page. Unauthorized memory access fixed in:
+ *
+ *  commit c7dfa4009965a9b2d7b329ee970eb8da0d32f0bc
+ *  Author: Maxim Levitsky <mlevitsk@redhat.com>
+ *  Date:   Mon Jul 19 16:05:00 2021 +0300
+ *
+ *  KVM: nSVM: always intercept VMLOAD/VMSAVE when nested (CVE-2021-3656)
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#if defined(__i386__) || defined(__x86_64__)
+
+#include "kvm_x86_svm.h"
+
+static void *vmsave_buf;
+
+/* Load FS, GS, TR and LDTR state from vmsave_buf */
+static int guest_vmload(void)
+{
+	asm (
+		"vmload\n"
+		:
+		: "a" (vmsave_buf)
+	);
+	return 0;
+}
+
+/* Save current FS, GS, TR and LDTR state to vmsave_buf */
+static int guest_vmsave(void)
+{
+	asm (
+		"vmsave\n"
+		:
+		: "a" (vmsave_buf)
+	);
+	return 0;
+}
+
+static int cmp_descriptor(const struct kvm_vmcb_descriptor *a,
+	const struct kvm_vmcb_descriptor *b)
+{
+	int ret;
+
+	ret = a->selector != b->selector;
+	ret = ret || a->attrib != b->attrib;
+	ret = ret || a->limit != b->limit;
+	ret = ret || a->base != b->base;
+	return ret;
+}
+
+/* Return non-zero if the VMCB fields touched by vmsave/vmload differ */
+static int cmp_vmcb(const struct kvm_vmcb *a, const struct kvm_vmcb *b)
+{
+	int ret;
+
+	ret = cmp_descriptor(&a->fs, &b->fs);
+	ret = ret || cmp_descriptor(&a->gs, &b->gs);
+	ret = ret || cmp_descriptor(&a->tr, &b->tr);
+	ret = ret || cmp_descriptor(&a->ldtr, &b->ldtr);
+	ret = ret || a->kernel_gs_base != b->kernel_gs_base;
+	ret = ret || a->star != b->star;
+	ret = ret || a->lstar != b->lstar;
+	ret = ret || a->cstar != b->cstar;
+	ret = ret || a->sfmask != b->sfmask;
+	ret = ret || a->sysenter_cs != b->sysenter_cs;
+	ret = ret || a->sysenter_esp != b->sysenter_esp;
+	ret = ret || a->sysenter_eip != b->sysenter_eip;
+	return ret;
+}
+
+void main(void)
+{
+	uint16_t ss;
+	uint64_t rsp;
+	struct kvm_svm_vcpu *vcpu;
+
+	kvm_init_svm();
+	vcpu = kvm_create_svm_vcpu(guest_vmload, 1);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_VMLOAD, 0);
+	vmsave_buf = kvm_alloc_vmcb();
+
+	/* Save allocated stack for later VM reinit */
+	ss = vcpu->vmcb->ss.selector;
+	rsp = vcpu->vmcb->rsp;
+
+	/* Load partial state from vmsave_buf and save it to vcpu->vmcb */
+	kvm_svm_vmrun(vcpu);
+
+	if (vcpu->vmcb->exitcode != SVM_EXIT_HLT)
+		tst_brk(TBROK, "Nested VM exited unexpectedly");
+
+	if (cmp_vmcb(vcpu->vmcb, vmsave_buf)) {
+		tst_res(TFAIL, "Nested VM can read host memory");
+		return;
+	}
+
+	/* Load state from vcpu->vmcb and save it to vmsave_buf */
+	memset(vmsave_buf, 0xaa, sizeof(struct kvm_vmcb));
+	kvm_init_guest_vmcb(vcpu->vmcb, 1, ss, (void *)rsp, guest_vmsave);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_VMSAVE, 0);
+	kvm_svm_vmrun(vcpu);
+
+	if (vcpu->vmcb->exitcode != SVM_EXIT_HLT)
+		tst_brk(TBROK, "Nested VM exited unexpectedly");
+
+	if (cmp_vmcb(vcpu->vmcb, vmsave_buf)) {
+		tst_res(TFAIL, "Nested VM can overwrite host memory");
+		return;
+	}
+
+	tst_res(TPASS, "VMLOAD and VMSAVE were intercepted by kernel");
+}
+
+#else /* defined(__i386__) || defined(__x86_64__) */
+TST_TEST_TCONF("Test supported only on x86");
+#endif /* defined(__i386__) || defined(__x86_64__) */
+
+#else /* COMPILE_PAYLOAD */
+
+static struct tst_test test = {
+	.test_all = tst_kvm_run,
+	.setup = tst_kvm_setup,
+	.cleanup = tst_kvm_cleanup,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"x86",
+		NULL
+	},
+	.tags = (struct tst_tag[]){
+		{"linux-git", "c7dfa4009965"},
+		{"CVE", "2021-3656"},
+		{}
+	}
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
