Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12158C7618E
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97C213CBEF9
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 16:57:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01B083CBE81
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73081200B08
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A483B21983;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682089067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZX1nQuoMJFk55qRNR7ZQeTpOg63UaPPSAmq9S9U7IM=;
 b=kxEvmkBWdnyzUfZZ9d/8B0WFR64x9RqkAI6j4J+UPqukj69Vs53Xq9hqt9pkJ05zvocdON
 BJfpMzTtBjruHMWwaTjesr9LFjcgwxwv7QBZbbk37liv58EeKTLZDbdmFYksI689XJWCFJ
 egMQxuBTuIrlTK9l+bkiRipTEYECIgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682089067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZX1nQuoMJFk55qRNR7ZQeTpOg63UaPPSAmq9S9U7IM=;
 b=q4a+Sqx+YXYiZCGJqrUTaR1RqV2DN+t7vSVEv0Z6Uezk/NuQHgQYRcvecQgE6V737Ow4Cn
 VU9Nu69YHbhWHWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83A7A1390E;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +LuWHmukQmRfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Apr 2023 14:57:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: nstange@suse.de,
	ltp@lists.linux.it
Date: Fri, 21 Apr 2023 16:57:46 +0200
Message-Id: <20230421145746.5704-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421145746.5704-1-mdoucha@suse.cz>
References: <20230421145746.5704-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] Add test for CVE 2021-3653
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
 testcases/kernel/kvm/kvm_svm01.c | 123 +++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 testcases/kernel/kvm/kvm_svm01.c

diff --git a/testcases/kernel/kvm/kvm_svm01.c b/testcases/kernel/kvm/kvm_svm01.c
new file mode 100644
index 000000000..32d15526b
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_svm01.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * CVE 2021-3653
+ *
+ * Check that KVM either blocks enabling virtual interrupt controller (AVIC)
+ * in nested VMs or correctly sets up the required memory address translation.
+ * If AVIC is enabled without address translation in the host kernel,
+ * the nested VM will be able to read and write an arbitraty physical memory
+ * page specified by the parent VM. Unauthorized memory access fixed in:
+ *
+ *  commit 0f923e07124df069ba68d8bb12324398f4b6b709
+ *  Author: Maxim Levitsky <mlevitsk@redhat.com>
+ *  Date:   Thu Jul 15 01:56:24 2021 +0300
+ *
+ *  KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl (CVE-2021-3653)
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#if defined(__i386__) || defined(__x86_64__)
+
+#include "kvm_x86_svm.h"
+
+#define AVIC_REG_ADDR 0x280
+#define AVIC_TEST_VAL 0xec
+#define AVIC_READ_FAIL 0x12ead
+
+#define AVIC_INFO_MASK ((1ULL << 32) | 0xff0)
+#define AVIC_INFO_EXP ((1ULL << 32) | AVIC_REG_ADDR)
+
+static uint32_t * const avic_ptr = (uint32_t *)AVIC_REG_ADDR;
+
+static int guest_main(void)
+{
+	if (*avic_ptr != 0xaaaaaaaa)
+		return AVIC_READ_FAIL;
+
+	*avic_ptr = AVIC_TEST_VAL;
+	return 0;
+}
+
+void main(void)
+{
+	struct kvm_svm_vcpu *vcpu;
+
+	kvm_init_svm();
+	vcpu = kvm_create_svm_vcpu(guest_main, 1);
+
+	/*
+	 * Enable AVIC and set both the AVIC base address (where the nested VM
+	 * will write) and backing page address (where the parent VM expects
+	 * to see the changes) to 0
+	 */
+	vcpu->vmcb->virt_intr_ctl |= SVM_INTR_AVIC;
+	vcpu->vmcb->avic_backing_page = 0;
+	vcpu->vmcb->avic_bar = 0;
+	memset((void *)8, 0xaa, PAGESIZE - 8);
+
+	/* Write into AVIC backing page in the nested VM */
+	kvm_svm_vmrun(vcpu);
+
+	switch (vcpu->vmcb->exitcode) {
+	case SVM_EXIT_HLT:
+		if (vcpu->vmcb->rax == AVIC_READ_FAIL) {
+			tst_res(TFAIL, "Nested VM can read host memory");
+			return;
+		}
+
+		if (vcpu->vmcb->rax)
+			tst_brk(TBROK, "Unexpected guest_main() return value");
+
+		break;
+
+	case SVM_EXIT_AVIC_NOACCEL:
+		if ((vcpu->vmcb->exitinfo1 & AVIC_INFO_MASK) == AVIC_INFO_EXP) {
+			tst_res(TPASS, "AVIC register write caused VMEXIT");
+			break;
+		}
+
+		/* unexpected exit, fall through */
+
+	default:
+		tst_brk(TBROK, "Nested VM exited unexpectedly");
+	}
+
+	if (*avic_ptr != AVIC_TEST_VAL) {
+		tst_res(TFAIL, "Write into AVIC ESR redirected to host memory");
+		return;
+	}
+
+	tst_res(TPASS, "Writes into AVIC backing page were not redirected");
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
+		{"linux-git", "0f923e07124d"},
+		{"CVE", "2021-3653"},
+		{}
+	}
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
