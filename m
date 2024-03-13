Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2121EC54E58
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 09:24:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 860D23CFD25
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 10:24:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E7733CD7F5
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:23:39 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 413BD1009BCF
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:23:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 111F91F7C7;
 Wed, 13 Mar 2024 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710321818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p83UPYO5Vl0d9uF8N2fG8V9Os0/MTyJWFlt/dhOaPCc=;
 b=LfUi1gyfTEv8+R6P7GCgGlmt1Nnz81c5QmO+Q+4q5U/E2C9yFBIvp3E87lYtdLbmNTFtw0
 cmozIZ55ysGiWfNAkFetT1dvQ1K5ftrGAJvlItvpfr/O+vGFUCDc0LOHBLhYSTVi9Is7LY
 eXqHPtXfvCcobpM2SjNafZM7kDahSS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710321818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p83UPYO5Vl0d9uF8N2fG8V9Os0/MTyJWFlt/dhOaPCc=;
 b=EuTbC3R6pmfhS2Bzc1O98fujcOoFT01NLXqm/qluDv3NNorT8YJqxv4x0JIGKtEmFGBsOx
 7ORm6qUlZFXioiAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710321818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p83UPYO5Vl0d9uF8N2fG8V9Os0/MTyJWFlt/dhOaPCc=;
 b=LfUi1gyfTEv8+R6P7GCgGlmt1Nnz81c5QmO+Q+4q5U/E2C9yFBIvp3E87lYtdLbmNTFtw0
 cmozIZ55ysGiWfNAkFetT1dvQ1K5ftrGAJvlItvpfr/O+vGFUCDc0LOHBLhYSTVi9Is7LY
 eXqHPtXfvCcobpM2SjNafZM7kDahSS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710321818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p83UPYO5Vl0d9uF8N2fG8V9Os0/MTyJWFlt/dhOaPCc=;
 b=EuTbC3R6pmfhS2Bzc1O98fujcOoFT01NLXqm/qluDv3NNorT8YJqxv4x0JIGKtEmFGBsOx
 7ORm6qUlZFXioiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF6E613980;
 Wed, 13 Mar 2024 09:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MBqBL5lw8WU2dAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Mar 2024 09:23:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 10:23:31 +0100
Message-Id: <20240313092331.18069-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313092331.18069-1-andrea.cervesato@suse.de>
References: <20240313092331.18069-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LfUi1gyf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EuTbC3R6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 111F91F7C7
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] Add shmat04 SysV IPC bug reproducer
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
Ensure that GETIPCKEY() will give a free slot given IPC key + 1

 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |  1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 92 +++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fab870ace..4ed2b5602 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1444,6 +1444,7 @@ setxattr03 setxattr03
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
index 000000000..ed03f8260
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
@@ -0,0 +1,92 @@
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
+	SAFE_MPROTECT(sh_mem + page_size, page_size, PROT_NONE);
+	SAFE_MPROTECT(sh_mem, 2 * page_size, PROT_WRITE);
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
+	key_id = GETIPCKEY() + 1;
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
