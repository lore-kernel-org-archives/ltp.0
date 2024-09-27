Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20793CEBF8D
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:49:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DEC13C4FA1
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:49:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50C1F3C4EBC
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4997B100B8A1
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 972B821B6B
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S+JHaKxYQMhF5aXLf2t9AXnvFyFwlzhrwwnP+6Nbz0=;
 b=ViFmwyuHiok7O1bYTFyISH+PRzB+g0gGJ9HySw0A4QcVrhIoYZZ0bti/+wJfRWbNmQezeb
 XLzdjHB9mtuAKknpl9xfv8F9Pi0babNhsX4LD1jqQJxNpYxvIg6zr49l+ZcWH11gU6I7be
 g1pafLdSoJJlXBZNCgDJ3duVPgX3LvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S+JHaKxYQMhF5aXLf2t9AXnvFyFwlzhrwwnP+6Nbz0=;
 b=JWLfST2fEEzZ9ohQkFspDGUzcVqHBeQ8i7AKAcHVoVaAj4rac1Q1ipSpnvqpmoZOyq/qWY
 dE6AsUobrlKu/mBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S+JHaKxYQMhF5aXLf2t9AXnvFyFwlzhrwwnP+6Nbz0=;
 b=ViFmwyuHiok7O1bYTFyISH+PRzB+g0gGJ9HySw0A4QcVrhIoYZZ0bti/+wJfRWbNmQezeb
 XLzdjHB9mtuAKknpl9xfv8F9Pi0babNhsX4LD1jqQJxNpYxvIg6zr49l+ZcWH11gU6I7be
 g1pafLdSoJJlXBZNCgDJ3duVPgX3LvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S+JHaKxYQMhF5aXLf2t9AXnvFyFwlzhrwwnP+6Nbz0=;
 b=JWLfST2fEEzZ9ohQkFspDGUzcVqHBeQ8i7AKAcHVoVaAj4rac1Q1ipSpnvqpmoZOyq/qWY
 dE6AsUobrlKu/mBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CF3C13AA0
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uCS2HKt/9ma9TQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 27 Sep 2024 11:49:21 +0200
MIME-Version: 1.0
Message-Id: <20240927-generate_syscalls-v2-1-108f5f2ad318@suse.com>
References: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
In-Reply-To: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727430571; l=8324;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=nHmW1f5vL0XgpWIsQnjWbvEBaAl3TG8bQEhh9WMEuQI=;
 b=lsHuDpbyZRYdYnx3IprNr/xL7JWYJ6rASYpqnzHyAjADvARVIhurwVt/mvGCN72IoLNh38yQg
 EJISfbi/PciBJLK+f25XIdndqiB42pXdC39T5KQMu50mGWGy7M71bxh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] Refactor regen.sh script to generate syscalls
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac                                       |   2 +-
 include/lapi/syscalls/generate_syscalls.sh         | 115 ++++++++++++++++++
 include/lapi/syscalls/regen.sh                     | 129 ---------------------
 .../lapi/syscalls/{order => supported-arch.txt}    |   2 +-
 4 files changed, 117 insertions(+), 131 deletions(-)

diff --git a/configure.ac b/configure.ac
index ebbf49e28..ae5c028bf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -384,7 +384,7 @@ else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
 
-AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
+AC_CONFIG_COMMANDS([syscalls.h], [include/lapi/syscalls/generate_syscalls.sh include/lapi/syscalls.h])
 
 # custom functions
 # NOTE: don't create custom functions for simple checks, put them into this file
diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
new file mode 100755
index 000000000..52e605900
--- /dev/null
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+#
+# Generate the syscalls.h file, merging all architectures syscalls input file
+# which are in the current folder and defined inside supported-arch.txt file.
+
+SYSCALLS_FILE="${1}"
+
+if [ -z "${SYSCALLS_FILE}" ]; then
+	echo "Please give the syscalls.h path:"
+	echo ""
+	echo "$0 path/of/syscalls.h"
+	echo ""
+	exit 1
+fi
+
+SCRIPT_DIR="$(realpath $(dirname "$0"))"
+SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
+
+merge_syscalls() {
+	echo '
+/************************************************
+* GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
+*  change your arch specific .in file instead  *
+************************************************/
+
+/*
+kj* Here we stick all the ugly *fallback* logic for linux
+* system call numbers (those __NR_ thingies).
+*
+* Licensed under the GPLv2 or later, see the COPYING file.
+*/
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
+	while IFS= read -r arch; do
+		(
+			echo
+			case ${arch} in
+			sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
+			sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
+			s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
+			mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
+			mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
+			mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
+			*) echo "#ifdef __${arch}__" ;;
+			esac
+
+			while read -r line; do
+				set -- ${line}
+				syscall_nr="__NR_$1"
+				shift
+
+				echo "# ifndef ${syscall_nr}"
+				echo "#  define ${syscall_nr} $*"
+				echo "# endif"
+			done <"${arch}.in"
+			echo "#endif"
+			echo
+		) >>${SYSCALLS_FILE}
+	done <${SUPPORTED_ARCH}
+
+	(
+		echo
+		echo "/* Common stubs */"
+		while IFS= read -r arch; do
+			while IFS= read -r line; do
+				set -- ${line}
+				syscall_nr="__NR_$1"
+				shift
+
+				echo "# ifndef ${syscall_nr}"
+				echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
+				echo "# endif"
+			done <"${arch}.in"
+		done <${SUPPORTED_ARCH}
+		echo "#endif"
+	) >>${SYSCALLS_FILE}
+}
+
+merge_syscalls
diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
deleted file mode 100755
index 663ce4458..000000000
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
index c18aa38cf..2368ce3e1 100644
--- a/include/lapi/syscalls/order
+++ b/include/lapi/syscalls/supported-arch.txt
@@ -8,8 +8,8 @@ loongarch
 mips_n32
 mips_n64
 mips_o32
-powerpc64
 powerpc
+powerpc64
 s390x
 s390
 sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
