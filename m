Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A12FC7EE25
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 09:14:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B26033CB2C6
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 11:14:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D71AB3C9EE7
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 11:14:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8E3311000B78
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 11:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686215671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QbqBfe8iGdckh7iJJ358rNk4jiX8haoSxkKSFsYyJ/4=;
 b=HtY/vfpHCPMPfuYXTr+PTVXsC92PYgNrCQqd6vlJmnSNd088U2kWEiq6jjs85FBPYcUO2G
 IfLQModB/Lrsbdvb1zESf20P4Gz5RYQlTqyNOT7hrtg83cguhU7QPitA2NuN3EfL6adkhH
 oqksu7U+qojlIrxDt9JLO2Tsg+wjtBU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-qaFtH4cZNcKOjPgtrZ3TIw-1; Thu, 08 Jun 2023 05:14:29 -0400
X-MC-Unique: qaFtH4cZNcKOjPgtrZ3TIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63C33811E96
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 09:14:29 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7596B9E8D
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 09:14:28 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  8 Jun 2023 17:14:26 +0800
Message-Id: <20230608091426.107673-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] preadv203: guarantee the subloop exit timely
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

We observed that timeout is still occasionally happening even with
introducing the tst_remaining_runtime. The likely reason is that
writer_thread needs more time in subloop.

Here exit it instantly when stop set to 1.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/preadv2/preadv203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 25c6e1c2e..c87deb674 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -159,7 +159,7 @@ static void *writer_thread(void *unused)
 	while (!stop) {
 		int fd = fds[random() % FILES];
 
-		for (j = 0; j < CHUNKS; j++) {
+		for (j = 0; j < CHUNKS && !stop; j++) {
 			memset(buf, '0' + j, sizeof(buf));
 
 			off_t off = CHUNK_SZ * j;
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
