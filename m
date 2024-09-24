Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D199DCF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 08:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3E743C4C90
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 10:07:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E0FC3C28AE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:54 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B95731000D1D
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A12D21B07
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0Mjn8LjdHUAL5Cq1iLwo4VnXUofDEQp0BQDzOh6ySc=;
 b=Ugwn1hO9kyhKVKUQshaKK4RZVRnxV2I4I8TrgpIIAccDsnYbkbgasnREHq3jy0Yld8cCJ4
 uPhyYBjOmEhKOimZdbJ5o3qgDj+QFr4Obzx+jX82FhCKEevSXb2NDBryWsf18BLjplvHyW
 +Vq46G3iq4QCfVp4+Hi6k1TdRQkYWEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0Mjn8LjdHUAL5Cq1iLwo4VnXUofDEQp0BQDzOh6ySc=;
 b=9oISzUDtgJwVk2MlV8lpqsoZOcGNbsJkrZh5Sp/8FA5LUHrt0qsuEjKd7Y+lu+KgKqtllN
 23M7FazhZq6ZQkDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0Mjn8LjdHUAL5Cq1iLwo4VnXUofDEQp0BQDzOh6ySc=;
 b=Ugwn1hO9kyhKVKUQshaKK4RZVRnxV2I4I8TrgpIIAccDsnYbkbgasnREHq3jy0Yld8cCJ4
 uPhyYBjOmEhKOimZdbJ5o3qgDj+QFr4Obzx+jX82FhCKEevSXb2NDBryWsf18BLjplvHyW
 +Vq46G3iq4QCfVp4+Hi6k1TdRQkYWEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0Mjn8LjdHUAL5Cq1iLwo4VnXUofDEQp0BQDzOh6ySc=;
 b=9oISzUDtgJwVk2MlV8lpqsoZOcGNbsJkrZh5Sp/8FA5LUHrt0qsuEjKd7Y+lu+KgKqtllN
 23M7FazhZq6ZQkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87ADB13AEE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +LO7Hxtz8mYVcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Sep 2024 10:06:27 +0200
MIME-Version: 1.0
Message-Id: <20240924-generate_syscalls-v1-2-941507a9cdac@suse.com>
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
In-Reply-To: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727165210; l=8491;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=9TGxABYNaWqVN75mxufgMlt9rzJy+Ff6sR9NHebbifU=;
 b=1LkSbe3SgGZAnPNBkJM6qJ5DXouiZ+VhmE+RBFvDnNa4g2StoRHAUFowUGTzcp3IJoFgtELLG
 ccq89wCB7xlBI7GFbvDWvnSBxqmeRoetjMFJyAr7lNlmxbyqkgRQBuR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] Add script to generate syscalls.h
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

Replicate the https://github.com/hrw/syscalls-table project way, by
creating a script that automatically generate syscalls input files,
merge them like regen.sh script does and to create syscalls.h header
file which can be used by LTP tests to access syscalls values accoring
to the architecture.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/blacklist-syscalls.txt |   6 +
 include/lapi/syscalls/generate_syscalls.sh   | 292 +++++++++++++++++++++++++++
 2 files changed, 298 insertions(+)

diff --git a/include/lapi/syscalls/blacklist-syscalls.txt b/include/lapi/syscalls/blacklist-syscalls.txt
new file mode 100644
index 000000000..e1ae5f76f
--- /dev/null
+++ b/include/lapi/syscalls/blacklist-syscalls.txt
@@ -0,0 +1,6 @@
+arch_specific_syscall
+available
+ni_syscall
+reserved
+SYSCALL_MASK
+unused
diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
new file mode 100755
index 000000000..f7bcbd50e
--- /dev/null
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -0,0 +1,292 @@
+#!/bin/sh
+#
+# Script to generate the syscalls file for supported architectures.
+# Based on https://github.com/hrw/syscalls-table/
+#
+# Author: Andrea Cervesato <andrea.cervesato@suse.com>
+
+TEMP=$(mktemp -d)
+LINUX_SRC="$1"
+SYSCALLS_FILE="$2"
+
+if [ -z "${LINUX_SRC}" ]; then
+	echo "Give the path of Linux kernel sources:"
+	echo ""
+	echo "$0 linux/kernel/sources path/to/syscalls.h"
+	echo ""
+	exit 1
+fi
+
+if [ ! -e "${LINUX_SRC}/Makefile" ]; then
+	echo "No Makefile in ${LINUX_SRC} directory!"
+	exit 1
+fi
+
+if [ -z "${SYSCALLS_FILE}" ]; then
+	echo "No syscalls.h file location has been provided:"
+	echo ""
+	echo "$0 linux/kernel/sources path/to/syscalls.h"
+	echo ""
+	exit 1
+fi
+
+export LC_ALL=C
+
+SUPPORTED_ARCH="${PWD}/supported-arch.txt"
+LINUX_HEADERS="${TEMP}/headers"
+SYSCALLS_NAMES="${TEMP}/syscalls-names.txt"
+GENERATOR_BIN="${TEMP}/list-syscalls"
+GENERATOR_SRC="${GENERATOR_BIN}.c"
+
+build_headers() {
+	local arch="$1"
+
+	echo "Building linux headers..."
+
+	make -s -C ${LINUX_SRC} \
+		ARCH=${arch} \
+		O=${LINUX_HEADERS} \
+		headers_install >/dev/null
+}
+
+extract_syscalls() {
+	local arch="$1"
+	local flags="$2"
+
+	echo "Extracting syscalls names..."
+
+	grep -E -h "^#define __NR_" \
+		${LINUX_HEADERS}/usr/include/asm/unistd*.h \
+		${LINUX_HEADERS}/usr/include/asm-generic/unistd.h > \
+		${TEMP}/syscalls-names.tosort
+
+	grep -E -v "(unistd.h|NR3264|__NR_syscall|__SC_COMP|__NR_.*Linux|__NR_FAST)" \
+		${TEMP}/syscalls-names.tosort |
+		grep -E -vi "(not implemented|available|unused|reserved|xtensa|spill)" |
+		grep -E -v "(__SYSCALL|SYSCALL_BASE|SYSCALL_MASK)" |
+		sed -e "s/#define\s*__NR_//g" -e "s/\s.*//g" |
+		sort -u >${SYSCALLS_NAMES}
+
+	grep -w -v -f ${PWD}/blacklist-syscalls.txt ${TEMP}/syscall-names.txt |
+		sort -u >${TEMP}/syscall-names.txt
+
+	(
+		echo
+		echo "
+		#include <stdio.h>
+		#include <asm/unistd.h>
+
+		int main(void) {"
+		while IFS= read -r syscall; do
+			echo "
+		#ifdef __NR_$syscall
+			printf(\"$syscall\\t%d\\n\", __NR_$syscall);
+		#endif"
+		done < ${SYSCALLS_NAMES}
+		echo "return 0; }"
+	) >> ${GENERATOR_SRC}
+
+	local uppercase_arch=$(echo "$arch" | tr '[:lower:]' '[:upper:]')
+
+	gcc ${GENERATOR_SRC} -U__LP64__ -U__ILP32__ -U__i386__ \
+		-D${uppercase_arch} -D__${arch}__ ${flags} \
+		-I ${LINUX_HEADERS}/usr/include/ \
+		-o ${GENERATOR_BIN} &>/dev/null
+
+	echo "Generating ${arch}.in ..."
+
+	${GENERATOR_BIN} > "${TEMP}/${arch}.in"
+}
+
+generate_syscalls() {
+	while IFS= read -r arch; do
+		echo "Preparing syscalls for ${arch} architecture..."
+
+		case ${arch} in
+		aarch64)
+			build_headers "arm64"
+			extract_syscalls "${arch}" "-D__ARM_EABI__"
+			;;
+		arc)
+			build_headers "arc"
+			extract_syscalls "${arch}" "-D__BITS_PER_LONG=32"
+			;;
+		arm)
+			build_headers "arm"
+			extract_syscalls "${arch}" "-D__BITS_PER_LONG=32"
+			;;
+		hppa)
+			build_headers "parisc"
+			extract_syscalls "${arch}" ""
+			;;
+		i386)
+			build_headers "x86"
+			extract_syscalls "${arch}" "-D__BITS_PER_LONG=32"
+			;;
+		ia64)
+			# ia64 has been removed from the kernel, so we copy its
+			# last generated input file
+			echo "Copying ia64.in ..."
+			cp ${PWD}/ia64.in ${TEMP}/ia64.in
+			;;
+		loongarch)
+			build_headers "loongarch"
+			extract_syscalls "${arch}" "-D_LOONGARCH_SZLONG=64"
+			;;
+		mips_n32)
+			build_headers "mips"
+			extract_syscalls "${arch}" "-D_MIPS_SIM=_MIPS_SIM_NABI32"
+			;;
+		mips_n64)
+			build_headers "mips"
+			extract_syscalls "${arch}" "-D_MIPS_SIM=_MIPS_SIM_ABI64"
+			;;
+		mips_o32)
+			build_headers "mips"
+			extract_syscalls "${arch}" "-D_MIPS_SIM=_MIPS_SIM_ABI32"
+			;;
+		powerpc)
+			build_headers "powerpc"
+			extract_syscalls "${arch}" "-D__BITS_PER_LONG=32"
+			;;
+		powerpc64)
+			build_headers "powerpc"
+			extract_syscalls "${arch}" ""
+			;;
+		s390)
+			build_headers "s390"
+			extract_syscalls "${arch}" "-D__BITS_PER_LONG=32"
+			;;
+		s390x)
+			build_headers "s390"
+			extract_syscalls "${arch}" ""
+			;;
+		sh)
+			build_headers "sh"
+			extract_syscalls "${arch}" "-D__BITS_PER_LONG=32"
+			;;
+		sparc)
+			build_headers "sparc"
+			extract_syscalls "${arch}" "-D__32bit_syscall_numbers__ -D__BITS_PER_LONG=32"
+			;;
+		sparc64)
+			build_headers "sparc64"
+			extract_syscalls "${arch}" "-D__arch64__"
+			;;
+		x86_64)
+			build_headers "x86_64"
+			extract_syscalls "${arch}" "-D__LP64__"
+			;;
+		*)
+			echo "Can't find '${arch}' architecture"
+			exit 1
+			;;
+		esac
+	done < ${SUPPORTED_ARCH}
+}
+
+merge_syscalls() {
+	echo "Merging syscalls files..."
+
+	echo '
+/************************************************
+ * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
+ *  change your arch specific .in file instead  *
+ ************************************************/
+
+/*
+ * Here we stick all the ugly *fallback* logic for linux
+ * system call numbers (those __NR_ thingies).
+ *
+ * Licensed under the GPLv2 or later, see the COPYING file.
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
+	tst_brk(TCONF, \
+		"syscall(%d) " SNR " not supported on your arch", NR); \
+})
+#else
+inline static void dummy_cleanup(void) {}
+
+#define TST_SYSCALL_BRK__(NR, SNR) ({ \
+	tst_brkm(TCONF, dummy_cleanup, \
+		"syscall(%d) " SNR " not supported on your arch", NR); \
+})
+#endif
+
+#define tst_syscall(NR, ...) ({ \
+	intptr_t tst_ret; \
+	if (NR == __LTP__NR_INVALID_SYSCALL) { \
+		errno = ENOSYS; \
+		tst_ret = -1; \
+	} else { \
+		tst_ret = syscall(NR, ##__VA_ARGS__); \
+	} \
+	if (tst_ret == -1 && errno == ENOSYS) { \
+		TST_SYSCALL_BRK__(NR, #NR); \
+	} \
+	tst_ret; \
+})
+
+#define __LTP__NR_INVALID_SYSCALL -1' > ${SYSCALLS_FILE}
+
+	local syscall_nr=""
+
+	while IFS= read -r arch; do
+	(
+		echo
+		case ${arch} in
+		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
+		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
+		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
+		mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
+		mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
+		mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
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
+		done <"${TEMP}/${arch}.in"
+		echo "#endif"
+		echo
+	) >> ${SYSCALLS_FILE}
+	done < ${SUPPORTED_ARCH}
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
+			done < ${TEMP}/${arch}.in
+		done < ${SUPPORTED_ARCH}
+		echo "#endif"
+	) >> ${SYSCALLS_FILE}
+}
+
+echo "Temporary folder: ${TEMP}"
+
+generate_syscalls
+merge_syscalls
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
