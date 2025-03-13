Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39E2C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 13:06:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 803AB3CA4E5
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 14:06:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAFB53CA509
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 14:04:39 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F8C7100094F
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 14:04:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF8FA21199;
 Thu, 13 Mar 2025 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741871053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=DcN+TFkUXd3kwLbQ1lX6FzjoePyXquq6iD/zfk9qTWlriSeJAKJogHsaimYdWail9ehnid
 oqwK10s9TPrAQenF8r0XN3zV+m3uQeATvtpyYYaTjFgKSBDyUt1J0TY0ZFcZrk5g4Twgxy
 ihuEaylDW79+1qWszoeRFTLPzM77E2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741871053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=uubzF1oSWkhxf9f9jdZmY+0I2ZoC7N2rIAOQlTEKKPaDpFegUY585WDBPRVkHSoQ4qQMAy
 bP8BsZG5JDbErfAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DcN+TFkU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uubzF1oS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741871053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=DcN+TFkUXd3kwLbQ1lX6FzjoePyXquq6iD/zfk9qTWlriSeJAKJogHsaimYdWail9ehnid
 oqwK10s9TPrAQenF8r0XN3zV+m3uQeATvtpyYYaTjFgKSBDyUt1J0TY0ZFcZrk5g4Twgxy
 ihuEaylDW79+1qWszoeRFTLPzM77E2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741871053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=uubzF1oSWkhxf9f9jdZmY+0I2ZoC7N2rIAOQlTEKKPaDpFegUY585WDBPRVkHSoQ4qQMAy
 bP8BsZG5JDbErfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC92D13A38;
 Thu, 13 Mar 2025 13:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2MEuLc3X0mcncwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Mar 2025 13:04:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 13 Mar 2025 14:04:02 +0100
MIME-Version: 1.0
Message-Id: <20250313-mmap_suite_refactoring-v4-7-efd682ece39a@suse.com>
References: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
In-Reply-To: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741871052; l=673;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=c2VWtn0+9MdwiaRTk2UGHsP9jvZaSyVL6ka4qYo14kg=;
 b=XMyAF4gn0QBLPRFjmuJX9HCCgQnxdS8MwpEEzQHV3oLzLocSjKQsyxnDp7om8fnw6p5SNu/er
 11/kDpiQtFrB/ULVLu+Hdi+QUmeZtBlh+uCNvljgiDcybGNvajYp/cN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: CF8FA21199
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 7/8] Cleanup mmap20 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap20.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap20.c b/testcases/kernel/syscalls/mmap/mmap20.c
index 09dea8c41d2687031cce7ded90cf10d2ab392a5b..f8e5129d1e490b931f0668bd2fe8ea89c64d0404 100644
--- a/testcases/kernel/syscalls/mmap/mmap20.c
+++ b/testcases/kernel/syscalls/mmap/mmap20.c
@@ -10,9 +10,6 @@
  * flag and invalid flag.
  */
 
-#include <errno.h>
-#include <stdio.h>
-#include <sys/types.h>
 #include "tst_test.h"
 #include "lapi/mmap.h"
 

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
