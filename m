Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B155606A31C
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=IjI5teQ/;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o8sdYZCI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794389599; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2vHbAkL5oRtQ2nDJyuG5zMQVGhX7o44ml6N6BtCl8wY=;
 b=IjI5teQ/aIJGJ3kKxGtPubj2r/PiAl/CUO+Ahgt600QVE3sjMunFENmbo3rboiu2Guzgu
 lm1mVkOiixt7eP/ns+6yxmuAjPg/BVJdD96xOL9fIwmMLKDPErf1cOrYuBxcVLpAxgQbSf+
 3KMw9gT+8YW3fgpHbqrVoF0WDSrmzmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2918D3C0CC9
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E958D3C99C9
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:32:05 +0100 (CET)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com
 [IPv6:2607:f8b0:4864:20::447])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 888E820006F
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:32:04 +0100 (CET)
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8b6463f95a4so2485310b3a.2
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 01:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794389523; x=1794994323; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dn+wfRd92QRa+npRt2ZtW7naOkJ9O0G8IayBshgYYTs=;
 b=o8sdYZCIn8lWQ+vtGn16ZUfRsgoRVjrk+F5olF880M7NuWpsjKP43vYFBj3QYRSO64
 S4dY4J8G+0IOHzsBJFAY+S0piPHk3j9bkt9+n28q8MASU7OsaZLmLTLNT7q8F5CkLL+9
 +LjPh32K3h5xaowWWx6mFo4FRZH3XNjT77q3bFUkC0YkoIcKrP93CTVsnnGRs9fNKxPi
 OSilERn9om/YcOQ0pFiS5kAv52uHjapkuJWC0tqkuvWXcgAj434esUK4LVKHCvm1xW5G
 VQ0ok+6Q7kTlaArTy+ZrMD4H+j7st8zMuEGxNOAifA4RsWDtGMDX2Ua5yvnT+ALhoqL/
 huYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389523; x=1794994323;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dn+wfRd92QRa+npRt2ZtW7naOkJ9O0G8IayBshgYYTs=;
 b=SImqDQdGLIYb96gtb06Wq3284WYg8O1CGMunSG+lZ5qNBRn7mNrfLdtHuJPerg2jvJ
 wUSUGBMSv2IMwWAaVEhMek0pcLijEMHSeRl+fmDPmygYbFMltFmwSPPJzFCaNTd3y3FO
 AfVmOJm6aAXi3WiHhJ5I72RFnZXyApoB4n31WYsD7uVnid93pZMB6XekEwOpG/TyfRw2
 vk/IJwM3Js9Xo1vQ7+UNhvYnhLdmnZgX/2uHA6Od1gJtv4jXL7i0HjzUSjp/Ey/x2nE5
 A3JvyaE2Cwa7akzad0xXYfmvr7HR0TW4mXqyHuu/QxF0Ke8D5yltwwF89MnCbRyGdcnE
 T7+w==
X-Gm-Message-State: APuU4Z/tiyh3mUMpRvp7S42+L0c4pFGDNqknGRLQHDryLPELpDAUYLM2
 zlVE5hoxkE8mbNJgXHpAVLX+sg4YSX44fKPPvCcwjYEd/QBxT5BZJZYwFOpXvJCrjp7eOE2aiMa
 nwNFpWLkZuwg5D3WzN6K/8QT2f1/0x+lS2ZJ8Iyx8+AgqUFvrtxoKD3PZvjl6CAZUDFYog16ys7
 xzEnnqHcM3yH6VDsx09BjoUNTCJQ==
X-Received: from pfwp4.prod.google.com ([2002:a05:6a00:26c4:b0:8b6:944b:1ec8])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:ef10:b0:3e2:86b6:9bed
 with SMTP id adf61e73a8af0-3f2ffbcdda7mr1600158637.57.1794389522603; Wed, 11
 Nov 2026 01:32:02 -0800 (PST)
Date: Wed, 11 Nov 2026 09:31:50 +0000
In-Reply-To: <20261111093151.374731-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111093151.374731-4-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: [LTP] [PATCH 3/4] ioctl10: Compare vma_page_size with
 KernelPageSize from smaps
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PROCMAP_QUERY returns in vma_page_size the page size the kernel uses to
back the VMA, i.e. vma_kernel_pagesize(), which /proc/$PID/smaps shows
as KernelPageSize. The test compares it with getpagesize() instead,
which is only correct as long as the kernel page size equals the page
size reported to userspace.

That is not the case with the 16K page size emulation that Android uses
on x86_64, where the kernel keeps using 4K pages internally:

  TFAIL: q->vma_page_size (4096) != getpagesize() (16384)

Compare it with KernelPageSize of the same VMA in /proc/self/smaps
instead. This also cross-checks the two kernel interfaces, the same way
the other fields are checked against /proc/self/maps. Nothing changes
on kernels where both page sizes are equal.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/ioctl/ioctl10.c | 34 ++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
index 8a4f8ae40..5dd2a866d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl10.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -28,6 +28,7 @@
 #include "lapi/ioctl.h"
 
 #define PROC_MAP_PATH "/proc/self/maps"
+#define PROC_SMAPS_PATH "/proc/self/smaps"
 
 struct map_entry {
 	unsigned long vm_start;
@@ -86,6 +87,37 @@ static void parse_maps_file(const char *filename, const char *keyword, struct ma
 	tst_brk(TFAIL, "parse maps file /proc/self/maps failed");
 }
 
+/*
+ * vma_page_size is the page size the kernel uses to back the VMA, which is
+ * reported as KernelPageSize in /proc/self/smaps. It is not necessarily
+ * equal to getpagesize(), e.g. for hugetlb mappings or when the kernel
+ * reports a larger page size to userspace than it uses internally.
+ */
+static unsigned long get_kernel_page_size(unsigned long vm_start)
+{
+	FILE *fp = SAFE_FOPEN(PROC_SMAPS_PATH, "r");
+	unsigned long start, end, size_kb;
+	char line[1024];
+	int found = 0;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (sscanf(line, "%lx-%lx ", &start, &end) == 2) {
+			found = start == vm_start;
+			continue;
+		}
+
+		if (found && sscanf(line, "KernelPageSize: %lu kB", &size_kb) == 1) {
+			SAFE_FCLOSE(fp);
+			return size_kb * 1024;
+		}
+	}
+
+	SAFE_FCLOSE(fp);
+	tst_brk(TBROK, "KernelPageSize of %lx not found in %s",
+		vm_start, PROC_SMAPS_PATH);
+	return 0;
+}
+
 static void verify_ioctl(void)
 {
 	struct map_entry entry;
@@ -107,7 +139,7 @@ static void verify_ioctl(void)
 	TST_EXP_EQ_LU(q->vma_flags, entry.vm_flags);
 	TST_EXP_EQ_LU(q->vma_start, entry.vm_start);
 	TST_EXP_EQ_LU(q->vma_end, entry.vm_end);
-	TST_EXP_EQ_LU(q->vma_page_size, getpagesize());
+	TST_EXP_EQ_LU(q->vma_page_size, get_kernel_page_size(entry.vm_start));
 	TST_EXP_EQ_LU(q->vma_offset, entry.vm_pgoff);
 	TST_EXP_EQ_LU(q->inode, entry.vm_inode);
 	TST_EXP_EQ_LU(q->dev_major, entry.vm_major);
-- 
2.56.0.567.gdb80ae8cd5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
