Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBD2C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 09:54:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 722F43C9101
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 10:54:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 756213C6AD0
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:54:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73D021401162
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639994063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yEqxY4pmQHSz9w9FyVZPMxmCQh31BRyAFZgZyXnwrk=;
 b=FwY2LojGm0cr+sKiFWSH5R26Zn/9MmW6gDFEn4N0A3wBzqg91Od9AI6WAF2T5mHY+dOkkB
 /6hbKhNkgGAfCmVuf92kxyq5ICZHhX9qm88IqT2ccSCsYBY+9CXPqt6gwZqlYDWCE4Z96S
 +g6B18vityGNrkw3DUozBRXwts/Ggdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-FRpPCVv6O0C3rcgZ9UukVA-1; Mon, 20 Dec 2021 04:54:22 -0500
X-MC-Unique: FRpPCVv6O0C3rcgZ9UukVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79916409A;
 Mon, 20 Dec 2021 09:54:21 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B60764E2A5;
 Mon, 20 Dec 2021 09:54:20 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 20 Dec 2021 17:54:15 +0800
Message-Id: <20211220095416.583323-2-liwang@redhat.com>
In-Reply-To: <20211220095416.583323-1-liwang@redhat.com>
References: <20211220095416.583323-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] lib: enable OOM protection for ltp lib process
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

We do protect ltp-lib ($PID) process from killing by OOM Killer,
hope this can help to get the completed correct report for all of
LTP tests.

This achieve by invoking tst_enable_oom_protection in tst_run_tcases,
at the same time, we purposely disabling the protection for children
in fork_testrun, to avoid the oom score inherit by testcase.

Fundamental principle:

                   ltp test harness --> library process
  (enable protection)   main --> tst_run_tcases --> ... --> fork_testrun
  (disable protection)    testrun --> run_tests --> ... --> testname
                            child_test --> ... --> end

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index ce2b8239d..51f438d06 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1446,6 +1446,7 @@ static int fork_testrun(void)
 		tst_brk(TBROK | TERRNO, "fork()");
 
 	if (!test_pid) {
+		tst_disable_oom_protection(0);
 		SAFE_SIGNAL(SIGALRM, SIG_DFL);
 		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
 		SAFE_SIGNAL(SIGINT, SIG_DFL);
@@ -1523,6 +1524,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	tst_test = self;
 
 	do_setup(argc, argv);
+	tst_enable_oom_protection(lib_pid);
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
