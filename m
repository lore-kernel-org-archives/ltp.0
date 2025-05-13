Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15FC3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 06:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747119374; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RabVwc4bEX0MCLxrkjDQNvSGh6NpUCjIxFnTPvhqLA8=;
 b=OFNkJ1lqXrFm5xj9EUnX9i65AB7VT6xmD8TINHwYOINVTjN7YUk4Zr+4+ur40liKhmtJv
 9SmcbUw9yjqwNr17anR2PK9kNIV2hL9kekHUszsM0CW19By+twGdPkrNrboi4xurDnu8lBw
 1NzVVQZ1aG3Kpc0RDsHXeBnxrh8oyrI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A8193CC302
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 08:56:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3EB03CC11D
 for <ltp@lists.linux.it>; Tue, 13 May 2025 08:55:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2AC0600858
 for <ltp@lists.linux.it>; Tue, 13 May 2025 08:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747119327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDvotNCxlGXPfJpn/3SN3b9VStDq3XIao3lIefcd8Yw=;
 b=f99KdYXLvEfLW0YhzPWLJsuQced8A3+Z5BHv+MJU0eWHlq7LW8r4QJo1qjbveUcqmg4vQS
 HU7NGiRsqT8eDsZBiVT8FcfgQWiPG8apjU3dO6qJyAkj4ivfPO7V19A8nsVcl9Yyz/5OXX
 U5syDu0dPP3H4+sG+sZIBuiGCQa+TFE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-CukDjMQbNUK2WvHveyp_HQ-1; Tue,
 13 May 2025 02:55:25 -0400
X-MC-Unique: CukDjMQbNUK2WvHveyp_HQ-1
X-Mimecast-MFC-AGG-ID: CukDjMQbNUK2WvHveyp_HQ_1747119324
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C981800876
 for <ltp@lists.linux.it>; Tue, 13 May 2025 06:55:24 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 007A31800359
 for <ltp@lists.linux.it>; Tue, 13 May 2025 06:55:22 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 13 May 2025 14:55:14 +0800
Message-ID: <20250513065515.49865-2-liwang@redhat.com>
In-Reply-To: <20250513065515.49865-1-liwang@redhat.com>
References: <20250513065515.49865-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dOa06dVXmX26Svz8afOEoPL0ZTKVGMI38aZHlRTo_40_1747119324
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH RFC 1/2] lib: rename tid to tcid
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

tcid is better to reflect testcase id, but not mislead developer
to think of thread id (tid).

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9f11c1c47..fbbfda426 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -55,7 +55,7 @@ const char *TCID __attribute__((weak));
 
 struct tst_test *tst_test;
 
-static const char *tid;
+static const char *tcid;
 static int iterations = 1;
 static float duration = -1;
 static float timeout_mul = -1;
@@ -106,7 +106,7 @@ static void setup_ipc(void)
 
 	if (access("/dev/shm", F_OK) == 0) {
 		snprintf(shm_path, sizeof(shm_path), "/dev/shm/ltp_%s_%d",
-			 tid, getpid());
+			 tcid, getpid());
 	} else {
 		char *tmpdir;
 
@@ -115,7 +115,7 @@ static void setup_ipc(void)
 
 		tmpdir = tst_get_tmpdir();
 		snprintf(shm_path, sizeof(shm_path), "%s/ltp_%s_%d",
-			 tmpdir, tid, getpid());
+			 tmpdir, tcid, getpid());
 		free(tmpdir);
 	}
 
@@ -1048,7 +1048,7 @@ static void copy_resources(void)
 		TST_RESOURCE_COPY(NULL, tst_test->resource_files[i], NULL);
 }
 
-static const char *get_tid(char *argv[])
+static const char *get_tcid(char *argv[])
 {
 	char *p;
 
@@ -1146,7 +1146,7 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode)
 	int start[3] = {'0', 'a', 'A'};
 
 	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
-			path, tid);
+			path, tcid);
 
 	len = strlen(template) - 1;
 	while (template[len] == 'X') {
@@ -1318,7 +1318,7 @@ static void do_setup(int argc, char *argv[])
 
 	assert_test_fn();
 
-	TCID = tid = get_tid(argv);
+	TCID = tcid = get_tcid(argv);
 
 	if (tst_test->sample)
 		tst_test = tst_timer_test_setup(tst_test);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
