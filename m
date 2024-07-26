Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB38C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 02:45:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF8DA3D1C2A
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 04:45:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0783D0E76
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 04:45:04 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A5AB1401716
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 04:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721961901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ocPWJDm1gOUeE9KbPi4UDzUOTmRYSXdABw9LPfhJX4I=;
 b=HPKkoaYDW6ipmw6FvUX0NGM1qaGdYPGASZ+3kA4J9gUPUpEcfxzG2ldWduX1HMieJH1F3n
 1rFkSayxMfz0fIN6fucUY7j8ydi0+EAXKGuYXdXrudWpAAj5svJGiFrS2d4Hwjubq+F9y1
 MOkAVkck7tLHRb5uu/wrPN/U4PY2s2w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-efSjuZV2PxKD19VSPAQ0tA-1; Thu,
 25 Jul 2024 22:44:57 -0400
X-MC-Unique: efSjuZV2PxKD19VSPAQ0tA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C982D1955D45; Fri, 26 Jul 2024 02:44:55 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4AF1955D42; Fri, 26 Jul 2024 02:44:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Fri, 26 Jul 2024 10:44:47 +0800
Message-ID: <20240726024447.134802-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cachestat: remove .min_kver from cachestat tests
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
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Removing the kernel version check (.min_kver) from the cachestat
tests to allow the test to run on distributions that backport the
cachestat syscall.

With no support just skip as TCONF:
  ../../../../include/lapi/mman.h:40: TCONF: syscall(451) __NR_cachestat not supported on your arch

Suggested-by: Stephen Bertram <sbertram@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 1 -
 testcases/kernel/syscalls/cachestat/cachestat02.c | 1 -
 testcases/kernel/syscalls/cachestat/cachestat03.c | 1 -
 testcases/kernel/syscalls/cachestat/cachestat04.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index f3730d773..19ae9655e 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -90,7 +90,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.min_kver = "6.5",
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
index 2bb94f133..e168de5a5 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat02.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -82,7 +82,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.min_kver = "6.5",
 	.bufs = (struct tst_buffers []) {
 		{&cs, .size = sizeof(struct cachestat)},
 		{&cs_range, .size = sizeof(struct cachestat_range)},
diff --git a/testcases/kernel/syscalls/cachestat/cachestat03.c b/testcases/kernel/syscalls/cachestat/cachestat03.c
index 35f6bdfb3..139745c34 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat03.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat03.c
@@ -70,7 +70,6 @@ static struct tst_test test = {
 	.needs_hugetlbfs = 1,
 	.hugepages = {1, TST_NEEDS},
 	.tcnt = ARRAY_SIZE(tcases),
-	.min_kver = "6.5",
 	.needs_tmpdir = 1,
 	.bufs = (struct tst_buffers []) {
 		{&cs, .size = sizeof(struct cachestat)},
diff --git a/testcases/kernel/syscalls/cachestat/cachestat04.c b/testcases/kernel/syscalls/cachestat/cachestat04.c
index a389c203c..a59494451 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat04.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat04.c
@@ -48,7 +48,6 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.min_kver = "6.5",
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.bufs = (struct tst_buffers []) {
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
