Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2097C77B7D
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:37:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6583F3CEE40
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:37:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 757D83CD47E
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EDE301A009B6
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5384D226C9;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684337803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gd4UY/AgUNs7s7B35irRF37BOwIlZk7Rf5x7qcGSvR4=;
 b=rrTr0QmGA+4IAqIm6B622Ie9w7vwt0E3yY1MOHgVn276MJAGTiYqJ/ZL3WHkxwuPLLPivL
 zELw2/gWzrYArmKXBA1c35jWhr1qubRARPe0tlC2W0RZXWZ5mJ/GU4jk8LCcNsFbh8Jw/F
 8GHqErhaLwCwrwlxowDdhXWsZRhQ0mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684337803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gd4UY/AgUNs7s7B35irRF37BOwIlZk7Rf5x7qcGSvR4=;
 b=lqIt/kGPQHirqiQleHV4a/TF3iwI83/i+L3eSg2n9vYdMWI/U9xEsGM2ldsIVTxWHRqY01
 Ui+LFF8+WYot0BCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F88E139F5;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qA6fDov0ZGSTCgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 17 May 2023 15:36:43 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Nicolai Stange <nstange@suse.de>,
	ltp@lists.linux.it
Date: Wed, 17 May 2023 17:36:39 +0200
Message-Id: <20230517153642.26919-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517153642.26919-1-mdoucha@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/7] KVM: Add async communication helper functions
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

Some KVM tests need to communicate with VM controller program
without stopping guest execution. Add guest helper functions
for sending asynchronous guest signal to host and waiting for host
to acknowledge the signal. Add host helper functions for waiting
for guest signal and acknowledging it.

Test programs using these functions must have at least two host threads.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/include/kvm_common.h |  8 ++++++++
 testcases/kernel/kvm/include/kvm_guest.h  | 14 +++++++++++++
 testcases/kernel/kvm/include/kvm_host.h   | 15 ++++++++++++++
 testcases/kernel/kvm/lib_guest.c          | 16 +++++++++++++++
 testcases/kernel/kvm/lib_host.c           | 24 +++++++++++++++++++++++
 5 files changed, 77 insertions(+)

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
index 2359944fd..cbbdadc06 100644
--- a/testcases/kernel/kvm/include/kvm_host.h
+++ b/testcases/kernel/kvm/include/kvm_host.h
@@ -134,4 +134,19 @@ void tst_kvm_run_instance(struct tst_kvm_instance *inst);
  */
 void tst_kvm_destroy_instance(struct tst_kvm_instance *inst);
 
+/*
+ * Wait for given VM to call tst_signal_host() or tst_wait_host(). Timeout
+ * value is in seconds. Zero means no wait, negative value means wait forever.
+ * Note that the actual wait time may be up to 1 second shorter due to time()
+ * granularity. Returns 0 if signal was received, KVM_TEXIT if the VM exited
+ * without sending a signal, or -1 if timeout was reached.
+ */
+int tst_kvm_wait_guest(struct tst_kvm_instance *inst, int timeout);
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
index 2782e68b0..a5f05449c 100644
--- a/testcases/kernel/kvm/lib_host.c
+++ b/testcases/kernel/kvm/lib_host.c
@@ -272,6 +272,30 @@ void tst_kvm_destroy_instance(struct tst_kvm_instance *inst)
 	memset(inst->ram, 0, sizeof(inst->ram));
 }
 
+int tst_kvm_wait_guest(struct tst_kvm_instance *inst, int timeout)
+{
+	volatile struct tst_kvm_result *result = inst->result;
+	int32_t res;
+	time_t start = time(NULL);
+
+	while ((res = result->result) != KVM_TSYNC) {
+		if (res == KVM_TEXIT)
+			return res;
+
+		if (timeout >= 0 && start + timeout <= time(NULL))
+			return -1;
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
