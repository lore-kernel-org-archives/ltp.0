Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF4FC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:32:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 490A93CF83A
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:32:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45C913C0F55
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8D739600B62
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0D27375A9;
 Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9RY5TTw4EeixgPlEej3pVujzZXEXZa+R+D7DsoJzeA=;
 b=xeGukZtEAZzj0lHXLdEZ8HYXERLb/EaJHjU3C4YoOfCh5aluyBCTjpCnt5wqgNIGjQVkYf
 +t7KGa9gAKnuomHe0QMV8FuioLVWwAy5ORz+gLu/hMlWhZ8zMcbFb7+MqSptLLMH5VqFMx
 s4MuKT+BTmwq63kT7OlvFiXUqv5u15I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9RY5TTw4EeixgPlEej3pVujzZXEXZa+R+D7DsoJzeA=;
 b=r/i8jIzofZEw6J6my7YTe4BQj+snjWotppPc9eGibvY5twbIzFFGqP3RaCaCu9krLQkVFf
 8jo65KCquRvPYMBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wuXFEbdj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KC8Bz+EJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9RY5TTw4EeixgPlEej3pVujzZXEXZa+R+D7DsoJzeA=;
 b=wuXFEbdjm3uQKwdpiYm+kzJv7zYl9L21MLZCjnqBX8FQAtLhL9t9LjK8JMbNV3wNgPKQzk
 mFTKtX9af9tXRpPF+a1c7TTS/MWz/Uk2LMFF7XFbbu/UVeRJZJK2NJJGpg2Pt36V1Nsx2a
 P54rAhGEXE2W21visKs7SHPrMVBWBxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9RY5TTw4EeixgPlEej3pVujzZXEXZa+R+D7DsoJzeA=;
 b=KC8Bz+EJGI5tw86PTFPXAYEk/EZLZ+9XOW1BpdbeOL1gkeMIc46YoY8Cm1geNMU63QzG/n
 bSWUoQDLZk6RVrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D57631386D;
 Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6J3YMgX0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:29:57 +0200
Message-ID: <20240411143025.352507-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F0D27375A9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/31] make: Remove UCLINUX (nommu detection)
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

nommu detection was written for UCLINUX distribution, which is not
active any more.  While there are still some used nommu kernel
architectures (m68k and other), there is missing support in the new
C API and nobody from the community did not stand to implement and
maintain it. Therefore removing all UCLINUX/nommu related code also
from makefiles.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile                                      | 7 -------
 include/mk/env_post.mk                        | 4 ----
 include/mk/features.mk.in                     | 4 ----
 testcases/kernel/Makefile                     | 2 --
 testcases/kernel/syscalls/Makefile            | 5 -----
 testcases/kernel/syscalls/access/Makefile     | 4 ----
 testcases/kernel/syscalls/ipc/msgsnd/Makefile | 4 ----
 testcases/kernel/syscalls/writev/Makefile     | 4 ----
 8 files changed, 34 deletions(-)

diff --git a/Makefile b/Makefile
index 96edd5a80..d7d2815f1 100644
--- a/Makefile
+++ b/Makefile
@@ -24,10 +24,6 @@ vpath %.in		$(top_srcdir)/include
 vpath %.m4		$(top_srcdir)/m4
 vpath %.mk		$(top_srcdir)/mk:$(top_srcdir)/mk/include
 
-# User wants uclinux binaries?
-UCLINUX			?= 0
-export UCLINUX
-
 # CLEAN_TARGETS:	Targets which exist solely in clean.
 # COMMON_TARGETS:	Targets which exist in all, clean, and install.
 # INSTALL_TARGETS:	Targets which exist in clean and install (contains
@@ -35,10 +31,7 @@ export UCLINUX
 # BOOTSTRAP_TARGETS:	Directories required to bootstrap out-of-build-tree
 # 			support.
 
-# We're not using uclinux based targets (default).
-ifneq ($(UCLINUX),1)
 COMMON_TARGETS		:= pan utils
-endif
 
 define target_to_dir_dep_mapping
 ifeq ($$(filter %-clean,$(1)),) # not *-clean
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index a00f31b08..0bbbc3705 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -39,10 +39,6 @@ CPPFLAGS			+= -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/
 
 LDFLAGS				+= -L$(top_builddir)/lib
 
-ifeq ($(UCLINUX),1)
-CPPFLAGS			+= -D__UCLIBC__ -DUCLINUX
-endif
-
 ifeq ($(ANDROID),1)
 LDFLAGS				+= -L$(top_builddir)/lib/android_libpthread
 LDFLAGS				+= -L$(top_builddir)/lib/android_librt
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index c2b64b549..73a2f6658 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -40,11 +40,7 @@ WITH_METADATA_PDF		:= @WITH_METADATA_PDF@
 WITH_OPEN_POSIX_TESTSUITE	:= @WITH_OPEN_POSIX_TESTSUITE@
 
 # Enable testcases/realtime's compile and install?
-ifeq ($(UCLINUX),1)
-WITH_REALTIME_TESTSUITE		:= no
-else
 WITH_REALTIME_TESTSUITE		:= @WITH_REALTIME_TESTSUITE@
-endif
 
 # Enable testcases/kernel/kvm compile and install?
 WITH_KVM_TESTSUITE		:= @WITH_KVM_TESTSUITE@
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 3ca0e74bd..98fd45a9d 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -15,7 +15,6 @@ SUBDIRS			:= syscalls
 # Build lib
 SUBDIRS			+= lib
 
-ifneq ($(UCLINUX),1)
 # KEEP THIS LIST ALPHABETIZED PLEASE!
 SUBDIRS			+= connectors \
 			   containers \
@@ -43,7 +42,6 @@ SUBDIRS			+= connectors \
 
 ifeq ($(WITH_KVM_TESTSUITE),yes)
 SUBDIRS			+= kvm
-endif
 
 endif
 
diff --git a/testcases/kernel/syscalls/Makefile b/testcases/kernel/syscalls/Makefile
index c6dc8d9e7..b2e1b1caf 100644
--- a/testcases/kernel/syscalls/Makefile
+++ b/testcases/kernel/syscalls/Makefile
@@ -10,11 +10,6 @@ top_srcdir		?= ../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-ifeq ($(UCLINUX),1)
-FILTER_OUT_DIRS	+= capget capset chmod chown clone fork getcontext llseek \
-		   mincore mprotect nftw profil remap_file_pages sbrk
-endif
-
 ifeq ($(UCLIBC),1)
 FILTER_OUT_DIRS	+= profil
 endif
diff --git a/testcases/kernel/syscalls/access/Makefile b/testcases/kernel/syscalls/access/Makefile
index 5d89a6c05..044619fb8 100644
--- a/testcases/kernel/syscalls/access/Makefile
+++ b/testcases/kernel/syscalls/access/Makefile
@@ -3,10 +3,6 @@
 
 top_srcdir		?= ../../../..
 
-ifeq ($(UCLINUX),1)
-FILTER_OUT_MAKE_TARGETS += access02 access03
-endif
-
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
index 85017fe90..63aee01d4 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -5,10 +5,6 @@ top_srcdir              ?= ../../../../..
 
 LTPLIBS = ltpnewipc
 
-ifeq ($(UCLINUX),1)
-FILTER_OUT_MAKE_TARGETS += msgsnd05 msgsnd06
-endif
-
 include $(top_srcdir)/include/mk/testcases.mk
 
 LTPLDLIBS  += -lltpnewipc
diff --git a/testcases/kernel/syscalls/writev/Makefile b/testcases/kernel/syscalls/writev/Makefile
index 6627abaed..2eb46974e 100644
--- a/testcases/kernel/syscalls/writev/Makefile
+++ b/testcases/kernel/syscalls/writev/Makefile
@@ -3,10 +3,6 @@
 
 top_srcdir		?= ../../../..
 
-ifeq ($(UCLINUX),1)
-FILTER_OUT_MAKE_TARGETS	+= writev02
-endif
-
 include $(top_srcdir)/include/mk/testcases.mk
 
 writev03: CFLAGS += -pthread
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
