Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75009606A33F
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=CL6XG43F;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aBRG5cbV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794839078; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=APU9gSI57+l5N2wefehaMWyWdtOKC1/RIYAgIsQuNLI=;
 b=CL6XG43F0kHV+WxiVOTs4dajaZRuuTbatcFn4WIxt3LkpJNC0CIOGROfJrRZf1CfwcnPZ
 ZY4PHf82OJ+m5aaurI9NWSSGRfolHeqri0/KzWKuITHqkBmxVyxoqAjE95YxQD1wvYfDmwV
 X5vsoU1XsiejZiY9O4oI7CHpLw+5m3k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0518D3E595E
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:24:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DD253EA9DE
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:48 +0100 (CET)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com
 [IPv6:2607:f8b0:4864:20::446])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82B55600474
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:47 +0100 (CET)
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-8b6463f95a4so2631280b3a.2
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838966; x=1795443766; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EiKQEaSa/tpN8YK6uwfjNku9cj5usCSNA3WLal0RjcE=;
 b=aBRG5cbVCUHVcyUODUGAG/pQKN9pqDl8hgjLXCGcr2p4KP5/ui0Xr4YKpUvbAP0fjf
 P7dgiQ8zIuRjWuhlej73zwPzCNGC6qj6iwUITHlprAjsz1ef4/9y2+CPZZjFqHNRb0vD
 hR6ZDa7+q+M4egFhVRx78IsROFeRuPT7YgdoCcoMkEGvqLzlrchlcA9YvMbmn33V/NNm
 VNh23IelorxERBUeJoVd132Li9IVZFMCUonOiwUYJswf8Vh/4J8Kjo4aDnRDol8sOnOk
 m9Kk2L1I6IXKaghjV07xyF0eXpXS1NTzZcJFsdJn+fCLELCD3lPgGYQktmDcvFjKQtoA
 /3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838966; x=1795443766;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EiKQEaSa/tpN8YK6uwfjNku9cj5usCSNA3WLal0RjcE=;
 b=FhHxSoZ8NCGRDpBlUYHOfsQnl9TobtFuVdRjyuGpp36Vb6PvIXGEUE8y3+4G2Fmi6a
 RBEiEVaGYWgcuh2kBO4n5jYsvyPMUulvchCiiienS1AjM9UBeOr/+gXf6CzgQKDfTGFo
 YmLfUa0/bfmIsk2LWu/2JHouHJxV7U+UTNn6H0D+ahZcoBAUQDqNS6jlRq8p+/whO8eV
 nnglhsukWGbbgknKkCaNtkz7/jrmsdj3ex/EsgvHEvWSaqN2IzvdehByqFnVB+v2v8Ye
 CrZDmeLb/nAlat0ppgcqv+G8pCnVDRHCFvVm6OnrPMqXdyEJAtlnn0ROCTg2yiRhvyen
 ClCQ==
X-Gm-Message-State: APuU4Z+HlcYm/EWrjIxyElYvt0peNtPYdRfoizgjAaB4AyZydm3FxB77
 4OCcJQMEIJzGtfBA0Df8vQ9s0VMdWZExcDV4dwZMDoM/QSYnM0o7xnV7ObK8HNOmesTjLPeMrCB
 3TBD84gJ37ZND1w8rBnsJeR6FbfG4I2MiDyur0+ywdE4VWY3xfBGAfkq9ByIcVBRxhAuc7MsGt3
 y6WFWZsCB6ZvTGYMTUPW/RzGaLZw==
X-Received: from pfbgc10.prod.google.com
 ([2002:a05:6a00:62ca:b0:8a9:2820:a18d])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a13:b0:89c:1f2b:a73f
 with SMTP id d2e1a72fcca58-8beb56c95a9mr9484797b3a.17.1794838965381; Mon, 16
 Nov 2026 06:22:45 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:39 +0000
In-Reply-To: <20261116142240.3153725-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116072346.2462510-1-wakel@google.com>
 <20261116142240.3153725-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142240.3153725-2-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] msync04: Check smaps when the page frame
 number is not exposed
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

The test looks up the dirty flag of the mapped page in /proc/kpageflags,
using the PFN it reads from /proc/self/pagemap. If the PFN is reported
as zero, get_dirty_bit() returns 0 and the test falls back to checking
the file content, which can end only with TCONF or TFAIL.

The PFN of a present page is reported as zero with the 16K page size
emulation that Android uses on x86_64, where each entry of the emulated
pagemap covers four 4K kernel pages and therefore carries no single PFN.
The test then reports:

  TCONF: Write was too fast, couldn't test msync()

When the page is present but its PFN is not exposed, sum up the
Shared_Dirty and Private_Dirty counters of the mapping in
/proc/self/smaps instead. They account for both the dirty bit in the
page table and the dirty flag of the page, and drop to zero once
msync() has written the page back. Nothing changes on kernels that
expose the PFN to root.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/msync/msync04.c | 46 ++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 1251388b6..1ed56fec6 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -17,6 +17,7 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 static int test_fd;
 static char *mmaped_area;
@@ -24,6 +25,39 @@ static long pagesize;
 
 #define STRING_TO_WRITE	"AAAAAAAAAA"
 
+#define PM_PFRAME_MASK	((1ULL << 55) - 1)
+#define PM_PRESENT	(1ULL << 63)
+
+/*
+ * Returns the amount of dirty memory of the mapping starting at addr, as
+ * accounted in /proc/self/smaps.
+ */
+static long get_smaps_dirty_kb(unsigned long addr)
+{
+	FILE *fp = SAFE_FOPEN("/proc/self/smaps", "r");
+	unsigned long start, end;
+	long dirty_kb = 0, kb;
+	char line[1024];
+	int found = 0;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (sscanf(line, "%lx-%lx ", &start, &end) == 2) {
+			found = start == addr;
+			continue;
+		}
+
+		if (!found)
+			continue;
+
+		if (sscanf(line, "Shared_Dirty: %ld kB", &kb) == 1 ||
+		    sscanf(line, "Private_Dirty: %ld kB", &kb) == 1)
+			dirty_kb += kb;
+	}
+
+	SAFE_FCLOSE(fp);
+	return dirty_kb;
+}
+
 static uint64_t get_dirty_bit(void *data)
 {
 	int pagemap_fd, pageflags_fd;
@@ -37,9 +71,17 @@ static uint64_t get_dirty_bit(void *data)
 	SAFE_READ(SAFE_READ_ALL, pagemap_fd, &pagemap_entry,
 		  sizeof(pagemap_entry));
 	SAFE_CLOSE(pagemap_fd);
-	pfn = pagemap_entry & ((1ULL << 55) - 1);
-	if (!pfn)
+	pfn = pagemap_entry & PM_PFRAME_MASK;
+	if (!pfn) {
+		/*
+		 * The PFN of a present page may not be exposed, check the
+		 * dirty accounting of the mapping in smaps instead.
+		 */
+		if (pagemap_entry & PM_PRESENT)
+			return get_smaps_dirty_kb(addr) > 0;
+
 		return 0;
+	}
 	pageflags_fd = SAFE_OPEN("/proc/kpageflags", O_RDONLY);
 	index = pfn * sizeof(uint64_t);
 	SAFE_LSEEK(pageflags_fd, index, SEEK_SET);
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
