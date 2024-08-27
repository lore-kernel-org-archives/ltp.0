Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4890C54734
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 12:04:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14F373D264F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 14:04:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04A653D264F
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 14:03:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A122E608A78
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 14:03:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E59421B0D
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724760234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBZTsxC1O+ITnWIEiUd4Po49/zPPtCjkE0XwVvTXNvM=;
 b=NJJRoW/pkhZxwcM8ShCQSOGIolZYInfbYBnfOcDIReBlYfbh/D7zEAn3oIoH82vzZu430r
 8SWE0Vihu4AFDdaZYzNcJleJV8K60pfZzKf6bnIIsjI3fFQzf5aST4QLmvKDOYRoLPHVxC
 E8sPSEKSEdrcRz+7GJyd687mHNsGVL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724760234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBZTsxC1O+ITnWIEiUd4Po49/zPPtCjkE0XwVvTXNvM=;
 b=xs22ny+BstRWDr6pTo3NMXTEHmY109npzVoGOpPr1TiiEpg0RoeA4/dnesTKKypY7a7s3T
 lYHGb0KYMy6zOcDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="NJJRoW/p";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xs22ny+B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724760234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBZTsxC1O+ITnWIEiUd4Po49/zPPtCjkE0XwVvTXNvM=;
 b=NJJRoW/pkhZxwcM8ShCQSOGIolZYInfbYBnfOcDIReBlYfbh/D7zEAn3oIoH82vzZu430r
 8SWE0Vihu4AFDdaZYzNcJleJV8K60pfZzKf6bnIIsjI3fFQzf5aST4QLmvKDOYRoLPHVxC
 E8sPSEKSEdrcRz+7GJyd687mHNsGVL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724760234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBZTsxC1O+ITnWIEiUd4Po49/zPPtCjkE0XwVvTXNvM=;
 b=xs22ny+BstRWDr6pTo3NMXTEHmY109npzVoGOpPr1TiiEpg0RoeA4/dnesTKKypY7a7s3T
 lYHGb0KYMy6zOcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89AE513A94
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 12:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PWWUIKrAzWYUWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 12:03:54 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 27 Aug 2024 14:02:34 +0200
Message-ID: <20240827120237.25805-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120237.25805-1-chrubis@suse.cz>
References: <20240827120237.25805-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9E59421B0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] include: tst_clone.h: Fix possible MUSL build
 failures
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

The problem is that on musl sched.h exposes clone() when _GNU_SOURCE is
defined and at the same time sched.h does not get pulled before
tst_clone.h gets included, which means that the macro from tst_clone.h
that rewrites clone() functions actually rewrites the function
declaration in the system header.

We remove the tst_clone.h from the old library because the newly
included sched.h causes conflicts in the cpuset/cpuset_lib/ directory
and the tst_clone.h header is used only in a single old library test
i.e. clone02.c.

This commit is needed in order to avoid build failures in the next
commits that add support for the shell test library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/test.h                        | 1 -
 include/tst_clone.h                       | 2 ++
 testcases/kernel/syscalls/clone/clone02.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/old/test.h b/include/old/test.h
index 0e210e4ef..306868fb5 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -31,7 +31,6 @@
 #include "tst_pid.h"
 #include "tst_cmd.h"
 #include "tst_cpu.h"
-#include "tst_clone.h"
 #include "old_device.h"
 #include "old_tmpdir.h"
 #include "tst_minmax.h"
diff --git a/include/tst_clone.h b/include/tst_clone.h
index 56f23142d..a57d761ca 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -5,6 +5,8 @@
 #ifndef TST_CLONE_H__
 #define TST_CLONE_H__
 
+#include <sched.h>
+
 #ifdef TST_TEST_H__
 
 /* The parts of clone3's clone_args we support */
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index 821adc2d9..fd3ee1aed 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -59,6 +59,7 @@
 #include <sched.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_clone.h"
 
 #define FLAG_ALL (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGCHLD)
 #define FLAG_NONE SIGCHLD
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
