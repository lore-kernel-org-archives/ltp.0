Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375BAFE51F5
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E01533E2D75
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:40:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43C053E5349
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D02E1000A5D
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A7A75BD87;
 Fri, 24 Apr 2026 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeH+FCyuxVut5/aOENtNyXp/PRG/dUrplLEXcBFUjLE=;
 b=f+WUaj5rxjHXZcFjaM6UsTu4Q3nLkhuTQjk46pfkaidISY3d502QgUREQYj+aNswxS7mlr
 M95buiU/Q7BurogEHfyQYNO8I7Not66Qu297O1BY8C2hhWlrfufsBruMVE3XTDgfHgWTNu
 dZo/Ovm+1poGUKMG8HuoJw/OiBMegnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeH+FCyuxVut5/aOENtNyXp/PRG/dUrplLEXcBFUjLE=;
 b=6iq6v4J70rd5+BLQgWYIc6DjsHJw2pm2XI9tLmuAIxLPIoREBrPy969mDXZW3EbSeyrSbT
 uTTA4QSFEzfZk2BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeH+FCyuxVut5/aOENtNyXp/PRG/dUrplLEXcBFUjLE=;
 b=MuE0enHNkbqe0+Wg6TjwebX5PzRhIA8awrbXmfyhSgcSV7EuO6GKW3KziM7fvz/4lagTxk
 3nvUgVTRrPIO5Fh6le8KDEtrSK6Ih9CHGd3zHFcw9yoyvGEQ+6DW9thgJvAEPVR0V5hBup
 AHuLEsLsZtT8VIz7dNzR3vDGTRlpruk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeH+FCyuxVut5/aOENtNyXp/PRG/dUrplLEXcBFUjLE=;
 b=iVCT3Q0uUKGlaMAVdnmkJwbfbdgxS+GMR5mJygqqTcD31Rd9bGKbey5unRuZpIM1K7aUjx
 hgRiHMBb4kiHOGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BD95593A6;
 Fri, 24 Apr 2026 09:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4KbIBVM662l0TQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 09:39:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 11:39:18 +0200
Message-ID: <20260424093919.500059-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424093919.500059-1-pvorel@suse.cz>
References: <20260424093919.500059-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,checkpatch.pl:url,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,linux.it:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] Add .checkpatch.conf for checkpatch.pl
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
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This helps to remove duplicity because checkpatch.pl is used in 'make
check' and in b4 config.

b4 uses some specific flags --mailback --showfile.

For make check use $CHECKPATCH_CONFIG_DIR (new feature from previous
commit) to pass config file in the root directory. b4 is already run
from the root directory therefore it does not need it (script uses
default search path: '.:$HOME:.scripts'.

For some reason CAMELCASE check now creates a file with camel case variables:
.checkpatch-camelcase.git.70caa71934, add it to the top level .gitignore.

Document at least some options in .checkpatch.conf.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
There should not be any functional change other that camelcase file.
Cc b4 users :)

 .b4-config             |  5 +++--
 .checkpatch.conf       | 13 +++++++++++++
 .gitignore             |  3 +++
 include/mk/env_post.mk |  2 +-
 4 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 .checkpatch.conf

diff --git a/.b4-config b/.b4-config
index da805a8a6b..ff3199624c 100644
--- a/.b4-config
+++ b/.b4-config
@@ -4,6 +4,7 @@
     send-series-to = Linux Test Project <ltp@lists.linux.it>
     pw-url = https://patchwork.ozlabs.org/
     pw-project = ltp
-    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING,STRCPY,STRLCPY,STRNCPY
-    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING,STRCPY,STRLCPY,STRNCPY
 
+    # other checkpatch.pl options from .checkpatch.conf are used
+    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --mailback --showfile
+    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --mailback
diff --git a/.checkpatch.conf b/.checkpatch.conf
new file mode 100644
index 0000000000..20b92aaca9
--- /dev/null
+++ b/.checkpatch.conf
@@ -0,0 +1,13 @@
+# Not Linux, so don't expect a Linux tree.
+--no-tree
+
+-f --terse --no-summary
+
+# enable more tests
+--strict
+
+# kernel specific
+--ignore PREFER_KERNEL_TYPES,STRCPY,STRLCPY,STRNCPY
+
+# TODO: document reason
+--ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING
diff --git a/.gitignore b/.gitignore
index 3fdfeaba03..f034ca1647 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,3 +63,6 @@ logfile.*
 
 compile_flags.txt
 compile_commands.json
+
+# added by scripts/checkpatch.pl
+.checkpatch-camelcase.*
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index dcb0bbc6c5..1b0d3a2a8e 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -73,7 +73,7 @@ CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcar
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
 CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
-CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING,STRCPY,STRLCPY,STRNCPY
+CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f
 SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
 SHELL_CHECK_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.sh))))
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
