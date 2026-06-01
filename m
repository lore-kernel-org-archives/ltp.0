Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D2ACD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13B03E56DE
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:21:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9250F3E56EA
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC71C1400554
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33F5D6BB53
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uifFp4Yg98bYDRxMFQE6LLv7udAloSjZqchfnbiUbs=;
 b=WkItJC4yTPMB/lB7khIooCIxX98uSZfJtHER5e//h9GyqoH82z/+OZ5zelBH7P3S0kwCE4
 8/QBfMwll8S4XvY4crdN6X8Y+LlFZh3t9VYbQdlWS0lgBA0SO3qIr/FygCP1PDp+BeEU3l
 CeOIBwlePHshSh5ScLn6mzn5twEqj50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uifFp4Yg98bYDRxMFQE6LLv7udAloSjZqchfnbiUbs=;
 b=pteGdvh58krRbP0WDbhh72+PA4KLJIk7+Sl1fqQRpqNoS+g6Qj62BPB5BUZSpmYvXNn6nj
 jrUcZfg2Lkhf3qBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uifFp4Yg98bYDRxMFQE6LLv7udAloSjZqchfnbiUbs=;
 b=WkItJC4yTPMB/lB7khIooCIxX98uSZfJtHER5e//h9GyqoH82z/+OZ5zelBH7P3S0kwCE4
 8/QBfMwll8S4XvY4crdN6X8Y+LlFZh3t9VYbQdlWS0lgBA0SO3qIr/FygCP1PDp+BeEU3l
 CeOIBwlePHshSh5ScLn6mzn5twEqj50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uifFp4Yg98bYDRxMFQE6LLv7udAloSjZqchfnbiUbs=;
 b=pteGdvh58krRbP0WDbhh72+PA4KLJIk7+Sl1fqQRpqNoS+g6Qj62BPB5BUZSpmYvXNn6nj
 jrUcZfg2Lkhf3qBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B65779A9
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wF6vCTyHHWp2OwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 13:21:00 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Jun 2026 15:20:47 +0200
Message-ID: <20260601132055.58728-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601132055.58728-1-mdoucha@suse.cz>
References: <20260601132055.58728-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] xfrm01: Use NETDEV_SET_STATE() to activate
 loopback
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 testcases/network/sockets/xfrm01.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
index b0353a724..c9001cdcd 100644
--- a/testcases/network/sockets/xfrm01.c
+++ b/testcases/network/sockets/xfrm01.c
@@ -27,6 +27,7 @@
 
 #include "tst_test.h"
 #include "tst_net.h"
+#include "tst_netdevice.h"
 #include "lapi/udp.h"
 #include "lapi/splice.h"
 
@@ -72,14 +73,7 @@ static void setup(void)
 	int i, ret;
 
 	tst_setup_netns();
-
-	const char *const lo_cmd[] = {
-		"ip", "link", "set", "lo", "up", NULL
-	};
-
-	ret = tst_cmd(lo_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (ret)
-		tst_brk(TBROK, "Failed to bring up loopback interface");
+	NETDEV_SET_STATE("lo", 1);
 
 	keyhex[0] = '0';
 	keyhex[1] = 'x';
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
