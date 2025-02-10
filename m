Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1174C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:36:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13C643C98B0
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:36:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE71D3C98A1
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4DECA2228F9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BA7621157;
 Mon, 10 Feb 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Kf317XG1CU4VjGWNXjFhZdCyNTxYh8NdhxdfOV/VTc=;
 b=1jn1bVnsdg2NqjqGbOdud6g3iZ+8msCXsRpxyrc4dJKyGKhLrC+q7e4bSbzB0AS9pPpllJ
 frvjyHKJyY3kxT+W9Ed/3GTAwpVtb2mSDVf8O7ZQ0SfZl0VWLS8WATal38pGPNDLPtauS6
 E7+QFtjAjxYyI6ami6R+MpgX0jsLC+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Kf317XG1CU4VjGWNXjFhZdCyNTxYh8NdhxdfOV/VTc=;
 b=5pOXr7wFTPVJWjHZurtTsTdjqVhKMFQDRYYEPFw8BcEIzffeqJKLONZFYZz7hJK8y0TROi
 zxQJWpSaEViTIUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Kf317XG1CU4VjGWNXjFhZdCyNTxYh8NdhxdfOV/VTc=;
 b=1jn1bVnsdg2NqjqGbOdud6g3iZ+8msCXsRpxyrc4dJKyGKhLrC+q7e4bSbzB0AS9pPpllJ
 frvjyHKJyY3kxT+W9Ed/3GTAwpVtb2mSDVf8O7ZQ0SfZl0VWLS8WATal38pGPNDLPtauS6
 E7+QFtjAjxYyI6ami6R+MpgX0jsLC+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Kf317XG1CU4VjGWNXjFhZdCyNTxYh8NdhxdfOV/VTc=;
 b=5pOXr7wFTPVJWjHZurtTsTdjqVhKMFQDRYYEPFw8BcEIzffeqJKLONZFYZz7hJK8y0TROi
 zxQJWpSaEViTIUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DE7313A62;
 Mon, 10 Feb 2025 11:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zEBnAr7jqWcGYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:11 +0100
Message-ID: <20250210113212.29520-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/13] mem/hugetlb: Remove mem/lib depenency
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
