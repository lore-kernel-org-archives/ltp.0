Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528DFC5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A77CB3D0053
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:07:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3277F3CE0C2
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:07:13 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 40E6110007AE
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:07:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A3997656C;
 Mon,  4 Mar 2024 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709564831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3Uj66VM4NOE/tVKXKcOqmyEYDGe5EstdeDvzISwPeU=;
 b=iN+1m/zn/Jq21/sI7KqjcocGJ+eAKJCh1jV0/ZMMEi/TjsTtS+opVHU/QOio1dHIvg+nce
 hJ1LfYlQOJXXIYXgSc2rBQItnN/weFIOmsZJlFe0Oc/hfK1mxy0v0Pyi0fKkF88FPo9zMQ
 Ce3ByWEiMbMeI7Cg7+dqEImObgntjP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709564831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3Uj66VM4NOE/tVKXKcOqmyEYDGe5EstdeDvzISwPeU=;
 b=WzZBRtopFxheMz3IjPNfPHitqKUns9OG88U2CTO9CGFs7zVdWK1TCNuEWZ9QW+ufxn6QQJ
 APpIIQa6Ne4TqXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709564831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3Uj66VM4NOE/tVKXKcOqmyEYDGe5EstdeDvzISwPeU=;
 b=iN+1m/zn/Jq21/sI7KqjcocGJ+eAKJCh1jV0/ZMMEi/TjsTtS+opVHU/QOio1dHIvg+nce
 hJ1LfYlQOJXXIYXgSc2rBQItnN/weFIOmsZJlFe0Oc/hfK1mxy0v0Pyi0fKkF88FPo9zMQ
 Ce3ByWEiMbMeI7Cg7+dqEImObgntjP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709564831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3Uj66VM4NOE/tVKXKcOqmyEYDGe5EstdeDvzISwPeU=;
 b=WzZBRtopFxheMz3IjPNfPHitqKUns9OG88U2CTO9CGFs7zVdWK1TCNuEWZ9QW+ufxn6QQJ
 APpIIQa6Ne4TqXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27D2913AC3;
 Mon,  4 Mar 2024 15:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YCvhBp/j5WX5YwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Mar 2024 15:07:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Mar 2024 16:07:09 +0100
Message-Id: <20240304150709.30260-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240304150709.30260-1-andrea.cervesato@suse.de>
References: <20240304150709.30260-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add shmat04 SysV IPC bug reproducer
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
result of TST_EXP_EQ_LU() as test result

 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |   1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 112 ++++++++++++++++++
 4 files changed, 115 insertions(+)
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
index 000000000..caadee961
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
@@ -0,0 +1,112 @@
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
+#include "libnewipc.h"
+
+static int segment_id = -1;
+static int key_id;
+static int page_size;
+static size_t segment_size;
+
+static void change_access(void *addr, int size, int prot)
+{
+	switch (prot) {
+	case PROT_NONE:
+		tst_res(TINFO, "Disable memory access. addr: %p - size: %d",
+			addr, size);
+		break;
+	case PROT_WRITE:
+		tst_res(TINFO, "Enable write memory access. addr: %p - size: %d",
+			addr, size);
+		break;
+	default:
+		tst_res(TINFO, "Change memory access. addr: %p - size: %d",
+			addr, size);
+		break;
+	}
+
+	SAFE_MPROTECT(addr, size, prot);
+}
+
+static void run(void)
+{
+	struct shmid_ds shmid_ds;
+	void *sh_mem;
+
+	segment_id = SAFE_SHMGET(
+		key_id,
+		segment_size,
+		IPC_CREAT | IPC_EXCL | 0600);
+
+	sh_mem = SAFE_SHMAT(segment_id, NULL, 0);
+
+	tst_res(TINFO, "Attached at %p. key: %d - size: %lu",
+		sh_mem, segment_id, segment_size);
+
+	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
+
+	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
+
+	change_access(sh_mem + page_size, page_size, PROT_NONE);
+	change_access(sh_mem, 2 * page_size, PROT_WRITE);
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
+	TST_EXP_EQ_LU(shmid_ds.shm_nattch, 0);
+}
+
+static void setup(void)
+{
+	key_id = GETIPCKEY();
+	page_size = getpagesize();
+
+	tst_res(TINFO, "Key id: %d", key_id);
+	tst_res(TINFO, "Page size: %d", page_size);
+
+	segment_size = 3 * page_size;
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
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
