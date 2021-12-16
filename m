Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D39BC433F5
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 03:41:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 431693C8F16
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 04:41:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78B363C8E63
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 04:41:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B62851A01735
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 04:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639626093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60OLBHxBIal0HKl3jiF/9bELIlWaXJARFEu6azlgE/U=;
 b=F8TAUksifKiee16I7a1PPsB5kAGrf/zgra5kVH4VxjYYAiajZ4dzS+U+9Gz6GliEmXXivE
 ysXog5htxe4oV3tMIgm6tbZ5xu9ODGRw6S1L/NG/pRbsMnqe8Pqfx+e8UJwzcMKMj3PPEM
 wGmMSibn8+d9Qx5AuabtUX0wypZZyA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-ukad5qV_PCi1caNTmbQEQw-1; Wed, 15 Dec 2021 22:41:31 -0500
X-MC-Unique: ukad5qV_PCi1caNTmbQEQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A887F760C1
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 03:41:30 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D916C2A199
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 03:41:29 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 16 Dec 2021 11:41:25 +0800
Message-Id: <20211216034125.255907-3-liwang@redhat.com>
In-Reply-To: <20211216034125.255907-1-liwang@redhat.com>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] oom: enable OOM protection for mem lib process
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

Just simply invoke oom protection on mem library to make
it can collect full state of hildren.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index ac890491c..566e29055 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -129,8 +129,11 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 	pid_t pid;
 	int status, threads;
 
+	tst_enable_oom_protection(getpid());
+
 	switch (pid = SAFE_FORK()) {
 	case 0:
+		tst_cancel_oom_protection(getpid());
 		threads = MAX(1, tst_ncpus() - 1);
 		child_alloc(testcase, lite, threads);
 	default:
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
