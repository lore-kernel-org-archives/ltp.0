Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2567FCA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:33:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41BB83E55D8
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:33:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9A1A3E2713
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:32:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF81A200B75
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:32:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD0721E8C;
 Wed, 30 Sep 2026 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790757161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwPd/LSqLk8v6q5rn6ge/AggQ1V0wRguZDriIinhKNs=;
 b=kCXqm98t6fcIuEuof0KSTtuVMAU5/h11FvTfC5/LX5SM3H1s9lGZDDJMiD8TxAXvNcTT63
 xXew/aedUOC1eOxvyMAjuQctDoFgF6/BsjUopc9xlBS5TqSGrZ+on3KsG9OVY+BMgDt8ky
 rV1ftcjPeEiNk4f6y/l2o+9y2oZ5scw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790757161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwPd/LSqLk8v6q5rn6ge/AggQ1V0wRguZDriIinhKNs=;
 b=qKP21xPuUWHLmfg6ecp1Mj6D/8eWoQaZkhNBEG/2sYy9sC9ueYwYVM9aRnFcPuGV9/tlYy
 TAPC1VHtNUIEh6Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790757157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwPd/LSqLk8v6q5rn6ge/AggQ1V0wRguZDriIinhKNs=;
 b=pZ8Zb6J7+sZcWYNxR7Q/ZKIzbIOw9RX99vHnCcKk+sKtN3YgG0vGJeiLbbJytSD07cBjra
 4QPdb2hSjXiYVpSygcudamuNt6c1hWSkcLsbjFNDn/UCvgUep6A6lmK3XFZITur5K2VW0A
 THUFHxllCYjdKe7o/8v5+g+0cC073FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790757157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwPd/LSqLk8v6q5rn6ge/AggQ1V0wRguZDriIinhKNs=;
 b=EUAAqcFTvbVadwQ94U68ZrSZl1Vy06eWs+HlGihV///EJS7SdSmoTrs8QsxhYxe8nTVGo6
 BaAvxYM7x8AYHbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11C8B13A90;
 Wed, 30 Sep 2026 08:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 409TLSTJvGpCfQAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Sep 2026 08:32:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 10:32:34 +0200
MIME-Version: 1.0
Message-Id: <20260930-fix_generate_syscalls-v1-1-fccaef437fa1@suse.com>
References: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
In-Reply-To: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790757156; l=5882;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=d7ugWBQRqLLHRrpclpWKjktikpaJbCAsUoD3v4CHcik=;
 b=RG3GnzAKBJ2LS8nVU05EsVmCQWDfqa5Wwz1RLNclU/4Opi5JvOWdi45qEdG7VOMkqMXJsLWrE
 R2EgeUy4FSsBCUwLCVxy6J94MHHaYy0CtW8zfQFgI0ycRN/BIhr3cYl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] generate_arch.sh: Fix syscall extraction bugs
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

Do not filter out sys_ni_syscall from tables and seed syscall names
from generic headers and existing tables so legacy syscalls like
_sysctl and timerfd are preserved.

Check s390 header macros to detect 31-bit ABI availability instead of
overwriting s390.in with 64-bit definitions on newer kernels.

Fail immediately when compilation fails for a supported architecture
rather than silently continuing.

Fixes: 1694fd203cf1 ("Add script to generate arch(s) dependant syscalls")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/generate_arch.sh | 99 +++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/include/lapi/syscalls/generate_arch.sh b/include/lapi/syscalls/generate_arch.sh
index 5d731794d..969c1b6da 100755
--- a/include/lapi/syscalls/generate_arch.sh
+++ b/include/lapi/syscalls/generate_arch.sh
@@ -33,6 +33,7 @@ if [ ! -e "${KERNELSRC}/Makefile" ]; then
 fi
 
 TEMP="$(mktemp -d)"
+trap 'rm -rf "${TEMP}"' EXIT
 KVER="$(make -C ${KERNELSRC} kernelversion -s)"
 
 SCRIPT_DIR="$(realpath $(dirname "$0"))"
@@ -41,18 +42,16 @@ LINUX_HEADERS="${TEMP}/headers"
 
 grab_syscall_names_from_tables() {
 	for tbl_file in $(find ${KERNELSRC}/arch -name syscall*.tbl); do
-		grep -E -v "(^#|^$|sys_ni_syscall)" $tbl_file |
+		grep -E -v "^(#|$)" "$tbl_file" |
 			awk '{ print $3 }' >>${TEMP}/syscall-names.tosort
 	done
 
-	drop_bad_entries
-}
-
-grab_syscall_names_from_unistd_h() {
 	grep -E -h "^#define __NR_" \
-		${LINUX_HEADERS}/usr/include/asm/unistd*.h \
-		${LINUX_HEADERS}/usr/include/asm-generic/unistd.h \
-		>${TEMP}/syscall-names.tosort
+		${KERNELSRC}/include/uapi/asm-generic/unistd.h \
+		${KERNELSRC}/arch/*/include/uapi/asm/unistd*.h \
+		>>${TEMP}/syscall-names.tosort 2>/dev/null || true
+
+	awk '{ print $1 }' ${SCRIPT_DIR}/*.in >>${TEMP}/syscall-names.tosort
 
 	drop_bad_entries
 }
@@ -60,6 +59,7 @@ grab_syscall_names_from_unistd_h() {
 drop_bad_entries() {
 	grep -E -v "(unistd.h|NR3264|__NR_syscall|__SC_COMP|__NR_.*Linux|__NR_FAST)" \
 		${TEMP}/syscall-names.tosort |
+		grep -E -vi "(not implemented|available|unused|reserved|spill|xtensa)" |
 		grep -E -v "(__SYSCALL|SYSCALL_BASE|SYSCALL_MASK)" |
 		sed -e "s/#define\s*__NR_//g" -e "s/\s.*//g" |
 		sort -u >${TEMP}/syscall-names.txt
@@ -68,51 +68,43 @@ drop_bad_entries() {
 generate_table() {
 	echo "- $arch"
 
+	local flags="${extraflags:-}"
 	if [ "$bits" -eq "32" ]; then
-		extraflags="${extraflags} -D__BITS_PER_LONG=32"
+		flags="${flags} -D__BITS_PER_LONG=32"
 	fi
 
 	local uppercase_arch=$(echo "$arch" | tr '[:lower:]' '[:upper:]')
 
-	# ignore any error generated by gcc. We want to obtain all the
-	# available architecture syscalls for the current platform and to handle
-	# only supported architectures later on
-	gcc ${TEMP}/list-syscalls.c -U__LP64__ -U__ILP32__ -U__i386__ \
+	rm -f "${TEMP}/list-syscalls"
+	gcc "${TEMP}/list-syscalls.c" -U__LP64__ -U__ILP32__ -U__i386__ \
 		-D${uppercase_arch} \
-		-D__${arch}__ ${extraflags} \
-		-I ${LINUX_HEADERS}/usr/include/ \
-		-o ${TEMP}/list-syscalls || true
+		-D__${arch}__ ${flags} \
+		-I "${LINUX_HEADERS}/usr/include/" \
+		-o "${TEMP}/list-syscalls" || {
+		echo "Failed to compile list-syscalls for $arch" >&2
+		if grep -Fxq "$arch" "${SUPPORTED_ARCH}"; then
+			return 1
+		fi
+		return 0
+	}
 
-	${TEMP}/list-syscalls >"${TEMP}/${arch}.in.tosort"
+	"${TEMP}/list-syscalls" >"${TEMP}/${arch}.in.tosort"
 
 	sort -k2,2n "${TEMP}/${arch}.in.tosort" >"${TEMP}/${arch}.in"
 }
 
 generate_list_syscalls_c() {
-	(
-		printf "
-		#include <stdio.h>
-		#include <asm/unistd.h>
-
-		int main(void)
-		{
-		"
-		for syscall in $(cat ${TEMP}/syscall-names.txt); do
-			printf "
-		#ifdef __NR_$syscall
-			printf(\"$syscall %%d"
-			# i know the following print is ugly, but dash and bash
-			# treat double quoted strings in a different way and we
-			# really need to inject '\n' character in the C code
-			# rather than carriage return
-			printf '\\n'
-			printf "\", __NR_$syscall);
-		#endif
-		"
-		done
-		printf " return 0;
-		}"
-	) >${TEMP}/list-syscalls.c
+	{
+		echo "#include <stdio.h>"
+		echo "#include <asm/unistd.h>"
+		echo
+		echo "int main(void)"
+		echo "{"
+		awk '{ printf "#ifdef __NR_%s\n\tprintf(\"%s %%d\\n\", __NR_%s);\n#endif\n", $1, $1, $1 }' \
+			"${TEMP}/syscall-names.txt"
+		echo "	return 0;"
+		echo "}"
+	} >"${TEMP}/list-syscalls.c"
 }
 
 export_headers() {
@@ -128,16 +120,16 @@ do_all_tables() {
 		extraflags=
 
 		case ${arch} in
-		Kconfig)
-			continue
-			;;
-		um)
+		Kconfig|um)
 			continue
 			;;
 		esac
 
+		if [ ! -f "${archdir}/Makefile" ] && [ ! -f "${archdir}/Kconfig" ]; then
+			continue
+		fi
+
 		export_headers
-		grab_syscall_names_from_unistd_h
 
 		case ${arch} in
 		arm)
@@ -156,8 +148,8 @@ do_all_tables() {
 			arch=mips64n32 extraflags=-D_MIPS_SIM=_MIPS_SIM_NABI32 generate_table
 			;;
 		powerpc)
-			generate_table
-			arch=powerpc64 generate_table
+			bits=32 generate_table
+			bits=64 arch=powerpc64 generate_table
 			;;
 		riscv)
 			arch=riscv64 extraflags=-D__LP64__ generate_table
@@ -165,8 +157,15 @@ do_all_tables() {
 			arch=riscv32 extraflags=-D__SIZEOF_POINTER__=4 generate_table
 			;;
 		s390)
-			bits=32
-			generate_table
+			# Older kernels define both ABIs directly in unistd.h.
+			gcc -E -dM -x c -D__s390__ -U__s390x__ \
+				-I "${LINUX_HEADERS}/usr/include/" \
+				-include asm/unistd.h /dev/null >"${TEMP}/s390-macros"
+			if grep -q '^#define __NR_getuid32 ' "${TEMP}/s390-macros"; then
+				bits=32 generate_table
+			else
+				echo "- s390 (31-bit ABI not available, skipping)"
+			fi
 			bits=64
 			arch=s390x generate_table
 			;;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
