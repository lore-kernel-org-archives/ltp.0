Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFFCCA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 14:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45D653CC8B2
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 16:07:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C2923C0639
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 16:06:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7ECA7600453
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 16:06:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B59B621233
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755526017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uIWssLNR6k11ll76O85I+B/t1CeEDvjGKx0mLk5ukTw=;
 b=QUysNvYHuFhyoPHnufUBirGuynaehtz3prsqSJWC9cID7+dy70cjXeF3GY7j/iEdObnGbc
 kbWoeNVNpTUUyJxlpuFpWY5dWjPt6LReiywvc2ZX6wfjjyZc7QEbwBCgsYoKHeK2jhdr7v
 T0AV3KTyfH1i/9fudpHnEK42l+/G6LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755526017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uIWssLNR6k11ll76O85I+B/t1CeEDvjGKx0mLk5ukTw=;
 b=ZtExEpN9GS1PDgFoRlFhX5j2QxXDd6pqAiLJ7OBRvMjnp/oKxXV2wISNM4jR7uM+bjlcXM
 cV+MlkSgCUODiIDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755526017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uIWssLNR6k11ll76O85I+B/t1CeEDvjGKx0mLk5ukTw=;
 b=QUysNvYHuFhyoPHnufUBirGuynaehtz3prsqSJWC9cID7+dy70cjXeF3GY7j/iEdObnGbc
 kbWoeNVNpTUUyJxlpuFpWY5dWjPt6LReiywvc2ZX6wfjjyZc7QEbwBCgsYoKHeK2jhdr7v
 T0AV3KTyfH1i/9fudpHnEK42l+/G6LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755526017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uIWssLNR6k11ll76O85I+B/t1CeEDvjGKx0mLk5ukTw=;
 b=ZtExEpN9GS1PDgFoRlFhX5j2QxXDd6pqAiLJ7OBRvMjnp/oKxXV2wISNM4jR7uM+bjlcXM
 cV+MlkSgCUODiIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A874813A55
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 14:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M8aXKIEzo2gQFQAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 14:06:57 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Aug 2025 16:06:54 +0200
Message-ID: <20250818140657.10351-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] define TST_MAX_CLOCKS to account MAX_AUX_CLOCKS also
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

Starting kernel v6.17, syscall tests clock_adjtime02, clock_gettime02,
clock_settime02 and timer_create02 fails in verifying expected errno
for invalid clock IDs, returning ENODEV instead of expected EINVAL.

clock_gettime02.c:133: TFAIL: clock_gettime(2): clock INVALID/UNKNOWN CLOCK failed unexpectedly: ENODEV (19)
clock_gettime02.c:133: TFAIL: clock_gettime(2): clock INVALID/UNKNOWN CLOCK failed unexpectedly: ENODEV (19)

This started as a result of these commits [1], [2] and [3], which
introduced auxiliary POSIX clocks, so when kernel has POSIX_AUX_CLOCKS
option enabled, invalid IDs being used in tests refer to AUX clock IDs.

To fix the tests, define TST_MAX_CLOCKS to also account MAX_AUX_CLOCKS
when trying invalid clock IDs.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9094c72c3d81bf2416b7c79d12c8494ab8fbac20
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=606424bf4ffd9d27865c45b5707c1edac6b187ed
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60ecc26ec5af567a55f362ad92c0cac8b894541c

Closes #1255

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 include/lapi/common_timers.h                             | 9 +++++++++
 .../kernel/syscalls/clock_adjtime/clock_adjtime02.c      | 4 ++--
 .../kernel/syscalls/clock_gettime/clock_gettime02.c      | 4 ++--
 .../kernel/syscalls/clock_settime/clock_settime02.c      | 4 ++--
 testcases/kernel/syscalls/timer_create/timer_create02.c  | 2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index 884c997a1..f68cea811 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -7,6 +7,7 @@
 #ifndef LAPI_COMMON_TIMERS_H__
 #define LAPI_COMMON_TIMERS_H__
 
+#include <linux/version.h>
 #include "config.h"
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
@@ -30,6 +31,14 @@ static const clock_t clock_list[] = {
 /* MAX_CLOCKS is the maximum number of clock sources supported by kernel */
 #define MAX_CLOCKS 16
 
+#define MAX_AUX_CLOCKS 8
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 17, 0)
+#define TST_MAX_CLOCKS (MAX_CLOCKS + MAX_AUX_CLOCKS)
+#else
+#define TST_MAX_CLOCKS (MAX_CLOCKS)
+#endif
+
 #define CLOCK_TO_STR(def_name)	\
 	case def_name:		\
 		return #def_name;
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
index 2df9099d5..0c5e6ac21 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -76,11 +76,11 @@ struct test_case {
 
 struct test_case tc[] = {
 	{
-	 .clktype = MAX_CLOCKS,
+	 .clktype = TST_MAX_CLOCKS,
 	 .exp_err = EINVAL,
 	},
 	{
-	 .clktype = MAX_CLOCKS + 1,
+	 .clktype = TST_MAX_CLOCKS + 1,
 	 .exp_err = EINVAL,
 	},
 	{
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index 0108bb426..1e1769864 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -34,11 +34,11 @@ struct test_case {
 
 static struct test_case tc[] = {
 	{
-	 .clktype = MAX_CLOCKS,
+	 .clktype = TST_MAX_CLOCKS,
 	 .exp_err = EINVAL,
 	 },
 	{
-	 .clktype = MAX_CLOCKS + 1,
+	 .clktype = TST_MAX_CLOCKS + 1,
 	 .exp_err = EINVAL,
 	 },
 	/*
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 5974e79a9..9d703565b 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -59,11 +59,11 @@ struct test_case tc[] = {
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 06: MAXCLOCK		      */
-	 .type = MAX_CLOCKS,
+	 .type = TST_MAX_CLOCKS,
 	 .exp_err = EINVAL,
 	 },
 	{				/* case 07: MAXCLOCK+1		      */
-	 .type = MAX_CLOCKS + 1,
+	 .type = TST_MAX_CLOCKS + 1,
 	 .exp_err = EINVAL,
 	 },
 	/* Linux specific */
diff --git a/testcases/kernel/syscalls/timer_create/timer_create02.c b/testcases/kernel/syscalls/timer_create/timer_create02.c
index 551cf50b9..9f41c683d 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create02.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create02.c
@@ -52,7 +52,7 @@ static struct testcase {
 } tcases[] = {
 	{CLOCK_REALTIME, NULL, &timer_id, EFAULT, "invalid sigevent struct"},
 	{CLOCK_REALTIME, &sig_ev, NULL, EFAULT, "invalid timer ID"},
-	{MAX_CLOCKS, &sig_ev, &timer_id, EINVAL, "invalid clock"},
+	{TST_MAX_CLOCKS, &sig_ev, &timer_id, EINVAL, "invalid clock"},
 	{CLOCK_REALTIME, &sig_ev_inv_not, &timer_id, EINVAL, "wrong sigev_notify"},
 	{CLOCK_REALTIME, &sig_ev_inv_sig, &timer_id, EINVAL, "wrong sigev_signo"},
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
