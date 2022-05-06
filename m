Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AF6C433EF
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 14:21:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D02093CA8C5
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 16:21:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B5BB3C0F84
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:21:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DB23B1000D41
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:21:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADE12219EB
 for <ltp@lists.linux.it>; Fri,  6 May 2022 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651846885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wlQ0FJjTGOJqJ6H0TRHEu51tZaPH1y8aTsDvJNyuLRM=;
 b=zMWx1NLN7vSkCbrjsfC8bik544YCZH9oDWLOsqt6bHZcyFOwZTpmBgs++pZavbWycolELZ
 Zi3QITZFSBXhOu/hP/ePcivSy74p2jQkucGvDqE34VNcAabrXOmeSIic2hetpBr6OtgLK7
 gvU4tC/Spjst+P/b/Hy5nBtDyTcK1Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651846885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wlQ0FJjTGOJqJ6H0TRHEu51tZaPH1y8aTsDvJNyuLRM=;
 b=4K+6IoLazHcHG38ZT/x+MtXl9gBwIXl6PRJiS6vq0sYIi57NLGTmB8D4V2zJvbLm7w67aR
 7cbrTgK0u2Tzz9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 990A413A1B
 for <ltp@lists.linux.it>; Fri,  6 May 2022 14:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8jREJOUudWLxbQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 06 May 2022 14:21:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 May 2022 16:21:24 +0200
Message-Id: <20220506142125.15564-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] kvm: Add VM memory access helper functions to
 host library
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
 testcases/kernel/kvm/include/kvm_host.h |  28 +++++-
 testcases/kernel/kvm/lib_host.c         | 112 +++++++++++++++++++-----
 2 files changed, 117 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/kvm/include/kvm_host.h b/testcases/kernel/kvm/include/kvm_host.h
index 52cc3f5e9..2359944fd 100644
--- a/testcases/kernel/kvm/include/kvm_host.h
+++ b/testcases/kernel/kvm/include/kvm_host.h
@@ -45,12 +45,13 @@
 
 #define MIN_FREE_RAM (10 * 1024 * 1024)
 #define DEFAULT_RAM_SIZE (16 * 1024 * 1024)
+#define MAX_KVM_MEMSLOTS 8
 
 struct tst_kvm_instance {
 	int vm_fd, vcpu_fd;
 	struct kvm_run *vcpu_info;
 	size_t vcpu_info_size;
-	void *ram;
+	struct kvm_userspace_memory_region ram[MAX_KVM_MEMSLOTS];
 	struct tst_kvm_result *result;
 };
 
@@ -82,8 +83,29 @@ void tst_kvm_validate_result(int value);
  * to free() it. Any extra space added at the beginning or end for page
  * alignment will be writable.
  */
-void *tst_kvm_alloc_memory(int vm, unsigned int slot, uint64_t baseaddr,
-	size_t size, unsigned int flags);
+void *tst_kvm_alloc_memory(struct tst_kvm_instance *inst, unsigned int slot,
+	uint64_t baseaddr, size_t size, unsigned int flags);
+
+/*
+ * Translate VM virtual memory address to the corresponding physical address.
+ * Returns 0 if the virtual address is unmapped or otherwise invalid.
+ */
+uint64_t tst_kvm_get_phys_address(const struct tst_kvm_instance *inst,
+	uint64_t addr);
+
+/*
+ * Find the struct tst_kvm_instance memory slot ID for the give virtual
+ * or physical VM memory address. Returns -1 if the address is not backed
+ * by any memory buffer.
+ */
+int tst_kvm_find_phys_memslot(const struct tst_kvm_instance *inst,
+	uint64_t paddr);
+int tst_kvm_find_memslot(const struct tst_kvm_instance *inst, uint64_t addr);
+
+/*
+ * Convert VM virtual memory address to a directly usable pointer.
+ */
+void *tst_kvm_get_memptr(const struct tst_kvm_instance *inst, uint64_t addr);
 
 /*
  * Find CPUIDs supported by KVM. x86_64 tests must set non-default CPUID,
diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_host.c
index a52722b7b..b8994f34e 100644
--- a/testcases/kernel/kvm/lib_host.c
+++ b/testcases/kernel/kvm/lib_host.c
@@ -36,15 +36,85 @@ void tst_kvm_validate_result(int value)
 	tst_brk(TBROK, "KVM test returned invalid result value %d", value);
 }
 
+uint64_t tst_kvm_get_phys_address(const struct tst_kvm_instance *inst,
+	uint64_t addr)
+{
+	struct kvm_translation trans = { .linear_address = addr };
+
+	TEST(ioctl(inst->vcpu_fd, KVM_TRANSLATE, &trans));
+
+	/* ioctl(KVM_TRANSLATE) is not implemented for this arch */
+	if (TST_RET == -1 && TST_ERR == EINVAL)
+		return addr;
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "ioctl(KVM_TRANSLATE) failed");
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO,
+			"Invalid ioctl(KVM_TRANSLATE) return value");
+	}
+
+	return trans.valid ? trans.physical_address : 0;
+}
+
+int tst_kvm_find_phys_memslot(const struct tst_kvm_instance *inst,
+	uint64_t paddr)
+{
+	int i;
+	uint64_t base;
+
+	for (i = 0; i < MAX_KVM_MEMSLOTS; i++) {
+		if (!inst->ram[i].userspace_addr)
+			continue;
+
+		base = inst->ram[i].guest_phys_addr;
+
+		if (paddr >= base && paddr - base < inst->ram[i].memory_size)
+			return i;
+	}
+
+	return -1;
+}
+
+int tst_kvm_find_memslot(const struct tst_kvm_instance *inst, uint64_t addr)
+{
+	addr = tst_kvm_get_phys_address(inst, addr);
+
+	if (!addr)
+		return -1;
+
+	return tst_kvm_find_phys_memslot(inst, addr);
+}
+
+void *tst_kvm_get_memptr(const struct tst_kvm_instance *inst, uint64_t addr)
+{
+	int slot;
+	char *ret;
+
+	addr = tst_kvm_get_phys_address(inst, addr);
+
+	if (!addr)
+		return NULL;
+
+	slot = tst_kvm_find_phys_memslot(inst, addr);
+
+	if (slot < 0)
+		return NULL;
+
+	ret = (char *)(uintptr_t)inst->ram[slot].userspace_addr;
+	return ret + (addr - inst->ram[slot].guest_phys_addr);
+}
+
 void tst_kvm_print_result(const struct tst_kvm_instance *inst)
 {
 	int ttype;
 	const struct tst_kvm_result *result = inst->result;
-	const char *file = inst->ram;
+	const char *file;
 
 	tst_kvm_validate_result(result->result);
 	ttype = TTYPE_RESULT(result->result);
-	file += result->file_addr;
+	file = tst_kvm_get_memptr(inst, result->file_addr);
 
 	if (ttype == TBROK)
 		tst_brk_(file, result->lineno, ttype, "%s", result->message);
@@ -52,26 +122,29 @@ void tst_kvm_print_result(const struct tst_kvm_instance *inst)
 		tst_res_(file, result->lineno, ttype, "%s", result->message);
 }
 
-void *tst_kvm_alloc_memory(int vm, unsigned int slot, uint64_t baseaddr,
-	size_t size, unsigned int flags)
+void *tst_kvm_alloc_memory(struct tst_kvm_instance *inst, unsigned int slot,
+	uint64_t baseaddr, size_t size, unsigned int flags)
 {
-	size_t pagesize;
-	void *ret;
+	size_t pagesize, offset;
+	char *ret;
 	struct kvm_userspace_memory_region memslot = {
 		.slot = slot,
 		.flags = flags
 	};
 
+	if (slot >= MAX_KVM_MEMSLOTS)
+		tst_brk(TBROK, "Invalid KVM memory slot %u", slot);
+
 	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
-	size += (baseaddr % pagesize) + pagesize - 1;
-	baseaddr -= baseaddr % pagesize;
-	size -= size % pagesize;
+	offset = baseaddr % pagesize;
+	size = LTP_ALIGN(size + offset, pagesize);
 	ret = tst_alloc(size);
 
-	memslot.guest_phys_addr = baseaddr;
+	memslot.guest_phys_addr = baseaddr - offset;
 	memslot.memory_size = size;
 	memslot.userspace_addr = (uintptr_t)ret;
-	SAFE_IOCTL(vm, KVM_SET_USER_MEMORY_REGION, &memslot);
+	SAFE_IOCTL(inst->vm_fd, KVM_SET_USER_MEMORY_REGION, &memslot);
+	inst->ram[slot] = memslot;
 	return ret;
 }
 
@@ -108,7 +181,7 @@ void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
 {
 	int sys_fd;
 	size_t pagesize, result_pageaddr = KVM_RESULT_BASEADDR;
-	char *vm_result, *reset_ptr;
+	char *buf, *reset_ptr;
 	struct kvm_cpuid2 *cpuid_data;
 	const size_t payload_size = kvm_payload_end - kvm_payload_start;
 
@@ -122,8 +195,7 @@ void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
 
 	if (payload_size + MIN_FREE_RAM > ram_size - VM_KERNEL_BASEADDR) {
 		ram_size = payload_size + MIN_FREE_RAM + VM_KERNEL_BASEADDR;
-		ram_size += 1024 * 1024 - 1;
-		ram_size -= ram_size % (1024 * 1024);
+		ram_size = LTP_ALIGN(ram_size, 1024 * 1024);
 		tst_res(TWARN, "RAM size increased to %zu bytes", ram_size);
 	}
 
@@ -148,15 +220,15 @@ void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
 	inst->vcpu_info = SAFE_MMAP(NULL, inst->vcpu_info_size,
 		PROT_READ | PROT_WRITE, MAP_SHARED, inst->vcpu_fd, 0);
 
-	inst->ram = tst_kvm_alloc_memory(inst->vm_fd, 0, 0, ram_size, 0);
-	vm_result = tst_kvm_alloc_memory(inst->vm_fd, 1, KVM_RESULT_BASEADDR,
+	buf = tst_kvm_alloc_memory(inst, 0, 0, ram_size, 0);
+	memcpy(buf + VM_KERNEL_BASEADDR, kvm_payload_start, payload_size);
+	buf = tst_kvm_alloc_memory(inst, 1, KVM_RESULT_BASEADDR,
 		KVM_RESULT_SIZE, 0);
-	memset(vm_result, 0, KVM_RESULT_SIZE);
-	memcpy(inst->ram + VM_KERNEL_BASEADDR, kvm_payload_start, payload_size);
+	memset(buf, 0, KVM_RESULT_SIZE);
 
-	reset_ptr = vm_result + (VM_RESET_BASEADDR % pagesize);
+	reset_ptr = buf + (VM_RESET_BASEADDR % pagesize);
 	memcpy(reset_ptr, tst_kvm_reset_code, sizeof(tst_kvm_reset_code));
-	inst->result = (struct tst_kvm_result *)(vm_result +
+	inst->result = (struct tst_kvm_result *)(buf +
 		(KVM_RESULT_BASEADDR % pagesize));
 	inst->result->result = KVM_TNONE;
 	inst->result->message[0] = '\0';
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
