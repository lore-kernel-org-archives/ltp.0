Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF7AE6B242
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:49:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D07353CD32E
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 11:49:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA0B83CD2E9
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:49:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AF11164552C
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:49:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D943C21B4B;
 Fri,  1 Nov 2024 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBvfMbftPQsKgAY8g3BeK38MOEdB3bsAyGSQbJg2+pk=;
 b=acrQWPlvX+v/742wC37D6ljEtAtfWFATstuV1Zo4UK0yg012TnBSa+UeTKdnZlhzdOIxnN
 WBsGNGQHy+vid2Gf+E8vHVjLpLL8CVXhsf9ZdhRClvR/3LFHbJ35rlC5tMOH4gTCzJX1VJ
 gcVCyQz3qY93sL6Q63hBglHBNL8iVDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBvfMbftPQsKgAY8g3BeK38MOEdB3bsAyGSQbJg2+pk=;
 b=uw28lOaGK4tBnLZ9xKOdp2Cc9jkxVIR9nEWBCPd50yooookM2RiggtSeywle+YK8otc9J4
 qMjCGBgX/QknAiBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBvfMbftPQsKgAY8g3BeK38MOEdB3bsAyGSQbJg2+pk=;
 b=jJL7P2TNayhPHbT0G8VS6x2tvX8EkJgnmcXOypn6L2uB4buSv1yr+VSFTBbMFUc/+UU1iU
 ZVv3IXh0iXJKs1fWkocNddjs7uNv8bsNWAfk6dnESr6RQ82FEzQCMPKy3EQD8SsiyIHUH+
 k5QSt3DFtEiu0wtulfOeAqfQlTqLjZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBvfMbftPQsKgAY8g3BeK38MOEdB3bsAyGSQbJg2+pk=;
 b=NO21/Ny9gbiWbLszVePsSB+CDyK8x8ZF0lR2wi91/DdMJL6UwkCAjWGe8hUBlDHAtoBJjU
 UM7zWQcgFWmt5PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C0AD13722;
 Fri,  1 Nov 2024 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uB9nERqyJGcIUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 01 Nov 2024 10:48:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 01 Nov 2024 11:48:27 +0100
MIME-Version: 1.0
Message-Id: <20241101-generate_syscalls-v9-2-d2c3820b0323@suse.com>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
In-Reply-To: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730458133; l=6483;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Z0PiU2prwOV6bqhEyMPuNh2AZk20SA4pCkY92A35v58=;
 b=iPTBEPvK67BrRwEzZV34DEctBDEvQNR2V+sRyGNAmLtVoyxMk61tWFJnF9+Rc3jJxoz9e6fJn
 b80gPspAZhvAq8T5rPw5E5TToGfdVjjYyhUKuqqHpSXOJFNdP4zHhxN
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/5] Add script to generate arch(s) dependant
 syscalls
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

Add generate_arch.sh script which can be used to generate arch(s)
dependant syscalls file. The way it works is pretty simple: for each
architecture defined into supported-arch.txt, compile kernel headers,
extract the list of syscalls and generate a .in file containing all of
them, associated with their own syscall's number.
The way syscalls files are generated, passes through a C application
which is automatically checking the availability of the syscalls in
the user space environment.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/generate_arch.sh | 213 +++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/include/lapi/syscalls/generate_arch.sh b/include/lapi/syscalls/generate_arch.sh
new file mode 100755
index 0000000000000000000000000000000000000000..5d731794d6492a76c3ba39ac0117b60d8a374740
--- /dev/null
+++ b/include/lapi/syscalls/generate_arch.sh
@@ -0,0 +1,213 @@
+#!/bin/sh -eu
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2009-2024
+# Copyright (c) Marcin Juszkiewicz, 2023-2024
+#
+# This is an adaptation of the update-tables.sh script, included in the
+# syscalls-table project (https://github.com/hrw/syscalls-table) and released
+# under the MIT license.
+#
+# Author: Andrea Cervesato <andrea.cervesato@suse.com>
+
+if [ "$#" -eq "0" ]; then
+	echo "Please provide kernel sources:"
+	echo ""
+	echo "$0 path/to/Linux/kernel/sources"
+	echo ""
+	exit 1
+fi
+
+KERNELSRC="$1"
+
+# to keep sorting in order
+export LC_ALL=C
+
+if [ ! -d "${KERNELSRC}" ]; then
+	echo "${KERNELSRC} is not a directory"
+	exit 1
+fi
+
+if [ ! -e "${KERNELSRC}/Makefile" ]; then
+	echo "No Makefile in ${KERNELSRC} directory"
+	exit 1
+fi
+
+TEMP="$(mktemp -d)"
+KVER="$(make -C ${KERNELSRC} kernelversion -s)"
+
+SCRIPT_DIR="$(realpath $(dirname "$0"))"
+SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
+LINUX_HEADERS="${TEMP}/headers"
+
+grab_syscall_names_from_tables() {
+	for tbl_file in $(find ${KERNELSRC}/arch -name syscall*.tbl); do
+		grep -E -v "(^#|^$|sys_ni_syscall)" $tbl_file |
+			awk '{ print $3 }' >>${TEMP}/syscall-names.tosort
+	done
+
+	drop_bad_entries
+}
+
+grab_syscall_names_from_unistd_h() {
+	grep -E -h "^#define __NR_" \
+		${LINUX_HEADERS}/usr/include/asm/unistd*.h \
+		${LINUX_HEADERS}/usr/include/asm-generic/unistd.h \
+		>${TEMP}/syscall-names.tosort
+
+	drop_bad_entries
+}
+
+drop_bad_entries() {
+	grep -E -v "(unistd.h|NR3264|__NR_syscall|__SC_COMP|__NR_.*Linux|__NR_FAST)" \
+		${TEMP}/syscall-names.tosort |
+		grep -E -v "(__SYSCALL|SYSCALL_BASE|SYSCALL_MASK)" |
+		sed -e "s/#define\s*__NR_//g" -e "s/\s.*//g" |
+		sort -u >${TEMP}/syscall-names.txt
+}
+
+generate_table() {
+	echo "- $arch"
+
+	if [ "$bits" -eq "32" ]; then
+		extraflags="${extraflags} -D__BITS_PER_LONG=32"
+	fi
+
+	local uppercase_arch=$(echo "$arch" | tr '[:lower:]' '[:upper:]')
+
+	# ignore any error generated by gcc. We want to obtain all the
+	# available architecture syscalls for the current platform and to handle
+	# only supported architectures later on
+	gcc ${TEMP}/list-syscalls.c -U__LP64__ -U__ILP32__ -U__i386__ \
+		-D${uppercase_arch} \
+		-D__${arch}__ ${extraflags} \
+		-I ${LINUX_HEADERS}/usr/include/ \
+		-o ${TEMP}/list-syscalls || true
+
+	${TEMP}/list-syscalls >"${TEMP}/${arch}.in.tosort"
+
+	sort -k2,2n "${TEMP}/${arch}.in.tosort" >"${TEMP}/${arch}.in"
+}
+
+generate_list_syscalls_c() {
+	(
+		printf "
+		#include <stdio.h>
+		#include <asm/unistd.h>
+
+		int main(void)
+		{
+		"
+		for syscall in $(cat ${TEMP}/syscall-names.txt); do
+			printf "
+		#ifdef __NR_$syscall
+			printf(\"$syscall %%d"
+			# i know the following print is ugly, but dash and bash
+			# treat double quoted strings in a different way and we
+			# really need to inject '\n' character in the C code
+			# rather than carriage return
+			printf '\\n'
+			printf "\", __NR_$syscall);
+		#endif
+		"
+		done
+		printf " return 0;
+		}"
+	) >${TEMP}/list-syscalls.c
+}
+
+export_headers() {
+	make -s -C ${KERNELSRC} ARCH=${arch} O=${LINUX_HEADERS} \
+		headers_install >/dev/null 2>&1
+}
+
+do_all_tables() {
+	for archdir in ${KERNELSRC}/arch/*; do
+		arch=$(basename $archdir)
+
+		bits=64
+		extraflags=
+
+		case ${arch} in
+		Kconfig)
+			continue
+			;;
+		um)
+			continue
+			;;
+		esac
+
+		export_headers
+		grab_syscall_names_from_unistd_h
+
+		case ${arch} in
+		arm)
+			bits=32
+			arch=armoabi extraflags= generate_table
+			arch=arm extraflags=-D__ARM_EABI__ generate_table
+			;;
+		loongarch)
+			# 32-bit variant of loongarch may appear
+			arch=loongarch64 extraflags=-D_LOONGARCH_SZLONG=64 generate_table
+			;;
+		mips)
+			arch=mips64 extraflags=-D_MIPS_SIM=_MIPS_SIM_ABI64 generate_table
+			bits=32
+			arch=mipso32 extraflags=-D_MIPS_SIM=_MIPS_SIM_ABI32 generate_table
+			arch=mips64n32 extraflags=-D_MIPS_SIM=_MIPS_SIM_NABI32 generate_table
+			;;
+		powerpc)
+			generate_table
+			arch=powerpc64 generate_table
+			;;
+		riscv)
+			arch=riscv64 extraflags=-D__LP64__ generate_table
+			bits=32
+			arch=riscv32 extraflags=-D__SIZEOF_POINTER__=4 generate_table
+			;;
+		s390)
+			bits=32
+			generate_table
+			bits=64
+			arch=s390x generate_table
+			;;
+		sparc)
+			bits=32
+			extraflags=-D__32bit_syscall_numbers__ generate_table
+			bits=64
+			arch=sparc64 extraflags=-D__arch64__ generate_table
+			;;
+		x86)
+			arch=x86_64 extraflags=-D__LP64__ generate_table
+			bits=32
+			arch=i386 generate_table
+			arch=x32 extraflags=-D__ILP32__ generate_table
+			;;
+		arc | csky | hexagon | m68k | microblaze | nios2 | openrisc | sh | xtensa)
+			bits=32 generate_table
+			;;
+		*)
+			generate_table
+			;;
+		esac
+	done
+}
+
+copy_supported_arch() {
+	while IFS= read -r arch; do
+		if [ -f "${TEMP}/${arch}.in" ]; then
+			echo "- ${arch}"
+			cp "${TEMP}/${arch}.in" "${SCRIPT_DIR}/${arch}.in"
+		fi
+	done <${SUPPORTED_ARCH}
+}
+
+echo "Temporary directory ${TEMP}"
+echo "Extracting syscalls"
+
+grab_syscall_names_from_tables
+generate_list_syscalls_c
+
+do_all_tables
+
+echo "Copying supported syscalls"
+copy_supported_arch

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
