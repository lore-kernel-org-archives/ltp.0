Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F19CEFC5D
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 09:45:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1289B3C2785
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:45:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575A63C259D
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:45:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 405FA60FB4F
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:45:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3AB7121F4D
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728467127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UbQSLW/InWkgIIpNudf7/R0gU9ianM3xGhIPMDH/AU=;
 b=T81FRvPCtmv1JIPOKv7YJsT9LJruZ/Yya7x42qCh6AK5pf22n2ZG9AHTNYr1jCu5HdSAQH
 P1/0g1lwxABIOnlNhZEZvel+VKPEuI/YaHFJFxwKX/yEpj2ULptBvmqRH+kbwmmrF1GHsG
 N7avDRnaCwbrLlvNYvL9kMrO/wXlD54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728467127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UbQSLW/InWkgIIpNudf7/R0gU9ianM3xGhIPMDH/AU=;
 b=GP4oiGbICQYBAZQfZvUwcEFLI0hQPH3AAuCzT7gSmkw4V3jCUmSWFpBRcj5DAV7on9GU/h
 oxhbv/f62YmFooBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728467127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UbQSLW/InWkgIIpNudf7/R0gU9ianM3xGhIPMDH/AU=;
 b=T81FRvPCtmv1JIPOKv7YJsT9LJruZ/Yya7x42qCh6AK5pf22n2ZG9AHTNYr1jCu5HdSAQH
 P1/0g1lwxABIOnlNhZEZvel+VKPEuI/YaHFJFxwKX/yEpj2ULptBvmqRH+kbwmmrF1GHsG
 N7avDRnaCwbrLlvNYvL9kMrO/wXlD54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728467127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UbQSLW/InWkgIIpNudf7/R0gU9ianM3xGhIPMDH/AU=;
 b=GP4oiGbICQYBAZQfZvUwcEFLI0hQPH3AAuCzT7gSmkw4V3jCUmSWFpBRcj5DAV7on9GU/h
 oxhbv/f62YmFooBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE09B13AAF
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 09:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WFIhNLZQBmfRZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 09:45:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 11:45:16 +0200
MIME-Version: 1.0
Message-Id: <20241009-generate_syscalls-v4-1-5328a785bbad@suse.com>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728467126; l=8138;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4kvWVfXXctywnKL8u4ee/g2h1Zis2kwcwQgKAouNUXQ=;
 b=mPzC/k7uaE2SwMYq1vUNyi5izqAebeW9zn/eq/k0vkJR39K1HQ4p2CUF7cbLUS99YoNuzowLV
 hnk0qoRWzzQAQyt3HBJlTiJRKkyH97T668/hqAmH0df3RrjKHRqd2Zx
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] Refactor regen.sh script to generate syscalls
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
 .../lapi/syscalls/{order => supported-arch.txt}    |   0
 4 files changed, 116 insertions(+), 130 deletions(-)

diff --git a/configure.ac b/configure.ac
index ebbf49e28..45f92477f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -384,7 +384,7 @@ else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
 
-AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
+AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./generate_syscalls.sh ../syscalls.h])
 
 # custom functions
 # NOTE: don't create custom functions for simple checks, put them into this file
diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
new file mode 100755
index 000000000..863f52253
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
+			done <"${SCRIPT_DIR}/${arch}.in"
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
+			done <"${SCRIPT_DIR}/${arch}.in"
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

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
