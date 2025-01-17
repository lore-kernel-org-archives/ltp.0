Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD57C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:25:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 330D83C7C54
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:25:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02F4F3C088F
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:25:07 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 320311BDB44B
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:25:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 090091F387
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737116705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V0ExaHWf4T4wMvp8GUfL3sldxUd9nsVq/fGiQruxpA=;
 b=N4z3bWdlTHAoCdpK0lsq3czMvfzN0ZFwk0ZVXL6bWviu4e5LcXmhkyijbNLuxffAmC9O9F
 mjqUHsMchdBgVKX/Ya13Rmfw7lTk6YfLRp2nhc6+Y8Z/GgfaaVuFFcSJ4YNyS8IlwzW5Ed
 NdpXl+JrcdtPa4p/EYk+LJBQksdANLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737116705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V0ExaHWf4T4wMvp8GUfL3sldxUd9nsVq/fGiQruxpA=;
 b=tmejrvZ098xIXaoE3X8eOvBb9a7efiTLxE2DoNZFGiekMsI1SwiwqnG4wUE/pcFbLreZRP
 5bk+8s2Q7TXpRaAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cc4OwUSe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8ib9i+wY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737116704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V0ExaHWf4T4wMvp8GUfL3sldxUd9nsVq/fGiQruxpA=;
 b=Cc4OwUSeO3eJMDf7H9XM+sEVWNnpNu2p59sbEisL+sRfHRNTi3sjFBtHHz+t1oqd9NcGmN
 cJbTBt6KIJpJR0sjqAxEi0UoGOoIW2p893q/VLAzrZg+W4S4RiK05eq2+AC3+vRUNOg5c/
 7BvgCo6ILtUdt9wq2pAhTmajF4fY9S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737116704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V0ExaHWf4T4wMvp8GUfL3sldxUd9nsVq/fGiQruxpA=;
 b=8ib9i+wYrqLi+cNm+ndCaKFUqRoFwG1qPfr2T9ncLHaezLCQzRgsySRnI4bMRkGmvxJ855
 YViQpJF2Ayq3ZcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA40313A30
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SvAhOB9MimcJSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:25:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 13:24:55 +0100
Message-ID: <20250117122455.7989-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117122455.7989-1-chrubis@suse.cz>
References: <20250117122455.7989-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 090091F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] testcases/lib: tst_net.sh: Do not use stderr in
 tst_rhost_run()
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

This is another place that broke the network test on the unrelated
changes that caused the SAFE_CLONE() to produce TINFO messages. The test
library prints messages into the stdout, because this is something that
is not supposed to be the command output but rather diagnostic messages.
So there was no good reason to include the stderr in the data we got
from the tst_rhost_run().

If this patch does not break anything it should be pushed since this
will fix the tst_ns_* helpers even if the they start print diagnostics
TINFO messages again.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ee0ae1cad..60bc25b79 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -257,7 +257,7 @@ tst_rhost_run()
 		tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
 	fi
 
-	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
+	output=$($rcmd "$sh_cmd" $out || echo 'RTERR')
 
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
