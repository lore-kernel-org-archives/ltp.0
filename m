Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E328C25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 00:57:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD20B3CF982
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 02:57:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AA313CF91F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 02:56:16 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01F006181D7
 for <ltp@lists.linux.it>; Thu, 16 May 2024 02:56:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E22E220E5E;
 Thu, 16 May 2024 00:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715820972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PZGmnRdYfrMMXgylBCRJiYTjdK2VZB7G8h2H/OzQUc=;
 b=xPZj2X04VOtdwKyEsPAoQLABpsuLCSOWjcGw1nwp0FQ7yIxUFF3lPXRTNznMi6AV0wQ4rd
 gMEvGkGBtXojw8SdvepO3WOhNN1y/luuNDDcBS4W8CjlH6vNds6J6tHeDn1liy7sReimmE
 4FUifyJaVNBFtW/WRX5NNDmAAYCcq3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715820972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PZGmnRdYfrMMXgylBCRJiYTjdK2VZB7G8h2H/OzQUc=;
 b=UzczyxdXBDE21hHZBXwd/c1/OrYm+px8wvTViewJbT8v36e0ikRUVFSi/22Cy/o2H7hA+j
 C48j/LRZfk0XLGAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715820971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PZGmnRdYfrMMXgylBCRJiYTjdK2VZB7G8h2H/OzQUc=;
 b=W9gCyKbl2Z0C8VnpYvpujgAP3swx8B8rKZW6HjwXKO856n+7yhqu07L5qdc7UJsWfaxKE/
 5cLjLtZKPi2vbRrVro8YZBCmYLtQOf9xnc7+mF6saq64OrHh1PiL4fvZEoua1OzjsROPC+
 sm0szqDXFgTRUqrtkvBd+FkkFiIXDew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715820971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PZGmnRdYfrMMXgylBCRJiYTjdK2VZB7G8h2H/OzQUc=;
 b=TlNdErFJ6f6rVTT1cAr1a9FH5Zr2wzu1Ux0T3wxZemgCImwsGzwbXxyLsbzsDesr5GVwZl
 VqZmLKjoqz0BNTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB296137C3;
 Thu, 16 May 2024 00:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MAn+LKtZRWbNJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 00:56:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 02:55:57 +0200
Message-ID: <20240516005558.253199-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516005558.253199-1-pvorel@suse.cz>
References: <20240516005558.253199-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lib: Add .skip_in_32bit
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_kernel.h | 13 +++++++++++++
 include/tst_test.h   |  6 +++++-
 lib/tst_kernel.c     | 11 +++++++++++
 lib/tst_test.c       |  5 ++++-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index e0ce7ce46..e3fadbeb0 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -1,10 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2018-2024
  */
 
 #ifndef TST_KERNEL_H__
 #define TST_KERNEL_H__
 
+#include <stdbool.h>
+
 /**
  * tst_kernel_bits() - Detect if running on 32bit or 64bit kernel.
  *
@@ -23,6 +26,16 @@ int tst_kernel_bits(void);
  */
 int tst_is_compat_mode(void);
 
+/**
+ * tst_is_32bit() - Detect if compiled for 32bit target.
+ *
+ * Detect if compiled for 32bit target (regardless if the test process is
+ * running on 32bit or 64bit kernel).
+ *
+ * Return: true if compiled for 32bit target or false otherwise.
+ */
+bool tst_is_32bit(void);
+
 /**
  * tst_check_builtin_driver() - Check if the kernel module is built-in.
  *
diff --git a/include/tst_test.h b/include/tst_test.h
index 69587917f..018249503 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) Linux Test Project, 2016-2019
+ * Copyright (c) Linux Test Project, 2016-2024
  */
 
 #ifndef TST_TEST_H__
@@ -328,6 +328,9 @@ struct tst_ulimit_val {
  * @skip_in_compat: Skip the test if we are executing 32bit binary on a 64bit
  *                  kernel, i.e. we are testing the kernel compat layer.
  *
+ * @skip_in_32bit: Skip the test if compiled for 32bit target (regardless if
+ *                 the test process is running on 32bit or 64bit kernel).
+ *
  * @needs_hugetlbfs: If set hugetlbfs is mounted at tst_test.mntpoint.
  *
  * @skip_filesystems: A NULL terminated array of unsupported file systems. The
@@ -494,6 +497,7 @@ struct tst_ulimit_val {
 	unsigned int skip_in_lockdown:1;
 	unsigned int skip_in_secureboot:1;
 	unsigned int skip_in_compat:1;
+	unsigned int skip_in_32bit:1;
 
 	unsigned int needs_hugetlbfs:1;
 
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 7fd1af871..ada8d104b 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) Linux Test Project, 2017-2024
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -18,6 +19,7 @@
 
 #include <sys/personality.h>
 #include <sys/utsname.h>
+#include <stdbool.h>
 #include <limits.h>
 
 #include "test.h"
@@ -96,6 +98,15 @@ int tst_is_compat_mode(void)
 	return TST_ABI != tst_kernel_bits();
 }
 
+bool tst_is_32bit(void)
+{
+#ifdef TST_ABI32
+	return true;
+#else
+	return false;
+#endif
+}
+
 static int tst_search_driver_(const char *driver, const char *file)
 {
 	struct stat st;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 686ee428d..c35dc12b3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) Linux Test Project, 2016-2021
+ * Copyright (c) Linux Test Project, 2016-2024
  */
 
 #include <limits.h>
@@ -1209,6 +1209,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->skip_in_compat && tst_is_compat_mode())
 		tst_brk(TCONF, "Not supported in 32-bit compat mode");
 
+	if (tst_test->skip_in_32bit && tst_is_32bit())
+		tst_brk(TCONF, "Not supported in 32-bit");
+
 	if (tst_test->needs_cmds) {
 		const char *cmd;
 		int i;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
