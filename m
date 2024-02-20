Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32388C48BC4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 09:13:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFA493CF1D0
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 10:13:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3A6F3CDAD0
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 10:13:37 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 633EB6011B8
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 10:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708420414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r+XkQnRLup48mFZIqwFvdjPpxnnBBnJEF71m/qV98+Y=;
 b=eHsga9w3BWpqd31H8WbiwOa1q13ppdC74dLY34ZH4mk8c8WzYeBh9qHxHYRBEERszjwuoJ
 8YDmGSDdD59Rr4sXPgxq3Ef85wMJwKYmD4A3Jne2PBMm8/+dQnTlP3DzH9mDyDRAcj5iKy
 VMqApdY4y1p5muIagCNGnz2lcwvJ/Vk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-qq4HtTV6NJaCjg3wVjjnag-1; Tue, 20 Feb 2024 04:13:33 -0500
X-MC-Unique: qq4HtTV6NJaCjg3wVjjnag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F268485A58E
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 09:13:32 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14F1E400D783
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 09:13:31 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 17:13:28 +0800
Message-Id: <20240220091328.2946023-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] move_pages12: compacting memory before each test loop
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

These simple steps are added to prepare the system's memory state
for the test, aiming to increase the test's reliability and
consistency by starting from a clean and defragmented memory state.

To reduce accidental failures on small (1.5G) RAM system:

  7 tst_test.c:1558: TINFO: Timeout per run is 0h 21m 00s
  8 move_pages12.c:273: TINFO: Free RAM 1542656 kB
  9 move_pages12.c:289: TINFO: Increasing 16384kB hugepages pool on node 0 to 4
  10 move_pages12.c:299: TINFO: Increasing 16384kB hugepages pool on node 1 to 4
  11 move_pages12.c:216: TINFO: Allocating and freeing 4 hugepages on node 0
  12 move_pages12.c:216: TINFO: Allocating and freeing 4 hugepages on node 1
  13 move_pages12.c:207: TPASS: Bug not reproduced
  14 move_pages12.c:106: TFAIL: madvise failed: ENOMEM (12)
  ...<repeats 741 times>...
  756 move_pages12.c:207: TPASS: Bug not reproduced

Note:
  This is a single hugetlb test without invoking the hugetlb-lib of LTP,
  so we add the compacting memory/cache steps additionally.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index fd7017d79..c387a326f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -154,6 +154,9 @@ static void do_test(unsigned int n)
 	pid_t cpid = -1;
 	int status;
 
+	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
+
 	addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
