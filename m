Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4531BC3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 06:53:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A14363D1FC3
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 08:53:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 604793D1BC0
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:53:00 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7BD9E1400071
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722840777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EVbZQ8HJSvye5RorhL7nUdABEKxQnIjIYFeCIOOqb3s=;
 b=H0pbk5hWSNngtgTJeZRdbBY033tk7+fVsmAHCMI4a67Z0tDlpwrDX3qgc1gWpQdzqcMFEl
 xJlK+2tzvfwcEWPcRO6/j/PTNKRj7pjuSvNNTcnkbQMQNI00rPqsQR9c1pOO3M/KpxCfA9
 w+bqCMFM0ZBi8pvroTO2xqPs/CL9Jlw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-i85yz6HyPLeUlMdH2KBobQ-1; Mon,
 05 Aug 2024 02:52:56 -0400
X-MC-Unique: i85yz6HyPLeUlMdH2KBobQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7C9419560A2
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 06:52:54 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44F1E1955F40
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 06:52:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  5 Aug 2024 14:52:46 +0800
Message-ID: <20240805065247.13791-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lapi: move pkey.h declarations inside the
 lapi/ folder
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/syscalls/pkeys => include/lapi}/pkey.h      | 10 +++++-----
 testcases/kernel/syscalls/pkeys/pkey01.c               |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)
 rename {testcases/kernel/syscalls/pkeys => include/lapi}/pkey.h (88%)

diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/include/lapi/pkey.h
similarity index 88%
rename from testcases/kernel/syscalls/pkeys/pkey.h
rename to include/lapi/pkey.h
index 6e32326b6..e0dc20dce 100644
--- a/testcases/kernel/syscalls/pkeys/pkey.h
+++ b/include/lapi/pkey.h
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 Red Hat, Inc.
- * Copyright (c) Linux Test Project, 2019
+ * Copyright (c) 2019-2024 Red Hat, Inc.
+ * Copyright (c) Linux Test Project, 2019-2024
  */
 
-#ifndef PKEYS_H
-#define PKEYS_H
+#ifndef PKEYS_H__
+#define PKEYS_H__
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
@@ -53,4 +53,4 @@ static inline void check_pkey_support(void)
 	ltp_pkey_free(pkey);
 }
 
-#endif /* PKEYS_H */
+#endif /* PKEYS_H__ */
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index 0159822e1..a6a739668 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -29,7 +29,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 
-#include "pkey.h"
+#include "lapi/pkey.h"
 
 #define TEST_FILE "pkey_testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
