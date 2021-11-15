Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD550C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 08:16:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690D861BFD
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 08:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 690D861BFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9343C8184
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:16:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C4B3C8183
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 09:15:35 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3F0B601DAE
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 09:15:34 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 003CA9FEA9;
 Mon, 15 Nov 2021 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1636964134; bh=lvb1xCKY9Nr5OggofedSzXjQ5P5y4nzrSfuw/Jwx/wI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=TcNh4j+ekHzrCDp1JqfWK87cOTHEf5H0s+aJFRh+CZjlDZo6M4qlNlsZRLhAlhn5A
 TYppWeH2YpqYqGOOXgFgVriYZXchpCsiAfBIvUPif6B1FvwDZVJa/W/DoKJINEYbPV
 yvdDyqY7JxUah16ChyuiDH5Uag8Eap54eZUqWs4I=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	bogdan.lezhepekov@suse.com
Date: Mon, 15 Nov 2021 09:15:24 +0100
Message-Id: <20211115081526.384856-2-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115081526.384856-1-lkml@jv-coder.de>
References: <20211115081526.384856-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] realtime/librttest: Fix functions with empty
 parameters
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/realtime/include/librttest.h | 16 ++++++++--------
 testcases/realtime/lib/librttest.c     |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
index b829f4089..8e3421869 100644
--- a/testcases/realtime/include/librttest.h
+++ b/testcases/realtime/include/librttest.h
@@ -58,8 +58,8 @@
 #include "list.h"
 #include "realtime_config.h"
 
-extern void setup();
-extern void cleanup();
+extern void setup(void);
+extern void cleanup(int i);
 
 extern int optind, opterr, optopt;
 extern char *optarg;
@@ -147,15 +147,15 @@ static inline void atomic_set(int i, atomic_t *v)
 
 /* buffer_init: initialize the buffered printing system
  */
-void buffer_init();
+void buffer_init(void);
 
 /* buffer_print: prints the contents of the buffer
  */
-void buffer_print();
+void buffer_print(void);
 
 /* buffer_fini: destroy the buffer
  */
-void buffer_fini();
+void buffer_fini(void);
 
 /* debug: do debug prints at level L (see DBG_* below).  If buffer_init
  * has been called previously, this will print to the internal memory
@@ -185,7 +185,7 @@ static volatile int _debug_count = 0;
 #define DBG_DEBUG 4
 
 /* rt_help: print help for standard args */
-void rt_help();
+void rt_help(void);
 
 /* rt_init_long: initialize librttest
  * options: pass in an getopt style string of options -- e.g. "ab:cd::e:"
@@ -269,7 +269,7 @@ void all_threads_quit(void);
 /* join_threads: wait for all threads to finish
  * (calls all_threads_quit interally)
  */
-void join_threads();
+void join_threads(void);
 
 /* get_thread: return a struct thread pointer from the list */
 struct thread * get_thread(int i);
@@ -317,7 +317,7 @@ void rt_nanosleep_until(nsec_t ns);
 
 /* rt_gettime: get CLOCK_MONOTONIC time in nanoseconds
  */
-nsec_t rt_gettime();
+nsec_t rt_gettime(void);
 
 /* busy_work_ms: do busy work for ms milliseconds
  */
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 722d99d50..89e2bfc6e 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -276,7 +276,7 @@ void cleanup(int i)
 		exit(i);
 }
 
-void setup()
+void setup(void)
 {
 	signal(SIGINT, cleanup);
 	signal(SIGQUIT, cleanup);
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
