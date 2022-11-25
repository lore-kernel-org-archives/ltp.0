Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A793C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:32:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75D203CC8A8
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:32:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A61A23CC89C
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:31:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B67E1200D58
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669379502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uocXs5/ft7uQbz+zfX8hY4YqbyE9Qjx1FDLSwegzctM=;
 b=bhfLbNnmGnNp1ZgQ1O5O7KpfEP1lq12UR41fqh3DE0DhyNsVSC5HISoY1Id5KBMrK8bpuI
 gTn7DxZA7YCk1vSUcW9AnDY45awqIyhNCP9fakPpvw5aE3JV89y/+xQkUTv9OcwsK21jP9
 dY8/90ktvrklNv0Ns1Ffke/X1XJOPZE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-iS7880XnPSuBqISg4K4xCw-1; Fri, 25 Nov 2022 07:31:37 -0500
X-MC-Unique: iS7880XnPSuBqISg4K4xCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7883E293249A;
 Fri, 25 Nov 2022 12:31:37 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C56140C6DC7;
 Fri, 25 Nov 2022 12:31:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 13:31:29 +0100
Message-Id: <20221125123129.102360-3-david@redhat.com>
In-Reply-To: <20221125123129.102360-1-david@redhat.com>
References: <20221125123129.102360-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] security/dirtyc0w_shmem: Drop useless
 needs_tmpdir tag
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Compilation points out that:
  testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c: useless tag:
  needs_tmpdir

needs_tmpdir is implied by needs_checkpoints, so we can drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index 1e3b194e7..14b8f8317 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -109,7 +109,6 @@ static struct tst_test test = {
 	.needs_checkpoints = 1,
 	.forks_child = 1,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.max_runtime = 120,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
