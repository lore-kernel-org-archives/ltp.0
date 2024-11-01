Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C97BE6B240
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:49:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08CFE3CD307
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 11:49:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB44D3CD2B6
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:49:01 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9938461A4BD
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:49:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 061C31F8B0;
 Fri,  1 Nov 2024 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siYhd8lfcKl6DaZYWHoeO4wLOF9SQ2u5cXR0BHzcmxs=;
 b=qjbGFP+9Gj0C/pNNL6CyEu+XmmS98yg5A/2MehfAc+laYi1qEHr5PqUGXX+iCCK3m7UHGU
 hSItipKN6yip+R9BEN7WBgfiNKumrSUDmGkhl4pedNaH0iueZec3m71EAf0PQUV+sn6EvV
 fkVsr43wAXlewT5bj8jHOd02VR8qIwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siYhd8lfcKl6DaZYWHoeO4wLOF9SQ2u5cXR0BHzcmxs=;
 b=WHoWKuaVGsjNlWae7mW/XKaxlgyj88kLn2hJu2lOL/7U8TqX83XbhWQdDEy3zbcnxobWl3
 HOY/FDe0fkcvEwDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siYhd8lfcKl6DaZYWHoeO4wLOF9SQ2u5cXR0BHzcmxs=;
 b=qjbGFP+9Gj0C/pNNL6CyEu+XmmS98yg5A/2MehfAc+laYi1qEHr5PqUGXX+iCCK3m7UHGU
 hSItipKN6yip+R9BEN7WBgfiNKumrSUDmGkhl4pedNaH0iueZec3m71EAf0PQUV+sn6EvV
 fkVsr43wAXlewT5bj8jHOd02VR8qIwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siYhd8lfcKl6DaZYWHoeO4wLOF9SQ2u5cXR0BHzcmxs=;
 b=WHoWKuaVGsjNlWae7mW/XKaxlgyj88kLn2hJu2lOL/7U8TqX83XbhWQdDEy3zbcnxobWl3
 HOY/FDe0fkcvEwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C83E013722;
 Fri,  1 Nov 2024 10:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YK5EIBeyJGcIUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 01 Nov 2024 10:48:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 01 Nov 2024 11:48:26 +0100
MIME-Version: 1.0
Message-Id: <20241101-generate_syscalls-v9-1-d2c3820b0323@suse.com>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
In-Reply-To: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730458133; l=10492;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=EvVQe8o/D/xhT6n/7Im0/mG3Rkxikqo2FkStL7+GBz4=;
 b=Mv53fKB7C5KfBAg3bxoE4bzZKbuGbpMvJ564nvXMJns+6UJIutHmrZ/OlMzmz4FqkihiVQ3iw
 s/N0sxndrHHBCV3LrUHPp5aTktjY/FZXk9VWMdGrmehlxLvnaDFUl1c
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/5] Refactor regen.sh script to generate syscalls
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
simplifying the code. Architecture *.in files have been renamed to
follow the new supported-syscalls.txt naming convention.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac                                       |   2 +-
 include/lapi/syscalls/{aarch64.in => arm64.in}     |   0
 include/lapi/syscalls/generate_syscalls.sh         | 109 +++++++++++++++++
 .../lapi/syscalls/{loongarch.in => loongarch64.in} |   0
 include/lapi/syscalls/{mips_n64.in => mips64.in}   |   0
 .../lapi/syscalls/{mips_n32.in => mips64n32.in}    |   0
 include/lapi/syscalls/{mips_o32.in => mipso32.in}  |   0
 include/lapi/syscalls/{hppa.in => parisc.in}       |   0
 include/lapi/syscalls/regen.sh                     | 129 ---------------------
 .../lapi/syscalls/{order => supported-arch.txt}    |  12 +-
 10 files changed, 116 insertions(+), 136 deletions(-)

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
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/arm64.in
similarity index 100%
rename from include/lapi/syscalls/aarch64.in
rename to include/lapi/syscalls/arm64.in
diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
new file mode 100755
index 0000000000000000000000000000000000000000..b17c72ddf09cff4f55b7ef80856cd97862ce1317
--- /dev/null
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -0,0 +1,109 @@
+#!/bin/sh -eu
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
+echo '// SPDX-License-Identifier: GPL-2.0-or-later
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
+
+		echo "# ifndef ${syscall_nr}"
+		echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
+		echo "# endif"
+	done
+	echo "#endif"
+) >>${SYSCALLS_FILE}
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch64.in
similarity index 100%
rename from include/lapi/syscalls/loongarch.in
rename to include/lapi/syscalls/loongarch64.in
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips64.in
similarity index 100%
rename from include/lapi/syscalls/mips_n64.in
rename to include/lapi/syscalls/mips64.in
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips64n32.in
similarity index 100%
rename from include/lapi/syscalls/mips_n32.in
rename to include/lapi/syscalls/mips64n32.in
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mipso32.in
similarity index 100%
rename from include/lapi/syscalls/mips_o32.in
rename to include/lapi/syscalls/mipso32.in
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/parisc.in
similarity index 100%
rename from include/lapi/syscalls/hppa.in
rename to include/lapi/syscalls/parisc.in
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
similarity index 58%
rename from include/lapi/syscalls/order
rename to include/lapi/syscalls/supported-arch.txt
index c18aa38cf4546cdf3ac8c89a45bd1b202ffa7711..c5c5191ac08482d89f0a8c39dfae936538f58f7f 100644
--- a/include/lapi/syscalls/order
+++ b/include/lapi/syscalls/supported-arch.txt
@@ -1,13 +1,13 @@
-aarch64
 arc
+arm64
 arm
-hppa
 i386
 ia64
-loongarch
-mips_n32
-mips_n64
-mips_o32
+loongarch64
+mips64n32
+mips64
+mipso32
+parisc
 powerpc64
 powerpc
 s390x

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
