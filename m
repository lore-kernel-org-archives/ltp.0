Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3999AC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 11:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97D7A3CFD1F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 13:02:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E12F23CF276
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 13:02:37 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DC2F141EA22
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 13:02:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 742F15C187;
 Fri, 19 Apr 2024 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713524555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sVUF7H2R7aeLym1xDC3XlFDahXu8I2biHZm2SDk0ltk=;
 b=oGc0wYK8ez/35HHxdRvTdtHb5LQ+JA1tJew6bxp+lBS7EV3ndZQPoliH2FpW76kSaqyMu8
 v/WIr4qyr+Z12QnoOqo2YzdNsQueKss1dMGaWnHfImQFYXDLHTFne0nY3wJIqIIrbrFklO
 Bu3noB5Ib18CMBlhD/CKi8+lpb1/o2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713524555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sVUF7H2R7aeLym1xDC3XlFDahXu8I2biHZm2SDk0ltk=;
 b=vCV14y/TFdXhN5bzQn/BL47qDjYSUQ/agpjQlymsmpz/+QTK5CYBA0u/ACfHydKHFjLwml
 7Crx0Rb6HR9GXkBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oGc0wYK8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="vCV14y/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713524555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sVUF7H2R7aeLym1xDC3XlFDahXu8I2biHZm2SDk0ltk=;
 b=oGc0wYK8ez/35HHxdRvTdtHb5LQ+JA1tJew6bxp+lBS7EV3ndZQPoliH2FpW76kSaqyMu8
 v/WIr4qyr+Z12QnoOqo2YzdNsQueKss1dMGaWnHfImQFYXDLHTFne0nY3wJIqIIrbrFklO
 Bu3noB5Ib18CMBlhD/CKi8+lpb1/o2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713524555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sVUF7H2R7aeLym1xDC3XlFDahXu8I2biHZm2SDk0ltk=;
 b=vCV14y/TFdXhN5bzQn/BL47qDjYSUQ/agpjQlymsmpz/+QTK5CYBA0u/ACfHydKHFjLwml
 7Crx0Rb6HR9GXkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF59A13687;
 Fri, 19 Apr 2024 11:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8rJgLUlPImYuIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 11:02:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 13:02:30 +0200
Message-ID: <20240419110230.191809-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 742F15C187
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] libs: Remove 'libltp' prefix from libs source
 directories
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

LTP internal libraries are located in libs/ directory. There is no need
to keep 'libltp' prefix in their own directories. NOTE: resulted
libraries (*.a) keep expected 'libltp' prefix.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Li, Cyril,

I know renaming files is not optimal. But history will be kept, when
browsing with gitk or git gui.

Improvement: less typing when cd to the directory.

Tested:
https://github.com/pevik/ltp/actions/runs/8752048451

Kind regards,
Petr

 include/mk/testcases.mk                            | 6 +++---
 libs/{libltpipc => ipc}/Makefile                   | 0
 libs/{libltpipc => ipc}/libipc.c                   | 0
 libs/{libltpipc => ipc}/libmsgctl.c                | 0
 libs/{libltpnewipc => newipc}/Makefile             | 0
 libs/{libltpnewipc => newipc}/libnewipc.c          | 0
 libs/{libltpnuma => numa}/Makefile                 | 0
 libs/{libltpnuma => numa}/tst_numa.c               | 0
 libs/{libltpsigwait => sigwait}/Makefile           | 0
 libs/{libltpsigwait => sigwait}/sigwait.c          | 0
 libs/{libltpswap => swap}/Makefile                 | 0
 libs/{libltpswap => swap}/libswap.c                | 0
 libs/{libltpuinput => uinput}/Makefile             | 0
 libs/{libltpuinput => uinput}/tst_uinput.c         | 0
 libs/{libltpvdso => vdso}/Makefile                 | 0
 libs/{libltpvdso => vdso}/README                   | 0
 libs/{libltpvdso => vdso}/parse_vdso.c             | 0
 libs/{libltpvdso => vdso}/vdso_helpers.c           | 0
 testcases/kernel/mem/ksm/Makefile                  | 2 +-
 testcases/kernel/syscalls/clock_gettime/Makefile   | 2 +-
 testcases/kernel/syscalls/get_mempolicy/Makefile   | 2 +-
 testcases/kernel/syscalls/ipc/msgctl/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/msgget/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/msgrcv/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/Makefile   | 2 +-
 testcases/kernel/syscalls/ipc/semctl/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/semget/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/semop/Makefile       | 2 +-
 testcases/kernel/syscalls/ipc/shmat/Makefile       | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/Makefile      | 2 +-
 testcases/kernel/syscalls/ipc/shmdt/Makefile       | 2 +-
 testcases/kernel/syscalls/ipc/shmget/Makefile      | 2 +-
 testcases/kernel/syscalls/kill/Makefile            | 2 +-
 testcases/kernel/syscalls/mbind/Makefile           | 2 +-
 testcases/kernel/syscalls/mremap/Makefile          | 2 +-
 testcases/kernel/syscalls/rt_sigtimedwait/Makefile | 2 +-
 testcases/kernel/syscalls/set_mempolicy/Makefile   | 2 +-
 testcases/kernel/syscalls/sigtimedwait/Makefile    | 2 +-
 testcases/kernel/syscalls/sigwait/Makefile         | 2 +-
 testcases/kernel/syscalls/sigwaitinfo/Makefile     | 2 +-
 testcases/kernel/syscalls/swapoff/Makefile         | 2 +-
 testcases/kernel/syscalls/swapon/Makefile          | 2 +-
 testcases/kernel/uevents/Makefile                  | 2 +-
 44 files changed, 29 insertions(+), 29 deletions(-)
 rename libs/{libltpipc => ipc}/Makefile (100%)
 rename libs/{libltpipc => ipc}/libipc.c (100%)
 rename libs/{libltpipc => ipc}/libmsgctl.c (100%)
 rename libs/{libltpnewipc => newipc}/Makefile (100%)
 rename libs/{libltpnewipc => newipc}/libnewipc.c (100%)
 rename libs/{libltpnuma => numa}/Makefile (100%)
 rename libs/{libltpnuma => numa}/tst_numa.c (100%)
 rename libs/{libltpsigwait => sigwait}/Makefile (100%)
 rename libs/{libltpsigwait => sigwait}/sigwait.c (100%)
 rename libs/{libltpswap => swap}/Makefile (100%)
 rename libs/{libltpswap => swap}/libswap.c (100%)
 rename libs/{libltpuinput => uinput}/Makefile (100%)
 rename libs/{libltpuinput => uinput}/tst_uinput.c (100%)
 rename libs/{libltpvdso => vdso}/Makefile (100%)
 rename libs/{libltpvdso => vdso}/README (100%)
 rename libs/{libltpvdso => vdso}/parse_vdso.c (100%)
 rename libs/{libltpvdso => vdso}/vdso_helpers.c (100%)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 444020f16..bec8d8cc4 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -44,8 +44,8 @@ LDLIBS		+= -lltp
 
 ifdef LTPLIBS
 
-LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/lib, $(LTPLIBS))
-LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),lib$(LIB)/lib$(LIB))))
+LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/, $(LTPLIBS))
+LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),$(LIB)/lib$(LIB))))
 
 MAKE_DEPS += $(LTPLIBS_FILES)
 
@@ -61,7 +61,7 @@ else
 	@$(MAKE) --no-print-directory -C "$(dir $@)" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$(dir $@))/Makefile" all
 endif
 
-LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
+LDFLAGS += $(addprefix -L$(top_builddir)/libs/, $(LTPLIBS))
 
 endif
 
diff --git a/libs/libltpipc/Makefile b/libs/ipc/Makefile
similarity index 100%
rename from libs/libltpipc/Makefile
rename to libs/ipc/Makefile
diff --git a/libs/libltpipc/libipc.c b/libs/ipc/libipc.c
similarity index 100%
rename from libs/libltpipc/libipc.c
rename to libs/ipc/libipc.c
diff --git a/libs/libltpipc/libmsgctl.c b/libs/ipc/libmsgctl.c
similarity index 100%
rename from libs/libltpipc/libmsgctl.c
rename to libs/ipc/libmsgctl.c
diff --git a/libs/libltpnewipc/Makefile b/libs/newipc/Makefile
similarity index 100%
rename from libs/libltpnewipc/Makefile
rename to libs/newipc/Makefile
diff --git a/libs/libltpnewipc/libnewipc.c b/libs/newipc/libnewipc.c
similarity index 100%
rename from libs/libltpnewipc/libnewipc.c
rename to libs/newipc/libnewipc.c
diff --git a/libs/libltpnuma/Makefile b/libs/numa/Makefile
similarity index 100%
rename from libs/libltpnuma/Makefile
rename to libs/numa/Makefile
diff --git a/libs/libltpnuma/tst_numa.c b/libs/numa/tst_numa.c
similarity index 100%
rename from libs/libltpnuma/tst_numa.c
rename to libs/numa/tst_numa.c
diff --git a/libs/libltpsigwait/Makefile b/libs/sigwait/Makefile
similarity index 100%
rename from libs/libltpsigwait/Makefile
rename to libs/sigwait/Makefile
diff --git a/libs/libltpsigwait/sigwait.c b/libs/sigwait/sigwait.c
similarity index 100%
rename from libs/libltpsigwait/sigwait.c
rename to libs/sigwait/sigwait.c
diff --git a/libs/libltpswap/Makefile b/libs/swap/Makefile
similarity index 100%
rename from libs/libltpswap/Makefile
rename to libs/swap/Makefile
diff --git a/libs/libltpswap/libswap.c b/libs/swap/libswap.c
similarity index 100%
rename from libs/libltpswap/libswap.c
rename to libs/swap/libswap.c
diff --git a/libs/libltpuinput/Makefile b/libs/uinput/Makefile
similarity index 100%
rename from libs/libltpuinput/Makefile
rename to libs/uinput/Makefile
diff --git a/libs/libltpuinput/tst_uinput.c b/libs/uinput/tst_uinput.c
similarity index 100%
rename from libs/libltpuinput/tst_uinput.c
rename to libs/uinput/tst_uinput.c
diff --git a/libs/libltpvdso/Makefile b/libs/vdso/Makefile
similarity index 100%
rename from libs/libltpvdso/Makefile
rename to libs/vdso/Makefile
diff --git a/libs/libltpvdso/README b/libs/vdso/README
similarity index 100%
rename from libs/libltpvdso/README
rename to libs/vdso/README
diff --git a/libs/libltpvdso/parse_vdso.c b/libs/vdso/parse_vdso.c
similarity index 100%
rename from libs/libltpvdso/parse_vdso.c
rename to libs/vdso/parse_vdso.c
diff --git a/libs/libltpvdso/vdso_helpers.c b/libs/vdso/vdso_helpers.c
similarity index 100%
rename from libs/libltpvdso/vdso_helpers.c
rename to libs/vdso/vdso_helpers.c
diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index 236625690..6aba73e61 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpnuma
+LTPLIBS = numa
 ksm06: LTPLDLIBS = -lltpnuma
 
 include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/syscalls/clock_gettime/Makefile b/testcases/kernel/syscalls/clock_gettime/Makefile
index e7f5e9e75..2d9144602 100644
--- a/testcases/kernel/syscalls/clock_gettime/Makefile
+++ b/testcases/kernel/syscalls/clock_gettime/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpvdso
+LTPLIBS = vdso
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/get_mempolicy/Makefile b/testcases/kernel/syscalls/get_mempolicy/Makefile
index a108d8209..517838f43 100644
--- a/testcases/kernel/syscalls/get_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/get_mempolicy/Makefile
@@ -4,7 +4,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpnuma
+LTPLIBS = numa
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index 6b2b26d05..baa2a48e6 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/Makefile b/testcases/kernel/syscalls/ipc/msgget/Makefile
index 6b2b26d05..baa2a48e6 100644
--- a/testcases/kernel/syscalls/ipc/msgget/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgget/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/Makefile b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
index 6b2b26d05..baa2a48e6 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
index 85017fe90..365270802 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 ifeq ($(UCLINUX),1)
 FILTER_OUT_MAKE_TARGETS += msgsnd05 msgsnd06
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index b821bda01..6fa163d5f 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index 42d00f1cd..aa11e7003 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc ltpnewipc
+LTPLIBS = ipc newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/ipc/semget/Makefile
index b1201281d..d1e778f98 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/semop/Makefile b/testcases/kernel/syscalls/ipc/semop/Makefile
index 43afffb3f..5d082e912 100644
--- a/testcases/kernel/syscalls/ipc/semop/Makefile
+++ b/testcases/kernel/syscalls/ipc/semop/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
index 6b2b26d05..baa2a48e6 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index f79ffa6dc..d4278dcd7 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 shmctl05: CFLAGS += -pthread
 shmctl05: LDLIBS += -lrt
diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index b1201281d..d1e778f98 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/ipc/shmget/Makefile
index b1201281d..d1e778f98 100644
--- a/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmget/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpnewipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/kill/Makefile b/testcases/kernel/syscalls/kill/Makefile
index 0cc064b32..369eec8f2 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpipc ltpnewipc
+LTPLIBS = ipc newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/mbind/Makefile b/testcases/kernel/syscalls/mbind/Makefile
index ed7d4375c..2a7d35693 100644
--- a/testcases/kernel/syscalls/mbind/Makefile
+++ b/testcases/kernel/syscalls/mbind/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS=ltpnuma
+LTPLIBS = numa
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 190b7659d..9f5aca9ec 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/rt_sigtimedwait/Makefile b/testcases/kernel/syscalls/rt_sigtimedwait/Makefile
index 1ae50b32c..f96d5dc3a 100644
--- a/testcases/kernel/syscalls/rt_sigtimedwait/Makefile
+++ b/testcases/kernel/syscalls/rt_sigtimedwait/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir ?= ../../../..
 
-LTPLIBS = ltpsigwait
+LTPLIBS = sigwait
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
index 100780dc3..f203aa216 100644
--- a/testcases/kernel/syscalls/set_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpnuma
+LTPLIBS = numa
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/sigtimedwait/Makefile b/testcases/kernel/syscalls/sigtimedwait/Makefile
index 1ae50b32c..f96d5dc3a 100644
--- a/testcases/kernel/syscalls/sigtimedwait/Makefile
+++ b/testcases/kernel/syscalls/sigtimedwait/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir ?= ../../../..
 
-LTPLIBS = ltpsigwait
+LTPLIBS = sigwait
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/sigwait/Makefile b/testcases/kernel/syscalls/sigwait/Makefile
index 1ae50b32c..f96d5dc3a 100644
--- a/testcases/kernel/syscalls/sigwait/Makefile
+++ b/testcases/kernel/syscalls/sigwait/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir ?= ../../../..
 
-LTPLIBS = ltpsigwait
+LTPLIBS = sigwait
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/sigwaitinfo/Makefile b/testcases/kernel/syscalls/sigwaitinfo/Makefile
index 1ae50b32c..f96d5dc3a 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/Makefile
+++ b/testcases/kernel/syscalls/sigwaitinfo/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir ?= ../../../..
 
-LTPLIBS = ltpsigwait
+LTPLIBS = sigwait
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/swapoff/Makefile b/testcases/kernel/syscalls/swapoff/Makefile
index 6954112a8..c39c321ea 100644
--- a/testcases/kernel/syscalls/swapoff/Makefile
+++ b/testcases/kernel/syscalls/swapoff/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpswap
+LTPLIBS = swap
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/swapon/Makefile b/testcases/kernel/syscalls/swapon/Makefile
index 6954112a8..c39c321ea 100644
--- a/testcases/kernel/syscalls/swapon/Makefile
+++ b/testcases/kernel/syscalls/swapon/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpswap
+LTPLIBS = swap
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/uevents/Makefile b/testcases/kernel/uevents/Makefile
index d5ceb0719..12fc57dff 100644
--- a/testcases/kernel/uevents/Makefile
+++ b/testcases/kernel/uevents/Makefile
@@ -2,7 +2,7 @@
 
 top_srcdir			?= ../../..
 
-LTPLIBS = ltpuinput
+LTPLIBS = uinput
 
 uevent03: LDLIBS += -lltpuinput
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
