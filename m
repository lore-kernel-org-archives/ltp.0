Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E873C27C4F
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 13:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 188AF3D116C
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 15:30:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74A4D3C1A00
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 15:30:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7108F100F4D8
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 15:30:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93E491FB60;
 Wed, 26 Jun 2024 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719408613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ILDPhg5j/VwcM4jgIMsmBJeyMQZpOeaFH5BV+TtdFqA=;
 b=KwMoarIgix4tiZubtplGGepBXHMomofAq6mPaPWmheiiqob0ut1b9VkK1FQwXzz+POPhgn
 AVGKBL9cMWk/VI427mm8M1oS33lyPCfd3ZRviEeGRjLzCI/yWN8yIsjcgTBO7Pm1p0NLav
 /R5flK8YiWUiAzvbWSivTBXXmBcNmTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719408613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ILDPhg5j/VwcM4jgIMsmBJeyMQZpOeaFH5BV+TtdFqA=;
 b=NZPHPqCEbp78yJiLgWMooacc8E2vMki2WFWaluhamihcl/fBAZs5lAYCXL8Eae2HUVHyPK
 jL661R5vHsT/RWCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719408613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ILDPhg5j/VwcM4jgIMsmBJeyMQZpOeaFH5BV+TtdFqA=;
 b=KwMoarIgix4tiZubtplGGepBXHMomofAq6mPaPWmheiiqob0ut1b9VkK1FQwXzz+POPhgn
 AVGKBL9cMWk/VI427mm8M1oS33lyPCfd3ZRviEeGRjLzCI/yWN8yIsjcgTBO7Pm1p0NLav
 /R5flK8YiWUiAzvbWSivTBXXmBcNmTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719408613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ILDPhg5j/VwcM4jgIMsmBJeyMQZpOeaFH5BV+TtdFqA=;
 b=NZPHPqCEbp78yJiLgWMooacc8E2vMki2WFWaluhamihcl/fBAZs5lAYCXL8Eae2HUVHyPK
 jL661R5vHsT/RWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EDB113AAD;
 Wed, 26 Jun 2024 13:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z75qHuUXfGYrQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Jun 2024 13:30:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jun 2024 15:30:04 +0200
Message-ID: <20240626133004.15810-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] include/tst_timer: Add TST_NO_LIBLTP
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
Cc: John Stultz <jstultz@google.com>, kernel-team@android.com,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Older compilers (gcc-4.8) are not smart enough to eliminate the
impossible branch with tst_brk() early enough and the sched_football
compilation fails due to the unresolved function.

Add TST_NO_LIBLTP macro that changes the tst_brk() messages into abort()
and make use of it in sched_football.

Fixes compilation on Leap-42.2.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_timer.h                              | 16 ++++++++++++++++
 .../func/sched_football/sched_football.c         |  1 +
 2 files changed, 17 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 6fb940020..fc0cdb5bc 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -180,7 +180,11 @@ static inline void *tst_ts_get(struct tst_ts *t)
 	case TST_KERN_TIMESPEC:
 		return &t->ts.kern_ts;
 	default:
+#ifndef TST_NO_LIBLTP
 		tst_brk(TBROK, "Invalid type: %d", t->type);
+#else
+		abort();
+#endif
 		return NULL;
 	}
 }
@@ -196,7 +200,11 @@ static inline void *tst_its_get(struct tst_its *t)
 	case TST_KERN_TIMESPEC:
 		return &t->ts.kern_its;
 	default:
+#ifndef TST_NO_LIBLTP
 		tst_brk(TBROK, "Invalid type: %d", t->type);
+#else
+		abort();
+#endif
 		return NULL;
 	}
 }
@@ -395,7 +403,11 @@ static inline long long tst_ts_get_sec(struct tst_ts ts)
 	case TST_KERN_TIMESPEC:
 		return ts.ts.kern_ts.tv_sec;
 	default:
+#ifndef TST_NO_LIBLTP
 		tst_brk(TBROK, "Invalid type: %d", ts.type);
+#else
+		abort();
+#endif
 		return -1;
 	}
 }
@@ -413,7 +425,11 @@ static inline long long tst_ts_get_nsec(struct tst_ts ts)
 	case TST_KERN_TIMESPEC:
 		return ts.ts.kern_ts.tv_nsec;
 	default:
+#ifndef TST_NO_LIBLTP
 		tst_brk(TBROK, "Invalid type: %d", ts.type);
+#else
+		abort();
+#endif
 		return -1;
 	}
 }
diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index b6ae692af..6846978f4 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -74,6 +74,7 @@
 #include <librttest.h>
 #include <tst_atomic.h>
 #define TST_NO_DEFAULT_MAIN
+#define TST_NO_LIBLTP
 #include <tst_timer.h>
 
 
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
