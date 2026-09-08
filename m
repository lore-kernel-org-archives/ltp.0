Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE69AC79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 02:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788834747; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=n2NhnTu8OMZS6MhF0FfUH8ozBPE3FK4OXTGhYmktdNQ=;
 b=iU9bbmRbZQkuC6yOgPvkbibKwCFciaHtkvPlAZ9KOAqyiUNV0c6lQbqnBk1qDBCyWe/Nv
 kjRIWrcm9e8dUuYRtQvjKXKgwSGISun08/8/bx5cJFbecpzJ+QoCP7J/HXtWFoDcg1E/Otl
 ZzOqfSJiX36n0IDkj35n0jbUE8ne740=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A13633E9536
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 04:32:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 689B13E1B63
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 04:32:04 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF82520099E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 04:31:58 +0200 (CEST)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 6882Vmdv010249
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 8 Sep 2026 10:31:48 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Tue, 8 Sep
 2026 10:31:47 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Sep
 2026 10:31:47 +0800
To: <ltp@lists.linux.it>
Date: Tue, 8 Sep 2026 10:31:21 +0800
Message-ID: <20260908023121.1895897-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 6882Vmdv010249
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap21: Check for free space before mapping the file
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Victor Cheng-Yen Yang <cyyang772@andestech.com>

The test creates a sparse file with lseek() and a one byte write, so
mmap() allocates no blocks. The child then touches every byte and ext4
fills the holes inside ext4_page_mkwrite(). A store instruction has no
error return, so an ENOSPC there becomes VM_FAULT_SIGBUS and the test
reports only

  tst_test.c:536: TBROK: Child (13042) killed by signal SIGBUS

which says nothing about the full filesystem. The information is
available before the mapping and gone after it, so check it in setup
and report TCONF earlier as convention.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 testcases/kernel/syscalls/mmap/mmap21.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
index ea3ae835a..3d6e8bd46 100644
--- a/testcases/kernel/syscalls/mmap/mmap21.c
+++ b/testcases/kernel/syscalls/mmap/mmap21.c
@@ -10,6 +10,7 @@
  * access, and read back the data from the file.
  */
 
+#include <sys/vfs.h>
 #include "tst_test.h"
 
 #define FILE_NAME "testfile"
@@ -71,11 +72,24 @@ exit:
 
 static void setup(void)
 {
+	struct statfs sf;
+	unsigned long long needed, avail;
+
 	if (tst_parse_filesize(str_pages, &pages, 1, LLONG_MAX))
 		tst_brk(TBROK, "Invalid number of pages: %s", str_pages);
 
 	memory_size = pages * getpagesize();
 
+	/* the byte written past the mapping costs a whole block */
+	SAFE_STATFS(".", &sf);
+	needed = memory_size + sf.f_bsize;
+	avail = (unsigned long long)sf.f_bavail * sf.f_bsize;
+
+	if (!tst_fs_has_free(".", needed, TST_BYTES)) {
+		tst_brk(TCONF, "Not enough free space, test needs %llu bytes, %llu available",
+			needed, avail);
+	}
+
 	buff = SAFE_MALLOC(memory_size);
 }
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
