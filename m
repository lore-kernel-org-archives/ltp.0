Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52957C3DA6E
	for <ltp@archiver.kernel.org>; Wed, 20 Dec 2023 14:51:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D04A3CF29E
	for <ltp@archiver.kernel.org>; Wed, 20 Dec 2023 15:51:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B5403C9F00
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 15:50:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C76A1A0C247
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 15:50:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 326B12209B;
 Wed, 20 Dec 2023 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703083852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Eu9mDmpEcYeoFsDiUKceRVOf/j9uAHpAvK4sTOqyYM=;
 b=wVR6uNCkE4bYvZbqtlJDw88smcU+Ai84UEBy08EITfReIRNAEXREFJXYG+9wsUPSq65yw1
 NJa6oTMzT9QkXOuSvPp/wg68covMBpQR4a1W4AtPorxcHDEPf6yf9uXqVwBo8boUzrx1fM
 0R28sS6Ebf8IeB9Cn73C3gdL41r59cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703083852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Eu9mDmpEcYeoFsDiUKceRVOf/j9uAHpAvK4sTOqyYM=;
 b=u325WzVRtKMrL/1UDHf+bo1OXS4pky5/fyj966xbXj8EQ+UJVPZOAXPv8RuH4vb/L8PXr3
 JDEGJNxE+dlp5KCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703083852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Eu9mDmpEcYeoFsDiUKceRVOf/j9uAHpAvK4sTOqyYM=;
 b=wVR6uNCkE4bYvZbqtlJDw88smcU+Ai84UEBy08EITfReIRNAEXREFJXYG+9wsUPSq65yw1
 NJa6oTMzT9QkXOuSvPp/wg68covMBpQR4a1W4AtPorxcHDEPf6yf9uXqVwBo8boUzrx1fM
 0R28sS6Ebf8IeB9Cn73C3gdL41r59cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703083852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Eu9mDmpEcYeoFsDiUKceRVOf/j9uAHpAvK4sTOqyYM=;
 b=u325WzVRtKMrL/1UDHf+bo1OXS4pky5/fyj966xbXj8EQ+UJVPZOAXPv8RuH4vb/L8PXr3
 JDEGJNxE+dlp5KCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D18F913722;
 Wed, 20 Dec 2023 14:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NEBbL0v/gmVzJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Dec 2023 14:50:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Dec 2023 15:50:47 +0100
Message-ID: <20231220145047.422491-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wVR6uNCk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u325WzVR
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 326B12209B
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] oom*: Turn docs to docparse
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I removed the paragraph which was the same for all tests, which is
generally good, but IMHO outdated (originates from 0db55077f in 2011,
e.g. 3 GB was in lib/oom.h #define LENGTH (3UL<<30), but the file was
removed in 4e217a398). Also tests differs, but the text is the same.

@Li If you have time, feel free to add more test description and push it
with yourself as the author.

Kind regards,
Petr

 testcases/kernel/mem/oom/oom01.c | 13 +++++--------
 testcases/kernel/mem/oom/oom02.c | 13 +++++--------
 testcases/kernel/mem/oom/oom03.c | 13 +++++--------
 testcases/kernel/mem/oom/oom04.c | 13 +++++--------
 testcases/kernel/mem/oom/oom05.c | 13 +++++--------
 5 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index c30f2da0c..903785f93 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -1,16 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Out Of Memory (OOM)
- *
- * The program is designed to cope with unpredictable like amount and
- * system physical memory, swap size and other VMM technology like KSM,
- * memcg, memory hotplug and so on which may affect the OOM
- * behaviours. It simply increase the memory consumption 3G each time
- * until all the available memory is consumed and OOM is triggered.
- *
  * Copyright (C) 2010-2017  Red Hat, Inc.
  * Copyright (c) Linux Test Project, 2011-2023
  */
+/*\
+ * [Description]
+ *
+ * Out Of Memory (OOM) test
+ */
 
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 7606260b5..087d61abe 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -1,16 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Out Of Memory (OOM) for mempolicy - need NUMA system support
- *
- * The program is designed to cope with unpredictable like amount and
- * system physical memory, swap size and other VMM technology like KSM,
- * memcg, memory hotplug and so on which may affect the OOM
- * behaviours. It simply increase the memory consumption 3G each time
- * until all the available memory is consumed and OOM is triggered.
- *
  * Copyright (C) 2010-2017  Red Hat, Inc.
  * Copyright (c) Linux Test Project, 2011-2023
  */
+/*\
+ * [Description]
+ *
+ * Out Of Memory (OOM) test for mempolicy - need NUMA system support
+ */
 
 #include "config.h"
 #include <sys/types.h>
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 6b9693359..1041a6a1d 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -1,16 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Out Of Memory (OOM) for Memory Resource Controller
- *
- * The program is designed to cope with unpredictable like amount and
- * system physical memory, swap size and other VMM technology like KSM,
- * memcg, memory hotplug and so on which may affect the OOM
- * behaviours. It simply increase the memory consumption 3G each time
- * until all the available memory is consumed and OOM is triggered.
- *
  * Copyright (C) 2010-2017  Red Hat, Inc.
  * Copyright (c) Linux Test Project, 2011-2023
  */
+/*\
+ * [Description]
+ *
+ * Out Of Memory (OOM) test for Memory Resource Controller
+ */
 
 #include "config.h"
 #include <sys/types.h>
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 418aa476d..3f0bcf7e2 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -1,16 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Out Of Memory (OOM) for CPUSET
- *
- * The program is designed to cope with unpredictable like amount and
- * system physical memory, swap size and other VMM technology like KSM,
- * memcg, memory hotplug and so on which may affect the OOM
- * behaviours. It simply increase the memory consumption 3G each time
- * until all the available memory is consumed and OOM is triggered.
- *
  * Copyright (C) 2010-2017  Red Hat, Inc.
  * Copyright (c) Linux Test Project, 2011-2023
  */
+/*\
+ * [Description]
+ *
+ * Out Of Memory (OOM) test for CPUSET
+ */
 
 #include "config.h"
 #include <sys/types.h>
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index f360fa5a1..74f0f78b3 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -1,16 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Out Of Memory (OOM) for MEMCG and CPUSET
- *
- * The program is designed to cope with unpredictable like amount and
- * system physical memory, swap size and other VMM technology like KSM,
- * memcg, memory hotplug and so on which may affect the OOM
- * behaviours. It simply increase the memory consumption 3G each time
- * until all the available memory is consumed and OOM is triggered.
- *
  * Copyright (C) 2013-2017  Red Hat, Inc.
  * Copyright (c) Linux Test Project, 2014-2023
  */
+/*\
+ * [Description]
+ *
+ * Out Of Memory (OOM) test for MEMCG and CPUSET
+ */
 
 #include "config.h"
 #include <sys/types.h>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
