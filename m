Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911A606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Xc9NJ5FZ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGVtpDn6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794813876; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=APU9gSI57+l5N2wefehaMWyWdtOKC1/RIYAgIsQuNLI=;
 b=Xc9NJ5FZDSxPm7ZCS8fbmw2JyaZJCvwBifufkP/ae778AHhr6Y3j8hmZZ9n9piCXinDnn
 WVj6rAPaGRMivH5E33p2EhZR15fri8fuy4EhK8IcpVMYY1Z7lEfOAPf2xb8bN/ti1pWCQgK
 HAQ3BEO0LGKS2Y2lMHs4qm6iQhUyOuQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8370A3E93FA
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:24:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFD153CD3B4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:23:53 +0100 (CET)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com
 [IPv6:2607:f8b0:4864:20::1047])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54E1D60004C
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:23:53 +0100 (CET)
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-3b10afdf947so3994236a91.0
 for <ltp@lists.linux.it>; Sun, 15 Nov 2026 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794813832; x=1795418632; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EiKQEaSa/tpN8YK6uwfjNku9cj5usCSNA3WLal0RjcE=;
 b=iGVtpDn6eJugMljRFnQU5QYfgjxUxFwB5TZZUWo6k+KYD4TsO9qOFNfWz9SPrc0emc
 HCQ6u40Bv6Y1JALxkIZXGerpGj7/rqAW2/3rmN6NBE7w5K7Yt4nriVchTcC9XVfjJbTG
 LuO/jPA0an5ZTsGOkvjZBsUEHbYR5Y0JEGFZMQJk/LtrPmKzCEIZ9ElOBN4eXFJPQcAA
 SoVfhKCdkM38fA6BrAGEOWEJhdsxjk6RTaIpuUKt/eP46QK5nf7dQv2mLgKYT6hKvMwn
 SSqoafop0iI597NbYrj4pw+SVpHYMMvJzIBPJ++UDZC4olB9Swyo1eubqZ4dIhcIK3pz
 WOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794813832; x=1795418632;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EiKQEaSa/tpN8YK6uwfjNku9cj5usCSNA3WLal0RjcE=;
 b=hgNRL4RfGD9O96LHB1S6B8sLP7z3TGbB+yhpF9WT8ITN6Qkzeme9oiZF/lG/CSqfS0
 x5w+4+tiuEXdnFe/r7+EZEaRjmz7pthlX7TGyZa97GryRw05OwpMk7adUIw4lLGwEwlh
 S4gFQFlzJtMnJf0B6AnDlOoCVM00cDy8+xI2s5Gk5zC24iCtD8mHacgp+EAe0e2vlpE8
 41EpRxwiHcwMfbqxuZsyg/HESvMLdI1VJvojLPv3dppYl6ADjD7bg3PBVa/n3wBG3IBo
 W5CEOEaR3r07U2jhajX5azX/qV4GawzOWiHUoPP+wvYXtHD+6xqu1U+TZhwYvZkG9WKg
 UXig==
X-Gm-Message-State: APuU4Z82D+BjKp7EDyLqkQxnDTW8N9FYp1XaaNyQwT3CbTozH2UKuIUN
 ek5xaG9wMWPP0Dn2Fn1XzmZOsocjNGA0h7Uf5zJ/6tDhvgLcaC3JFv0H5wzYyCVxS3bz9HzZJME
 R1Wxro5R2FI2aUJ4o9HKXgpaVvIcb7tP6gUq7HJPxetfBeeRMrFICG6RWcX8jWfO5x84BgK6Oee
 koLXgKuN+CJ+qVvHGjCezYa9GcrA==
X-Received: from pjbgz6.prod.google.com ([2002:a17:90b:ec6:b0:3ad:9e7b:240f])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5483:b0:3aa:412f:b0a7
 with SMTP id 98e67ed59e1d1-3b1b087e1c4mr6189166a91.5.1794813831469; Sun, 15
 Nov 2026 23:23:51 -0800 (PST)
Date: Mon, 16 Nov 2026 07:23:45 +0000
In-Reply-To: <20261116072346.2462510-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116072346.2462510-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116072346.2462510-2-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] msync04: Check smaps when the page frame number
 is not exposed
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
