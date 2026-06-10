Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43147CD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 13:00:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D46963E5E9E
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 15:00:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A9033E183A
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:00:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 27FD920038D
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:00:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF8A06AD94;
 Wed, 10 Jun 2026 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781096409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=boVQmvuVnP/p6hCXrcEajjXbI4j27Y/rwRjg9WkHSt4=;
 b=mGmZRh3LmQsVSZDMT7b7sjQ9TKLnTW5bPkKgKei558COTXTLonIDiOw0jbJbkdPxLRuwAU
 Yd6cUgteD+7WQp9iizuBKhCyoo9clSPi7aLMDnq48hxPOiLlEj47/hpSYoY/5+ztjsLrNr
 mKeN2iu4J1tbvENY8GkBsWTru+J9Khc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781096409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=boVQmvuVnP/p6hCXrcEajjXbI4j27Y/rwRjg9WkHSt4=;
 b=omwpNvRC1iyOcJiQwjMSmDw0xO8lCUdOkGnE6gPMBFAmqw1S/jK67UZ1Z1dWE+U1FVyQc3
 3p95aWndLh/aWhDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781096406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=boVQmvuVnP/p6hCXrcEajjXbI4j27Y/rwRjg9WkHSt4=;
 b=bKKpuWBnmmHWhAu5/NFyLwsiI/RP0Occx6RPicdmmrvCQvAqx5JSExjrt0Ghjv4kUCZebk
 ZINR1/eTb9zn+EHwWzTq4H0oBDI+0fFowx1Y3/2ag7wFWLLeAApfCDl0cp/KvNg8ru4L7j
 ivLqc1VfJhIm+jtIyGrBZxwQvcPOMoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781096406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=boVQmvuVnP/p6hCXrcEajjXbI4j27Y/rwRjg9WkHSt4=;
 b=3ZmgdAqOcGErCQSXEsg2Bzg77Wy3/boyuqSBKBSs5WYHPUumpC6vDaqa9+gxoPjM+lWVoI
 Phck61CHf6FQKZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A41D2779A7;
 Wed, 10 Jun 2026 13:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tNy7JtZfKWpBDAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jun 2026 13:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 15:00:05 +0200
MIME-Version: 1.0
Message-Id: <20260610-fix_buildsystem_modules-v1-1-7f24a774d19d@suse.com>
X-B4-Tracking: v=1; b=H4sIANRfKWoC/x2MSQqAMAwAvyI5W2hFe/ArIlJNqgE3GiuK+HeLx
 4GZeUAoMAnU2QOBThbe1gQmz2CY3DqSYkwMhS6stkYrz1fXR55Rbjlo6ZYN40yiXIXe2KH06Ah
 SvQdK6n9u2vf9AJ1/QZ9pAAAA
X-Change-ID: 20260610-fix_buildsystem_modules-a5df16c4fdae
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781096406; l=2349;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=LqbvpPamsdqFKCtrFINoAyYfxF4IZMTXPagc/ljMhco=;
 b=MRHdUjuPM6HKed1RWhle4WN58ZsvNXs1EvHYhaF92bxAYqqGrdsCvM8uVh5Gbl7NrfJRg7fir
 crEeY4pmSf5DcCuUaqvT1oh5Couec1IfW2/j11vAUCjb3nagp49Fntr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,env_post.mk:url,module.mk:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, module.mk:url, env_post.mk:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] build: run make check on test sources in kernel
 module directories
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

In directories that build a kernel module, module.mk set CHECK_TARGETS
with ':=' before env_post.mk could populate it via '?=', leaving it empty
so 'make check' never ran sparse/checkpatch on the test sources. The filter
also used a '%.ko' pattern that never matched any 'check-<name>' entry.

Drop the broken assignment from module.mk and instead exclude the kernel
module sources (MODULE_SOURCES) in env_post.mk once CHECK_TARGETS has been
populated, so test sources are checked while kernel module code is skipped.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/mk/env_post.mk | 2 +-
 include/mk/module.mk   | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 726b9a9e7526562f4f6e8363da394485c805fa88..43983197638a2ba42a9c1a20e072fa3179e04344 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -70,7 +70,7 @@ endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
 endif
 
 CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcard $(abs_srcdir)/*.c)))))
-CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
+CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS) $(notdir $(basename $(MODULE_SOURCES)))), $(CHECK_TARGETS))
 CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
 CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f --root $(abs_top_srcdir)
diff --git a/include/mk/module.mk b/include/mk/module.mk
index 3e97f01289e2eb4f5a494c55a83022860b37a835..8949d9067ca6afdb790de122ff4ff56e38a54066 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -51,8 +51,6 @@ endif
 
 CLEAN_TARGETS += .dep_modules *.mod built-in.a
 
-CHECK_TARGETS := $(filter-out %.ko, $(CHECK_TARGETS))
-
 MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko, $(MAKE_TARGETS)))
 
 # Ignoring the exit status of commands is done to be forward compatible with

---
base-commit: c1b71bf7ebb6a58507e4998faf5c74154f595f96
change-id: 20260610-fix_buildsystem_modules-a5df16c4fdae

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
