Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950D2C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 20:12:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22D493CF95C
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 22:12:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9344D3CEDE2
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:11:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD7751001F20
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:11:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED5141FEB4;
 Tue, 24 Oct 2023 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698178300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNHoUdF9jkm1nXo1gih+X6AmWZ1nBtFbRkJExTflHec=;
 b=OrFt+ynBnYKfd9lFaqCHyG67aXk5ZQbOZc5mpw+s5ZDlFhOSMSF0E234rAH3totQFKOn6K
 9yWDSUtV9QPqzOprBwP8ewBQgMd67GWlLNj7/YlcU0cbYUvCIEx41O5+fdRn5iwDHTT8fp
 I0C7475sLY+Jc7148xdD11Yntsj4EGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698178300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNHoUdF9jkm1nXo1gih+X6AmWZ1nBtFbRkJExTflHec=;
 b=FL1p+3ncO9ncIKqHO6QLvzEJX2JhMQB2dvwKycu11WiiTr+5kJG+uJI6ADx5rakDhm2RWB
 4AtEYkAUad6AUoCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D25201391C;
 Tue, 24 Oct 2023 20:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IAK3MPskOGVmVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 20:11:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Oct 2023 22:11:35 +0200
Message-ID: <20231024201135.264768-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024201135.264768-1-pvorel@suse.cz>
References: <20231024201135.264768-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] input_helper: Fix compilation on CentOS 7
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

Include lapi/uinput.h to fix compilation on CentOS 7
(the oldest distro in our CI). The actual functionality of the test was
not tested.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/input/input_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index 58bb9ee10..c929de6ba 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -25,6 +25,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "input_helper.h"
+#include "lapi/uinput.h"
 
 #define VIRTUAL_DEVICE "virtual-device-ltp"
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
