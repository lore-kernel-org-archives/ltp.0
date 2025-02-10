Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D5EC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:36:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69CF03C98AF
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:36:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6736F3C98A9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:15 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D89ED62E775
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 749EE1F390;
 Mon, 10 Feb 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPsepYMhSYlTWlmmy/Z1DyE7aZ03KwqX3YH5WOAwEi4=;
 b=o/2Y8MVjoV2890BMpRPmNELWL3S5xmJg7UEf9jH6GVV8h4Axius5ip5HC9PqZt6aa+1Mf4
 /VVVZ3ih0OandLPU4Aegv/1bBqPBRFaEo2+Jbe8D6zpfYPCUDAPinIk7O9iJI0TSGmVYzd
 kR4AGQWQBlcxLAqckGhk8vc46TV44UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPsepYMhSYlTWlmmy/Z1DyE7aZ03KwqX3YH5WOAwEi4=;
 b=YSzbSdyUvlQyDxMDCipPVmh7AKTYsg/u+HJRKS6PD7UR9S4utG/ZFESTY+76UhhTs1MqxH
 MOlmEqWWMO89F+AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="o/2Y8MVj";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YSzbSdyU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPsepYMhSYlTWlmmy/Z1DyE7aZ03KwqX3YH5WOAwEi4=;
 b=o/2Y8MVjoV2890BMpRPmNELWL3S5xmJg7UEf9jH6GVV8h4Axius5ip5HC9PqZt6aa+1Mf4
 /VVVZ3ih0OandLPU4Aegv/1bBqPBRFaEo2+Jbe8D6zpfYPCUDAPinIk7O9iJI0TSGmVYzd
 kR4AGQWQBlcxLAqckGhk8vc46TV44UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPsepYMhSYlTWlmmy/Z1DyE7aZ03KwqX3YH5WOAwEi4=;
 b=YSzbSdyUvlQyDxMDCipPVmh7AKTYsg/u+HJRKS6PD7UR9S4utG/ZFESTY+76UhhTs1MqxH
 MOlmEqWWMO89F+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 670FC13A62;
 Mon, 10 Feb 2025 11:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uq9RGL7jqWcIYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:12 +0100
Message-ID: <20250210113212.29520-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 749EE1F390
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/13] testcases/kernel/mem: Remove library
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

Now that the last bits of the library are unused we can remove it
safely.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/include/libmem.mk | 43 --------------------------
 testcases/kernel/mem/include/mem.h     | 25 ---------------
 testcases/kernel/mem/lib/Makefile      | 27 ----------------
 testcases/kernel/mem/lib/mem.c         | 30 ------------------
 4 files changed, 125 deletions(-)
 delete mode 100644 testcases/kernel/mem/include/libmem.mk
 delete mode 100644 testcases/kernel/mem/include/mem.h
 delete mode 100644 testcases/kernel/mem/lib/Makefile
 delete mode 100644 testcases/kernel/mem/lib/mem.c

diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
deleted file mode 100644
index b6d45f0fc..000000000
--- a/testcases/kernel/mem/include/libmem.mk
+++ /dev/null
@@ -1,43 +0,0 @@
-#
-#  Copyright (C) 2012  Red Hat, Inc.
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-MEM_SRCDIR		:= $(abs_top_srcdir)/testcases/kernel/mem
-LIBMEM_SRCDIR		:= $(MEM_SRCDIR)/lib
-
-MEM_DIR			:= $(top_builddir)/testcases/kernel/mem
-LIBMEM_DIR		:= $(MEM_DIR)/lib
-LIBMEM			:= $(LIBMEM_DIR)/libmem.a
-FILTER_OUT_DIRS		:= $(LIBMEM_DIR)
-CFLAGS			+= -I$(MEM_SRCDIR)/include -pthread
-LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
-LDFLAGS			+= -L$(LIBMEM_DIR)
-
-$(LIBMEM_DIR):
-	mkdir -p "$@"
-
-$(LIBMEM): $(LIBMEM_DIR)
-	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" all
-
-MAKE_DEPS		+= $(LIBMEM)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBMEM_DIR)
-	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" clean
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
deleted file mode 100644
index 25389f34c..000000000
--- a/testcases/kernel/mem/include/mem.h
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) Linux Test Project, 2011-2021
- */
-#ifndef _MEM_H
-#define _MEM_H
-#include "config.h"
-#include "tst_test.h"
-#include "ksm_helper.h"
-#include "tst_memutils.h"
-
-#define MB			(1UL<<20)
-#define KB			(1UL<<10)
-#define PATH_SYSVM		"/proc/sys/vm/"
-#define PATH_MEMINFO		"/proc/meminfo"
-
-/* KSM */
-
-/* HUGETLB */
-
-#define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
-
-void write_memcg(void);
-
-#endif
diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib/Makefile
deleted file mode 100644
index d4624e9b0..000000000
--- a/testcases/kernel/mem/lib/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#  Copyright (C) 2010  Red Hat, Inc.
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-CPPFLAGS		+= -I$(abs_srcdir)/../include
-INTERNAL_LIB		:= libmem.a
-
-include $(top_srcdir)/testcases/kernel/include/lib.mk
-include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
deleted file mode 100644
index 4e5c0b873..000000000
--- a/testcases/kernel/mem/lib/mem.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#define TST_NO_DEFAULT_MAIN
-
-#include "config.h"
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <sys/param.h>
-#include <errno.h>
-#include <fcntl.h>
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
-#include <pthread.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include "mem.h"
-#include "numa_helper.h"
-
-
-/* KSM */
-
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
