Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E6C0219E
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 03:25:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91EFC3C98F4
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 04:25:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20BE3C2D4E
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 04:25:08 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3E1B01BEBE78
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 04:25:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739244305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y74crPhIdY7oBSUjYZbVsYMfKWAEEdvU5A6iSE8eFb8=;
 b=D1lDDkLZfMyD/7ABwe+dr+eDSbgNqp5GW3658WOkoRZ0DVJ6m5iTh+819cKhm1m6aXVl3Y
 1eM5R6922hFA6QHOwVi7Al/OpIxyJZSKlVPqDvyDEOTvxu9brzxjk93SCiZ9tfynEbXwgt
 6GCrRoaK08981ESzFUXsG/rF6c2IW6I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-kN1vCSp0P4aSLki0gMcCvg-1; Mon,
 10 Feb 2025 22:25:03 -0500
X-MC-Unique: kN1vCSp0P4aSLki0gMcCvg-1
X-Mimecast-MFC-AGG-ID: kN1vCSp0P4aSLki0gMcCvg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ECBF18004A7
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 03:25:02 +0000 (UTC)
Received: from thoundrobot.redhat.com (unknown [10.72.112.207])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9181430001AB; Tue, 11 Feb 2025 03:24:59 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 11:24:57 +0800
Message-ID: <20250211032457.7396-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0jVGehnA6Y94RFB9Li-rH-hE7sfF8vH4e1tXLM2C8Ko_1739244302
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statx07: Skip test if NFS server is never enabled
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
Cc: Yongcheng Yang <yoyang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The statx07 test requires an active NFS server, as it relies on
exportfs, which reads from '/var/lib/nfs/etab'. By default, etab
file does not exist unless the NFS server is started at least once
(since new version nfs-utils-2.5.4-32.el9).

This causing the test to fail when etab is missing:

  tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
  tst_buffers.c:57: TINFO: Test is using guarded buffers
  exportfs: can't open /var/lib/nfs/etab for reading
  statx07.c:136: TBROK: failed to exportfs

This patch adds a check using access("/var/lib/nfs/etab", F_OK)
before running the test. If the file does not exist, the test
is skipped (TCONF) instead of failing, preventing misleading
test failures.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Yongcheng Yang <yoyang@redhat.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 968174330..bc8e6fd65 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -115,6 +115,9 @@ static void setup(void)
 	int ret;
 	char server_path[BUFF_SIZE];
 
+	if (access("/var/lib/nfs/etab", F_OK) < 0)
+		tst_brk(TCONF, "nfs-server might not set up");
+
 	mode_t old_umask = umask(0);
 
 	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
