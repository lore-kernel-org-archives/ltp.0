Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C89FCE7B0E
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 08:44:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2F783CDD57
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 10:44:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF863C9956
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 10:44:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3E9F1400F49
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 10:44:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB35A2188E;
 Thu, 28 Sep 2023 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695890658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zd0upSZtZo8aSY+/9On2JW37JofM4E3NIvu88djZ6zk=;
 b=F4up4s/cncnDPjNYSVNO/ayMLCAFyrhL7ytSOc9hFLBawOUkG4PZE/K5ZtP6j5Zooic/I0
 MYVs38znMKCIaB6ROeSAGJOJBWncikvmnikC66RHn5e6nKgbjsPeBpmYg2065FZC3e+uK6
 qGu3x6ZeFqlIu1S22PV/dcYpuUKRuXU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B47C7138E9;
 Thu, 28 Sep 2023 08:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iOgnHuE8FWWbVAAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 28 Sep 2023 08:44:17 +0000
To: ltp@lists.linux.it
Date: Thu, 28 Sep 2023 04:44:08 -0400
Message-Id: <20230928084408.21125-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230928010808.15862-1-wegao@suse.com>
References: <20230928010808.15862-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getcwd01: Use syscall directly check invalid
 argument
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Related issue: https://github.com/linux-test-project/ltp/issues/1084

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/getcwd/getcwd01.c | 23 +++++++++++----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 65d827873..d47174ffc 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -14,8 +14,8 @@
  *
  * Expected Result:
  * 1) getcwd(2) should return NULL and set errno to EFAULT.
- * 2) getcwd(2) should return NULL and set errno to ENOMEM.
- * 3) getcwd(2) should return NULL and set errno to EINVAL.
+ * 2) getcwd(2) should return NULL and set errno to EFAULT.
+ * 3) getcwd(2) should return NULL and set errno to ERANGE.
  * 4) getcwd(2) should return NULL and set errno to ERANGE.
  * 5) getcwd(2) should return NULL and set errno to ERANGE.
  *
@@ -24,6 +24,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <limits.h>
+#include "lapi/syscalls.h"
 #include "tst_test.h"
 
 static char buffer[5];
@@ -34,32 +35,32 @@ static struct t_case {
 	int exp_err;
 } tcases[] = {
 	{(void *)-1, PATH_MAX, EFAULT},
-	{NULL, (size_t)-1, ENOMEM},
-	{buffer, 0, EINVAL},
+	{NULL, (size_t)-1, EFAULT},
+	{buffer, 0, ERANGE},
 	{buffer, 1, ERANGE},
 	{NULL, 1, ERANGE}
 };
 
+
 static void verify_getcwd(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
-	char *res;
+	int res;
 
 	errno = 0;
-	res = getcwd(tc->buf, tc->size);
-	TST_ERR = errno;
-	if (res) {
+	res = syscall(__NR_getcwd, tc->buf, tc->size);
+	if (!res) {
 		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
 		return;
 	}
 
-	if (TST_ERR != tc->exp_err) {
-		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
+	if (errno != tc->exp_err) {
+		tst_res(TFAIL, "getcwd() failed unexpectedly, expected %s",
 			tst_strerrno(tc->exp_err));
 		return;
 	}
 
-	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
+	tst_res(TPASS, "getcwd() failed as expected");
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
