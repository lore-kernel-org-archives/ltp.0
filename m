Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA1C6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 07:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B01E53CDCEE
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 08:41:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63A913CB9DC
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 08:41:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77196600C7A
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 08:41:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677742889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRzD/xITiLolO1dyj9bm4hgJhdh6QEfAK0AH06i3utg=;
 b=Nmlz4LIlPnsY9x28oRAiz39SF6f/7RiKjnTmg/Z1joIPTagjPHqxnDdDHig+W3NV3XIotn
 3hvFfVetL6rlGX9G9aXaza8IIFsFiWgKksdUzdTI9nUNks/8QvVQKImMbwRrBTtjyxO4Pc
 PHUDj4J9L8M1tPiXFFS0yDzF3lm4OqY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-4wBSraMwNMmSxAOPO0VgNg-1; Thu, 02 Mar 2023 02:41:28 -0500
X-MC-Unique: 4wBSraMwNMmSxAOPO0VgNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C603804061;
 Thu,  2 Mar 2023 07:41:28 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B75FDC16027;
 Thu,  2 Mar 2023 07:41:25 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de
Date: Thu,  2 Mar 2023 15:41:23 +0800
Message-Id: <20230302074123.567654-1-liwang@redhat.com>
In-Reply-To: <CAEemH2esqAP+kfEgwXkSkw6V7ubFn+uq2_QdF_Nx1gF2t-WXzA@mail.gmail.com>
References: <CAEemH2esqAP+kfEgwXkSkw6V7ubFn+uq2_QdF_Nx1gF2t-WXzA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCh v2] madvise06: stop throwing failure when
 MADV_WILLNEED is ignored
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
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is an intermittent failure which we have observed many times whether
on rhel or mainline kernel. But we're unable to stable reproduce it:

    43	madvise06.c:201: TFAIL: less than 102400 Kb were moved to the swap cache
    ...

However it does not look like a kernel issue, because SwapCached change is
not strictly abiding by the principle of MADV_WILLNEED advice. That means it
all depends on the kernel's specific circumstances. The value of the threshold
is debatable at least from my point of view, its use 1/4 is not guaranteed
100% safe.

As MADV_WILLNEED is just advice to the kernel, not a guarantee. The kernel may
choose to ignore the advice, or may prioritize other memory management tasks
over pre-loading the advised pages.

This change to report a test result of "TINFO" instead of "TFAIL" when the swap
cache size is less than expected would be intended to indicate that this is an
acceptable outcome. Same changes apply to the page_fault counting as well.

Reported-by: Paul Bunyan <pbunyan@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.de>
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: Eirik Fuller <efuller@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index c7967ae6f..0e5ce3276 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -198,7 +198,7 @@ static void test_advice_willneed(void)
 
 	meminfo_diag("After madvise");
 	res = swapcached > swapcached_start + PASS_THRESHOLD_KB;
-	tst_res(res ? TPASS : TFAIL,
+	tst_res(res ? TPASS : TINFO,
 		"%s than %ld Kb were moved to the swap cache",
 		res ? "more" : "less", PASS_THRESHOLD_KB);
 
@@ -226,7 +226,7 @@ static void test_advice_willneed(void)
 	meminfo_diag("After page access");
 
 	res = page_fault_num_2 - page_fault_num_1;
-	tst_res(res == 0 ? TPASS : TFAIL,
+	tst_res(res == 0 ? TPASS : TINFO,
 		"%d pages were faulted out of 3 max", res);
 
 	SAFE_MUNMAP(target, CHUNK_SZ);
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
