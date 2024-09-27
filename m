Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1EDCEBF8C
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A3733C4FEC
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:50:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97CF83C4EBC
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:33 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 720D2205CE5
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B32431FD9F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNzgxdloit8E39bhFj8uiccimP+YdKku3Q8OwrCoOkU=;
 b=WEuva37bruAs8HuzFF4eoFWsEHfw/Qrb1FDTnyU2Jszz/nKXvJy/+IPaXud7/Z5m4icalQ
 CSFhiyf5aYy647RKij8dOG1EOziAmtGz999AjR/htn3mMdz4ZqOIQqxewBJrvSmje6iYEB
 BwgZivMIkTk7TnIveWlFXUMPl1Qe58s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNzgxdloit8E39bhFj8uiccimP+YdKku3Q8OwrCoOkU=;
 b=wwlo3PpjKj45XYRsIvGpQMEn6p2rrOjIBBMch0hmAXtPWazeg9Dll2ZZ8AmKQrkP/kG/ow
 8h1Cy/5k+03SBkAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WEuva37b;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wwlo3Ppj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNzgxdloit8E39bhFj8uiccimP+YdKku3Q8OwrCoOkU=;
 b=WEuva37bruAs8HuzFF4eoFWsEHfw/Qrb1FDTnyU2Jszz/nKXvJy/+IPaXud7/Z5m4icalQ
 CSFhiyf5aYy647RKij8dOG1EOziAmtGz999AjR/htn3mMdz4ZqOIQqxewBJrvSmje6iYEB
 BwgZivMIkTk7TnIveWlFXUMPl1Qe58s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNzgxdloit8E39bhFj8uiccimP+YdKku3Q8OwrCoOkU=;
 b=wwlo3PpjKj45XYRsIvGpQMEn6p2rrOjIBBMch0hmAXtPWazeg9Dll2ZZ8AmKQrkP/kG/ow
 8h1Cy/5k+03SBkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C7D413AC3
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wENQJKt/9ma9TQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 27 Sep 2024 11:49:22 +0200
MIME-Version: 1.0
Message-Id: <20240927-generate_syscalls-v2-2-108f5f2ad318@suse.com>
References: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
In-Reply-To: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727430571; l=6673;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=SdiFjyAP/Y8SSWDBtwKIL4HEyjwm2ZFLlGqXm7nCVBw=;
 b=SF+l7fAz6ecFxnrfGZEFptsXiPZacLBqEJ3kee4eSyC/BJDg+dXN69IVWNifymEsZEBBlQw7q
 Eg0jSPJ7plSCJYMqlav1EPo9DdfhzhuRenTzIZOspKsuvbIXVzKFfAO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: B32431FD9F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] Add script to generate arch(s) dependant
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/blacklist-syscalls.txt |   6 +
 include/lapi/syscalls/generate_arch.sh       | 182 +++++++++++++++++++++++++++
 include/lapi/syscalls/generate_syscalls.sh   |   4 +-
 3 files changed, 190 insertions(+), 2 deletions(-)

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
diff --git a/include/lapi/syscalls/generate_arch.sh b/include/lapi/syscalls/generate_arch.sh
new file mode 100755
index 000000000..c3338d82c
--- /dev/null
+++ b/include/lapi/syscalls/generate_arch.sh
@@ -0,0 +1,182 @@
+#!/bin/sh
+#
+# Generate arch dependant syscalls files.
+# Based on https://github.com/hrw/syscalls-table/
+#
+# Author: Andrea Cervesato <andrea.cervesato@suse.com>
+
+TEMP=$(mktemp -d)
+LINUX_SRC="$1"
+
+if [ -z "${LINUX_SRC}" ]; then
+	echo "Please give the path of Linux kernel sources:"
+	echo ""
+	echo "$0 path/of/linux/sources"
+	echo ""
+	exit 1
+fi
+
+if [ ! -e "${LINUX_SRC}/Makefile" ]; then
+	echo "No Makefile in ${LINUX_SRC} directory!"
+	exit 1
+fi
+
+export LC_ALL=C
+
+SCRIPT_DIR="$(realpath $(dirname "$0"))"
+SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
+SYSCALLS_BLACKLIST="${SCRIPT_DIR}/blacklist-syscalls.txt"
+LINUX_HEADERS="${TEMP}/headers"
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
+	local syscalls_tosort="${TEMP}/syscalls-names.tosort"
+	local syscalls_names="${TEMP}/syscalls-names.txt"
+	local generator_bin="${TEMP}/list-syscalls"
+	local generator_src="${generator_bin}.c"
+
+	echo "Extracting syscalls names..."
+
+	grep -E -h "^#define __NR_" \
+		${LINUX_HEADERS}/usr/include/asm/unistd*.h \
+		${LINUX_HEADERS}/usr/include/asm-generic/unistd.h > \
+		${syscalls_tosort}
+
+	grep -E -v "(unistd.h|NR3264|__NR_syscall|__SC_COMP|__NR_.*Linux|__NR_FAST)" \
+		${syscalls_tosort} |
+		grep -E -vi "(not implemented|available|unused|reserved|xtensa|spill)" |
+		grep -E -v "(__SYSCALL|SYSCALL_BASE|SYSCALL_MASK)" |
+		sed -e "s/#define\s*__NR_//g" -e "s/\s.*//g" |
+		sort -u >${syscalls_names}
+
+	grep -w -v -f ${SYSCALLS_BLACKLIST} ${syscalls_names} |
+		sort -u >${syscalls_names}
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
+		done < ${syscalls_names}
+		echo "return 0; }"
+	) >> ${generator_src}
+
+	local uppercase_arch=$(echo "$arch" | tr '[:lower:]' '[:upper:]')
+
+	gcc ${generator_src} -U__LP64__ -U__ILP32__ -U__i386__ \
+		-D${uppercase_arch} -D__${arch}__ ${flags} \
+		-I ${LINUX_HEADERS}/usr/include/ \
+		-o ${generator_bin} &>/dev/null
+
+	echo "Generating ${arch}.in ..."
+
+	${generator_bin} > "${SCRIPT_DIR}/${arch}.in"
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
+			# ia64 has been removed from the kernel
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
+echo "Temporary folder: ${TEMP}"
+
+generate_syscalls
+
diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
index 52e605900..a75d3ea38 100755
--- a/include/lapi/syscalls/generate_syscalls.sh
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -88,7 +88,7 @@ tst_ret; \
 				echo "# ifndef ${syscall_nr}"
 				echo "#  define ${syscall_nr} $*"
 				echo "# endif"
-			done <"${arch}.in"
+			done <"${SCRIPT_DIR}/${arch}.in"
 			echo "#endif"
 			echo
 		) >>${SYSCALLS_FILE}
@@ -106,7 +106,7 @@ tst_ret; \
 				echo "# ifndef ${syscall_nr}"
 				echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
 				echo "# endif"
-			done <"${arch}.in"
+			done <"${SCRIPT_DIR}/${arch}.in"
 		done <${SUPPORTED_ARCH}
 		echo "#endif"
 	) >>${SYSCALLS_FILE}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
