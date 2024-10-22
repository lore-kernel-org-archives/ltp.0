Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE3D1CDCB
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 09:45:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7FB3C6FA5
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 11:45:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50563C20C3
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 11:45:10 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADCE5141B2CD
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 11:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729590308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nNL+4XzEYb364wfZ29ypZ/mfKwKxypkxC2RzGHHguUA=;
 b=YoaBP7Y4g9qVG1KauMIKXpLEtVptJ4J7eiNENrA69TDsz09Pk4ySgbbATL315Jwr+VV4yK
 24bfAyhAjmKKL2QiPJnxWro8c9DCtkd20QoTWsB/PAvlnKR3YKxPa7cqd2J739mgQKeQDM
 pJunPJ+fiRqWbQkz4EwlJBaYJmD/yAg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-4bd5adAeO_a63fTNkwJfSA-1; Tue,
 22 Oct 2024 05:45:04 -0400
X-MC-Unique: 4bd5adAeO_a63fTNkwJfSA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B5BE19560AD
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 09:45:03 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.11])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4240B19560AE; Tue, 22 Oct 2024 09:45:01 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 22 Oct 2024 11:44:56 +0200
Message-ID: <36c63ee52ce1e7ab1f6ce90bc6a4c58272130bee.1729590080.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] read_all: limit sysfs tpm entries to single worker
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Repeated reads from TPM entries (tcg_operations, vs_operations,
caps,..) are causing big delays with 3 or more repetitions,
which has signs of some kind of rate-limitting on firmware side.

This patch introduces a new kind of blacklist, which doesn't
completely skips the entry, but assigns it to only single
worker.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 49 +++++++++++++++++++++----
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 266678ea7794..9c58b5e85bbf 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -94,11 +94,17 @@ static int worker_timeout;
 static int timeout_warnings_left = 15;
 
 static char *blacklist[] = {
-	NULL, /* reserved for -e parameter */
+	"/reserved/", /* reserved for -e parameter */
 	"/sys/kernel/debug/*",
 	"/sys/devices/platform/*/eeprom",
 	"/sys/devices/platform/*/nvmem",
 	"/sys/*/cpu??*(?)/*",	/* cpu* entries with 2 or more digits */
+	NULL
+};
+
+static char *ratelimit_list[] = {
+	"/sys/devices/*/tpm*",
+	NULL,
 };
 
 static long long epoch;
@@ -193,19 +199,43 @@ static void sanitize_str(char *buf, ssize_t count)
 		strcpy(buf + MAX_DISPLAY, "...");
 }
 
-static int is_blacklisted(const char *path)
+static int is_onlist(const char *path, char *list[])
 {
-	unsigned int i;
+	unsigned int i = 0;
+
+	while (1) {
+		const char *pattern = list[i++];
 
-	for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
-		if (blacklist[i] && !fnmatch(blacklist[i], path, FNM_EXTMATCH)) {
-			if (verbose)
-				tst_res(TINFO, "Ignoring %s", path);
+		if (!pattern)
+			break;
+		if (!fnmatch(pattern, path, FNM_EXTMATCH))
 			return 1;
-		}
 	}
 
 	return 0;
+
+}
+
+static int is_blacklisted(const char *path)
+{
+	int ret;
+
+	ret = is_onlist(path, blacklist);
+	if (ret && verbose)
+		tst_res(TINFO, "Ignoring %s", path);
+
+	return ret;
+}
+
+static int is_ratelimitted(const char *path)
+{
+	int ret;
+
+	ret = is_onlist(path, ratelimit_list);
+	if (ret && verbose)
+		tst_res(TINFO, "Limiting to single worker %s", path);
+
+	return ret;
 }
 
 static void worker_heartbeat(const int worker)
@@ -503,6 +533,9 @@ static int sched_work(const int first_worker,
 	int min_ttl = worker_timeout, sleep_time = 1;
 	int pushed, workers_pushed = 0;
 
+	if (is_ratelimitted(path))
+		repetitions = 1;
+
 	for (i = 0, j = first_worker; i < repetitions; j++) {
 		if (j >= worker_count)
 			j = 0;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
