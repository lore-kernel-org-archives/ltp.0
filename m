Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D7FC433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE4D73C66FF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:52:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97F983C4E59
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:52:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3BB31000930
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:52:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38AEB1FD54;
 Tue, 30 Nov 2021 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638269569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FfQw9HcEXH7m6lIk+ticzzVaTJzvk+lTYqVMzb2vlh4=;
 b=F6xkCKHu1fYr2xzy8pTblOasz2T+b8d2t9JI9zbMc148Dac5q73PNOconbaqJA0zyOcmLJ
 3qYvxeNhhxNXccFwIOPjqVpTJrGwajcI5QWknpmD23O1rnqiY8/f5U/0dKd1SV1kmhF835
 cw/zQI2Ps3gLXlgTCaYKaZtN+1X80ic=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBB2813C44;
 Tue, 30 Nov 2021 10:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4A7uLoACpmFNQgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 30 Nov 2021 10:52:48 +0000
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 11:52:46 +0100
Message-Id: <20211130105246.19900-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add common.h utilities for aiodio tests
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common.h | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 testcases/kernel/io/ltp-aiodio/common.h

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
new file mode 100644
index 000000000..860abcc2a
--- /dev/null
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef AIODIO_COMMON_H__
+#define AIODIO_COMMON_H__
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+static char *check_zero(char *buf, int size)
+{
+	char *p;
+
+	p = buf;
+
+	while (size > 0) {
+		if (*buf != 0) {
+			tst_res(TINFO,
+				"non zero buffer at buf[%lu] => 0x%02x,%02x,%02x,%02x",
+				buf - p, (unsigned int)buf[0],
+				size > 1 ? (unsigned int)buf[1] : 0,
+				size > 2 ? (unsigned int)buf[2] : 0,
+				size > 3 ? (unsigned int)buf[3] : 0);
+			tst_res(TINFO, "buf %p, p %p", buf, p);
+			return buf;
+		}
+		buf++;
+		size--;
+	}
+
+	return 0;
+}
+
+static void io_append(const char *path, char pattern, int flags, size_t bs, size_t bcount)
+{
+	int fd;
+	size_t i;
+	char *bufptr;
+
+	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
+	memset(bufptr, pattern, bs);
+
+	fd = SAFE_OPEN(path, flags, 0666);
+
+	for (i = 0; i < bcount; i++)
+		SAFE_WRITE(1, fd, bufptr, bs);
+
+	free(bufptr);
+	SAFE_CLOSE(fd);
+}
+
+#endif /* AIODIO_COMMON_H__ */
\ No newline at end of file
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
