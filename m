Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65A5CDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 07:39:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A9923CD101
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 09:39:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98E573C8671
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 09:39:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFAEC140124B
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 09:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697528348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vOBYRuq5MlNcm37xPUGZZBoNBa4teD2UXEJyJ81YuzM=;
 b=Q4YoYZboSGTuONheslKXzcmzSuAc5pWjm2aOCj3K6ESf2Lig1/5JOQ072OZjqcDdAa3xan
 qfLSaP9bQGMmKJo98wH8qRhth2aEpe6L932WX+b2o4SMZcxAKhI45ZrIWeRGhU9YkcWwVq
 UGorPhI3VSQYHw5neCecP0uql24h/tQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-h-Hst0BrMhK3twpzL_TcEA-1; Tue, 17 Oct 2023 03:38:46 -0400
X-MC-Unique: h-Hst0BrMhK3twpzL_TcEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9087E811726
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 07:38:46 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29FD11C060AE
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 07:38:45 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 17 Oct 2023 09:34:14 +0200
Message-Id: <3453edcb87b9b0a480c672173df9d4fa848b0d12.1697527976.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/splice06: minimum pipe-max-size is page size
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

Test currently fails on ppc64le/aarch64 with page sizes > 4k, because
miminum pipe-max-size allowed is page size:

  splice06.c:178: TPASS: Read num through splice correctly
  splice06.c:187: TBROK: Write num through splice failed: SUCCESS (0)

From kernel's fs/pipe.c:
	unsigned int round_pipe_size(unsigned int size)
	{
		if (size > (1U << 31))
			return 0;

		/* Minimum pipe size, as required by POSIX */
		if (size < PAGE_SIZE)
			return PAGE_SIZE;

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/splice/splice06.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
index 3139d16db84d..0cb5dec29136 100644
--- a/testcases/kernel/syscalls/splice/splice06.c
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -25,11 +25,11 @@
 
 #define BUF_SIZE 100
 #define PIPE_MAX_INIT_SIZE 65536
-#define PIPE_MAX_TEST_SIZE 4096
 #define DOMAIN_INIT_NAME "LTP_INIT"
 #define DOMAIN_TEST_NAME "LTP_TEST"
 #define INTEGER_PROCFILE "/proc/sys/fs/pipe-max-size"
 #define STRING_PROCFILE "/proc/sys/kernel/domainname"
+static int pipe_max_test_size;
 
 static void format_str(char *str)
 {
@@ -179,9 +179,9 @@ static void splice_test(void)
 	else
 		tst_brk(TBROK | TERRNO, "Read num through splice failed");
 
-	splice_write_num(INTEGER_PROCFILE, PIPE_MAX_TEST_SIZE);
+	splice_write_num(INTEGER_PROCFILE, pipe_max_test_size);
 
-	if (file_read_num(INTEGER_PROCFILE) == PIPE_MAX_TEST_SIZE)
+	if (file_read_num(INTEGER_PROCFILE) == pipe_max_test_size)
 		tst_res(TPASS, "Write num through splice correctly");
 	else
 		tst_brk(TBROK | TERRNO, "Write num through splice failed");
@@ -210,6 +210,7 @@ static void splice_test(void)
 
 static void setup(void)
 {
+	pipe_max_test_size = getpagesize();
 	file_write_str(STRING_PROCFILE, DOMAIN_INIT_NAME);
 	file_write_num(STRING_PROCFILE, PIPE_MAX_INIT_SIZE);
 }
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
