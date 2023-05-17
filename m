Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA8EC77B7D
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CB083CF266
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:37:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D01F3CB2D4
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0F982600879
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2C93226CD;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684337803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhEQNIGFmbcJ2AZl5IXTRc9lLiYDHKWPdvOURiPnvV4=;
 b=IHxFskLvPRa8GIfAUSqXKUs4DNVRFF19SxcNNxiaqFZuud9FF1wZLr1IMbuBLjUVvprVKh
 a2l64vfCZjin2UrYH3Z+mQnvUQ3hg2A7tR3CIrrWG3FJHEJplcraL3eIOWh/iEj1XnT8Nu
 CvBT65l4aoO/NRUTpWr32MgK/cxNFAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684337803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhEQNIGFmbcJ2AZl5IXTRc9lLiYDHKWPdvOURiPnvV4=;
 b=tsgdzX351ys7FD6lQnuqOz9j4ZAbfEdd4flG5EezCSamxyC4nNK3kqdceBFbPvqkefNZ2R
 IRwSJRPxYnludJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E9A613A5E;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IJL5IYv0ZGSTCgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 17 May 2023 15:36:43 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Nicolai Stange <nstange@suse.de>,
	ltp@lists.linux.it
Date: Wed, 17 May 2023 17:36:42 +0200
Message-Id: <20230517153642.26919-8-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517153642.26919-1-mdoucha@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/7] Add KVM test for CPU lockup through malicous SVM
 guest
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

The reproducer was verified on vulnerable SLE kernels.

 runtest/kvm                      |   1 +
 testcases/kernel/kvm/.gitignore  |   1 +
 testcases/kernel/kvm/Makefile    |   3 +
 testcases/kernel/kvm/kvm_svm03.c | 164 +++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 testcases/kernel/kvm/kvm_svm03.c

diff --git a/runtest/kvm b/runtest/kvm
index 59e410beb..4094a21a8 100644
--- a/runtest/kvm
+++ b/runtest/kvm
@@ -1,3 +1,4 @@
 kvm_pagefault01 kvm_pagefault01
 kvm_svm01 kvm_svm01
 kvm_svm02 kvm_svm02
+kvm_svm03 kvm_svm03
diff --git a/testcases/kernel/kvm/.gitignore b/testcases/kernel/kvm/.gitignore
index c757cd3f4..9638a6fc7 100644
--- a/testcases/kernel/kvm/.gitignore
+++ b/testcases/kernel/kvm/.gitignore
@@ -1,3 +1,4 @@
 /kvm_pagefault01
 /kvm_svm01
 /kvm_svm02
+/kvm_svm03
diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index e12cb4e98..03d754420 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -48,6 +48,9 @@ endif
 lib_guest.o $(ARCH_OBJ): CPPFLAGS	:= $(GUEST_CPPFLAGS)
 lib_guest.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS)
 
+kvm_svm03: CFLAGS += -pthread
+kvm_svm03: LDLIBS += -pthread -lrt
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 %-payload.o: %.c lib_guest.o $(ARCH_OBJ)
diff --git a/testcases/kernel/kvm/kvm_svm03.c b/testcases/kernel/kvm/kvm_svm03.c
new file mode 100644
index 000000000..365df789e
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_svm03.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * Check that KVM correctly intercepts the CLGI instruction in a nested
+ * virtual machine even when the parent guest disables intercept.
+ * If KVM does not override the disabled intercept, it'll allow the nested VM
+ * to hold the physical CPU indefinitely and potentially perform a denial
+ * of service attack against the host kernel. CPU lockup fixed in:
+ *
+ *  commit 91b7130cb6606d8c6b3b77e54426b3f3a83f48b1
+ *  Author: Paolo Bonzini <pbonzini@redhat.com>
+ *  Date:   Fri May 22 12:28:52 2020 -0400
+ *
+ *  KVM: SVM: preserve VGIF across VMCB switch
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#if defined(__i386__) || defined(__x86_64__)
+
+#include "kvm_x86_svm.h"
+
+/* Disable global interrupts */
+static int guest_clgi(void)
+{
+	int ret, *result = (int *)KVM_RESULT_BASEADDR;
+
+	/*
+	 * Make sure that result page is present in memory. CLGI may disable
+	 * page fault handling on the current CPU. The actual value
+	 * at that address is irrelevant.
+	 */
+	ret = *result;
+
+	/* Disable global interrupts */
+	asm ("clgi");
+
+	/* Signal host to kill the VM and wait */
+	tst_wait_host(NULL);
+	return ret;
+}
+
+void main(void)
+{
+	struct kvm_svm_vcpu *vcpu;
+
+	kvm_init_svm();
+	vcpu = kvm_create_svm_vcpu(guest_clgi, 1);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_CLGI, 0);
+	kvm_svm_vmrun(vcpu);
+
+	if (vcpu->vmcb->exitcode != SVM_EXIT_HLT)
+		tst_brk(TBROK, "Nested VM exited unexpectedly");
+}
+
+#else /* defined(__i386__) || defined(__x86_64__) */
+TST_TEST_TCONF("Test supported only on x86");
+#endif /* defined(__i386__) || defined(__x86_64__) */
+
+#else /* COMPILE_PAYLOAD */
+
+#include <pthread.h>
+#include "tst_safe_pthread.h"
+#include "tst_safe_clocks.h"
+
+static struct tst_kvm_instance test_vm = { .vm_fd = -1 };
+static pthread_mutex_t mutex;
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+
+}
+
+static void *vm_thread(void *arg)
+{
+	SAFE_PTHREAD_MUTEX_LOCK(&mutex);
+	tst_kvm_run_instance(&test_vm, EINTR);
+	SAFE_PTHREAD_MUTEX_UNLOCK(&mutex);
+	return arg;
+}
+
+static void setup(void)
+{
+	struct sigaction sa = { .sa_handler = sighandler };
+	pthread_mutexattr_t attr;
+
+	SAFE_PTHREAD_MUTEXATTR_INIT(&attr);
+	SAFE_PTHREAD_MUTEXATTR_SETTYPE(&attr, PTHREAD_MUTEX_NORMAL);
+	SAFE_PTHREAD_MUTEX_INIT(&mutex, &attr);
+	SAFE_PTHREAD_MUTEXATTR_DESTROY(&attr);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+}
+
+static void run(void)
+{
+	struct timespec timeout;
+	pthread_t tid;
+	int ret;
+
+	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
+
+	SAFE_PTHREAD_CREATE(&tid, NULL, vm_thread, NULL);
+	ret = tst_kvm_wait_guest(&test_vm, 2);
+
+	if (ret == KVM_TEXIT) {
+		SAFE_PTHREAD_JOIN(tid, NULL);
+		tst_brk(TCONF, "Guest exited early");
+	}
+
+	if (ret)
+		tst_brk(TBROK, "Wait for guest initialization timed out");
+
+	SAFE_PTHREAD_KILL(tid, SIGUSR1);
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &timeout);
+	timeout.tv_sec += 2;
+
+	if (SAFE_PTHREAD_MUTEX_TIMEDLOCK(&mutex, &timeout)) {
+		tst_kvm_clear_guest_signal(&test_vm);
+		tst_res(TFAIL, "VM thread does not respond to signals");
+	} else {
+		SAFE_PTHREAD_MUTEX_UNLOCK(&mutex);
+		tst_res(TPASS, "VM thread was interrupted by signal");
+	}
+
+	SAFE_PTHREAD_JOIN(tid, NULL);
+	tst_kvm_destroy_instance(&test_vm);
+	tst_free_all();
+}
+
+static void cleanup(void)
+{
+	/* VM is likely still running, cannot clean up anything */
+	if (SAFE_PTHREAD_MUTEX_TRYLOCK(&mutex))
+		return;
+
+	if (!SAFE_PTHREAD_MUTEX_UNLOCK(&mutex))
+		SAFE_PTHREAD_MUTEX_DESTROY(&mutex);
+
+	tst_kvm_destroy_instance(&test_vm);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_cpus = 2,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"x86",
+		NULL
+	},
+	.tags = (struct tst_tag[]){
+		{"linux-git", "91b7130cb660"},
+		{}
+	}
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
