Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F3C3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 05:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747112766; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=oNcZwNsGugy/ijsHdlza3FNjQKM876RQklD1qLaNFMM=;
 b=hqRL5eA8Ozy21q7FuaZbl5ijAM7y/IUTwdHWVIDDtsXmkAoDKYN9btB3/+v10joDplCVW
 fT9w8G6KUL3ZvbplZW9FcQBcw2grNHh3ZPgZPL2yG7ALefV3cJy2jgKLbJyBOnIOAsTQtGO
 UpSKsURxLmPK0/V5SGbuyDzhpuXeZlw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9F893CC30E
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 07:06:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 129193CB3B6
 for <ltp@lists.linux.it>; Tue, 13 May 2025 07:05:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B03E5600A91
 for <ltp@lists.linux.it>; Tue, 13 May 2025 07:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747112741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9hixQ7a4dy6cDCCqDtyuGAMJ9F43xjzp8pzpay0OLGM=;
 b=eIjvSBxu9M8u7LZtKs52c9cMYEtHNTpnIj6qYzGrzpkx+ws4cmx9CT6GXOHgcvQGB8N4n9
 B9FkO3uRqRUX1k23B3MsKGxGLy2RMQFYthXI0ZuudnGEq0Ao6KimSpVLIU3e4Q8ogO+Phv
 pTgGY5NPRvM4KFt8R9ifWtwU5oWY0qs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-g8GcsSHYOzKET-nm2t4o2g-1; Tue,
 13 May 2025 01:05:39 -0400
X-MC-Unique: g8GcsSHYOzKET-nm2t4o2g-1
X-Mimecast-MFC-AGG-ID: g8GcsSHYOzKET-nm2t4o2g_1747112738
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52DEF19560A1; Tue, 13 May 2025 05:05:38 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F41271956095; Tue, 13 May 2025 05:05:35 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 13 May 2025 13:05:29 +0800
Message-ID: <20250513050530.47541-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k6qVHPieT2wKr_RonJdM94PVBiVExx6dB5HhWWMUeyk_1747112738
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
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

To get rid of failure from github CI.

CI Test Job: https://github.com/wangli5665/ltp/actions/runs/14988530205

Follow-up-fix: commit b987b8ac5 ("lib: child process exit with error due to uninitialized lib_pid")
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b666715b9..9f11c1c47 100644
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
@@ -143,7 +142,9 @@ static void setup_ipc(void)
 		tst_futexes = (char *)results + sizeof(struct results);
 		tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
 	}
-	results->lib_pid = lib_pid;
+
+	results->lib_pid = 0;
+	results->main_pid = 0;
 }
 
 static void cleanup_ipc(void)
@@ -394,7 +395,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	 * If tst_brk() is called from some of the C helpers even before the
 	 * library was initialized, just exit.
 	 */
-	if (!results->lib_pid)
+	if (!results || !results->lib_pid)
 		exit(TTYPE_RESULT(ttype));
 
 	update_results(TTYPE_RESULT(ttype));
@@ -1334,6 +1335,8 @@ static void do_setup(int argc, char *argv[])
 		tst_test->forks_child = 1;
 	}
 
+	setup_ipc();
+
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
@@ -1393,8 +1396,6 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->hugepages.number)
 		tst_reserve_hugepages(&tst_test->hugepages);
 
-	setup_ipc();
-
 	if (tst_test->bufs)
 		tst_buffers_alloc(tst_test->bufs);
 
@@ -1929,10 +1930,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	unsigned int test_variants = 1;
 	struct utsname uval;
 
-	lib_pid = getpid();
 	tst_test = self;
 
 	do_setup(argc, argv);
+
+	results->lib_pid = getpid();
 	tst_enable_oom_protection(results->lib_pid);
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
@@ -1940,7 +1942,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	tst_res(TINFO, "LTP version: "LTP_VERSION);
 
-
 	uname(&uval);
 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
