Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBA3C25B10
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 10:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C152B3CE104
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:28:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 671D13CE0C8
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:28:11 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 840C21400F8A
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715250489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Pn7E6V/yofAI+ouecmjurolmSRAv+V7SyYRNcVkW1g=;
 b=avNcq2TxKQVLpSt8ZoKK86VB7K1IfqVbkLnykgNn98x2EPXZcR+srNqQ2CtwnuAG1LOwH/
 3OHm/ex5N72lxq/0Pa4lklJiH/mX6qBhOqeKUfd0BrXdmMr5RBHbWgXxa58Wi8gfURuxOy
 QO9xBvT3PwpPGdYGrTjgP66R4reDmzQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-QL7Yjc6PPt2IokfMHNYYSA-1; Thu, 09 May 2024 06:28:07 -0400
X-MC-Unique: QL7Yjc6PPt2IokfMHNYYSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CDC7857A81
 for <ltp@lists.linux.it>; Thu,  9 May 2024 10:28:07 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06DD07414;
 Thu,  9 May 2024 10:28:05 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 May 2024 18:28:02 +0800
Message-ID: <20240509102802.20091-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] madvise11: ignore EBUSY for MADV_SOFT_OFFLINE
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
Cc: Luis Goncalves <lgoncalv@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The EBUSY error could be easily triggered on small system with
kernel-debug. By not treating EBUSY as a failure, the test can
avoid false positives where the test environment itself might
frequently cause resource contention.

Test output:
  madvise11.c:409: TINFO: Spawning 4 threads, with a total of 640 memory pages
  madvise11.c:163: TINFO: Thread [0] returned 0, succeeded.
  madvise11.c:163: TINFO: Thread [2] returned 0, succeeded.
  madvise11.c:163: TINFO: Thread [1] returned 0, succeeded.
  madvise11.c:163: TINFO: Thread [3] returned 0, succeeded.
  madvise11.c:198: TPASS: soft-offline / mmap race still clean     <--- end of 1st test
  madvise11.c:132: TFAIL: madvise failed: EBUSY (16)               <--- ERROR!
  ...

From kernel log:
  [ 431.590511] soft offline: 0xbfa8f: page migration failed 1, type
  0x800000008002e(referenced|uptodate|dirty|active|swapbacked|node=0|zone=1)
  ...
  [ 435.510819] soft offline: 0x98fb6: page migration failed 1, type
  0x800000008000e(referenced|uptodate|dirty|swapbacked|node=0|zone=1)
  ...

Kernel callpath:
  do_madvise()
  ---
  #ifdef CONFIG_MEMORY_FAILURE
      if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
          return madvise_inject_error(behavior, start, start + len_in);
  #endif
  ---
    madvise_inject_error()
      soft_offline_page()
        soft_offline_in_use_page()
 	  ...
           2727	pr_info("soft offline: %#lx: %s migration failed %ld, type %pGp\n",
           2728		pfn, msg_page[huge], ret, &page->flags);
           2729	if (ret > 0)
           2730		ret = -EBUSY;   <--- Here

Debugged-by: Luis Goncalves <lgoncalv@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 7a12abf20..fe27a18d8 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -128,6 +128,8 @@ static int allocate_offline(int tnum)
 				return -1;
 
 			if (madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE) == -1) {
+				if (errno == EBUSY)
+					continue;
 				if (errno != EINVAL)
 					tst_res(TFAIL | TERRNO, "madvise failed");
 				if (errno == EINVAL)
-- 
2.45.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
