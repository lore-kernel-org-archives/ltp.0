Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22481F9D0C4
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776167310; h=date : to :
 message-id : mime-version : content-type : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : sender : from;
 bh=7U3r9/MSRVo9plnthIvhXZ6mDbg7LKPoEhVKRCajcX0=;
 b=fAy0SL4B4PcvNJ/6QFcujkWwJg1K6bjCcAtmNn/oXetpblw2JbkkyU4czKRb11t68Ud7r
 yuJlfnVqgfy8SQLIbuMupaupFWYOdaN1BlWOI3ulRyynh2G+HAjPe75JbnQDt1GKDybvTgT
 sxOAMrxNdU1ZH8821rSyQgJCilVkWqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0E803E4B23
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 13:48:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49A153E2673
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 13:48:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A7EFB600BD4
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 13:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776167285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=DX1vnS7XJ7lBKgJp3P4LCQAXRk7ddRX2aZ2kdDRKXfg=;
 b=a2fpi+Me9wqJmUDkovKR/L4rOVw4qzQ+lS11C26D2e/efYkfKNEO2+8Ko/Dmppx6Ko89kz
 vWA4tUGm7L5STiheuqoD9xD3fLvlq5sBZX/NSF7JDP+NMr0JKyvkAk+4Z7DFwVs7pC/g+3
 eGhYRXO+eBnAYOrlI23bhcu/BCn0uMY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-_gbhWZi6O32HbSfZthU_cg-1; Tue, 14 Apr 2026 07:48:03 -0400
X-MC-Unique: _gbhWZi6O32HbSfZthU_cg-1
X-Mimecast-MFC-AGG-ID: _gbhWZi6O32HbSfZthU_cg_1776167282
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fa07f2bbso27690805e9.2
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 04:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776167282; x=1776772082;
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1F6cDMPrYo4iTXNXrZN1sNGTl8/L6AD6c0CMVWQZUSo=;
 b=Fzl6Rv8+a8II47WmgT2kVnNK7tT53nynMtHzQ6Yn2ZqPYTMpN30i2zLqRd659MkDF1
 BXB1LATU8Pnm9aVi4aLyq8BbakO9Td7bSCgifgvzwhO17tedWd6rDcMwTUMFTbilLxBf
 JUg4a7/KpuV19gUNQdVfcPt16+GM8oHo45vNb5EJFDCGtrcSTTCdm77+LE+bq5gYxRSD
 Pp3sIHH+6VuuwIBmC7e6b4R64TU7VK2JraxV250DTwERRwZ96pePFjHmyALpkoy4NT0w
 Gy7rqkYAGLOcyv1+dczh4CFRpi+XGluPbbsZ2y8G21x5JKB/nFyy0yipJONE/bnHxRdD
 KQxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dGmW+LXnT7nsT1wgmtS4ExwlN7XTDAiT7h3IrBHUqzO2aIdEPFAAT9GVpmMTOMCdNRgg=@lists.linux.it
X-Gm-Message-State: AOJu0YwRRtquCP7gGt9USZhJzwni34nJwSgz4CSYqJegVA+pwn0staEc
 42GtbKOtA5RMGZ/+7Ke1mCvAk4rHihX0Qw6XVrDSls2qL/PpumJg83ol6noN+sCgE2YQVoZ8n4+
 GQsPKVe5zPCYVzRU4I9my4FUA6KCyN6IWOG8xI27Ewwck7PUaAjF3Fjvgn7+a
X-Gm-Gg: AeBDietk2bwFEBos70B7eiqNNfucl9wu4w78eMtdo7uTR+PZM3s5ZND/bteIJm+Epgs
 mPPitvaZKSaDZ3uC0suXrFRtqJFffKR5QJNoDNSCWkMPIFZGwMJ0ptF2faIJY6RE+lqcEKnRED2
 TYbUy0npPQdtlk/0UH8eQHvEGUzs1RuTek6xm9vmEKeztfL2Rg7umOx+DGxjXrLIPJKs7Zbwms5
 Cdzg0+cNcG1ImHV5uO4INNeBZVyDChWZDE1OyXfPOhoAy4+IW2eDsyGt9ubPPOjryc2uqM1Fr8g
 xvgcDx4u+oak6nazDQn8Vj9XdRAGh7PPaH615IItMR2AXDzDryFmn1XuO105+12QEH6POfAlVGK
 dzObpDUBLzurT30YrKNAZAr/biuqBiRCPPg==
X-Received: by 2002:a05:600c:c108:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-488d68539e3mr158228055e9.11.1776167281741; 
 Tue, 14 Apr 2026 04:48:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c108:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-488d68539e3mr158227735e9.11.1776167281227; 
 Tue, 14 Apr 2026 04:48:01 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e217sm78435785e9.5.2026.04.14.04.48.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 04:48:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:47:58 +0200
To: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Message-ID: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MemhpJZsFFrytHfAT97DhF6L4cN06haE4dezIINZKzk_1776167282
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="wqu2qa3o3lnlgqdn"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Avoid syscall param ioctl(generic) points to uninitialised
 byte(s)
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--wqu2qa3o3lnlgqdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

one more nit re uninitialised bytes attached.

Thanks,
Martin


--wqu2qa3o3lnlgqdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Avoid-syscall-param-ioctl-generic-points-to-uninitia.patch"

From b81924101f441d7f2103197c8b81a38e8920fda4 Mon Sep 17 00:00:00 2001
From: Super User <root@vm-10-0-185-15.hosted.upshift.rdu2.redhat.com>
Date: Wed, 20 Jan 2038 01:08:34 -0500
Subject: [PATCH] Avoid syscall param ioctl(generic) points to uninitialised
 byte(s)

lib/tst_clocks.c: fix uninitialized memory in run()  Reproducible
                  using userfaultfd01.

Signed-off-by: Martin Cermak <mcermak@redhat.com>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 7368d3863..d24766e7c 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -92,8 +92,8 @@ static void *handle_thread(void)
 static void run(unsigned int i)
 {
 	pthread_t thr;
-	struct uffdio_api uffdio_api = {};
-	struct uffdio_register uffdio_register;
+	struct uffdio_api uffdio_api = {0, };
+	struct uffdio_register uffdio_register = {0, };
 	struct tcase *tc = &tcases[i];
 
 	if (tc->kver == AFTER_5_11 && kver == BEFORE_5_11)
-- 
2.52.0


--wqu2qa3o3lnlgqdn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--wqu2qa3o3lnlgqdn--

