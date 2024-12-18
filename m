Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB48FE77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:49:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 824D73ED624
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:49:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEC313ED5EB
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:31 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34DE165E7F1
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF7AE21164;
 Wed, 18 Dec 2024 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuQvwkAmHuUwbQQsqB9nwMGAXXGONCb4XT3/IoQJZGk=;
 b=DqHPCviN8YogO3X0pLQIGqBCG1JYfPBrLxSd4RL8BNcKpyV9rJ8vYVBJD9ZLSVsjBuyv4h
 prRs/BWrDCwCmr+vknPkDjhwk27lqlAYH55+xHCWWVUMsKqcfGwYRdR5yJQ0AZW+3fXeQi
 Fr7s32FOb4oQyb6GrQJ4LMHGv57tIyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuQvwkAmHuUwbQQsqB9nwMGAXXGONCb4XT3/IoQJZGk=;
 b=pxNKzIhiF/kUl4B1ENHCcvqdB0fObuqZFg2bCgAWtG302W48eLTLc7cclLFSmBV/frW7PN
 AhfEab0qkZE+FgCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DqHPCviN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pxNKzIhi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuQvwkAmHuUwbQQsqB9nwMGAXXGONCb4XT3/IoQJZGk=;
 b=DqHPCviN8YogO3X0pLQIGqBCG1JYfPBrLxSd4RL8BNcKpyV9rJ8vYVBJD9ZLSVsjBuyv4h
 prRs/BWrDCwCmr+vknPkDjhwk27lqlAYH55+xHCWWVUMsKqcfGwYRdR5yJQ0AZW+3fXeQi
 Fr7s32FOb4oQyb6GrQJ4LMHGv57tIyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuQvwkAmHuUwbQQsqB9nwMGAXXGONCb4XT3/IoQJZGk=;
 b=pxNKzIhiF/kUl4B1ENHCcvqdB0fObuqZFg2bCgAWtG302W48eLTLc7cclLFSmBV/frW7PN
 AhfEab0qkZE+FgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE43137CF;
 Wed, 18 Dec 2024 18:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gm22JUoYY2eCcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 18:45:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 19:45:17 +0100
Message-ID: <20241218184518.16190-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218184518.16190-1-chrubis@suse.cz>
References: <20241218184518.16190-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AF7AE21164
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/13] mem/hugetlb: Remove mem/lib depenency
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

The last bit used from the library PATH_SHMMAX macro.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/hugetlb/Makefile.inc          | 3 ---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 1 -
 testcases/kernel/mem/hugetlb/lib/Makefile          | 1 -
 testcases/kernel/mem/hugetlb/lib/hugetlb.h         | 3 ++-
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
index 9a4aa8795..b272e62a8 100644
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ b/testcases/kernel/mem/hugetlb/Makefile.inc
@@ -33,6 +33,3 @@ CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
 LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
 LDLIBS			+= -lhugetlb
 MAKE_DEPS		+= $(LIBIPC)
-
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
-# vim: syntax=make
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index d5983fc55..75f28102d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -34,7 +34,6 @@ static char path_sys_sz_huge[BUFSIZ];
 #define PATH_PROC_VM		"/proc/sys/vm/"
 #define PATH_PROC_OVER		PATH_PROC_VM "nr_overcommit_hugepages"
 #define PATH_PROC_HUGE		PATH_PROC_VM "nr_hugepages"
-#define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
 
 /* Only ia64 requires this */
 #ifdef __ia64__
diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile b/testcases/kernel/mem/hugetlb/lib/Makefile
index ceccd2615..45606b17f 100644
--- a/testcases/kernel/mem/hugetlb/lib/Makefile
+++ b/testcases/kernel/mem/hugetlb/lib/Makefile
@@ -4,7 +4,6 @@
 top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 
 INTERNAL_LIB		:= libhugetlb.a
 
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index abc88e25e..22975c99a 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include "tst_test.h"
-#include "mem.h"
 
 #define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
 
@@ -29,6 +28,8 @@
 #define SHM_HUGETLB	04000	/* segment is mapped via hugetlb */
 #endif
 
+#define PATH_SHMMAX "/proc/sys/kernel/shmmax"
+
 #ifndef barrier
 # ifdef mb
 	/* Redefining the mb() */
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
