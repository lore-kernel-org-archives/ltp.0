Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA4C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 02:49:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99C283C928D
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 03:49:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7FE3C2FE8
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 03:48:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F02C21400DD6
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 03:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640227728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIPsCK2gKtYEg4LxVVM61uEDX5+MSwXE7U0uk/PZz4g=;
 b=b9d2kJ78m5NGyufpa2MVqHtqp3qPWWY/JDjDYlr38E1LmRMD5/H1MUfCFGf2K5HOevuePT
 JP1E9uVJnvIrZO3A5LEBz/CTS10Ab/3TlhlRxbjsnz0LY3TvlDD02sw2WKg6g3kzQKt2+R
 a9Ujae/PMf0Zxo8AVJrToaFGjniF84M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230--h5l1vOCOkiZviXjaVrI_Q-1; Wed, 22 Dec 2021 21:48:45 -0500
X-MC-Unique: -h5l1vOCOkiZviXjaVrI_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6F82F25;
 Thu, 23 Dec 2021 02:48:44 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F47260C4A;
 Thu, 23 Dec 2021 02:48:42 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 23 Dec 2021 10:48:41 +0800
Message-Id: <20211223024841.801160-1-liwang@redhat.com>
In-Reply-To: <CAEemH2di0818vNoByrpUeEfZi-T58fNMg131=HZFeF2W6Be0Ng@mail.gmail.com>
References: <CAEemH2di0818vNoByrpUeEfZi-T58fNMg131=HZFeF2W6Be0Ng@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] lib: Do not fail a test if oom score cannot be
 adjusted.
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

From: Petr Vorel <pvorel@suse.cz>

Setting value < 0 in /proc/<pid>/oom_score_adj requires CAP_SYS_RESOURCE.
However setting the library process score is a best effort operation,
so let's skip it silently when the user is not privileged to do so.

Fixes: 8a0827766d ("lib: add functions to adjust oom score")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v2 --> v3
    	* drop the useless CAP_SYS_ADMIN
    	* add some new commments
    CI job: https://github.com/wangli5665/ltp/actions/runs/1613852940

 include/tst_memutils.h | 10 +++++++-
 lib/tst_memutils.c     | 54 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 68a6e3771..45dec55bc 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -28,13 +28,21 @@ long long tst_available_mem(void);
 /*
  * Enable OOM protection to prevent process($PID) being killed by OOM Killer.
  *   echo -1000 >/proc/$PID/oom_score_adj
+ *
  * If the pid is 0 which means it will set on current(self) process.
  *
+ * Unless the process has CAP_SYS_RESOURCE this call will be no-op because
+ * setting adj value < 0 requires it.
+ *
+ * CAP_SYS_RESOURCE:
+ *   set /proc/[pid]/oom_score_adj to a value lower than the value last set
+ *   by a process with CAP_SYS_RESOURCE.
+ *
  * Note:
  *  This exported tst_enable_oom_protection function can be used at anywhere
  *  you want to protect, but please remember that if you do enable protection
  *  on a process($PID) that all the children will inherit its score and be
- *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection
+ *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection()
  *  to be used in combination.
  */
 void tst_enable_oom_protection(pid_t pid);
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 4dea30330..4a4974761 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -11,6 +11,8 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_capability.h"
+#include "lapi/syscalls.h"
 
 #define BLOCKSIZE (16 * 1024 * 1024)
 
@@ -93,6 +95,41 @@ long long tst_available_mem(void)
 	return mem_available;
 }
 
+static int has_caps(void)
+{
+	struct tst_cap_user_header hdr = {
+		.version = 0x20080522,
+		.pid = tst_syscall(__NR_gettid),
+	};
+
+	struct tst_cap_user_data caps[2];
+
+	if (tst_capget(&hdr, caps))
+		tst_brk(TBROK | TERRNO, "tst_capget()");
+
+	if (caps[0].effective & (1U << CAP_SYS_RESOURCE))
+		return 1;
+
+	return 0;
+}
+
+static int write_score(const char *path, int score)
+{
+	FILE *f;
+
+	f = fopen(path, "w");
+	if (!f)
+		return 1;
+
+	if (fprintf(f, "%d", score) <= 0)
+		return 1;
+
+	if (fclose(f))
+		return 1;
+
+	return 0;
+}
+
 static void set_oom_score_adj(pid_t pid, int value)
 {
 	int val;
@@ -111,17 +148,18 @@ static void set_oom_score_adj(pid_t pid, int value)
 			tst_brk(TBROK, "%s does not exist, please check if PID is valid", score_path);
 	}
 
-	FILE_PRINTF(score_path, "%d", value);
+	if (write_score(score_path, value)) {
+		if (!has_caps())
+			return;
+
+		tst_res(TWARN, "Can't adjust score, even with capabilities!?");
+		return;
+	}
+
 	FILE_SCANF(score_path, "%d", &val);
 
-	if (val != value) {
-		if (value < 0) {
-			tst_res(TWARN, "'%s' cannot be set to %i, are you root?",
-				score_path, value);
-			return;
-		}
+	if (val != value)
 		tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val, value);
-	}
 }
 
 void tst_enable_oom_protection(pid_t pid)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
