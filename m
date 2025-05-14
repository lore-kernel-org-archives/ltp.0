Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6C1C3ABC5
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 04:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747196965; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=myROsB9RVlMCjiEjl0Qfi1jC+/mU60D/Slvo8wK2B1I=;
 b=XiE9rddlJMp/0o0hnexYXF5fWmzOvCyn7ZXXWT6urej4JXjjmt7trbj1y0as/Ax+KLDEk
 UCrQ677URPkWz/sHtBoHzKDRXamSVshU1cXzjW5wr0WRX3TvKGiZtJAjzybE1Eo8bgU/LzP
 R5mGfXeCvgtPcbJ7gCh3htQNgcfdQJE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EF783CC2F1
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 06:29:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9388D3CAB2B
 for <ltp@lists.linux.it>; Wed, 14 May 2025 06:28:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54CCE200AE8
 for <ltp@lists.linux.it>; Wed, 14 May 2025 06:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747196908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOgnvDMiz9B9L4nkYuK4DL+AvzQnJ8XN5m8HC4tcrXo=;
 b=KrVSExN6mDOD+BqRoshCtVBLcVoXSHdMZMeeRHLLJgjHCNO57+6tXNkJVBcx9O/f9fKys6
 pQtMRLXPfRDN/q1yW5Z1R+RJY+rDA3NA4Yr6Ke2e2qvGkQlcLxp5Vk8oxJsdVRDjtRe0aP
 8JPVbDAiKiKjkr4HBFwCLHun3p6rTh4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-vxI0w4DWPfCTTooY3B8yyw-1; Wed,
 14 May 2025 00:28:24 -0400
X-MC-Unique: vxI0w4DWPfCTTooY3B8yyw-1
X-Mimecast-MFC-AGG-ID: vxI0w4DWPfCTTooY3B8yyw_1747196903
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13BB21800446; Wed, 14 May 2025 04:28:23 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5956919560A7; Wed, 14 May 2025 04:28:19 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 14 May 2025 12:28:11 +0800
Message-ID: <20250514042811.58339-2-liwang@redhat.com>
In-Reply-To: <20250514042811.58339-1-liwang@redhat.com>
References: <20250514042811.58339-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NQDnkT7t-s5L2texj71okMvZuorGowzHP8MQFDo9L68_1747196903
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v2 2/2] lib: initialize results area to zero in the
 setup_ipc
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To resolve several problems:

  1. failure from tst_needs_cmd02 in github CI.

  2. tst_run_shell.c segement fault

  3. commit b987b8ac5 introduced an issue that incorrectly identified
     TCONF as TFAIL. This caused quite a few test cases (TCONF from old API)
     to be reported as failures.

  4. https://github.com/linux-test-project/ltp/issues/1240

CI-Job: https://github.com/wangli5665/ltp/actions/runs/15012129791
Follow-up-fix: commit b987b8ac5 ("lib: child process exit with error due to uninitialized lib_pid")
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b666715b9..03ebdc157 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -59,7 +59,6 @@ static const char *tid;
 static int iterations = 1;
 static float duration = -1;
 static float timeout_mul = -1;
-static pid_t lib_pid;
 static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
@@ -143,7 +142,8 @@ static void setup_ipc(void)
 		tst_futexes = (char *)results + sizeof(struct results);
 		tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
 	}
-	results->lib_pid = lib_pid;
+
+	memset(results, 0 , size);
 }
 
 static void cleanup_ipc(void)
@@ -394,7 +394,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	 * If tst_brk() is called from some of the C helpers even before the
 	 * library was initialized, just exit.
 	 */
-	if (!results->lib_pid)
+	if (!results || !results->lib_pid)
 		exit(TTYPE_RESULT(ttype));
 
 	update_results(TTYPE_RESULT(ttype));
@@ -1334,6 +1334,8 @@ static void do_setup(int argc, char *argv[])
 		tst_test->forks_child = 1;
 	}
 
+	setup_ipc();
+
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
@@ -1393,8 +1395,6 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->hugepages.number)
 		tst_reserve_hugepages(&tst_test->hugepages);
 
-	setup_ipc();
-
 	if (tst_test->bufs)
 		tst_buffers_alloc(tst_test->bufs);
 
@@ -1929,10 +1929,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	unsigned int test_variants = 1;
 	struct utsname uval;
 
-	lib_pid = getpid();
 	tst_test = self;
 
 	do_setup(argc, argv);
+
+	results->lib_pid = getpid();
 	tst_enable_oom_protection(results->lib_pid);
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
@@ -1940,7 +1941,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	tst_res(TINFO, "LTP version: "LTP_VERSION);
 
-
 	uname(&uval);
 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
