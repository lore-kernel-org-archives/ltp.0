Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C75CF9C71
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 08:07:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6FFD3C4BB4
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 10:07:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9C573C28AE
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B944B60004F
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:06:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 831D221B06
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vWVM3gl75DqH/xeFd9IgDTgi1V9SQWAu5OGHTzoduE=;
 b=W+8EXLSe+TjpGKOAex7fgg5WUOqLYJL7JLTiBiS97gw/GjotwWXX2BPRIexEA6QRkCIaGF
 N2epYIcBmFgzTx/kZJ9siYWHPohNC9ZzGgB1y1m8Xt7Wish6f1objJ6/vxrlk8oHJ/SLwb
 GVyMIpjdMinzPiegubMdJxjrnlgk294=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vWVM3gl75DqH/xeFd9IgDTgi1V9SQWAu5OGHTzoduE=;
 b=cFbjPbMHUnM3sYcFnUv2rNt+7EFlUxKQUiCoTXCTOoLnM9r+aDlz58R1BKt6YbPyqaDm/s
 QeFmX6Inn1d8dWDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727165211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vWVM3gl75DqH/xeFd9IgDTgi1V9SQWAu5OGHTzoduE=;
 b=W+8EXLSe+TjpGKOAex7fgg5WUOqLYJL7JLTiBiS97gw/GjotwWXX2BPRIexEA6QRkCIaGF
 N2epYIcBmFgzTx/kZJ9siYWHPohNC9ZzGgB1y1m8Xt7Wish6f1objJ6/vxrlk8oHJ/SLwb
 GVyMIpjdMinzPiegubMdJxjrnlgk294=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727165211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vWVM3gl75DqH/xeFd9IgDTgi1V9SQWAu5OGHTzoduE=;
 b=cFbjPbMHUnM3sYcFnUv2rNt+7EFlUxKQUiCoTXCTOoLnM9r+aDlz58R1BKt6YbPyqaDm/s
 QeFmX6Inn1d8dWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FE6A13AE2
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ONL0GRtz8mYVcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 08:06:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Sep 2024 10:06:26 +0200
MIME-Version: 1.0
Message-Id: <20240924-generate_syscalls-v1-1-941507a9cdac@suse.com>
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
In-Reply-To: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727165210; l=4316;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ROd9ztfSE/Ymi695L9Nsvs/RI0W/YwcikxpAQO78AiQ=;
 b=M0P5P1atUEbHAj8hIm5Skr0T4KKxgssGdEUBUQWEky741j9em0rThY5S0x3IuvJXcnX9uD3cM
 rCEnN5TPk4jCUbfIT9oaInz6Qis29bzpb1VSKngLLijd08P6I7PJ9/a
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] Rename syscalls order file to supported-arch.txt
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/regen.sh                     | 88 +++++++++++-----------
 .../lapi/syscalls/{order => supported-arch.txt}    |  1 -
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 663ce4458..e06746483 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -14,7 +14,7 @@ err() {
 	exit 1
 }
 
-cat << EOF > "${output_pid}"
+cat <<EOF >"${output_pid}"
 /************************************************
  * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
  *  change your arch specific .in file instead  *
@@ -65,40 +65,40 @@ inline static void dummy_cleanup(void) {}
 EOF
 
 jobs=0
-for arch in $(cat "${srcdir}/order") ; do
+for arch in $(cat "${srcdir}/supported-arch.txt"); do
 	(
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
+		echo "Generating data for arch $arch ... "
+
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
+			while read line; do
+				set -- ${line}
+				nr="__NR_$1"
+				shift
+				if [ $# -eq 0 ]; then
+					err "invalid line found: $line"
+				fi
+				echo "# ifndef ${nr}"
+				echo "#  define ${nr} $*"
+				echo "# endif"
+			done <"${srcdir}/${arch}.in"
+			echo "#endif"
+			echo
+		) >>"${output_pid}.${arch}"
 
 	) &
 
-	jobs=$(( jobs + 1 ))
-	if [ ${jobs} -ge ${max_jobs} ] ; then
+	jobs=$((jobs + 1))
+	if [ ${jobs} -ge ${max_jobs} ]; then
 		wait || exit 1
 		jobs=0
 	fi
@@ -106,24 +106,24 @@ done
 
 echo "Generating stub list ... "
 (
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
+	echo
+	echo "/* Common stubs */"
+	echo "#define __LTP__NR_INVALID_SYSCALL -1" >>"${output_pid}"
+	for nr in $(awk '{print $1}' "${srcdir}/"*.in | sort -u); do
+		nr="__NR_${nr}"
+		echo "# ifndef ${nr}"
+		echo "#  define ${nr} __LTP__NR_INVALID_SYSCALL"
+		echo "# endif"
+	done
+	echo "#endif"
+) >>"${output_pid}._footer"
 
 wait || exit 1
 
 printf "Combining them all ... "
-for arch in $(cat "${srcdir}/order") _footer ; do
+for arch in $(cat "${srcdir}/supported-arch.txt") _footer; do
 	cat "${output_pid}.${arch}"
-done >> "${output_pid}"
+done >>"${output_pid}"
 mv "${output_pid}" "../${output}"
 rm -f "${output_pid}"*
 echo "OK!"
diff --git a/include/lapi/syscalls/order b/include/lapi/syscalls/supported-arch.txt
similarity index 91%
rename from include/lapi/syscalls/order
rename to include/lapi/syscalls/supported-arch.txt
index c18aa38cf..de88957ed 100644
--- a/include/lapi/syscalls/order
+++ b/include/lapi/syscalls/supported-arch.txt
@@ -8,7 +8,6 @@ loongarch
 mips_n32
 mips_n64
 mips_o32
-powerpc64
 powerpc
 s390x
 s390

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
