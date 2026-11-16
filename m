Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F414606A32A
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=oNxFSVxB;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k+wVd4be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794839014; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9g23u9pkoKbzX0vJ7CY6NPQ/BtyCACAyo/6C+U0k5v8=;
 b=oNxFSVxB+kDUEo9KjnZV29JNi7FRUEiiZwIwwRNIeO0JramZcPasKd6461aRNp6wa4fcU
 qQ+bBDKnoZDN7t54QqyQeYojtTmAYzGjRfew/zWnioegd8BuFti5dZixQY9ZZ1ct8dm17gz
 uW52lkbXUWbBjoVfX6yug80Lm7/f/Cc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D15723EA9D7
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:23:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AC693EAA1E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:19 +0100 (CET)
Received: from mail-dl1-x1248.google.com (mail-dl1-x1248.google.com
 [IPv6:2607:f8b0:4864:20::1248])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B71282001B4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:18 +0100 (CET)
Received: by mail-dl1-x1248.google.com with SMTP id
 a92af1059eb24-1b3a348a6dbso2652722c88.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838937; x=1795443737; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B/YyFXE4Q4u5oMMLZQAB4E8w55phBQ4Gk36oP8hNOtc=;
 b=k+wVd4be1A3/E0u3bKnW3ugFvVkUC9hG7rDyI5h35FU1gwBeGSsIkjs0EQmUPEpS1/
 hQx7Hj9AQ0DKCJubd7yisigbbCqJPGrJbroL4sOEYaQXGW1sc9RlgKNHwUbUCROJ7tY+
 m21zk7dwMRPM8J2Mtp6t9yJWtBa97l16xXgJSv+OoGPwYbt8Gh8MLLm4qyQqR2SIYekS
 LjYXoko3jSYL44llgbriqPX4tECaz/Won1MypK0+2EVGzp53mPfbQddeq5dhMwsLMsSg
 i1clOBgqI3grGalwnXVerAs5QiBK9BIUsScjeORNjEDpD+xqAtzaeH4UC50WdmpFSBmY
 Qy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838937; x=1795443737;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B/YyFXE4Q4u5oMMLZQAB4E8w55phBQ4Gk36oP8hNOtc=;
 b=fp8IDRqYlByeEmAhcbq50tZCmwp2xPYXR+nAT/rHrHV8WVAED2k2cRP5puz4aW+iSX
 sO4eQ4QR/yx+YtNTZreGX5ymvpRVk43JwJ3lf8Thn1P2Umj6V83NffIXB74ct7uqIJ7A
 tK+LJFP+jjMEeVbdxX4yQm34+y+uZUWW1G5mKHOEyIi35z4OwSGlGCKsZkfphOEumCoC
 +lhEdU01ndkW97ax1mn+PFcHmSnBslKIXAWwU8PnRfj+G6+wVgYFQJ4WE7e3jhCJKCY3
 IXzNm8acHjvcfdGcLzKQU+zyvr/me/PjclsMP9aVBzp7yl1rc8GM4aNqp0wyaRokbwd8
 sBBA==
X-Gm-Message-State: APuU4Z8Dh8WlDgHnTKzqa/noZPaS9yFzBQ0+osR7czlV09x1GYnMj6mr
 /1aY//eeod8QZGNMgBXYPffSauPwnn008HOAp6G2i5NixYkjlt6y3ERz3sx4IZUGqcCJW3uUse+
 +uVstNmOxab0+ycN6JwRdhdhIrMVc2KOYO2fD6anplLxxAJrt9dMSR7Wqy5k+OCz94dCDhMYuGL
 0gfETn7JwfgU8klVIayNu0UXLvPw==
X-Received: from dlaf14.prod.google.com ([2002:a05:701b:240e:b0:1b2:5589:f43a])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2390:b0:18d:96e8:b913
 with SMTP id a92af1059eb24-1b503195191mr15107711c88.47.1794838936548; Mon, 16
 Nov 2026 06:22:16 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:05 +0000
In-Reply-To: <20261116142206.3151308-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
 <20261116142206.3151308-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142206.3151308-4-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] ioctl10: Compare vma_page_size with
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
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
