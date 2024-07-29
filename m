Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B5AC3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 11:40:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4274D3D1D70
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 13:40:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7EC43D1BDA
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:39:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BAAA601568
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:39:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4DE021B19;
 Mon, 29 Jul 2024 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722253172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9t/y5GnxxRGv38F9Ld8P0gww6h8kH5EYg5gwS/h6E+0=;
 b=bEUScvIneNNenX6koyVMm+rvGjx3PoOl6HxWeGf7KL90umaoIHfZFH8uXXbWYKKCX9ZakH
 3FEjwfYdazFXzlP8D3PP+pRryQG8Lu7PBjiR0cz9Nj9yJK7gx26k74jdspczaRD39ax2nb
 YsZoGOJYsUFfqzirX8g40UqWBVHJMy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722253172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9t/y5GnxxRGv38F9Ld8P0gww6h8kH5EYg5gwS/h6E+0=;
 b=Lwr0fU+rExa13Z2ump+LAj0uhW1YYM7nE86l4VuOq+LcXmlkbH5L8x6B8qPaQ/wivG2W0l
 7fRy/uExRnuaBfDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bEUScvIn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Lwr0fU+r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722253172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9t/y5GnxxRGv38F9Ld8P0gww6h8kH5EYg5gwS/h6E+0=;
 b=bEUScvIneNNenX6koyVMm+rvGjx3PoOl6HxWeGf7KL90umaoIHfZFH8uXXbWYKKCX9ZakH
 3FEjwfYdazFXzlP8D3PP+pRryQG8Lu7PBjiR0cz9Nj9yJK7gx26k74jdspczaRD39ax2nb
 YsZoGOJYsUFfqzirX8g40UqWBVHJMy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722253172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9t/y5GnxxRGv38F9Ld8P0gww6h8kH5EYg5gwS/h6E+0=;
 b=Lwr0fU+rExa13Z2ump+LAj0uhW1YYM7nE86l4VuOq+LcXmlkbH5L8x6B8qPaQ/wivG2W0l
 7fRy/uExRnuaBfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C4E21397F;
 Mon, 29 Jul 2024 11:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BolHXR/p2aANAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 11:39:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jul 2024 13:39:27 +0200
Message-ID: <20240729113927.1250531-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729113927.1250531-1-pvorel@suse.cz>
References: <20240729113927.1250531-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C4DE021B19
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] sched_football: Remove run_auto.sh helper script
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

Script is unused since uninstalled since previous commit.

realtime tests needs to be properly integrated to LTP anyway or moved to
rt-tests. See https://github.com/linux-test-project/ltp/issues/1078.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/func/sched_football/run_auto.sh | 14 --------------
 1 file changed, 14 deletions(-)
 delete mode 100755 testcases/realtime/func/sched_football/run_auto.sh

diff --git a/testcases/realtime/func/sched_football/run_auto.sh b/testcases/realtime/func/sched_football/run_auto.sh
deleted file mode 100755
index 7e0703acf8..0000000000
--- a/testcases/realtime/func/sched_football/run_auto.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-
-profile=${1:-default}
-
-cd $(dirname $0) # Move to test directory
-if [ ! $SCRIPTS_DIR ]; then
-        # assume we're running standalone
-        export SCRIPTS_DIR=../../scripts/
-fi
-
-. $SCRIPTS_DIR/setenv.sh
-
-# Warning: tests args are now set in profiles
-$SCRIPTS_DIR/run_c_files.sh $profile sched_football
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
