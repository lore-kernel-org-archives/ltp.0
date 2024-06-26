Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3EC30659
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 10:55:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35E793D115C
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 12:55:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94F7E3D116A
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 12:54:50 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB3CF1A0C69B
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 12:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719399288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osQmSi7z92TglC+x0QpuWSFHz3DkGGKOWi1rMAl9RLE=;
 b=PUE2Mx3v+FdcrcCsionGC4cJikf5DT9NBChqVVE5AaU5wcxuKSyqs3DoBbNjO5iwsehS/j
 cFQcTtOXJQoyZxesDcp3wFoNtxbc1nRhQjsa1zdfLRy7q749URKKN1ceyyL2Vlq1OEUdcR
 pdK/f10AxAoUG9rGhWrgvngBmsKIwO0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-RbTugf3QO0u6SYGxQ-g4XQ-1; Wed,
 26 Jun 2024 06:54:41 -0400
X-MC-Unique: RbTugf3QO0u6SYGxQ-g4XQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38041956083
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 10:54:40 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 994EF1956050
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 10:54:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 26 Jun 2024 18:54:31 +0800
Message-ID: <20240626105431.746411-2-liwang@redhat.com>
In-Reply-To: <20240626105431.746411-1-liwang@redhat.com>
References: <20240626105431.746411-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/2] testcase: use new TST_RES macros
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

This is a damo for use TST_RES_ MACRO (randomly replace some), we might
not want to replace tst_res() all by macros, to keep both methods exist
probably more flexiable.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_kconfig.c                               |  2 +-
 lib/tst_supported_fs_types.c                    |  2 +-
 testcases/kernel/kvm/kvm_pagefault01.c          |  2 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c      |  2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl08.c |  2 +-
 testcases/kernel/syscalls/madvise/madvise01.c   |  6 +++---
 testcases/kernel/syscalls/madvise/madvise02.c   | 10 +++++-----
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index e16ca1400..3678669c7 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -606,7 +606,7 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)
 		break;
 		default:
 			if (b_pos + 1 >= sizeof(buf)) {
-				tst_res(TWARN, "Buffer overflowed while parsing /proc/cmdline");
+				TST_RES_TWARN("Buffer overflowed while parsing /proc/cmdline");
 				while (line[l_pos] != '\0' && line[l_pos] != ' ' && line[l_pos] != '\n')
 					l_pos++;
 
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19..fbee7f23b 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -158,7 +158,7 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	only_fs = getenv("LTP_SINGLE_FS_TYPE");
 
 	if (only_fs) {
-		tst_res(TINFO, "WARNING: testing only %s", only_fs);
+		TST_RES_TWARN("testing only %s", only_fs);
 		if (tst_fs_is_supported(only_fs))
 			fs_types[0] = only_fs;
 		return fs_types;
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
index 16b3137c0..e6ed1bacb 100644
--- a/testcases/kernel/kvm/kvm_pagefault01.c
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -200,7 +200,7 @@ static void disable_tdp(void)
 		reload_module("kvm_intel", "ept=0");
 
 	if (read_bool_sys_param(TDP_MMU_SYSFILE) > 0)
-		tst_res(TINFO, "WARNING: tdp_mmu is enabled, beware of false negatives");
+		TST_RES_TWARN("tdp_mmu is enabled, beware of false negatives");
 }
 
 static void setup(void)
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 43a677ce9..14fc5a905 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -106,7 +106,7 @@ void rm_shm(int shm_id)
 	 * check for # of attaches ?
 	 */
 	if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
-		tst_res(TINFO, "WARNING: shared memory deletion failed.");
+		TST_RES_TWARN("shared memory deletion failed.");
 		tst_res(TINFO, "This could lead to IPC resource problems.");
 		tst_res(TINFO, "id = %d", shm_id);
 	}
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
index 1878bd49d..64160af05 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -40,7 +40,7 @@ static void run(void)
 		tst_res(TPASS, "time_high fields cleared by the kernel");
 
 	if (semctl(semid, 0, IPC_RMID, arg) == -1)
-		tst_res(TINFO, "WARNING: semaphore deletion failed.");
+		TST_RES_TWARN("semaphore deletion failed.");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 884c59b0b..ba2c79536 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -102,15 +102,15 @@ static void verify_madvise(unsigned int i)
 
 	if (TST_RET == -1) {
 		if (TST_ERR == EINVAL) {
-			tst_res(TCONF, "%s is not supported", tc->name);
+			TST_BRK_TCONF("%s is not supported", tc->name);
 		} else {
-			tst_res(TFAIL, "madvise test for %s failed with "
+			TST_RES_TFAIL("madvise test for %s failed with "
 					"return = %ld, errno = %d : %s",
 					tc->name, TST_RET, TST_ERR,
 					tst_strerrno(TFAIL | TTERRNO));
 		}
 	} else {
-		tst_res(TPASS, "madvise test for %s PASSED", tc->name);
+		TST_RES_TPASS("madvise test for %s PASSED", tc->name);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index cc3faf5cf..bfe6e55c4 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -92,7 +92,7 @@ static void tcases_filter(void)
 		switch (tc->advice) {
 		case MADV_DONTNEED:
 			if (mlock(file1, st.st_size) < 0)
-				tst_brk(TBROK | TERRNO, "mlock failed");
+				TST_BRK_TBROK_ER(TERRNO, "mlock failed");
 		break;
 		case MADV_MERGEABLE:
 		case MADV_UNMERGEABLE:
@@ -160,22 +160,22 @@ static void advice_test(unsigned int i)
 	struct tcase *tc = &tcases[i];
 
 	if (tc->skip == 1) {
-		tst_res(TCONF, "%s is not supported", tc->name);
+		TST_RES_TCONF("%s is not supported", tc->name);
 		return;
 	}
 
 	TEST(madvise(*(tc->addr), st.st_size, tc->advice));
 	if (TST_RET == -1) {
 		if (TST_ERR == tc->exp_errno) {
-			tst_res(TPASS | TTERRNO, "%s failed as expected", tc->name);
+			TST_RES_TPASS_ER(TTERRNO, "%s failed as expected", tc->name);
 		} else {
-			tst_res(TFAIL | TTERRNO,
+			TST_RES_TFAIL_ER(TTERRNO,
 					"%s failed unexpectedly; expected - %d : %s",
 					tc->name, tc->exp_errno,
 					tst_strerrno(TFAIL | TTERRNO));
 		}
 	} else {
-		tst_res(TFAIL, "madvise succeeded unexpectedly");
+		TST_RES_TFAIL("madvise succeeded unexpectedly");
 	}
 }
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
