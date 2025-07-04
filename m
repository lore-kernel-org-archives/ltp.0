Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2301BC83F03
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 08:43:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BB183C9D1D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 10:43:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57AF43C68DA
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 10:43:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6484214010D8
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 10:43:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F3061F454
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751618612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxUuKxbhA7CuO1CMS6tW3XT1kzdgvHiPIyv7eQsNCrU=;
 b=y59fo5CE0VfSc90IVQHQ61Xeaxt1WfXlcRiF5NUcztvJTKF326fe95mrT29jmDw1I8Oavq
 zQBUzp3IZxj++lU2HL0c+xiLPUvWDGhTt9CDLf96dgx/qesIzrQkhY6TMbU0gkPIweSvze
 wh5W0Tza4ltGx3iu795BftHaT5ZifNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751618612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxUuKxbhA7CuO1CMS6tW3XT1kzdgvHiPIyv7eQsNCrU=;
 b=YKwmv44XLwJrkXdE5kTg1tQjSJRmo8SbCJCcQ2hAHYAKd++YHvaIyMkcIL3fmPxHzw077q
 fLCesobhxw6zfRCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VXE8PTZ1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ikCe0JrV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751618610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxUuKxbhA7CuO1CMS6tW3XT1kzdgvHiPIyv7eQsNCrU=;
 b=VXE8PTZ1rwDx9vL4Oz72evLY96d8+5yKcGScGSDmWwp8Ag2poIq1miAsZ0HW0gYVqbYwdv
 u8cxSXbmby6UYCihD1x6EwRV59WwdZ63VbixusSzWg7S1tSo76C8mZDm1wWyyKC4w2Dulg
 c5FO5lQLlAW61XtgmkYSCvBfMKve+Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751618610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxUuKxbhA7CuO1CMS6tW3XT1kzdgvHiPIyv7eQsNCrU=;
 b=ikCe0JrVDvmjVmPwr17Q0Df3/MzwQkxgnpIgHub5KtG+wnUlBMz55GGUj++GxGVY+9wQdA
 NQy0SRvRmkoTl2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65A1B13A71
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 08:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1sKJGDKUZ2jbFwAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 08:43:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  4 Jul 2025 10:43:26 +0200
Message-ID: <20250704084330.17896-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7F3061F454
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] crash02: remove verbose option from runtest file
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

we have removed support for verbose option -v in the rewrite of crash02

Fixes: 16cd67ef1 (misc: rewrite crash02 test)
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/crashme | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/crashme b/runtest/crashme
index 7a630916b..af45d29bc 100644
--- a/runtest/crashme
+++ b/runtest/crashme
@@ -7,6 +7,6 @@ f00f f00f
 crash01 crash01
 # Generate random code and execute it. Read f00f comment,
 # this test lockup SunOS,WindowsNT,etc. in seconds..
-crash02 crash02 -v 2
+crash02 crash02
 # Fork as many children as possible.  On systems with lots of memory
 # and kernels prior to 2.4.19, this can hang the system by using up all pids
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
