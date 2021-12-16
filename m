Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB1CC433F5
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 03:41:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4333C8F30
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 04:41:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30CF83C556F
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 04:41:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 415CB601D54
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 04:41:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639626091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQlB9SBdwwGGQPVWawK9r/1wk6Qs49TDI/L+WVVb2Sc=;
 b=ALTbUMtug1taBNtsZqb7IItLbuCqaR7C2Yj05OIKjWuFVCPHLzLv2MmsiL/Y2Jr7VIpvbO
 F4oe4gBzejM5+xhXwlOkR2jsYidhR+1NzWMWh5bsjQUaQ+3PresTbOKF3Vov5/0CeVSEsy
 KjjzFaiC1hq6Wm0+K7ujMbGO41dJ4Ok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-f6RfxewgNO2Evm8ELWk4Wg-1; Wed, 15 Dec 2021 22:41:30 -0500
X-MC-Unique: f6RfxewgNO2Evm8ELWk4Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A49102CB79
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 03:41:29 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CEA42A19A
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 03:41:28 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 16 Dec 2021 11:41:24 +0800
Message-Id: <20211216034125.255907-2-liwang@redhat.com>
In-Reply-To: <20211216034125.255907-1-liwang@redhat.com>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ltp: enable OOM protection for main and test
 harness process
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
to distiguish many process branches. We do protect ltp test harness($PPID)
and main ($PID) process from killing by OOM Killer, hope this can help
to get the completed correct report for all of LTP tests.

Fundamental principle:

  (oom protection) ltp test harness --> library process
  (oom protection)   main --> tst_run_tcases --> ... --> fork_testrun
  (cancel protection)  testrun --> run_tests --> ... --> testname()
                         child_test --> ... --> end

Note: there might be still argument on doing this protection for test harness,
      because it will affect all common testcases (I mean none oom tests), but
      I slightly think it is safe as there seems no much system load during
      perform them.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index ce2b8239d..f3ae48240 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1441,11 +1441,15 @@ static int fork_testrun(void)
 
 	SAFE_SIGNAL(SIGINT, sigint_handler);
 
+	tst_enable_oom_protection(getppid());
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
