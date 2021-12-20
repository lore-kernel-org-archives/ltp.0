Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9AFC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 09:54:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E1F13C917B
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 10:54:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8565D3C90FC
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:54:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5BA8600431
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639994064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8eIyEeOoIE5hH7X2i/cRBxP1HzVibQCUPWMi3aLN/Xk=;
 b=WPXcNKYoav1b1//YKmsMrWhnedYAffChs94GwnCsgvgtvtPqCF9cUaw2a1vhLh+9ygYbSm
 MSK0P57Jgi4XWMasMrU/jX7uGTY8CnX2XuxKlX4A1t7UjfkuS/tVu8StbN+1Xtnjv1Zvp3
 I1qJpAX2yXWdtL61ISOaqeuKS15Kvuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-VIc9U9lfP4-IgWIhG4Sr7g-1; Mon, 20 Dec 2021 04:54:21 -0500
X-MC-Unique: VIc9U9lfP4-IgWIhG4Sr7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 390AE81CCB5;
 Mon, 20 Dec 2021 09:54:20 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 288CF4E2A1;
 Mon, 20 Dec 2021 09:54:18 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 20 Dec 2021 17:54:14 +0800
Message-Id: <20211220095416.583323-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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

This introduces function to LTP for adjusting the oom_score_adj of
target process, which may be helpful in OOM tests to prevent kernel
killing the main or lib process during test running.

The exported global tst_enable_oom_protection function can be used
at anywhere you want to protect, but please remember that if you
do enable protection on a process($PID) that all the children will
inherit its score and be ignored by OOM Killer as well. So that's
why tst_disable_oom_protection is recommended to combination in use.

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

Notes:
    v2 --> v3
    	* rename to tst_disable_oom_protection
    	* support set PID as 0 to protect current process

 include/tst_memutils.h | 20 ++++++++++++++++++++
 lib/tst_memutils.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index f605f544e..a5265423d 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -25,4 +25,24 @@ void tst_pollute_memory(size_t maxsize, int fillchar);
  */
 long long tst_available_mem(void);
 
+/*
+ * Enable OOM protection to prevent process($PID) being killed by OOM Killer.
+ *   echo -1000 >/proc/$PID/oom_score_adj
+ * If the pid is 0 which means it will set on current(self) process.
+ *
+ * Note:
+ *  This exported tst_enable_oom_protection function can be used at anywhere
+ *  you want to protect, but please remember that if you do enable protection
+ *  on a process($PID) that all the children will inherit its score and be
+ *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection
+ *  is recommended to combination in use.
+ */
+void tst_enable_oom_protection(pid_t pid);
+
+/*
+ * Disable the OOM protection for the process($PID).
+ *   echo 0 >/proc/$PID/oom_score_adj
+ */
+void tst_disable_oom_protection(pid_t pid);
+
 #endif /* TST_MEMUTILS_H__ */
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index bd09cf6fa..0757fe654 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
  */
 
+#include <stdio.h>
 #include <unistd.h>
 #include <limits.h>
 #include <sys/sysinfo.h>
@@ -91,3 +92,34 @@ long long tst_available_mem(void)
 
 	return mem_available;
 }
+
+static void set_oom_score_adj(pid_t pid, int value)
+{
+	int val;
+	char score_path[64];
+
+	if (access("/proc/self/oom_score_adj", F_OK) == -1) {
+		tst_res(TINFO, "Warning: oom_score_adj does not exist");
+		return;
+	}
+
+	if (pid == 0)
+		sprintf(score_path, "/proc/self/oom_score_adj");
+	else
+		sprintf(score_path, "/proc/%d/oom_score_adj", pid);
+
+	SAFE_FILE_PRINTF(score_path, "%d", value);
+	SAFE_FILE_SCANF(score_path, "%d", &val);
+	if (val != value)
+		tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val, value);
+}
+
+void tst_enable_oom_protection(pid_t pid)
+{
+	set_oom_score_adj(pid, -1000);
+}
+
+void tst_disable_oom_protection(pid_t pid)
+{
+	set_oom_score_adj(pid, 0);
+}
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
