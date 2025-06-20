Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF32C7115B
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750409781; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nNKfyxKAWBBR1/UX+JnE++bevDZbBe+XQaqDN9ci4f8=;
 b=WcxvgtxFsQz04bDe4OF1CxBneOpVh3FRrBKWxgHax/zh3KLeIwhtsOGpX4V/GkMSMcGA3
 Wq9JtiF57zXcaNkVAGKJQYD7fkOQo2y2zHcQCNLbIGt/veun9vuDvIDbGQJlVq7oO1FvQUu
 oyAFIGBS0OOApOuealFRLQqBV0sXKIA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A1783CC82E
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 10:56:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B7913CB18C
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 10:55:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 408E82009E8
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 10:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750409756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y9QzwD+bShPGBHHM1CrvDrT39M3IYdd8jx/VXaVc6LQ=;
 b=Xft8qzFkgRlHH64f/YY15RoMMYhmOZYe3xrmm1osx0rZPobiXNgknxiuLAazDOY4rnf2nv
 6fY4GWCqWrxjTly3YuRLtGWGzmKwphLW5cFR0yvEaRT0teLBgFDy63HvL1XSXqQU1GNNLf
 a3Ku5it1dTq12xDQr6JnR7QbYRtbR+8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-kNmm5V8NOA6EMGGm4Xun8Q-1; Fri,
 20 Jun 2025 04:55:54 -0400
X-MC-Unique: kNmm5V8NOA6EMGGm4Xun8Q-1
X-Mimecast-MFC-AGG-ID: kNmm5V8NOA6EMGGm4Xun8Q_1750409753
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57C8519560B5
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 08:55:53 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.218])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 307A918003FC
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 08:55:50 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 20 Jun 2025 16:55:48 +0800
Message-ID: <20250620085548.519702-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5eLNSTI_2G44jCWWCsB4ldWAc8X7wKzd9K9qqri7aSM_1750409753
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] preadv203: avoid false failures when runtime is
 scaled down
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test relies on a certain number of iterations of I/O operations to
probabilistically trigger EAGAIN, which is a core part of the test's pass
condition.

When .runtime is scaled down with LTP_RUNTIME_MUL=0.1, the main test loop
(while (!stop && tst_remaining_runtime())) exits too early, before enough
contention or conditions are created to hit EAGAIN, especially on fast
filesystems (e.g., ext2, ext4).

This leads to false negatives like:
  preadv203.c:224: TFAIL: Haven't got EAGAIN

To address this, we now report TCONF (configuration issue) when the test
finishes without EAGAIN but also before the expected runtime could be met.
This avoids misreporting test failures due to overly aggressive runtime scaling.

Rely-on: https://lists.linux.it/pipermail/ltp/2025-June/043960.html
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/preadv2/preadv203.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 72a35d3ab..128e7ae34 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -218,8 +218,13 @@ static void verify_preadv2(void)
 	SAFE_PTHREAD_JOIN(dropper, NULL);
 	SAFE_PTHREAD_JOIN(writer, NULL);
 
-	if (eagains)
+	if (eagains) {
 		tst_res(TPASS, "Got some EAGAIN");
+		return;
+	}
+
+	if (!tst_remaining_runtime())
+		tst_res(TCONF, "Runtime too short to reliably trigger EAGAIN");
 	else
 		tst_res(TFAIL, "Haven't got EAGAIN");
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
