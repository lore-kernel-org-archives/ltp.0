Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF04DC433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 08:37:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F14C93CAB86
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 10:37:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D75A3CAAEC
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:36:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0A229200C6A
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653035794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3B7x0PRlHlNwgEmW8jTsOeIxbREUNulCAm0OsyYUkU=;
 b=OZ8wjmhPUmz5oTNb95I53ZJ5OaEQQ7vTBcVJAhxzNgRbPSTO2WraormaoTeGUt8NVqEJAL
 Dl5IGtOdzlDVhU7mVEeZShxVXjjIOIYHwwbJ+tuWMxrb7uV2omuIeZt3+BouSqjIYVc/RR
 mxoAGR7uFcRcKojDZ9eiSPve9UgBDPI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-Bd1Kd6q5P_SRmxg0fIdSYg-1; Fri, 20 May 2022 04:36:33 -0400
X-MC-Unique: Bd1Kd6q5P_SRmxg0fIdSYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A37D38349B1
 for <ltp@lists.linux.it>; Fri, 20 May 2022 08:36:33 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86220492C3B
 for <ltp@lists.linux.it>; Fri, 20 May 2022 08:36:32 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 20 May 2022 16:36:27 +0800
Message-Id: <20220520083627.2499121-3-liwang@redhat.com>
In-Reply-To: <20220520083627.2499121-1-liwang@redhat.com>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] mmap3: reset runtime to 10s
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

As we have removed the "-x" support from this test, there is no way to
reduce running time by multiply small float number.

Let's set 10 seconds for the max_runtime (approximately equal to -x 0.002).

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/mm                           | 2 +-
 testcases/kernel/mem/mtest06/mmap3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 6537666a9..4ecb61f24 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -16,7 +16,7 @@ mtest01w mtest01 -p80 -w
 mtest05   mmstress
 mtest06   mmap1
 mtest06_2 mmap2 -x 0.002 -a -p
-mtest06_3 mmap3 -x 0.002 -p
+mtest06_3 mmap3 -p
 # Remains diabled till the infinite loop problem is solved
 #mtest-6_4 shmat1 -x 0.00005
 
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index 6d47b01e7..3064f5cf7 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -182,5 +182,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_mmap,
-	.max_runtime = 86400,
+	.max_runtime = 10,
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
