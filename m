Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE1EC3DA62
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:18:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F4CF3D1AED
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:18:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21B923D0C9E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B6F81A00A49
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49B5E21A6F;
 Wed, 17 Jul 2024 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJHFf+JIqXbBHsgx9P7ULrukLEhIvT43SFgL8VhyRKU=;
 b=dWkauH8ptOwAYYyachVEO/Xs4cuRPD5/mgECFK66tGcJs43U5sNKqWJWNerYqs1JzKx3wz
 ElevgsgDI2KJEI3fEz7Dt86Kwc6DARKsuDCgCKDPz9RymXiF9xF41L3YF0iP45ckim43j0
 i5TJGcvhuHrGS+fqo+y/4i4DvqlAkEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJHFf+JIqXbBHsgx9P7ULrukLEhIvT43SFgL8VhyRKU=;
 b=ujxI9drbuoj+PXD7woz7go5JwXwCDLG/ItIJaUlXG+NV17yAhdSjv1igTlI+BdTKPENpFV
 lk/lT73Vu0A046Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJHFf+JIqXbBHsgx9P7ULrukLEhIvT43SFgL8VhyRKU=;
 b=dWkauH8ptOwAYYyachVEO/Xs4cuRPD5/mgECFK66tGcJs43U5sNKqWJWNerYqs1JzKx3wz
 ElevgsgDI2KJEI3fEz7Dt86Kwc6DARKsuDCgCKDPz9RymXiF9xF41L3YF0iP45ckim43j0
 i5TJGcvhuHrGS+fqo+y/4i4DvqlAkEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJHFf+JIqXbBHsgx9P7ULrukLEhIvT43SFgL8VhyRKU=;
 b=ujxI9drbuoj+PXD7woz7go5JwXwCDLG/ItIJaUlXG+NV17yAhdSjv1igTlI+BdTKPENpFV
 lk/lT73Vu0A046Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 155851396E;
 Wed, 17 Jul 2024 17:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YFkVBJ/8l2ZQOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:17:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jul 2024 19:17:13 +0200
Message-ID: <20240717171713.687339-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717171713.687339-1-pvorel@suse.cz>
References: <20240717171713.687339-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [1.20 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] realtime: Use proper syntax for non-system include
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
 testcases/realtime/func/async_handler/async_handler.c         | 4 ++--
 testcases/realtime/func/async_handler/async_handler_jk.c      | 4 ++--
 testcases/realtime/func/async_handler/async_handler_tsc.c     | 4 ++--
 testcases/realtime/func/gtod_latency/gtod_infinite.c          | 2 +-
 testcases/realtime/func/gtod_latency/gtod_latency.c           | 4 ++--
 testcases/realtime/func/hrtimer-prio/hrtimer-prio.c           | 4 ++--
 testcases/realtime/func/matrix_mult/matrix_mult.c             | 4 ++--
 testcases/realtime/func/measurement/preempt_timing.c          | 2 +-
 testcases/realtime/func/measurement/rdtsc-latency.c           | 2 +-
 testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c | 4 ++--
 .../func/periodic_cpu_load/periodic_cpu_load_single.c         | 4 ++--
 testcases/realtime/func/pi-tests/test-skeleton.c              | 2 +-
 testcases/realtime/func/pi-tests/testpi-0.c                   | 2 +-
 testcases/realtime/func/pi-tests/testpi-1.c                   | 2 +-
 testcases/realtime/func/pi-tests/testpi-2.c                   | 2 +-
 testcases/realtime/func/pi-tests/testpi-4.c                   | 2 +-
 testcases/realtime/func/pi-tests/testpi-5.c                   | 2 +-
 testcases/realtime/func/pi-tests/testpi-6.c                   | 2 +-
 testcases/realtime/func/pi-tests/testpi-7.c                   | 2 +-
 testcases/realtime/func/pi_perf/pi_perf.c                     | 4 ++--
 testcases/realtime/func/prio-preempt/prio-preempt.c           | 2 +-
 testcases/realtime/func/prio-wake/prio-wake.c                 | 4 ++--
 .../realtime/func/pthread_kill_latency/pthread_kill_latency.c | 4 ++--
 testcases/realtime/func/rt-migrate/rt-migrate.c               | 4 ++--
 testcases/realtime/func/sched_jitter/sched_jitter.c           | 4 ++--
 testcases/realtime/func/sched_latency/sched_latency.c         | 4 ++--
 testcases/realtime/func/thread_clock/tc-2.c                   | 2 +-
 testcases/realtime/lib/librttest.c                            | 4 ++--
 testcases/realtime/lib/libstats.c                             | 4 ++--
 testcases/realtime/perf/latency/pthread_cond_latency.c        | 2 +-
 testcases/realtime/perf/latency/pthread_cond_many.c           | 4 ++--
 testcases/realtime/stress/pi-tests/lookup_pi_state.c          | 2 +-
 testcases/realtime/stress/pi-tests/testpi-3.c                 | 2 +-
 33 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/testcases/realtime/func/async_handler/async_handler.c b/testcases/realtime/func/async_handler/async_handler.c
index 70ef56cc1f..bbe1d9adc9 100644
--- a/testcases/realtime/func/async_handler/async_handler.c
+++ b/testcases/realtime/func/async_handler/async_handler.c
@@ -39,8 +39,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 #include <getopt.h>
 
 #define SIGNAL_PRIO 89
diff --git a/testcases/realtime/func/async_handler/async_handler_jk.c b/testcases/realtime/func/async_handler/async_handler_jk.c
index 4d87218224..8ce826b78a 100644
--- a/testcases/realtime/func/async_handler/async_handler_jk.c
+++ b/testcases/realtime/func/async_handler/async_handler_jk.c
@@ -41,8 +41,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 // This is the normal priority for an event handler if not specified.
 #define NORMAL_PRIORITY	43
diff --git a/testcases/realtime/func/async_handler/async_handler_tsc.c b/testcases/realtime/func/async_handler/async_handler_tsc.c
index 73d4ee5c61..0fe109c511 100644
--- a/testcases/realtime/func/async_handler/async_handler_tsc.c
+++ b/testcases/realtime/func/async_handler/async_handler_tsc.c
@@ -44,8 +44,8 @@
 #include <math.h>
 #include <stdint.h>
 #include <pthread.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #include "tst_tsc.h"
 
diff --git a/testcases/realtime/func/gtod_latency/gtod_infinite.c b/testcases/realtime/func/gtod_latency/gtod_infinite.c
index 676b132cbf..cee469bd46 100644
--- a/testcases/realtime/func/gtod_latency/gtod_infinite.c
+++ b/testcases/realtime/func/gtod_latency/gtod_infinite.c
@@ -50,7 +50,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <sched.h>
-#include <librttest.h>
+#include "librttest.h"
 #include <sys/mman.h>
 #include <unistd.h>
 #include <signal.h>
diff --git a/testcases/realtime/func/gtod_latency/gtod_latency.c b/testcases/realtime/func/gtod_latency/gtod_latency.c
index 26ee85f533..8f8174cd73 100644
--- a/testcases/realtime/func/gtod_latency/gtod_latency.c
+++ b/testcases/realtime/func/gtod_latency/gtod_latency.c
@@ -52,8 +52,8 @@
 #include <sched.h>
 #include <errno.h>
 #include <limits.h>
-#include <libstats.h>
-#include <librttest.h>
+#include "libstats.h"
+#include "librttest.h"
 #include <sys/mman.h>
 
 #define ITERATIONS 10000000
diff --git a/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c b/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
index cbc2343f61..5a382f5bd2 100644
--- a/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
+++ b/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
@@ -42,8 +42,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define DEF_MED_PRIO 60		// (softirqd-hrtimer,98)
 #define DEF_ITERATIONS 10000
diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
index c32092344d..e028952be8 100644
--- a/testcases/realtime/func/matrix_mult/matrix_mult.c
+++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
@@ -16,8 +16,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define MAX_CPUS	8192
 #define PRIO		43
diff --git a/testcases/realtime/func/measurement/preempt_timing.c b/testcases/realtime/func/measurement/preempt_timing.c
index b84d546924..87286f63f2 100644
--- a/testcases/realtime/func/measurement/preempt_timing.c
+++ b/testcases/realtime/func/measurement/preempt_timing.c
@@ -51,7 +51,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 #include <stdint.h>
-#include <librttest.h>
+#include "librttest.h"
 
 #include "tst_tsc.h"
 
diff --git a/testcases/realtime/func/measurement/rdtsc-latency.c b/testcases/realtime/func/measurement/rdtsc-latency.c
index 3829947bc4..dba5a90f69 100644
--- a/testcases/realtime/func/measurement/rdtsc-latency.c
+++ b/testcases/realtime/func/measurement/rdtsc-latency.c
@@ -43,7 +43,7 @@
 #include <sched.h>
 #include <errno.h>
 #include <stdint.h>
-#include <librttest.h>
+#include "librttest.h"
 
 #include "tst_tsc.h"
 
diff --git a/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c b/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c
index 9b9307a276..386eed98b4 100644
--- a/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c
+++ b/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c
@@ -38,8 +38,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define PRIO_A 63
 #define PRIO_B 53
diff --git a/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c b/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c
index ebbb461395..1e23d88391 100644
--- a/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c
+++ b/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c
@@ -38,8 +38,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define HIST_BUCKETS 100
 
diff --git a/testcases/realtime/func/pi-tests/test-skeleton.c b/testcases/realtime/func/pi-tests/test-skeleton.c
index 7816cf8771..816076e0cb 100644
--- a/testcases/realtime/func/pi-tests/test-skeleton.c
+++ b/testcases/realtime/func/pi-tests/test-skeleton.c
@@ -41,7 +41,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include <time.h>
-#include <librttest.h>
+#include "librttest.h"
 
 void usage(void)
 {
diff --git a/testcases/realtime/func/pi-tests/testpi-0.c b/testcases/realtime/func/pi-tests/testpi-0.c
index fd8ad0717d..093082382e 100644
--- a/testcases/realtime/func/pi-tests/testpi-0.c
+++ b/testcases/realtime/func/pi-tests/testpi-0.c
@@ -42,7 +42,7 @@
 #include <pthread.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 void usage(void)
 {
diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index 3dbe292d25..8acf215ba9 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -44,7 +44,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 pthread_barrier_t barrier;
 
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index 3f7185e8d8..1752d0af9d 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -45,7 +45,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 pthread_barrier_t barrier;
 
diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index e9e0ed6d6d..cb309e8bf7 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -45,7 +45,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 pthread_barrier_t barrier;
 
diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index a524864174..24bbb334c1 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -39,7 +39,7 @@
 #include <pthread.h>
 #include <string.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 pthread_mutex_t child_mutex;
 
 void *child_thread(void *arg)
diff --git a/testcases/realtime/func/pi-tests/testpi-6.c b/testcases/realtime/func/pi-tests/testpi-6.c
index 637d38355c..d09e6d2dc5 100644
--- a/testcases/realtime/func/pi-tests/testpi-6.c
+++ b/testcases/realtime/func/pi-tests/testpi-6.c
@@ -39,7 +39,7 @@
 #include <pthread.h>
 #include <string.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 pthread_mutex_t child_mutex;
 
diff --git a/testcases/realtime/func/pi-tests/testpi-7.c b/testcases/realtime/func/pi-tests/testpi-7.c
index 20908b6621..499898775d 100644
--- a/testcases/realtime/func/pi-tests/testpi-7.c
+++ b/testcases/realtime/func/pi-tests/testpi-7.c
@@ -40,7 +40,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
+#include "librttest.h"
 
 #define HIGH_PRIO 15
 #define MED_PRIO 10
diff --git a/testcases/realtime/func/pi_perf/pi_perf.c b/testcases/realtime/func/pi_perf/pi_perf.c
index 45cf8ed157..fa87839f62 100644
--- a/testcases/realtime/func/pi_perf/pi_perf.c
+++ b/testcases/realtime/func/pi_perf/pi_perf.c
@@ -47,8 +47,8 @@
 #include <unistd.h>
 #include <string.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define LOWPRIO 30
 #define HIGHPRIO 40
diff --git a/testcases/realtime/func/prio-preempt/prio-preempt.c b/testcases/realtime/func/prio-preempt/prio-preempt.c
index 16abc11846..2728337631 100644
--- a/testcases/realtime/func/prio-preempt/prio-preempt.c
+++ b/testcases/realtime/func/prio-preempt/prio-preempt.c
@@ -68,7 +68,7 @@
 #include <sched.h>
 #include <errno.h>
 #include <sys/syscall.h>
-#include <librttest.h>
+#include "librttest.h"
 
 #define NUM_WORKERS	27
 #define CHECK_LIMIT	1
diff --git a/testcases/realtime/func/prio-wake/prio-wake.c b/testcases/realtime/func/prio-wake/prio-wake.c
index 8b3bee7b82..94eea0f41a 100644
--- a/testcases/realtime/func/prio-wake/prio-wake.c
+++ b/testcases/realtime/func/prio-wake/prio-wake.c
@@ -53,8 +53,8 @@
 #include <sched.h>
 #include <errno.h>
 #include <sys/syscall.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 volatile int running_threads = 0;
 static int rt_threads = 0;
diff --git a/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c b/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c
index dc3dd3e81a..48cbffb873 100644
--- a/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c
+++ b/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c
@@ -51,8 +51,8 @@
 #include <sched.h>
 #include <signal.h>
 #include <errno.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define PRIO 89
 #define ITERATIONS 10000
diff --git a/testcases/realtime/func/rt-migrate/rt-migrate.c b/testcases/realtime/func/rt-migrate/rt-migrate.c
index 252e77e6a6..2a17628f44 100644
--- a/testcases/realtime/func/rt-migrate/rt-migrate.c
+++ b/testcases/realtime/func/rt-migrate/rt-migrate.c
@@ -67,8 +67,8 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define gettid() syscall(__NR_gettid)
 
diff --git a/testcases/realtime/func/sched_jitter/sched_jitter.c b/testcases/realtime/func/sched_jitter/sched_jitter.c
index 9989528953..d1fba431b9 100644
--- a/testcases/realtime/func/sched_jitter/sched_jitter.c
+++ b/testcases/realtime/func/sched_jitter/sched_jitter.c
@@ -47,8 +47,8 @@
 #include <pthread.h>
 #include <sched.h>
 #include <unistd.h>
-#include <libstats.h>
-#include <librttest.h>
+#include "libstats.h"
+#include "librttest.h"
 
 #define NUMRUNS 1000
 #define NUMLOOPS 1000000
diff --git a/testcases/realtime/func/sched_latency/sched_latency.c b/testcases/realtime/func/sched_latency/sched_latency.c
index d19d5889a0..49d253b3c3 100644
--- a/testcases/realtime/func/sched_latency/sched_latency.c
+++ b/testcases/realtime/func/sched_latency/sched_latency.c
@@ -49,8 +49,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #define PRIO 89
 //#define PERIOD 17*NS_PER_MS
diff --git a/testcases/realtime/func/thread_clock/tc-2.c b/testcases/realtime/func/thread_clock/tc-2.c
index f994d40d61..323fbd1250 100644
--- a/testcases/realtime/func/thread_clock/tc-2.c
+++ b/testcases/realtime/func/thread_clock/tc-2.c
@@ -46,7 +46,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 #define NS_PER_SEC 1000000000
 #define THRESHOLD 0.5		/* 500 milliseconds */
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 7e81635efd..764398179d 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -40,8 +40,8 @@
  *
  *****************************************************************************/
 
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/testcases/realtime/lib/libstats.c b/testcases/realtime/lib/libstats.c
index 96090bd152..52b0cca6e8 100644
--- a/testcases/realtime/lib/libstats.c
+++ b/testcases/realtime/lib/libstats.c
@@ -43,8 +43,8 @@
 #include <errno.h>
 #include <unistd.h>
 #include <math.h>
-#include <libstats.h>
-#include <librttest.h>
+#include "libstats.h"
+#include "librttest.h"
 
 int save_stats = 0;
 
diff --git a/testcases/realtime/perf/latency/pthread_cond_latency.c b/testcases/realtime/perf/latency/pthread_cond_latency.c
index d0048d5e42..c1b64b20a1 100644
--- a/testcases/realtime/perf/latency/pthread_cond_latency.c
+++ b/testcases/realtime/perf/latency/pthread_cond_latency.c
@@ -41,7 +41,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdlib.h>
-#include <librttest.h>
+#include "librttest.h"
 
 pthread_mutex_t child_mutex = PTHREAD_MUTEX_INITIALIZER;
 volatile int child_waiting = 0;
diff --git a/testcases/realtime/perf/latency/pthread_cond_many.c b/testcases/realtime/perf/latency/pthread_cond_many.c
index 9c6a897299..2bc9c1ed3b 100644
--- a/testcases/realtime/perf/latency/pthread_cond_many.c
+++ b/testcases/realtime/perf/latency/pthread_cond_many.c
@@ -44,8 +44,8 @@
 #include <sys/poll.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <librttest.h>
-#include <libstats.h>
+#include "librttest.h"
+#include "libstats.h"
 #define PASS_US 100
 pthread_mutex_t child_mutex;
 volatile int *child_waiting = NULL;
diff --git a/testcases/realtime/stress/pi-tests/lookup_pi_state.c b/testcases/realtime/stress/pi-tests/lookup_pi_state.c
index 83781d80e2..1799892aa6 100644
--- a/testcases/realtime/stress/pi-tests/lookup_pi_state.c
+++ b/testcases/realtime/stress/pi-tests/lookup_pi_state.c
@@ -34,7 +34,7 @@
  *****************************************************************************/
 
 #include <stdio.h>
-#include <librttest.h>
+#include "librttest.h"
 
 #define NUM_SLAVES 20
 #define SLAVE_PRIO 89
diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c b/testcases/realtime/stress/pi-tests/testpi-3.c
index 1c3d44452c..70ec94513c 100644
--- a/testcases/realtime/stress/pi-tests/testpi-3.c
+++ b/testcases/realtime/stress/pi-tests/testpi-3.c
@@ -41,7 +41,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <librttest.h>
+#include "librttest.h"
 
 void usage(void)
 {
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
