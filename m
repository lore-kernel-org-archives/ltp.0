Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0A6E68958
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 07:28:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 009FB3CBC0C
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 08:28:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2504B3CBBF5
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 08:28:10 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D6A723D8D3
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 08:28:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 065A321CFB;
 Thu, 31 Oct 2024 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730359688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jx5EOQm5vYM+x5rjYDJa7scqfnUGiCT7njJ8AiIp+Po=;
 b=FmtsgeYVjEa4fZEL2OfTdWlzLUb/i2ugD+AwgRPdiUdHqB7uzlRTEiuUtr/RZVyn8XK55N
 AuVODC19Uila3wmypWqnUeNYDFxgKntasOLgRchOBnlzuGbd0GXyVHh8y65F2yZgiWalMV
 uu0iqaRAHC2CmWF/OaUGqhxdQMO1qj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730359688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jx5EOQm5vYM+x5rjYDJa7scqfnUGiCT7njJ8AiIp+Po=;
 b=ODPa0l2XF+l25jcFnqHoCN/e/AW1g9k9IDM61dE8NPVpnYbWrKu7epsKIZ75AsqRl7EWen
 Xy7nD0GI+A8PQhAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cb3dCsTn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=asjvnaWY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730359687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jx5EOQm5vYM+x5rjYDJa7scqfnUGiCT7njJ8AiIp+Po=;
 b=cb3dCsTnBzgpPx8ibp3XNlZkoqGymf3wt6BE0gvRsPyFKB8ghSOMyeiFcLPop39crIWp50
 O1qVhqouDypyhwPc4BXsMXx/o+G/q++08W0U+jq+mWKX1+Edqf+e3xbnN+2oTnpjYXB3TW
 DZlrVfUbBU/Q2CVQ2J/eOWbQkR1k6Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730359687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jx5EOQm5vYM+x5rjYDJa7scqfnUGiCT7njJ8AiIp+Po=;
 b=asjvnaWYelXKzC8nakYnDqzzpM5Qcb5MJE44EU/0xnWxi+8UcXhRhtJtTeri87O6G4lrm2
 /oc2pE41gU87VZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B89E136A5;
 Thu, 31 Oct 2024 07:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qJ7+D4YxI2fLBQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Oct 2024 07:28:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 31 Oct 2024 08:27:06 +0100
MIME-Version: 1.0
Message-Id: <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
In-Reply-To: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730359657; l=8440;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=EuwsETiNwV93Anj0LfsgKQYxahr1nYwzjpINwmjLjsc=;
 b=l3oKF5mI/2bn4iX0OPGzGnsr5YvF4obCVfQmd+nv1ntwdyv0b8tbbCr11rkS18EIueO0BYuJI
 162Xca0gDoUDV3QHHzATtt3ez7yMvBigvZcSWm7O8mMux6tnHXA6u2q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 065A321CFB
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate syscalls
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

Rename regen.sh into a more meaningful generate_syscalls.sh name, rename
order into a more meaningful supported-syscalls.txt name and rewrite
part of the regen.sh script code in order to execute it from anywhere in
the filesystem, without need to be in its own folder. The new code is
also more clear and concise, using native sh features which are
simplifying the code.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac                                       |   2 +-
 include/lapi/syscalls/generate_syscalls.sh         | 111 ++++++++++++++++++
 include/lapi/syscalls/regen.sh                     | 129 ---------------------
 .../lapi/syscalls/{order => supported-arch.txt}    |   0
 4 files changed, 112 insertions(+), 130 deletions(-)

diff --git a/configure.ac b/configure.ac
index d327974efa71f263d7f7f5aec9d2c5831d53dd0e..cd1233d19fad376973fc880d6689859845613fb0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -386,7 +386,7 @@ else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
 
-AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh; cd - >/dev/null])
+AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./generate_syscalls.sh ../syscalls.h; cd - >/dev/null])
 
 # custom functions
 # NOTE: don't create custom functions for simple checks, put them into this file
diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
new file mode 100755
index 0000000000000000000000000000000000000000..8fcc0f80654011e8d0811b9ca64157c778bb12ce
--- /dev/null
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Generate the syscalls.h file, merging all architectures syscalls input file
+# which are in the current folder and defined inside supported-arch.txt file.
+
+SYSCALLS_FILE="$1"
+
+if [ -z "${SYSCALLS_FILE}" ]; then
+	echo "Please provide the syscalls.h directory:"
+	echo ""
+	echo "$0 path/of/syscalls.h"
+	echo ""
+	exit 1
+fi
+
+SCRIPT_DIR="$(realpath $(dirname "$0"))"
+SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
+
+echo '
+// SPDX-License-Identifier: GPL-2.0-or-later
+/************************************************
+ * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
+ *  change your arch specific .in file instead  *
+ ************************************************/
+
+/*
+ * Here we stick all the ugly *fallback* logic for linux
+ * system call numbers (those __NR_ thingies).
+ */
+
+#ifndef LAPI_SYSCALLS_H__
+#define LAPI_SYSCALLS_H__
+
+#include <errno.h>
+#include <sys/syscall.h>
+#include <asm/unistd.h>
+
+#ifdef TST_TEST_H__
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \
+tst_brk(TCONF, \
+	"syscall(%d) " SNR " not supported on your arch", NR); \
+})
+#else
+inline static void dummy_cleanup(void) {}
+
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \
+tst_brkm(TCONF, dummy_cleanup, \
+	"syscall(%d) " SNR " not supported on your arch", NR); \
+})
+#endif
+
+#define tst_syscall(NR, ...) ({ \
+intptr_t tst_ret; \
+if (NR == __LTP__NR_INVALID_SYSCALL) { \
+	errno = ENOSYS; \
+	tst_ret = -1; \
+} else { \
+	tst_ret = syscall(NR, ##__VA_ARGS__); \
+} \
+if (tst_ret == -1 && errno == ENOSYS) { \
+	TST_SYSCALL_BRK__(NR, #NR); \
+} \
+tst_ret; \
+})
+
+#define __LTP__NR_INVALID_SYSCALL -1' >${SYSCALLS_FILE}
+
+while IFS= read -r arch; do
+	(
+		echo
+		case ${arch} in
+		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
+		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
+		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
+		mips64n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
+		mips64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
+		mipso32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
+		parisc) echo "#ifdef __hppa__" ;;
+		loongarch64) echo "#ifdef __loongarch__" ;;
+		arm64) echo "#ifdef __aarch64__" ;;
+		*) echo "#ifdef __${arch}__" ;;
+		esac
+
+		while read -r line; do
+			set -- ${line}
+			syscall_nr="__NR_$1"
+			shift
+
+			echo "# ifndef ${syscall_nr}"
+			echo "#  define ${syscall_nr} $*"
+			echo "# endif"
+		done <"${SCRIPT_DIR}/${arch}.in"
+		echo "#endif"
+		echo
+	) >>${SYSCALLS_FILE}
+done <${SUPPORTED_ARCH}
+
+(
+	echo
+	echo "/* Common stubs */"
+	for num in $(awk '{print $1}' "${SCRIPT_DIR}/"*.in | sort -u); do
+		syscall_nr="__NR_${num}"
+		shift
+
+		echo "# ifndef ${syscall_nr}"
+		echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
+		echo "# endif"
+	done
+	echo "#endif"
+) >>${SYSCALLS_FILE}
diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
deleted file mode 100755
index 663ce4458bbc67c3a9e8073dfe8359164a9da0ee..0000000000000000000000000000000000000000
--- a/include/lapi/syscalls/regen.sh
+++ /dev/null
@@ -1,129 +0,0 @@
-#!/bin/sh
-
-output="syscalls.h"
-rm -f "${output}".[1-9]*
-output_pid="${output}.$$"
-
-max_jobs=$(getconf _NPROCESSORS_ONLN 2>/dev/null)
-: ${max_jobs:=1}
-
-srcdir=${0%/*}
-
-err() {
-	echo "$*" 1>&2
-	exit 1
-}
-
-cat << EOF > "${output_pid}"
-/************************************************
- * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
- *  change your arch specific .in file instead  *
- ************************************************/
-
-/*
- * Here we stick all the ugly *fallback* logic for linux
- * system call numbers (those __NR_ thingies).
- *
- * Licensed under the GPLv2 or later, see the COPYING file.
- */
-
-#ifndef LAPI_SYSCALLS_H__
-#define LAPI_SYSCALLS_H__
-
-#include <errno.h>
-#include <sys/syscall.h>
-#include <asm/unistd.h>
-
-#ifdef TST_TEST_H__
-#define TST_SYSCALL_BRK__(NR, SNR) ({ \\
-	tst_brk(TCONF, \\
-		"syscall(%d) " SNR " not supported on your arch", NR); \\
-})
-#else
-inline static void dummy_cleanup(void) {}
-
-#define TST_SYSCALL_BRK__(NR, SNR) ({ \\
-	tst_brkm(TCONF, dummy_cleanup, \\
-		"syscall(%d) " SNR " not supported on your arch", NR); \\
-})
-#endif
-
-#define tst_syscall(NR, ...) ({ \\
-	intptr_t tst_ret; \\
-	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
-		errno = ENOSYS; \\
-		tst_ret = -1; \\
-	} else { \\
-		tst_ret = syscall(NR, ##__VA_ARGS__); \\
-	} \\
-	if (tst_ret == -1 && errno == ENOSYS) { \\
-		TST_SYSCALL_BRK__(NR, #NR); \\
-	} \\
-	tst_ret; \\
-})
-
-EOF
-
-jobs=0
-for arch in $(cat "${srcdir}/order") ; do
-	(
-	echo "Generating data for arch $arch ... "
-
-	(
-	echo
-	case ${arch} in
-		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
-		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
-		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
-		mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
-		mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
-		mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
-		*) echo "#ifdef __${arch}__" ;;
-	esac
-	while read line ; do
-		set -- ${line}
-		nr="__NR_$1"
-		shift
-		if [ $# -eq 0 ] ; then
-			err "invalid line found: $line"
-		fi
-		echo "# ifndef ${nr}"
-		echo "#  define ${nr} $*"
-		echo "# endif"
-	done < "${srcdir}/${arch}.in"
-	echo "#endif"
-	echo
-	) >> "${output_pid}.${arch}"
-
-	) &
-
-	jobs=$(( jobs + 1 ))
-	if [ ${jobs} -ge ${max_jobs} ] ; then
-		wait || exit 1
-		jobs=0
-	fi
-done
-
-echo "Generating stub list ... "
-(
-echo
-echo "/* Common stubs */"
-echo "#define __LTP__NR_INVALID_SYSCALL -1" >> "${output_pid}"
-for nr in $(awk '{print $1}' "${srcdir}/"*.in | sort -u) ; do
-	nr="__NR_${nr}"
-	echo "# ifndef ${nr}"
-	echo "#  define ${nr} __LTP__NR_INVALID_SYSCALL"
-	echo "# endif"
-done
-echo "#endif"
-) >> "${output_pid}._footer"
-
-wait || exit 1
-
-printf "Combining them all ... "
-for arch in $(cat "${srcdir}/order") _footer ; do
-	cat "${output_pid}.${arch}"
-done >> "${output_pid}"
-mv "${output_pid}" "../${output}"
-rm -f "${output_pid}"*
-echo "OK!"
diff --git a/include/lapi/syscalls/order b/include/lapi/syscalls/supported-arch.txt
similarity index 100%
rename from include/lapi/syscalls/order
rename to include/lapi/syscalls/supported-arch.txt

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
