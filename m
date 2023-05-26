Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1283C7EE23
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 13:34:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 686013CD186
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 15:34:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 268843CA154
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 82522600EAE
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B33DE21A11;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685108076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2yI3uvS5l26VwzMblSIzInBfRRMG22ICASSGFJej+I=;
 b=AZGricbTR0rrmqHWVLnjIlWdpywsF4tNWSw2doBQayGobVK56I+bVJmxYjjFuGxiA3eXYL
 4fzpd+rcMxPaRYie5PQbWAAvtcYUYLwn6dxt8xEfDnZU3yn+o96uCWaUnKNyOGOvfvUurI
 aouCG/fogAFgSs88A9VMpajCAr0kvFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685108076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2yI3uvS5l26VwzMblSIzInBfRRMG22ICASSGFJej+I=;
 b=CUto91GwsKaIbZTqGQUAfAcqqPUnHbaBkh8PBtQNgkPGSSbSVYd7qZQqwiT63ff323qT2c
 MLKNdDqoHyk5MCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F8BF138E6;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KJJCJmy1cGTMZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 26 May 2023 13:34:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 May 2023 15:34:32 +0200
Message-Id: <20230526133435.7369-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526133435.7369-1-mdoucha@suse.cz>
References: <20230526133435.7369-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/7] KVM: Add async communication helper functions
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

Some KVM tests need to communicate with VM controller program
without stopping guest execution. Add guest helper functions
for sending asynchronous guest signal to host and waiting for host
to acknowledge the signal. Add host helper functions for waiting
for guest signal and acknowledging it.

Test programs using these functions must have at least two host threads.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Use tst_clock_gettime() to measure timeout

 testcases/kernel/kvm/Makefile             |  1 +
 testcases/kernel/kvm/include/kvm_common.h |  8 ++++++
 testcases/kernel/kvm/include/kvm_guest.h  | 14 ++++++++++
 testcases/kernel/kvm/include/kvm_host.h   | 14 ++++++++++
 testcases/kernel/kvm/lib_guest.c          | 16 +++++++++++
 testcases/kernel/kvm/lib_host.c           | 33 +++++++++++++++++++++++
 6 files changed, 86 insertions(+)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index e12cb4e98..501bb5a09 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -7,6 +7,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 ASFLAGS =
 CPPFLAGS += -I$(abs_srcdir)/include
+LDLIBS += -lrt
 GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
 GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
 GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fno-stack-protector -z noexecstack
diff --git a/testcases/kernel/kvm/include/kvm_common.h b/testcases/kernel/kvm/include/kvm_common.h
index 4e81d8302..377e3f6aa 100644
--- a/testcases/kernel/kvm/include/kvm_common.h
+++ b/testcases/kernel/kvm/include/kvm_common.h
@@ -10,6 +10,14 @@
 
 #define KVM_TNONE	-1	/* "No result" status value */
 
+/*
+ * Result value for asynchronous notifications between guest and host.
+ * Do not use this value directly. Call tst_signal_host() or tst_wait_host()
+ * in guest code. The notification must be handled by another host thread
+ * and then the result value must be reset to KVM_TNONE.
+ */
+#define KVM_TSYNC	0xfe
+
 /*
  * Result value indicating end of test. If the test program exits using
  * the HLT instruction with any valid result value other than KVM_TEXIT or
diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
index ec13c5845..96f246155 100644
--- a/testcases/kernel/kvm/include/kvm_guest.h
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -64,6 +64,20 @@ void tst_brk_(const char *file, const int lineno, int result,
 	const char *message) __attribute__((noreturn));
 #define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))
 
+/*
+ * Send asynchronous notification to host without stopping VM execution and
+ * return immediately. The notification must be handled by another host thread.
+ * The data argument will be passed to host in test_result->file_addr and
+ * can be used to send additional data both ways.
+ */
+void tst_signal_host(void *data);
+
+/*
+ * Call tst_signal_host(data) and wait for host to call
+ * tst_kvm_clear_guest_signal().
+ */
+void tst_wait_host(void *data);
+
 void *tst_heap_alloc_aligned(size_t size, size_t align);
 void *tst_heap_alloc(size_t size);
 
diff --git a/testcases/kernel/kvm/include/kvm_host.h b/testcases/kernel/kvm/include/kvm_host.h
index 2359944fd..3949dd040 100644
--- a/testcases/kernel/kvm/include/kvm_host.h
+++ b/testcases/kernel/kvm/include/kvm_host.h
@@ -134,4 +134,18 @@ void tst_kvm_run_instance(struct tst_kvm_instance *inst);
  */
 void tst_kvm_destroy_instance(struct tst_kvm_instance *inst);
 
+/*
+ * Wait for given VM to call tst_signal_host() or tst_wait_host(). Timeout
+ * value is in milliseconds. Zero means no wait, negative value means wait
+ * forever. Returns 0 if signal was received, KVM_TEXIT if the VM exited
+ * without sending a signal, or -1 if timeout was reached.
+ */
+int tst_kvm_wait_guest(struct tst_kvm_instance *inst, int timeout_ms);
+
+/*
+ * Clear VM signal sent by tst_signal_host(). If the VM is waiting
+ * in tst_wait_host(), this function will signal the VM to resume execution.
+ */
+void tst_kvm_clear_guest_signal(struct tst_kvm_instance *inst);
+
 #endif /* KVM_HOST_H_ */
diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
index d3b2ac3d5..f3e21d3d6 100644
--- a/testcases/kernel/kvm/lib_guest.c
+++ b/testcases/kernel/kvm/lib_guest.c
@@ -155,6 +155,22 @@ void tst_brk_(const char *file, const int lineno, int result,
 	kvm_exit();
 }
 
+void tst_signal_host(void *data)
+{
+	test_result->file_addr = (uintptr_t)data;
+	test_result->result = KVM_TSYNC;
+}
+
+void tst_wait_host(void *data)
+{
+	volatile int32_t *vres = &test_result->result;
+
+	tst_signal_host(data);
+
+	while (*vres != KVM_TNONE)
+		;
+}
+
 void tst_handle_interrupt(struct kvm_interrupt_frame *ifrm, long vector,
 	unsigned long errcode)
 {
diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_host.c
index 2782e68b0..2f524e3ce 100644
--- a/testcases/kernel/kvm/lib_host.c
+++ b/testcases/kernel/kvm/lib_host.c
@@ -10,6 +10,8 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_clocks.h"
+#include "tst_timer.h"
 #include "kvm_host.h"
 
 static struct tst_kvm_instance test_vm = { .vm_fd = -1 };
@@ -272,6 +274,37 @@ void tst_kvm_destroy_instance(struct tst_kvm_instance *inst)
 	memset(inst->ram, 0, sizeof(inst->ram));
 }
 
+int tst_kvm_wait_guest(struct tst_kvm_instance *inst, int timeout_ms)
+{
+	volatile struct tst_kvm_result *result = inst->result;
+	int32_t res;
+	struct timespec start, now;
+
+	if (timeout_ms >= 0)
+		tst_clock_gettime(CLOCK_MONOTONIC, &start);
+
+	while ((res = result->result) != KVM_TSYNC) {
+		if (res == KVM_TEXIT)
+			return res;
+
+		if (timeout_ms >= 0) {
+			tst_clock_gettime(CLOCK_MONOTONIC, &now);
+
+			if (tst_timespec_diff_ms(now, start) >= timeout_ms)
+				return -1;
+		}
+
+		usleep(1000);
+	}
+
+	return 0;
+}
+
+void tst_kvm_clear_guest_signal(struct tst_kvm_instance *inst)
+{
+	inst->result->result = KVM_TNONE;
+}
+
 void tst_kvm_setup(void)
 {
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
