Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF37DC27C77
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 09:13:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00F3B3D0BB8
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 11:13:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BD033D00C7
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 11:13:17 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B37221001193
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 11:13:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57C8E34180;
 Wed, 12 Jun 2024 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718183593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=90ZwcvEZKy/dY2kGggFt342GF0yjYtRFjzPylze3urU=;
 b=EsVJ1N7S6zrDTCkwTwBZxuXQIaljw9v2GFG9mmwHBpgVY5FRJHZTLMLk7UddPZwKDajy3y
 Uti1pkUjdsatQsihzxif5kHiA0y4Oc9WbRM4ZnRBv0/M3Q7SsYaYhDf0L+h8F/NnQtBbbb
 FOMrSTflwL7s8KNjxEOW3A5nHPyN7Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718183593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=90ZwcvEZKy/dY2kGggFt342GF0yjYtRFjzPylze3urU=;
 b=T+cihgL88HReyymeu6c3tojVeh9Ax518ROawU32gTMWCqwyVzOwHQFjwjE6b27ntg2Plfg
 jE2eXn0TdpAS23AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718183592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=90ZwcvEZKy/dY2kGggFt342GF0yjYtRFjzPylze3urU=;
 b=UL9xQ66SypKgqZnPLXHN4O3v6cJc5IlEtlOkfkQfk3HbYoXqhmO8DpfOwJQ6nZr7RHXDy0
 XspFA1H+Rzk0FaoNKibljADkOwlie7Ax9C1sBZx6wbOLaT31xLzIvl33o9xpTFLVJtt5/I
 stx8sGA1pDI2HAdUQKQZ5K0X9c5G6uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718183592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=90ZwcvEZKy/dY2kGggFt342GF0yjYtRFjzPylze3urU=;
 b=nxBN4+M2WYm7ixUzEu9ZxVFXTKP/vCpyHZ36Hftyo4MsIJUq0OsRlhfWUA4D0eXntM0Sr0
 /Ia5K0mGscfvPkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 418EC137DF;
 Wed, 12 Jun 2024 09:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xw6PDqhmaWbAaQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Jun 2024 09:13:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Jun 2024 11:12:56 +0200
Message-ID: <20240612091256.4931-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] [PATCH] sched: starvation: Autocallibrate the timeout
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
Cc: Steve <xufeifei1@oppo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Instead of hardcoding the values we attempt to measure the CPU speed and
set the timeout accordingly. Given that the difference in the duration
of the test when the kernel is buggy is about 30x we do not have to have
a precise callibration, just very rough estimate if we are running on a
server or small ARM board would suffice.

So we attempt to measure how long does a bussy loop take and base the
default timeout on that. On x86_64 CPUs the resulting timeout is about
double of the value of the actual test runtime and works fine, but we
need to make sure that the coeficient we divide the result from
callibrate works for small boards too. So please run the test on as many
machines as you can and report if we need to make the dividor smaller or
not.

CC: Steve <xufeifei1@oppo.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/sched/cfs-scheduler/starvation.c   | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index eb9fd6ff5..94175fdd1 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -21,11 +21,42 @@
 #include <sched.h>
 
 #include "tst_test.h"
+#include "tst_safe_clocks.h"
+#include "tst_timer.h"
 
 static char *str_loop;
-static long loop = 2000000;
+static long loop = 1000000;
 static char *str_timeout;
-static int timeout = 240;
+static int timeout;
+
+#define CALLIBRATE_LOOPS 100000000
+
+static int callibrate(void)
+{
+	volatile int counter;
+	struct timespec start, stop;
+	long long diff;
+
+	counter = CALLIBRATE_LOOPS;
+	do
+		counter--;
+	while (counter > 0);
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
+
+	counter = CALLIBRATE_LOOPS;
+	do
+		counter--;
+	while (counter > 0);
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &stop);
+
+	diff = tst_timespec_diff_us(stop, start);
+
+	tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
+
+	return diff;
+}
 
 static int wait_for_pid(pid_t pid)
 {
@@ -59,8 +90,11 @@ static void setup(void)
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
 
-	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
+	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX)) {
 		tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
+	} else {
+		timeout = callibrate() / 1000;
+	}
 
 	tst_set_max_runtime(timeout);
 }
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
