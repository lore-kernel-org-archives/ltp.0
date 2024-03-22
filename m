Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A4CC54E58
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 03:02:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 499A93CFBC9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 04:02:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6C183CF1DF
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 04:02:23 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20A2C600713
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 04:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711076541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HM5y23Be45MM33YheG03yqVTEQhG7IH+5OT+MyOqbGQ=;
 b=RhSUVCV3NJwMuiaZ9S3mQSg1e//QON1eRfAfGEagAubUaKBKtQqUkXIJez4L6IYJflRdIC
 FjA3LTs8YlbQXMP1c800o/augO6Q/exjXh6IAuvBmi//pwoNmQ9lnRrSpqfrt/3DpcqIob
 3JYcP8kzFDuoVFu6w74neHJniw4JKzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-PHCtdlF0M6ysIcZmJQc3IA-1; Thu, 21 Mar 2024 23:02:15 -0400
X-MC-Unique: PHCtdlF0M6ysIcZmJQc3IA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C679185A781;
 Fri, 22 Mar 2024 03:02:15 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FBF1C15773;
 Fri, 22 Mar 2024 03:02:14 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 22 Mar 2024 11:02:08 +0800
Message-Id: <20240322030208.3278120-2-liwang@redhat.com>
In-Reply-To: <20240322030208.3278120-1-liwang@redhat.com>
References: <20240322030208.3278120-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] swapon01: create 128MB swapfile
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

The modification in the setup function changes the swap file
creation approach. Instead of allocating swap space based on
a number of blocks (which potentially could be too small for
the polluted memory swapout, thus causing an OOM), it now uses
a fixed size of 128 units for the swap file creation.

This is likely a conservative figure to prevent the OOM killer
from being triggered due to excessive memory allocation for the
swap file, helping ensure the test runs successfully on systems
with no swap space.

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index b986d97c4..49915c32d 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -38,7 +38,7 @@ static void verify_swapon(void)
 static void setup(void)
 {
 	is_swap_supported(SWAP_FILE);
-	MAKE_SWAPFILE_BLKS(SWAP_FILE, 10);
+	MAKE_SWAPFILE_SIZE(SWAP_FILE, 128);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
