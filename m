Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D665AC54E49
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 11:35:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60C93CEF94
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 12:35:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DCD53CC0CD
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 12:35:22 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4167160A787
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 12:35:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E4AC224CA;
 Mon, 26 Feb 2024 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708947321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PIoRdyMQIRDibAH86Ce6y6FHWFoMARmwKqTBPQMClvI=;
 b=krkI+r40e7AS6Cip0HNUaHXQyjD6H73dcgJD5YjMKc9ly3y6fpUsuT037PRkTlY8mBJHYk
 p6XEAqP/etq7u0FzeT9PrXF57AHSAfbwACYfDqp04ObzbhknXovIQAXVi1ggs5pQlvbT5F
 fF75j1t8MSOhOTDT6vktsLMFj9FlLhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708947321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PIoRdyMQIRDibAH86Ce6y6FHWFoMARmwKqTBPQMClvI=;
 b=XesTuzzdrTFwg5b4vxSKNYKKMAzueJA2GUFUABGQ3YwZlUvkzQTlGr4QAvR/2nxNCxXgja
 ebP//TVQcNCR00BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708947321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PIoRdyMQIRDibAH86Ce6y6FHWFoMARmwKqTBPQMClvI=;
 b=krkI+r40e7AS6Cip0HNUaHXQyjD6H73dcgJD5YjMKc9ly3y6fpUsuT037PRkTlY8mBJHYk
 p6XEAqP/etq7u0FzeT9PrXF57AHSAfbwACYfDqp04ObzbhknXovIQAXVi1ggs5pQlvbT5F
 fF75j1t8MSOhOTDT6vktsLMFj9FlLhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708947321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PIoRdyMQIRDibAH86Ce6y6FHWFoMARmwKqTBPQMClvI=;
 b=XesTuzzdrTFwg5b4vxSKNYKKMAzueJA2GUFUABGQ3YwZlUvkzQTlGr4QAvR/2nxNCxXgja
 ebP//TVQcNCR00BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFB6C13A3A;
 Mon, 26 Feb 2024 11:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Od9aKXh33GWJQQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 26 Feb 2024 11:35:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 12:35:10 +0100
Message-Id: <20240226113510.29937-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add shmat04 SysV IPC bug reproducer
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This is an LTP port of a SysV bug reproducer provided by Michal Hocko.

When debugging issues with a workload using SysV shmem, Michal Hocko has
come up with a reproducer that shows how a series of mprotect()
operations can result in an elevated shm_nattch and thus leak of the
resource.

The problem is caused by wrong assumptions in vma_merge() commit
714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
mergeability test"). The shmem vmas have a vma_ops->close callback
that decrements shm_nattch, and we remove the vma without calling it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |  1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 91 +++++++++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7794f1465..cc0144379 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1445,6 +1445,7 @@ setxattr03 setxattr03
 shmat01 shmat01
 shmat02 shmat02
 shmat03 shmat03
+shmat04 shmat04
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index df41140a7..9860394de 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -49,6 +49,7 @@ semop03 semop03
 
 shmat01 shmat01
 shmat02 shmat02
+shmat04 shmat04
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/testcases/kernel/syscalls/ipc/shmat/.gitignore b/testcases/kernel/syscalls/ipc/shmat/.gitignore
index 2b972f8f2..5600b2742 100644
--- a/testcases/kernel/syscalls/ipc/shmat/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmat/.gitignore
@@ -1,3 +1,4 @@
 /shmat01
 /shmat02
 /shmat03
+/shmat04
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat04.c b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
new file mode 100644
index 000000000..fb7857345
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC
+ * Author: Michal Hocko <mhocko@suse.com>
+ * LTP port: Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * When debugging issues with a workload using SysV shmem, Michal Hocko has
+ * come up with a reproducer that shows how a series of mprotect()
+ * operations can result in an elevated shm_nattch and thus leak of the
+ * resource.
+ *
+ * The problem is caused by wrong assumptions in vma_merge() commit
+ * 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
+ * mergeability test"). The shmem vmas have a vma_ops->close callback
+ * that decrements shm_nattch, and we remove the vma without calling it.
+ *
+ * Patch: https://lore.kernel.org/all/20240222215930.14637-2-vbabka@suse.cz/
+ */
+
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define PAGE_SIZE 4096UL
+#define KEY_ID 0x1234
+#define MAGIC_ADDR 290816
+
+static int segment_id = -1;
+
+static void run(void)
+{
+	char *sh_mem;
+	struct shmid_ds shmid_ds;
+	size_t segment_size = 16UL << 20;
+	size_t addr_step = 4 * PAGE_SIZE;
+
+	segment_id = SAFE_SHMGET(
+		KEY_ID,
+		segment_size,
+		IPC_CREAT | IPC_EXCL | 0600);
+
+	sh_mem = (char *)SAFE_SHMAT(segment_id, NULL, 0);
+
+	tst_res(TINFO, "Segment ID: %d - Segment Size: %lu", segment_id, segment_size);
+	tst_res(TINFO, "Attached at %p", sh_mem);
+
+	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
+
+	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
+	tst_res(TINFO, "Disable memory access");
+
+	for (char *addr = sh_mem; addr < sh_mem + segment_size; addr += addr_step)
+		mprotect(addr, PAGE_SIZE, PROT_NONE);
+
+	tst_res(TINFO, "Write memory protection at %d", MAGIC_ADDR);
+
+	/* This breaks it - anything but PROT_NONE */
+	mprotect(sh_mem + MAGIC_ADDR, 8192, PROT_WRITE);
+
+	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
+
+	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
+	tst_res(TINFO, "Delete attached memory");
+
+	SAFE_SHMDT(sh_mem);
+	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
+
+	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
+
+	SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
+	segment_id = -1;
+
+	if (shmid_ds.shm_nattch)
+		tst_res(TFAIL, "The system is affected by the SysV IPC bug");
+	else
+		tst_res(TPASS, "Test passed");
+}
+
+static void cleanup(void)
+{
+	if (segment_id != -1)
+		SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
