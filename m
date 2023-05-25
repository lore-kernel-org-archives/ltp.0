Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488A5C77B7A
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 08:10:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99C483CD1A7
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 10:10:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387E13CD1B0
 for <ltp@lists.linux.it>; Thu, 25 May 2023 10:09:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A20396009FC
 for <ltp@lists.linux.it>; Thu, 25 May 2023 10:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/UsPI22jpvxIc8h0kVhKbWbEYVVgUPc2dPcL/AfASU=;
 b=TQo765JUdwUMb5jhBQ6aLKBAyYSTI7JgZ5jD5yPY4gTmx7XNKSsLIweYFBzgRTmES4GHGt
 mH6nla16ZZ5SdwlpCvfAws5LgYhO53rz2PPKUy0Ieo4cJQZHI5uAx0AG2nGvX61R7CQOy1
 K+gH0GgXPcscbxy/Vf6o1koP6GkWvWU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-FZh0kBfQMTC4wresJHvXoQ-1; Thu, 25 May 2023 04:09:39 -0400
X-MC-Unique: FZh0kBfQMTC4wresJHvXoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 598361C05131
 for <ltp@lists.linux.it>; Thu, 25 May 2023 08:09:39 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A8471121314
 for <ltp@lists.linux.it>; Thu, 25 May 2023 08:09:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 25 May 2023 16:09:34 +0800
Message-Id: <20230525080934.54793-2-liwang@redhat.com>
In-Reply-To: <20230525080934.54793-1-liwang@redhat.com>
References: <20230525080934.54793-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cleanup: changing FILE_PRINTF to SAFE_FILE_PRINTF
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

SAFE_MACROS() used in cleanup do not exit the test anymore since:
commit 6440c5d0d15 (newlib: Allow SAFE_MACROS to be called from cleanup)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c | 4 ++--
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c  | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl33.c               | 2 +-
 testcases/kernel/syscalls/readahead/readahead02.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 67917b3fe..0a56519a1 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -78,10 +78,10 @@ static void check_set_turbo(char *file, char *off)
 
 static void cleanup(void)
 {
-	FILE_PRINTF(cdrv[id].file, "%d", boost_value);
+	SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%d", boost_value);
 
 	if (governor[0] != '\0')
-		FILE_PRINTF(governor, "%s", governor_name);
+		SAFE_FILE_PRINTF(cleanup, governor, "%s", governor_name);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 7e72a19ca..625761f6e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -84,7 +84,7 @@ static void cleanup(void)
 		rm_shm(shm_id_arr[i]);
 
 	if (orig_shmmni != -1)
-		FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
+		SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 8d0d1a5a1..3c6a38b81 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -209,7 +209,7 @@ static void cleanup(void)
 		SAFE_CLOSE(fd);
 
 	/* Restore the lease-break-time. */
-	FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
+	SAFE_FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 7acf4bb18..b6c097b31 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -352,7 +352,7 @@ static void setup_readahead_length(void)
 	/* raise bdi limit as much as kernel allows */
 	ra_new_limit = testfile_size / 1024;
 	while (ra_new_limit > pagesize / 1024) {
-		FILE_PRINTF(sys_bdi_ra_path, "%d", ra_new_limit);
+		SAFE_FILE_PRINTF(sys_bdi_ra_path, "%d", ra_new_limit);
 		SAFE_FILE_SCANF(sys_bdi_ra_path, "%d", &ra_limit);
 
 		if (ra_limit == ra_new_limit) {
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
