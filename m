Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4139C3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 11:39:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50E2F3D1D61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 13:39:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A8C43D1BDA
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:39:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 974D11400770
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:39:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71DAE1F790;
 Mon, 29 Jul 2024 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722253172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K0gEnp2y5UWmsCVXcBjGnRi08Mt7O765n1QqIDEXdxM=;
 b=mJXMlycyXs7cYnsDKlRoJ/qRZdqf4cjvRzkSK4ldnJ9Ql4KYGv0b6cuA/y999/vd3F1Pbx
 knHzzXGValzPM8MhIb185S4t4HQzAZgSg+ODMIgzktA7fP9XothJarsfkh7urwYuEeWcmW
 FCpgCXwtUYfx6/cAv9XPrQIP7kAFAMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722253172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K0gEnp2y5UWmsCVXcBjGnRi08Mt7O765n1QqIDEXdxM=;
 b=x/mqWwbz4PwJgHXuSk1/jaICHHqDdY9AswZtGRCvboRGjxzurcQpPLc8lG6iKhGzJQl+MR
 lDFR+1r3ziYtFtDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mJXMlycy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="x/mqWwbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722253172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K0gEnp2y5UWmsCVXcBjGnRi08Mt7O765n1QqIDEXdxM=;
 b=mJXMlycyXs7cYnsDKlRoJ/qRZdqf4cjvRzkSK4ldnJ9Ql4KYGv0b6cuA/y999/vd3F1Pbx
 knHzzXGValzPM8MhIb185S4t4HQzAZgSg+ODMIgzktA7fP9XothJarsfkh7urwYuEeWcmW
 FCpgCXwtUYfx6/cAv9XPrQIP7kAFAMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722253172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K0gEnp2y5UWmsCVXcBjGnRi08Mt7O765n1QqIDEXdxM=;
 b=x/mqWwbz4PwJgHXuSk1/jaICHHqDdY9AswZtGRCvboRGjxzurcQpPLc8lG6iKhGzJQl+MR
 lDFR+1r3ziYtFtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 519691368A;
 Mon, 29 Jul 2024 11:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0x8aEnR/p2aANAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 11:39:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jul 2024 13:39:26 +0200
Message-ID: <20240729113927.1250531-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 71DAE1F790
X-Spamd-Result: default: False [-1.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; SUBJECT_HAS_CURRENCY(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] sched_football: Install to the default
 $LTPROOT/testcases/bin
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

Fixes: 3a8e38fc2c ("runtest/sched: Add sched_football")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/func/sched_football/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/func/sched_football/Makefile b/testcases/realtime/func/sched_football/Makefile
index 9bc779efad..aac98eab60 100644
--- a/testcases/realtime/func/sched_football/Makefile
+++ b/testcases/realtime/func/sched_football/Makefile
@@ -6,10 +6,11 @@
 
 top_srcdir		?= ../../../..
 
-INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 
+INSTALL_DIR=testcases/bin
+
 # TODO: integrate properly with LTP library
 LDLIBS			+= -lltp
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
