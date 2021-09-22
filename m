Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8725C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 05:40:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC58611B0
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 05:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BC58611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE1673C9AAE
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 07:40:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 820BA3CA14F
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 07:40:14 +0200 (CEST)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA623200DA8
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 07:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1632289210; i=@fujitsu.com;
 bh=hysPykdeQdYvbwP/Tcwj4l4Q5f4ZTG59zTYs2y8cKSs=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=i4pLxN78F4CXcBeiH6h/ayZbS5B8T9R9EILrj0H56i7kbWMUdD6oFp00rfzZ1wnYO
 cPGjYn6em2OJW+WU5z72wJ1LPhznaduScvFFUorEfFeDguM5UjHqjYVWAjZpxmuFLI
 peEP8Y9wUHlkav9GvcPHjEQODzSqViAXQy0TUZ3An6BPoCyCrPj71oBGIQDoZkxjUh
 wKAOwerNgTllcx6WELc5MsV0dvEoqCsvGJVpd9/kAcJuhI+2YmzyiwD6otHhJSPrIX
 76yB/qcjTKjj9119HehQdOcDmt5Do26zUnE7TpQtukOUswN+vv8F2kObOM/nxuYGLB
 ko9aGwISqnjLw==
Received: from [100.112.199.201] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.eu-west-1.aws.symcld.net id F8/0F-21838-AB1CA416;
 Wed, 22 Sep 2021 05:40:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8MxRXfXQa9
 Eg74rPBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bb/rXsBb8lKt6tO8TWwDhJtIuRi0NIoIVJ
 ou/zVxYIZw+jxPzv+1m7GDk52AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9YgKxhQWcJbqWr
 wGLswioSnxfOgGsl1fAQ2LZyZ2MILaEgILElIfvweZwCnhKvHuxFywuBFRz4v91Noh6QYmTM5
 +wQMyXkDj44gUzRK+ixKWOb1BzKiRmzWpjmsDIPwtJyywkLQsYmVYxWiQVZaZnlOQmZuboGho
 Y6BoaGukaWprrGhqb6yVW6SbppZbqlqcWl+ga6iWWF+sVV+Ym56To5aWWbGIEBmRKwdHOHYy/
 Xn3QO8QoycGkJMrrru2VKMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC9+x+oJxgUWp6akVaZg4wO
 mDSEhw8SiK8AruA0rzFBYm5xZnpEKlTjLoczZOWb2cWYsnLz0uVEuctOQBUJABSlFGaBzcCFq
 mXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzvt0HNIUnM68EbtMroCOYgI7gX+kBckRJIkJ
 KqoEp6mU+V0evW/eftb18v7dMNOYzbgzd93bj2zkObM6+O1K+PGfMPVHj8DbnrcOXtyzd600U
 +0+/8TpRf1og8KwM49sHKsHevP8CFlbEO0YG8Fdf4HN0CXvy82bUprWvX/2apGEzJyiy/6BWW
 +X1A9k71jQ/yNpw2YFz6m6JMAPZqrAGgU87TP5UHAjjdZtyr6tjQvCME7POxun46eV9Wtr/U+
 iljUinyJFfSw+JTew4ueiZyNR3XxRd+hOeetlksG2TtC/IXqF5N+Y7/8otqdtYJUtSnp2vKtg
 49fjE7/afWjsXP18g96jibdhMD8Zrh7Zou2uGrXjA2bmmfekXjoI3W27N2KHA0FSr3634f766
 EktxRqKhFnNRcSIA50pb808DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-285.messagelabs.com!1632289209!237285!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9740 invoked from network); 22 Sep 2021 05:40:10 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-14.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Sep 2021 05:40:10 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 18M5e3Yi010435
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 06:40:09 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 22 Sep 2021 06:40:00 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 22 Sep 2021 13:39:42 +0800
Message-ID: <1632289182-2191-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632289182-2191-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1632289182-2191-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] syscalls/dup207: Add file offset check test
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

Since the two file descriptors refer to the same open file description, they share file offset.
If the file offset is modified by using lseek(2) on one of the file descriptors, the offset is
also changed for the other file descriptor.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/dup2/.gitignore |  1 +
 testcases/kernel/syscalls/dup2/dup207.c   | 82 +++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/dup2/dup207.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 068fba456..b19316805 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -154,6 +154,7 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 dup206 dup206
+dup207 dup207
 
 dup3_01 dup3_01
 dup3_02 dup3_02
diff --git a/testcases/kernel/syscalls/dup2/.gitignore b/testcases/kernel/syscalls/dup2/.gitignore
index e2e008b58..f5938a182 100644
--- a/testcases/kernel/syscalls/dup2/.gitignore
+++ b/testcases/kernel/syscalls/dup2/.gitignore
@@ -4,3 +4,4 @@
 /dup204
 /dup205
 /dup206
+/dup207
diff --git a/testcases/kernel/syscalls/dup2/dup207.c b/testcases/kernel/syscalls/dup2/dup207.c
new file mode 100644
index 000000000..8badf4229
--- /dev/null
+++ b/testcases/kernel/syscalls/dup2/dup207.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test whether the file offset are the same for both file descriptors.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define WRITE_STR "abcdefg"
+
+static int ofd = -1, nfd = 10;
+
+static struct tcase {
+	off_t offset;
+	size_t exp_size;
+	/* 0 - change offset before dup2, 1 - change offset after dup2 */
+	int flag;
+	char *exp_data;
+	char *desc;
+} tcases[] = {
+	{1, 6, 0, "bcdefg", "Test offset check when using lseek before dup2"},
+	{2, 5, 1, "cdefg", "Test offset check when using lseek after dup2"},
+};
+
+static void setup(void)
+{
+	char testfile[40];
+
+	sprintf(testfile, "dup207.%d", getpid());
+	ofd = SAFE_OPEN(testfile, O_RDWR | O_CREAT, 0644);
+	SAFE_WRITE(1, ofd, WRITE_STR, sizeof(WRITE_STR) - 1);
+}
+
+static void cleanup(void)
+{
+	if (ofd > 0)
+		SAFE_CLOSE(ofd);
+	close(nfd);
+}
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = tcases + i;
+	char read_buf[20];
+
+	memset(read_buf, 0, sizeof(read_buf));
+	tst_res(TINFO, "%s", tc->desc);
+	if (!tc->flag)
+		SAFE_LSEEK(ofd, tc->offset, SEEK_SET);
+
+	TEST(dup2(ofd, nfd));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
+		return;
+	}
+	if (tc->flag)
+		SAFE_LSEEK(ofd, tc->offset, SEEK_SET);
+
+	SAFE_READ(1, nfd, read_buf, tc->exp_size);
+	if (strncmp(read_buf, tc->exp_data, tc->exp_size))
+		tst_res(TFAIL, "Expect %s, but get %s.", tc->exp_data, read_buf);
+	else
+		tst_res(TPASS, "Get expected buf %s", read_buf);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
