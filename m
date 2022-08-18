Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85D3C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 09:50:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7326A3CA22A
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:50:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 686B03C87EF
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:50:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 745E320090D
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660816235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IRsz/P9/Mtacq3YGcsD/Pa0uTJtMXyshF1iH20vzkuk=;
 b=NLYKPcpgwU5mLDtg8UkOPnYJXz8A1IpO2nJ0f/pdAj1lkVLeXc6Ur7OYbbhmy4eTqeppyb
 1TPpCwao8B24hGT/kkhn2uTsp0V5MT1POl8ee1l8Q5bCUnKchNBH7badItUUnn0DlU4y1K
 0KvgyBp/u2SdQ0V5qPyPTOXVT61+dS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-j3rV7x5KNwWEMlHqFBojfQ-1; Thu, 18 Aug 2022 05:50:33 -0400
X-MC-Unique: j3rV7x5KNwWEMlHqFBojfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 835F6185A7BA
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 09:50:33 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91DDA2166B26
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 09:50:32 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 18 Aug 2022 17:50:30 +0800
Message-Id: <20220818095030.1964355-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statx04: mask STATX_ATTR_COMPRESSED on tmpfs
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

Recently a new kernel commit (e408e695f) introduces the inode attributes
being supported in tmpfs, which is like other Linux file systems. But that
caused statx04 to throw an unsupported error in STATX_ATTR_COMPRESSED.

This patch help masks it just like what we did for XFS.

    tst_test.c:1599: TINFO: Testing on tmpfs
    tst_test.c:1064: TINFO: Skipping mkfs for TMPFS filesystem
    tst_test.c:1045: TINFO: Limiting tmpfs size to 32MB
    statx04.c:114: TFAIL: STATX_ATTR_COMPRESSED not supported
    statx04.c:112: TPASS: STATX_ATTR_APPEND is supported
    statx04.c:112: TPASS: STATX_ATTR_IMMUTABLE is supported
    statx04.c:112: TPASS: STATX_ATTR_NODUMP is supported

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/statx/statx04.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 083298310..03d909534 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -17,7 +17,7 @@
  * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
  * three other flags.
  *
- * ext2, ext4, btrfs and xfs support statx syscall since the following commit
+ * ext2, ext4, btrfs, xfs and tmpfs support statx syscall since the following commit
  *
  *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
  *  Author: yangerkun <yangerkun@huawei.com>
@@ -42,6 +42,13 @@
  *  Date:   Fri Mar 31 18:32:03 2017 +0100
  *
  *  xfs: report crtime and attribute flags to statx
+ *
+ *  commit e408e695f5f1f60d784913afc45ff2c387a5aeb8
+ *  Author: Theodore Ts'o <tytso@mit.edu>
+ *  Date:   Thu Jul 14 21:59:12 2022 -0400
+ *
+ *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
+ *
  */
 
 #define _GNU_SOURCE
@@ -88,8 +95,8 @@ static void setup(void)
 	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
 		expected_mask |= attr_list[i].attr;
 
-	/* STATX_ATTR_COMPRESSED not supported on XFS */
-	if (!strcmp(tst_device->fs_type, "xfs"))
+	/* STATX_ATTR_COMPRESSED not supported on XFS, TMPFS */
+	if (!strcmp(tst_device->fs_type, "xfs") || !strcmp(tst_device->fs_type, "tmpfs"))
 		expected_mask &= ~STATX_ATTR_COMPRESSED;
 
 	/* Attribute support was added to Btrfs statx() in kernel v4.13 */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
