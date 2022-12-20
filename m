Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26B8C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 05:46:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EF3E3CBA71
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:46:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD66A3CBA4A
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 06:45:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89FAD6006C9
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 06:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671515154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gMhOLRSo6IoxBGLEqd1HmriUiOuYiBbEYXvFA4vSfOE=;
 b=DouGACLcjIpESsLxA8GnkJNA4fykbcDQZPnt4+p3KP5RjyUhk8KN5OwH1BtN7+eOaJ0lJK
 QAGIP0/E2liwV1jl8Pn0jMHTrFJnbzZlvjeCiWdyevtZC5Q4RB4A2q7xZwpEIyI7elZAn8
 HL7KjDL49flhd1/zSz708PBdEAcRfUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-KTuachPlOF-niKggo0X99w-1; Tue, 20 Dec 2022 00:45:52 -0500
X-MC-Unique: KTuachPlOF-niKggo0X99w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63E6C80D0E4
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:45:52 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E58A40C2064
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:45:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 13:45:49 +0800
Message-Id: <20221220054549.1757270-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] set_mempolicy01: cancel the limit of maximum runtime
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

It needs more time for running on multiple numa nodes system.
Here propose to cancel the limit of max_runtime.

  ========= test log on 16 nodes system =========
  ...
  set_mempolicy01.c:80: TPASS: child: Node 15 allocated 16
  tst_numa.c:25: TINFO: Node 0 allocated 0 pages
  tst_numa.c:25: TINFO: Node 1 allocated 0 pages
  tst_numa.c:25: TINFO: Node 2 allocated 0 pages
  tst_numa.c:25: TINFO: Node 3 allocated 0 pages
  tst_numa.c:25: TINFO: Node 4 allocated 0 pages
  tst_numa.c:25: TINFO: Node 5 allocated 0 pages
  tst_numa.c:25: TINFO: Node 6 allocated 0 pages
  tst_numa.c:25: TINFO: Node 7 allocated 0 pages
  tst_numa.c:25: TINFO: Node 8 allocated 0 pages
  tst_numa.c:25: TINFO: Node 9 allocated 0 pages
  tst_numa.c:25: TINFO: Node 10 allocated 0 pages
  tst_numa.c:25: TINFO: Node 11 allocated 0 pages
  tst_numa.c:25: TINFO: Node 12 allocated 0 pages
  tst_numa.c:25: TINFO: Node 13 allocated 0 pages
  tst_numa.c:25: TINFO: Node 14 allocated 0 pages
  tst_numa.c:25: TINFO: Node 15 allocated 16 pages
  set_mempolicy01.c:80: TPASS: parent: Node 15 allocated 16

  Summary:
  passed   393210
  failed   0
  broken   0
  skipped  0
  warnings 0

  real	6m15.147s
  user	0m33.641s
  sys	0m44.553s

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index 07f5d789b..502e33024 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -110,6 +110,7 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.max_runtime = TST_UNLIMITED_RUNTIME,
 };
 
 #else
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
