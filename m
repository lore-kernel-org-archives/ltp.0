Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BD2CDB47E
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 11:09:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE3923CD055
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 13:09:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAA3D3CD00B
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 13:09:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1CF71A0C279
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 13:09:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DD501F45B;
 Fri, 20 Oct 2023 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697800162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o//S29i7uPpBcvuY9FntiVlwKdM1veHohmiHT4sXRU=;
 b=ppsSycV6TO8oIasHgqZTZ/2xJ4txphExpX3fImCAwfM5NK4NjPRLGQTiI8H5COGftYbXwc
 60E7uu50d80JuKO45oOnP8HWB9YJd08yn+d6N1VXnrZWCOJgifiN7x68h8Pv3w9l5Fkikm
 0l0zOaWPTxt+X4qz4tWbXrhoWeuINlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697800162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o//S29i7uPpBcvuY9FntiVlwKdM1veHohmiHT4sXRU=;
 b=naOLADp6uNS4opT2C3wriO1rC7yn3n3W+9DJXafv9ZreSdhvgQo80xrAy9/JcSCqjAKdZK
 qJRgoHKeMtcaR+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B74C139C2;
 Fri, 20 Oct 2023 11:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UP+oDOJfMmXZZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 Oct 2023 11:09:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 Oct 2023 13:09:18 +0200
Message-ID: <20231020110918.26066-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020110918.26066-1-pvorel@suse.cz>
References: <20231020110918.26066-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.66 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(2.76)[92.59%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] setsockopt10: Use lapi/{socket,
 tcp}.h to fix compilation
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Distros with glibc-2.26 and older will fail due missing SOL_TLS
in <sys/socket.h> and TCP_ULP in <netinet/tcp.h>. Use fallback
definitions in lapi/socket.h and lapi/tcp.h.

Also replace quotes ("") with sharp brackets (<>) for <netinet/in.h>
(it's a system header, the same was for netinet/tcp.h, but it was
replaced with lapi).

Fixes: bdb37aab9 ("Add setsockopt10 TLS ULP UAF CVE-2023-0461")
Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/setsockopt/setsockopt10.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
index afd2c40a1..4e7e44938 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
@@ -49,10 +49,11 @@
 #ifdef HAVE_LINUX_TLS_H
 
 #include <linux/tls.h>
-#include "netinet/in.h"
-#include "netinet/tcp.h"
+#include <netinet/in.h>
 
 #include "lapi/sched.h"
+#include "lapi/socket.h"
+#include "lapi/tcp.h"
 #include "tst_checkpoint.h"
 #include "tst_net.h"
 #include "tst_safe_net.h"
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
