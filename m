Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A833C433F5
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 11:33:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35D873C8B76
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 13:33:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16B563C868B
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 13:33:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 223DC1000498
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 13:33:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D3DE1F37D
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648726405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXwoBQT9lTAj/qe3O2zZB7xJf9pmSU+U/AQ9LbHHHLI=;
 b=bqT35o/n8bgIC0sjfgmj1zK67haEmwzJP8mPgv8qqmw0ItyyU7WT1wkRc1UPMxuxV0Xj6G
 DAl15sMoeU9q21d2vbAEBl3mwpFl12PAX7svsDxvGbdWe8FtBo8TQw2X30vvL6zkdKr5O6
 TdniTUTurebCxmYd7RrbvFtsjk08HX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648726405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXwoBQT9lTAj/qe3O2zZB7xJf9pmSU+U/AQ9LbHHHLI=;
 b=X6UaoG7r3WBky9dCyh4jJBv/t+tKGmvc5Z/yZFTdoQm2EPaZMDxpK74Hps362eNuc/OY8A
 Qs00X2wzb4csl3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BB3113AF8
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 11:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +KzYCYWRRWKCeQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 11:33:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 31 Mar 2022 13:33:22 +0200
Message-Id: <20220331113324.14742-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331113324.14742-1-mdoucha@suse.cz>
References: <20220331113324.14742-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] Add AX_CHECK_COMPILE_FLAG() autoconf macro
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 m4/ax_check_compile_flag.m4 | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 m4/ax_check_compile_flag.m4

diff --git a/m4/ax_check_compile_flag.m4 b/m4/ax_check_compile_flag.m4
new file mode 100644
index 000000000..bd753b34d
--- /dev/null
+++ b/m4/ax_check_compile_flag.m4
@@ -0,0 +1,53 @@
+# ===========================================================================
+#  https://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_CHECK_COMPILE_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
+#
+# DESCRIPTION
+#
+#   Check whether the given FLAG works with the current language's compiler
+#   or gives an error.  (Warnings, however, are ignored)
+#
+#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
+#   success/failure.
+#
+#   If EXTRA-FLAGS is defined, it is added to the current language's default
+#   flags (e.g. CFLAGS) when the check is done.  The check is thus made with
+#   the flags: "CFLAGS EXTRA-FLAGS FLAG".  This can for example be used to
+#   force the compiler to issue an error when a bad flag is given.
+#
+#   INPUT gives an alternative input source to AC_COMPILE_IFELSE.
+#
+#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
+#   macro in sync with AX_CHECK_{PREPROC,LINK}_FLAG.
+#
+# LICENSE
+#
+#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
+#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@gmail.com>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved.  This file is offered as-is, without any
+#   warranty.
+
+#serial 6
+
+AC_DEFUN([AX_CHECK_COMPILE_FLAG],
+[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
+AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
+AC_CACHE_CHECK([whether _AC_LANG compiler accepts $1], CACHEVAR, [
+  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
+  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1"
+  AC_COMPILE_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
+    [AS_VAR_SET(CACHEVAR,[yes])],
+    [AS_VAR_SET(CACHEVAR,[no])])
+  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
+AS_VAR_IF(CACHEVAR,yes,
+  [m4_default([$2], :)],
+  [m4_default([$3], :)])
+AS_VAR_POPDEF([CACHEVAR])dnl
+])dnl AX_CHECK_COMPILE_FLAGS
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
