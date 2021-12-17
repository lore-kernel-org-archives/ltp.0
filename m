Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D638C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 11:38:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C2DE3C900A
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 12:38:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CAD83C8FAC
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 12:38:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 719EA14060D8
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 12:38:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639741080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp890V1p0Nb5eIXZVDNlpSQJdf0DMAG7VEs7llaCFR8=;
 b=XfiiMAY3LGiDzLu4+5otRk01Bn0RDXbwaPMIGnh58SaX6kuVkT7WtMgr8VyKWXv7TSwAtA
 SyVgQt2WTHK8hQd07n2zMSWteoxY7fcQHf1OcXDsiMbPYPib9r51RrX+r/5M54NCFnF4g0
 0ZjAZtfUcXeKbAlJ5uG/qA4g+lzlQIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-QsZpnNnFN9yWf9hVZNS0Rg-1; Fri, 17 Dec 2021 06:37:57 -0500
X-MC-Unique: QsZpnNnFN9yWf9hVZNS0Rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD2B801B31;
 Fri, 17 Dec 2021 11:37:55 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8995B8D5BA;
 Fri, 17 Dec 2021 11:37:54 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 17 Dec 2021 19:37:49 +0800
Message-Id: <20211217113751.359613-2-liwang@redhat.com>
In-Reply-To: <20211217113751.359613-1-liwang@redhat.com>
References: <20211217113751.359613-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] lib: enable OOM protection for the main process
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

Here invoke OOM protection in fork_testrun, since it is the key point
to distiguish many process branches. We do protect main ($PID) process
from killing by OOM Killer, hope this can help to get the completed
correct report for all of LTP tests.

Fundamental principle:

                   ltp test harness --> library process
  (oom protection)   main --> tst_run_tcases --> ... --> fork_testrun
  (cancel protection)  testrun --> run_tests --> ... --> testname
                         child_test --> ... --> end

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

Notes:
    Changes v1->v2:
        * remove the protection for parent process as suggested by Martin

 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index ce2b8239d..0b370e691 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1441,11 +1441,14 @@ static int fork_testrun(void)
 
 	SAFE_SIGNAL(SIGINT, sigint_handler);
 
+	tst_enable_oom_protection(getpid());
+
 	test_pid = fork();
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
 
 	if (!test_pid) {
+		tst_cancel_oom_protection(getpid());
 		SAFE_SIGNAL(SIGALRM, SIG_DFL);
 		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
 		SAFE_SIGNAL(SIGINT, SIG_DFL);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
