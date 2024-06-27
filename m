Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BA7C3064D
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 13:35:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5EDF3D1301
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 15:35:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BF403D1166
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 15:35:09 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E48F81400767
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 15:35:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D4EA21B86;
 Thu, 27 Jun 2024 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719495307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xvk2LLBcoAPM+IC5BbdhDbjGgElvoXsh4ozzL8VGmd0=;
 b=NwuwjcqsavU7gE3w7qysFJmSh4RYViS45mBcvh3HA3vjvy3dkgU5zt3Zlnk04BQExuTULu
 7KOls56qcmrhpjnDEKLFGg2RW8UCwvWTb5z7FSDtuQhx86HmQXuNBr5OfF73T/+t5QyXNr
 qVCg6n6VpL3awpZOSGzCKfIPzJ+a8Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719495307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xvk2LLBcoAPM+IC5BbdhDbjGgElvoXsh4ozzL8VGmd0=;
 b=JUoY/cGEwphGZ8k9ntHGBjcIFKsbC1UdCmlEewAXSPNEkHvLiAh7wf15uK2YoAywy8Un3t
 DcAei6R7bnVy+KBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nwuwjcqs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="JUoY/cGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719495307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xvk2LLBcoAPM+IC5BbdhDbjGgElvoXsh4ozzL8VGmd0=;
 b=NwuwjcqsavU7gE3w7qysFJmSh4RYViS45mBcvh3HA3vjvy3dkgU5zt3Zlnk04BQExuTULu
 7KOls56qcmrhpjnDEKLFGg2RW8UCwvWTb5z7FSDtuQhx86HmQXuNBr5OfF73T/+t5QyXNr
 qVCg6n6VpL3awpZOSGzCKfIPzJ+a8Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719495307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xvk2LLBcoAPM+IC5BbdhDbjGgElvoXsh4ozzL8VGmd0=;
 b=JUoY/cGEwphGZ8k9ntHGBjcIFKsbC1UdCmlEewAXSPNEkHvLiAh7wf15uK2YoAywy8Un3t
 DcAei6R7bnVy+KBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 019941384C;
 Thu, 27 Jun 2024 13:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HXdxOopqfWYOZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 13:35:06 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Jun 2024 15:34:56 +0200
Message-ID: <20240627133456.11327-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1D4EA21B86
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] include/tst_timer: Add TST_NO_LIBLTP
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

Add TST_NO_LIBLTP macro that adds tst_brk_() inline implementaiont that
prints the message and calls abort() and make use of it in sched_football.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                            | 23 +++++++++++++++++++
 .../func/sched_football/sched_football.c      |  1 +
 2 files changed, 24 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 8dc20d110..9bd1b363d 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -648,4 +648,27 @@ int main(int argc, char *argv[])
 #define TST_TEST_TCONF(message)                                 \
         static struct tst_test test = { .tconf_msg = message  } \
 
+/*
+ * Fallback for cases where we do not want to link against ltp library.
+ *
+ * This allows us for instance to use tst_timer.h without LTP library.
+ */
+#ifdef TST_NO_LIBLTP
+__attribute__ ((format (printf, 4, 5)))
+inline void tst_brk_(const char *file, const int lineno, int ttype,
+                     const char *fmt, ...)
+{
+	va_list va;
+
+	(void) ttype;
+
+	fprintf(stderr, "%s: %i: ", file, lineno);
+	va_start(va, fmt);
+	vfprintf(stderr, fmt, va);
+	va_end(va);
+
+	abort();
+}
+#endif
+
 #endif	/* TST_TEST_H__ */
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
