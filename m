Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD2C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 09:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F76E3C987E
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 10:19:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B68983C97F7
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:19:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F1706002BC
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:19:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 45B6B1F383;
 Tue,  1 Feb 2022 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643707180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h2Vw/fDDdCARkO3jWSn58GxJuOvagBS6/aZR374oz8Q=;
 b=T7Rr8ULdTUfWnxPAjJpXzmUiB6ITJ0MWdEk+BSdH5/wRcPpmLXdlqGj8avkd+df9FK552D
 pNEF79Je8p/qvkvcaa3C3LzWE60OZVgw5XF4aiqlKfgu9IqB1fmbSHDMlmwTSuaZCCmBeU
 US2NHszZU3zwE9TM3nhqRzvnV0hPugI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643707180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h2Vw/fDDdCARkO3jWSn58GxJuOvagBS6/aZR374oz8Q=;
 b=YzKpfYhJBLz2xcKnxRnTg1o7kYOXVrwpxRNwawz8/l+vENNb5foCdm72nr1stZdBFwjASZ
 923FblVgk+pge7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F5E13D24;
 Tue,  1 Feb 2022 09:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HmSNAiz7+GGXawAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 01 Feb 2022 09:19:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  1 Feb 2022 10:19:38 +0100
Message-Id: <20220201091938.23362-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Refactoring aiodio_sparse.c using LTP API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
In v4 there's a better memory and events handling.
Number of AIO is set to filesize/writesize as maximum value.
Little adjustments to code format and documentation.

 runtest/ltp-aiodio.part2                      | 163 ++++----
 .../kernel/io/ltp-aiodio/aiodio_sparse.c      | 389 +++++++-----------
 2 files changed, 228 insertions(+), 324 deletions(-)

diff --git a/runtest/ltp-aiodio.part2 b/runtest/ltp-aiodio.part2
index bed5841bc..599c9fd2f 100644
--- a/runtest/ltp-aiodio.part2
+++ b/runtest/ltp-aiodio.part2
@@ -1,84 +1,83 @@
 ADSP000 aiodio_sparse
 ADSP001 aiodio_sparse -s 180k
-ADSP002 aiodio_sparse -dd -s 1751k -w 11k
-ADSP003 aiodio_sparse -i 9 -d -s 180k -w 18k
-ADSP004 aiodio_sparse -i 2 -a 2k -w 2k -s 4k -n 2
-ADSP005 aiodio_sparse -i 2 -a 4k -w 4k -s 8k -n 2
-ADSP006 aiodio_sparse -i 2 -a 4k -w 4k -s 8k -n 2
-ADSP007 aiodio_sparse -i 4 -a 8k -w 8k -s 32k -n 2
-ADSP008 aiodio_sparse -i 4 -a 8k -w 16k -s 64k -n 2
-ADSP009 aiodio_sparse -i 4 -a 8k -w 32k -s 128k -n 2
-ADSP010 aiodio_sparse -i 4 -a 8k -w 64k -s 256k -n 2
-ADSP011 aiodio_sparse -i 4 -a 8k -w 128k -s 512k -n 2
-ADSP012 aiodio_sparse -i 4 -a 8k -w 256k -s 1024k -n 2
-ADSP013 aiodio_sparse -i 4 -a 8k -w 512k -s 2048k -n 2
-ADSP014 aiodio_sparse -i 4 -a 8k -w 1024k -s 4096k -n 2
-ADSP015 aiodio_sparse -i 4 -a 8k -w 2048k -s 8192k -n 2
-ADSP016 aiodio_sparse -i 4 -a 8k -w 4096k -s 16384k -n 2
-ADSP017 aiodio_sparse -i 4 -a 8k -w 8192k -s 32768k -n 2
-ADSP018 aiodio_sparse -i 4 -a 8k -w 16384k -s 65536k -n 2
-ADSP019 aiodio_sparse -i 4 -a 8k -w 16384k -s 65536k -n 4
-ADSP020 aiodio_sparse -i 4 -a 8k -w 16384k -s 65536k -n 6
-ADSP021 aiodio_sparse -i 4 -a 8k -w 128k -s 512k -n 6
-ADSP022 aiodio_sparse -i 4 -a 8k -w 256k -s 1024k -n 6
-ADSP023 aiodio_sparse -i 4 -a 8k -w 512k -s 2048k -n 6
-ADSP024 aiodio_sparse -i 4 -a 8k -w 1024k -s 4096k -n 6
-ADSP025 aiodio_sparse -i 4 -a 8k -w 2048k -s 8192k -n 6
-ADSP026 aiodio_sparse -i 4 -a 8k -w 4096k -s 16384k -n 6
-ADSP027 aiodio_sparse -i 4 -a 8k -w 18192k -s 72768k -n 6
-ADSP028 aiodio_sparse -i 4 -a 8k -w 18192k -s 518192k -n 6
-ADSP029 aiodio_sparse -i 4 -a 8k -w 65536k -s 262144k -n 6
-ADSP030 aiodio_sparse -i 6 -a 8k -w 65536k -n 6
-ADSP031 aiodio_sparse -i 8 -a 8k -w 128k -s 1024k -n 6
-ADSP032 aiodio_sparse -i 16 -a 8k -w 256k -s 4096k -n 6
-ADSP033 aiodio_sparse -i 32 -a 8k -w 512k -s 16384k -n 6
-ADSP034 aiodio_sparse -i 64 -a 8k -w 1024k -s 65536k -n 6
-ADSP035 aiodio_sparse -i 4 -a 8k -w 4096k -s 16384k -n 32
-ADSP036 aiodio_sparse -i 4 -a 8k -w 4096k -s 16384k -n 64
-ADSP037 aiodio_sparse -i 4 -a 8k -w 18192k -s 72768k -n 128
-ADSP038 aiodio_sparse -i 4 -a 8k -w 18192k -n 512
-ADSP039 aiodio_sparse -i 4 -a 8k -w 18192k -n 1000
-ADSP040 dio_sparse
-ADSP041 dio_sparse -s 180k
-ADSP042 dio_sparse -s 1751k -w 11k
-ADSP043 dio_sparse  -s 180k -w 18k
-ADSP044 dio_sparse  -w 2k -s 2k -n 2
-ADSP045 dio_sparse  -w 4k -s 2k -n 2
-ADSP046 dio_sparse  -w 4k -s 4k -n 2
-ADSP047 dio_sparse  -w 16k -s 16k -n 2
-ADSP048 dio_sparse  -w 32k -s 32k -n 2
-ADSP049 dio_sparse  -w 64k -s 64k -n 2
-ADSP050 dio_sparse  -w 128k -s 128k -n 2
-ADSP051 dio_sparse  -w 256k -s 256k -n 2
-ADSP052 dio_sparse  -w 512k -s 512k -n 2
-ADSP053 dio_sparse  -w 1024k -s 1024k -n 2
-ADSP054 dio_sparse  -w 2048k -s 2048k -n 2
-ADSP055 dio_sparse  -w 4096k -s 4096k -n 2
-ADSP056 dio_sparse  -w 8192k -s 8192k -n 2
-ADSP057 dio_sparse  -w 18192k -s 18192k -n 2
-ADSP058 dio_sparse  -w 518192k -s 518192k -n 2
-ADSP059 dio_sparse  -w 58192k -s 58192k -n 4
-ADSP060 dio_sparse  -w 58192k -s 58192k -n 6
-ADSP061 dio_sparse  -w 256k -s 256k -n 6
-ADSP062 dio_sparse  -w 512k -s 512k -n 6
-ADSP063 dio_sparse  -w 1024k -s 1024k -n 6
-ADSP064 dio_sparse  -w 2048k -s 2048k -n 6
-ADSP065 dio_sparse  -w 2048k -s 4096k -n 6
-ADSP066 dio_sparse  -w 8192k -s 8192k -n 6
-ADSP067 dio_sparse  -w 18192k -s 18192k -n 6
-ADSP068 dio_sparse  -w 58192k -s 518192k -n 6
-ADSP069 dio_sparse  -w 518192k -s 518192k -n 6
-ADSP070 dio_sparse  -w 1024k -s 2048k -n 6
-ADSP071 dio_sparse  -w 4096k -s 4096k -n 32
-ADSP072 dio_sparse  -w 8192k -s 8192k -n 64
-ADSP073 dio_sparse  -w 518192k -s 18192k -n 128
-ADSP074 dio_sparse  -w 518192k -s 518192k -n 512
-ADSP075 dio_sparse  -w 518192k -s 518192k -n 1000
-ADSP076 dio_sparse  -w 4k -s 2k -o 2k -n 2
-ADSP077 dio_sparse  -w 2k -s 1k -o 1k -n 2
-ADSP078 dio_sparse  -w 1k -s 512 -o 512 -n 2
-ADSP079 dio_sparse  -w 4k -s 2k -o 3k -n 2
-ADSP080 dio_sparse  -w 4k -s 4k -o 4k -n 2
-ADSP081 dio_sparse  -w 4k -s 4k -o 6k -n 2
-ADSP082 dio_sparse  -w 4k -s 4k -o 8k -n 2
-ADSP083 dio_sparse  -w 16k -s 8k -o 8k -n 2
+ADSP002 aiodio_sparse -s 1751k -w 11k
+ADSP003 aiodio_sparse -o 9 -s 180k -w 18k
+ADSP004 aiodio_sparse -o 2 -w 2k -s 4k -n 2
+ADSP005 aiodio_sparse -o 2 -w 4k -s 8k -n 2
+ADSP006 aiodio_sparse -o 4 -w 8k -s 32k -n 2
+ADSP007 aiodio_sparse -o 4 -w 16k -s 64k -n 2
+ADSP008 aiodio_sparse -o 4 -w 32k -s 128k -n 2
+ADSP009 aiodio_sparse -o 4 -w 64k -s 256k -n 2
+ADSP010 aiodio_sparse -o 4 -w 128k -s 512k -n 2
+ADSP011 aiodio_sparse -o 4 -w 256k -s 1024k -n 2
+ADSP012 aiodio_sparse -o 4 -w 512k -s 2048k -n 2
+ADSP013 aiodio_sparse -o 4 -w 1024k -s 4096k -n 2
+ADSP014 aiodio_sparse -o 4 -w 2048k -s 8192k -n 2
+ADSP015 aiodio_sparse -o 4 -w 4096k -s 16384k -n 2
+ADSP016 aiodio_sparse -o 4 -w 8192k -s 32768k -n 2
+ADSP017 aiodio_sparse -o 4 -w 16384k -s 65536k -n 2
+ADSP018 aiodio_sparse -o 4 -w 16384k -s 65536k -n 4
+ADSP019 aiodio_sparse -o 4 -w 16384k -s 65536k -n 6
+ADSP020 aiodio_sparse -o 4 -w 128k -s 512k -n 6
+ADSP021 aiodio_sparse -o 4 -w 256k -s 1024k -n 6
+ADSP022 aiodio_sparse -o 4 -w 512k -s 2048k -n 6
+ADSP023 aiodio_sparse -o 4 -w 1024k -s 4096k -n 6
+ADSP024 aiodio_sparse -o 4 -w 2048k -s 8192k -n 6
+ADSP025 aiodio_sparse -o 4 -w 4096k -s 16384k -n 6
+ADSP026 aiodio_sparse -o 4 -w 18192k -s 72768k -n 6
+ADSP027 aiodio_sparse -o 4 -w 18192k -s 518192k -n 6
+ADSP028 aiodio_sparse -o 4 -w 65536k -s 262144k -n 6
+ADSP029 aiodio_sparse -o 6 -w 65536k -n 6
+ADSP030 aiodio_sparse -o 8 -w 128k -s 1024k -n 6
+ADSP031 aiodio_sparse -o 16 -w 256k -s 4096k -n 6
+ADSP032 aiodio_sparse -o 32 -w 512k -s 16384k -n 6
+ADSP033 aiodio_sparse -o 64 -w 1024k -s 65536k -n 6
+ADSP034 aiodio_sparse -o 4 -w 4096k -s 16384k -n 32
+ADSP035 aiodio_sparse -o 4 -w 4096k -s 16384k -n 64
+ADSP036 aiodio_sparse -o 4 -w 18192k -s 72768k -n 128
+ADSP037 aiodio_sparse -o 4 -w 18192k -n 512
+ADSP038 aiodio_sparse -o 4 -w 18192k -n 1000
+ADSP039 dio_sparse
+ADSP040 dio_sparse -s 180k
+ADSP041 dio_sparse -s 1751k -w 11k
+ADSP042 dio_sparse  -s 180k -w 18k
+ADSP043 dio_sparse  -w 2k -s 2k -n 2
+ADSP044 dio_sparse  -w 4k -s 2k -n 2
+ADSP045 dio_sparse  -w 4k -s 4k -n 2
+ADSP046 dio_sparse  -w 16k -s 16k -n 2
+ADSP047 dio_sparse  -w 32k -s 32k -n 2
+ADSP048 dio_sparse  -w 64k -s 64k -n 2
+ADSP049 dio_sparse  -w 128k -s 128k -n 2
+ADSP050 dio_sparse  -w 256k -s 256k -n 2
+ADSP051 dio_sparse  -w 512k -s 512k -n 2
+ADSP052 dio_sparse  -w 1024k -s 1024k -n 2
+ADSP053 dio_sparse  -w 2048k -s 2048k -n 2
+ADSP054 dio_sparse  -w 4096k -s 4096k -n 2
+ADSP055 dio_sparse  -w 8192k -s 8192k -n 2
+ADSP056 dio_sparse  -w 18192k -s 18192k -n 2
+ADSP057 dio_sparse  -w 518192k -s 518192k -n 2
+ADSP058 dio_sparse  -w 58192k -s 58192k -n 4
+ADSP059 dio_sparse  -w 58192k -s 58192k -n 6
+ADSP060 dio_sparse  -w 256k -s 256k -n 6
+ADSP061 dio_sparse  -w 512k -s 512k -n 6
+ADSP062 dio_sparse  -w 1024k -s 1024k -n 6
+ADSP063 dio_sparse  -w 2048k -s 2048k -n 6
+ADSP064 dio_sparse  -w 2048k -s 4096k -n 6
+ADSP065 dio_sparse  -w 8192k -s 8192k -n 6
+ADSP066 dio_sparse  -w 18192k -s 18192k -n 6
+ADSP067 dio_sparse  -w 58192k -s 518192k -n 6
+ADSP068 dio_sparse  -w 518192k -s 518192k -n 6
+ADSP069 dio_sparse  -w 1024k -s 2048k -n 6
+ADSP070 dio_sparse  -w 4096k -s 4096k -n 32
+ADSP071 dio_sparse  -w 8192k -s 8192k -n 64
+ADSP072 dio_sparse  -w 518192k -s 18192k -n 128
+ADSP073 dio_sparse  -w 518192k -s 518192k -n 512
+ADSP074 dio_sparse  -w 518192k -s 518192k -n 1000
+ADSP075 dio_sparse  -w 4k -s 2k -o 2k -n 2
+ADSP076 dio_sparse  -w 2k -s 1k -o 1k -n 2
+ADSP077 dio_sparse  -w 1k -s 512 -o 512 -n 2
+ADSP078 dio_sparse  -w 4k -s 2k -o 3k -n 2
+ADSP079 dio_sparse  -w 4k -s 4k -o 4k -n 2
+ADSP080 dio_sparse  -w 4k -s 4k -o 6k -n 2
+ADSP081 dio_sparse  -w 4k -s 4k -o 8k -n 2
+ADSP082 dio_sparse  -w 16k -s 8k -o 8k -n 2
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 4767f49d2..33a25a28c 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
  *               2004 Open Source Development Lab
@@ -5,167 +6,125 @@
  * Copyright (c) 2004 Marty Ridgeway <mridge@us.ibm.com>
  *
  * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Create a sparse file and write zeroes to it using libaio while other
+ * processes are doing buffered reads and check if the buffer reads always see
+ * zero.
  */
 
 #define _GNU_SOURCE
 
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <signal.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <sys/wait.h>
-#include <limits.h>
-#include <getopt.h>
-
-
-#include "config.h"
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "aiodio_sparse";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #ifdef HAVE_LIBAIO
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
 #include <libaio.h>
+#include "common.h"
 
-#define NUM_CHILDREN 1000
+static int *run_child;
 
-int debug;
-int fd;
+static char *str_numchildren;
+static char *str_writesize;
+static char *str_filesize;
+static char *str_numaio;
 
-static void setup(void);
-static void cleanup(void);
-static void usage(void);
+static int numchildren = 1000;
+static long long writesize = 1024;
+static long long filesize = 100 * 1024 * 1024;
+static long long alignment = 512;
+static int numaio = 16;
 
-#include "common_sparse.h"
+static void check_event(struct io_event event)
+{
+	struct iocb *iocbp;
 
-/*
- * do async DIO writes to a sparse file
- */
-int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
+	iocbp = (struct iocb *)event.obj;
+	if (event.res2 != 0 || event.res != iocbp->u.c.nbytes) {
+		tst_brk(TBROK, "AIO write offset %lld expected %ld got %ld",
+			iocbp->u.c.offset, iocbp->u.c.nbytes, event.res);
+	}
+}
+
+static void aiodio_sparse(char *filename, long long align, long long ws,
+			  long long fs, int naio)
 {
+	int fd;
 	int i, w;
 	struct iocb **iocbs;
+	struct iocb *iocb;
 	off_t offset;
 	io_context_t myctx;
 	struct io_event event;
 	int aio_inflight;
 
-	if ((num_aio * writesize) > filesize)
-		num_aio = filesize / writesize;
+	fd = SAFE_OPEN(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	SAFE_FTRUNCATE(fd, fs);
 
 	memset(&myctx, 0, sizeof(myctx));
-	io_queue_init(num_aio, &myctx);
+	io_queue_init(naio, &myctx);
 
-	iocbs = malloc(sizeof(struct iocb *) * num_aio);
-	for (i = 0; i < num_aio; i++) {
-		if ((iocbs[i] = malloc(sizeof(struct iocb))) == 0) {
-			tst_resm(TBROK | TERRNO, "malloc()");
-			return 1;
-		}
-	}
+	iocbs = SAFE_MALLOC(sizeof(struct iocb *) * naio);
+	iocb = SAFE_MALLOC(sizeof(struct iocb) * naio);
+
+	for (i = 0; i < naio; i++)
+		iocbs[i] = iocb + i;
 
 	/*
 	 * allocate the iocbs array and iocbs with buffers
 	 */
 	offset = 0;
-	for (i = 0; i < num_aio; i++) {
+	for (i = 0; i < naio; i++) {
 		void *bufptr;
 
-		TEST(posix_memalign(&bufptr, align, writesize));
-		if (TEST_RETURN) {
-			tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
-			return 1;
-		}
-		memset(bufptr, 0, writesize);
-		io_prep_pwrite(iocbs[i], fd, bufptr, writesize, offset);
-		offset += writesize;
+		bufptr = SAFE_MEMALIGN(align, ws);
+		memset(bufptr, 0, ws);
+		io_prep_pwrite(iocbs[i], fd, bufptr, ws, offset);
+		offset += ws;
 	}
 
 	/*
-	 * start the 1st num_aio write requests
+	 * start the 1st naio write requests
 	 */
-	if ((w = io_submit(myctx, num_aio, iocbs)) < 0) {
-		tst_resm(TBROK, "io_submit() returned %i", w);
-		return 1;
-	}
-
-	if (debug)
-		tst_resm(TINFO, "io_submit() returned %d", w);
+	w = io_submit(myctx, naio, iocbs);
+	if (w < 0)
+		tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
 
 	/*
 	 * As AIO requests finish, keep issuing more AIO until done.
 	 */
-	aio_inflight = num_aio;
+	aio_inflight = naio;
 
-	while (offset < filesize) {
+	while (offset < fs) {
 		int n;
 		struct iocb *iocbp;
 
-		if (debug)
-			tst_resm(TINFO,
-				 "aiodio_sparse: offset %p filesize %d inflight %d",
-				 &offset, filesize, aio_inflight);
+		n = io_getevents(myctx, 1, 1, &event, 0);
 
-		if ((n = io_getevents(myctx, 1, 1, &event, 0)) != 1) {
-			if (-n != EINTR)
-				tst_resm(TBROK, "io_getevents() returned %d",
-					 n);
-			break;
-		}
+		if (-n == EINTR)
+			continue;
 
-		if (debug)
-			tst_resm(TINFO,
-				 "aiodio_sparse: io_getevent() returned %d", n);
+		if (n != 1)
+			tst_brk(TBROK, "io_getevents: %s", tst_strerrno(-n));
 
 		aio_inflight--;
 
-		/*
-		 * check if write succeeded.
-		 */
-		iocbp = (struct iocb *)event.obj;
-		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes) {
-			tst_resm(TBROK,
-				 "AIO write offset %lld expected %ld got %ld",
-				 iocbp->u.c.offset, iocbp->u.c.nbytes,
-				 event.res);
-			break;
-		}
-
-		if (debug)
-			tst_resm(TINFO,
-				 "aiodio_sparse: io_getevent() res %ld res2 %ld",
-				 event.res, event.res2);
+		check_event(event);
 
 		/* start next write */
-		io_prep_pwrite(iocbp, fd, iocbp->u.c.buf, writesize, offset);
-		offset += writesize;
-		if ((w = io_submit(myctx, 1, &iocbp)) < 0) {
-			tst_resm(TBROK, "io_submit failed at offset %ld",
-				 offset);
-			break;
-		}
+		iocbp = (struct iocb *)event.obj;
 
-		if (debug)
-			tst_resm(TINFO, "io_submit() return %d", w);
+		io_prep_pwrite(iocbp, fd, iocbp->u.c.buf, ws, offset);
+		offset += ws;
+		w = io_submit(myctx, 1, &iocbp);
+		if (w < 0)
+			tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
 
 		aio_inflight++;
 	}
@@ -175,163 +134,109 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
 	 */
 	while (aio_inflight > 0) {
 		int n;
-		struct iocb *iocbp;
 
-		if ((n = io_getevents(myctx, 1, 1, &event, 0)) != 1) {
-			tst_resm(TBROK, "io_getevents failed");
-			break;
-		}
+		n = io_getevents(myctx, 1, 1, &event, 0);
+
+		if (-n == EINTR)
+			continue;
+
+		if (n != 1)
+			tst_brk(TBROK, "io_getevents failed");
+
 		aio_inflight--;
-		/*
-		 * check if write succeeded.
-		 */
-		iocbp = (struct iocb *)event.obj;
-		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes) {
-			tst_resm(TBROK,
-				 "AIO write offset %lld expected %ld got %ld",
-				 iocbp->u.c.offset, iocbp->u.c.nbytes,
-				 event.res);
-		}
-	}
 
-	return 0;
-}
+		check_event(event);
+	}
 
-static void usage(void)
-{
-	fprintf(stderr, "usage: dio_sparse [-n children] [-s filesize]"
-		" [-w writesize]\n");
-	exit(1);
+	free(iocb);
+	free(iocbs);
 }
 
-int main(int argc, char **argv)
+static void setup(void)
 {
-	char *filename = "aiodio_sparse";
-	int pid[NUM_CHILDREN];
-	int num_children = 1;
-	int i;
-	long alignment = 512;
-	int writesize = 65536;
-	int filesize = 100 * 1024 * 1024;
-	int num_aio = 16;
-	int children_errors = 0;
-	int c;
-	int ret;
-
-	while ((c = getopt(argc, argv, "dw:n:a:s:i:")) != -1) {
-		char *endp;
-		switch (c) {
-		case 'd':
-			debug++;
-			break;
-		case 'i':
-			num_aio = atoi(optarg);
-			break;
-		case 'a':
-			alignment = strtol(optarg, &endp, 0);
-			alignment = (int)scale_by_kmg((long long)alignment,
-						      *endp);
-			break;
-		case 'w':
-			writesize = strtol(optarg, &endp, 0);
-			writesize =
-			    (int)scale_by_kmg((long long)writesize, *endp);
-			break;
-		case 's':
-			filesize = strtol(optarg, &endp, 0);
-			filesize =
-			    (int)scale_by_kmg((long long)filesize, *endp);
-			break;
-		case 'n':
-			num_children = atoi(optarg);
-			if (num_children > NUM_CHILDREN) {
-				fprintf(stderr,
-					"number of children limited to %d\n",
-					NUM_CHILDREN);
-				num_children = NUM_CHILDREN;
-			}
-			break;
-		case '?':
-			usage();
-			break;
-		}
-	}
+	struct stat sb;
 
-	setup();
-	tst_resm(TINFO, "Dirtying free blocks");
-	dirty_freeblocks(filesize);
-
-	fd = SAFE_OPEN(cleanup, filename,
-		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
-	SAFE_FTRUNCATE(cleanup, fd, filesize);
-
-	tst_resm(TINFO, "Starting I/O tests");
-	signal(SIGTERM, SIG_DFL);
-	for (i = 0; i < num_children; i++) {
-		switch (pid[i] = fork()) {
-		case 0:
-			SAFE_CLOSE(NULL, fd);
-			read_sparse(filename, filesize);
-			break;
-		case -1:
-			while (i-- > 0)
-				kill(pid[i], SIGTERM);
-
-			tst_brkm(TBROK | TERRNO, cleanup, "fork()");
-		default:
-			continue;
-		}
+	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX)) {
+		tst_brk(TBROK, "Invalid number of children '%s'",
+			str_numchildren);
 	}
-	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	ret = aiodio_sparse(fd, alignment, writesize, filesize, num_aio);
+	if (tst_parse_filesize(str_writesize, &writesize, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid write blocks size '%s'", str_writesize);
 
-	tst_resm(TINFO, "Killing childrens(s)");
+	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
 
-	for (i = 0; i < num_children; i++)
-		kill(pid[i], SIGTERM);
-
-	for (i = 0; i < num_children; i++) {
-		int status;
-		pid_t p;
+	if (tst_parse_int(str_numaio, &numaio, 1, INT_MAX)) {
+		tst_brk(TBROK, "Invalid number of AIO control blocks '%s'",
+			str_numaio);
+	}
 
-		p = waitpid(pid[i], &status, 0);
-		if (p < 0) {
-			tst_resm(TBROK | TERRNO, "waitpid()");
-		} else {
-			if (WIFEXITED(status) && WEXITSTATUS(status) == 10)
-				children_errors++;
-		}
+	if ((numaio * writesize) > filesize) {
+		numaio = filesize / writesize;
+		tst_res(TINFO,
+			"Numbers of AIO have been reduced to %d so we fit "
+			"filesize",
+			numaio);
 	}
 
-	if (children_errors)
-		tst_resm(TFAIL, "%i children(s) exited abnormally",
-			 children_errors);
+	SAFE_STAT(".", &sb);
+	alignment = sb.st_blksize;
 
-	if (!children_errors && !ret)
-		tst_resm(TPASS, "Test passed");
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "Dirtying free blocks");
+	dirty_freeblocks(filesize);
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	tst_tmpdir();
+	*run_child = 0;
+	SAFE_MUNMAP(run_child, sizeof(int));
 }
 
-static void cleanup(void)
+static void run(void)
 {
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "Failed to close file");
+	char *filename = "file.bin";
+	int status;
+	int i;
+
+	*run_child = 1;
 
-	tst_rmdir();
+	for (i = 0; i < numchildren; i++) {
+		if (!SAFE_FORK()) {
+			io_read(filename, filesize, run_child);
+			return;
+		}
+	}
+
+	tst_res(TINFO, "Parent create a sparse file");
+
+	aiodio_sparse(filename, alignment, writesize, filesize, numaio);
+
+	if (SAFE_WAITPID(-1, &status, WNOHANG))
+		tst_res(TFAIL, "Non zero bytes read");
+	else
+		tst_res(TPASS, "All bytes read were zeroed");
+
+	*run_child = 0;
 }
 
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"n:", &str_numchildren, "Number of threads (default 1000)"},
+		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
+		{"s:", &str_filesize, "Size of file (default 100M)"},
+		{"o:", &str_numaio, "Number of AIO control blocks (default 16)"},
+		{},
+	},
+};
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
-}
+TST_TEST_TCONF("test requires libaio and its development packages");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
