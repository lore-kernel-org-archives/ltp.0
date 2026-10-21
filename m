Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA9606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=BMDlXv2C;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=A3sp7JXx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792659549; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=+KZS4Uhovc+YHNMDuHCDwh+PXET9MFY1lpytNoAieQA=;
 b=BMDlXv2CCNZNpPhe5FqXge19Gtu47ePjcPcGM6rZPzsKjD+Ziqrq5lFGZvD56u5paCgeu
 19tX+0h9uNJBosVj9yWJ/+LpT6oPmfEJV8aaVt3kHvBaRA9/uAzNALvVndiZ0kP/Xsgvcuf
 mRfnaGheM9fGcaXrI/fnINDr8k+D9N4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B645D3D2293
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 10:59:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE2873E4B30
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 04:46:43 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1DB582002AD
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 04:46:42 +0200 (CEST)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 58B743FC3F
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792550802;
 bh=GZG9SmIYcAvWuQ37YdocwqT8qaJE+Y4wIGH8P2FLc/A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=A3sp7JXxKz1IzVk3h3mzo4rTYoWjmp24kemN/E/LjJOam+9gsjZLP90v68CBLm3M6
 0ctmEvatcP5WzBc74/pD/9Tj5Z98BwGIryoV5tXp7bnatwUXz1c2cKVTW3cov1IVho
 2/kJYvthEjOM/aHuyXPrHPTIGemHwbFWbAXgOpYP/WK2FZpzUGqQ559KltnIitqwOB
 jRN2HQGivv94K40prk2GMFWdoQOhw74kjLw+hVsYgz03kuWD4ZgiSGrT7UiFTJFIU+
 qJHjX17HaUVcSQNFG7zIT4jaDRxbD7/Ti8cBhOMkXvJyb6UA4//ji87LM7+mRm5lPl
 AOsfEBhE/ndPErx0yO5aEdtvIVDGRXI55UKGipULhBbN7uvOHCCk8W8XV7vkFAqwAY
 7G333tBi4yF5hCTlD7f6o2bvLufxXZe2+kfoO9UmAjucpFjwj6FCRVzzwthCC8zSjm
 09UDFK1adlBwEE3M+z8lkyIkFitz0s77juW8NPb1P42FjrkLGm9XbyXSEJ8McEwsz2
 gDo9x0E2nHDvIKeTALj9oodNysaMxbmZTYmUuwpIgv6EsZFcIpqb9E/22UYi+CzTr8
 0kmHTQUgaHSzAWH5mI7OPzXHESTG9eH+QyFHfXRqOMDUAJPxHT7CeEMeg9Kiu9T9QN
 /IseleUElCTmEe+rxSR0Lrv4=
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso406963eec.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 19:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792550801; x=1793155601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GZG9SmIYcAvWuQ37YdocwqT8qaJE+Y4wIGH8P2FLc/A=;
 b=n3bN+v1FCl4HxLYAlPHvksagfQ4QfzfKSeoUvTGxmW5cieZDc6D/gFehQys8klaCB8
 IPSq4/dHUG0mucnh+TzqDUFg2E9osfY1bQA4CCuFyX9gNT1piOsbOrBkrT1apHCh4v1h
 iiGMUnSfXiaeBKFVItAZcHvoS3eKY5CBgHJOCpXxwuQxBbFlgYFNJsf0/6r506zNBSDz
 JTS7XrcbPN5KVep5i46Mxw9uhjvj8OJeYhBgYEH/M1KDu0q5/lQhS0TSm3J8i6IaxNh6
 +9zDlLL2NAuVO0wHYsqH6iTAKjtHFJtDV2C2qWN0tcgj1D2l1LBi+cStgjc0mJA0Yahy
 8FXQ==
X-Gm-Message-State: AFq9FYL0j86mSIIBKR5Qitff+dgKT4KUAZFub/kPBRf0k2g5vdAtxC1O
 NCpbVXi4CEyVZaFPy4zdq+fDyId1/fWcnMLU5cszDm3/mt0FZeOeGas2W9ryrCFTOUtYATTI/hq
 FuK/myc3pzRRxS/fb7Pqdd2UqNRRIFaDgS/s+dHg17z5C4XLQXpelM/i72BkkuIxYjpT/ybRyyO
 BV
X-Gm-Gg: AYBFou0P1sT3tq0FWIzIkgcQvigH3Ka8w73KvuBBz4iN6xv6mLTkj/cQajbl7enPyg9
 avMAPL8m5Gp7NbB3SH+qUp+XvGg+2nL5nGW+BCQJw3WJbj1iWIBxQ4JPUdPRjnGb+IaFLeG2b5C
 POBUK3jOjDlRYIB6+B3rmUqrz6Q56L1MEtV2GFRUXJVmq8U8Y85ppfZSyW1vu/H9+//+N97TFGT
 gWlka7wc2BXEBl+rsS7ggCOBPDLX6HRzo7eu9up3TYo494UDmHRm7Yk8yts+1UGG2IRqTQFVuRl
 ugeVAhYc3Kv1/MiEOU7QWx205Z4fPyRrInf3mIKoHxM4RbvePa7mKKBRCI9SmwxVjp3KedPshS3
 k3CWhWjYzRU8p0xlvfz+PFAAG8wzvifFIQUdHsan2BFP7SNRGBrifGii/Mz91qQOR
X-Received: by 2002:a05:7300:4a93:b0:365:cdcc:9f57 with SMTP id
 5a478bee46e88-3674a41b2ecmr1626037eec.4.1792550800567; 
 Tue, 20 Oct 2026 19:46:40 -0700 (PDT)
X-Received: by 2002:a05:7300:4a93:b0:365:cdcc:9f57 with SMTP id
 5a478bee46e88-3674a41b2ecmr1625937eec.4.1792550798466; 
 Tue, 20 Oct 2026 19:46:38 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8439sm3016560eec.11.2026.10.20.19.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 19:46:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 10:47:55 +0800
Message-ID: <20261021024758.13541-1-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 22 Oct 2026 10:58:13 +0200
Subject: [LTP] [PATCH] binfmt_misc02.sh: Fix interpreter with
 uutils/coreutils
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Kuan-Ying Lee via ltp <ltp@lists.linux.it>
Reply-To: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Cc: po-hsu.lin@canonical.com, kuan-ying.lee@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test registers the system 'cat' directly as a binfmt_misc
interpreter and expects executing the data files to echo their content
back.

This breaks on distributions shipping the Rust uutils/coreutils
implementation (e.g. Ubuntu "Resolute"), where 'cat' is a hardlink to a
single multi-call 'coreutils' binary:

  $ readlink -f /usr/bin/cat
  /usr/lib/cargo/bin/coreutils/cat
  $ cat --version
  cat (uutils coreutils) 0.8.0

Such a binary has to work out which applet to run, and uutils does so
from AT_EXECFN, i.e. the path the kernel actually exec'd, rather than
from argv[0]. binfmt_misc sets argv[0] to the interpreter, but AT_EXECFN
keeps naming the file passed to the original execve(), so the applet
name is derived from the data file rather than from 'cat'. Renaming the
very same data file to "cat.extension" makes it work, which confirms
where the applet name comes from.

Hence the exec fails (exit 1) and subtests 1-4 report:

  binfmt_misc02 1 TFAIL: Fail to recognise a binary type

Subtests 5-6 pass because they expect no recognition and never run the
interpreter.

Fix it by registering a small wrapper script as the interpreter. The
shell execs cat itself, so argv[0] and AT_EXECFN name cat again and the
right applet is picked.

The interpreter path ends up in the binfmt_misc registration string,
whose delimiter is ':', '.' or ',' depending on the subtest, so the
path must contain none of them. That rules out $TST_TMPDIR, which
carries a '.', hence create the wrapper in a directory of our own
under $TMPDIR.

Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 .../kernel/fs/binfmt_misc/binfmt_misc02.sh    | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
index 37c9b9e0f4e2..0d71f6a30ce9 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
@@ -18,8 +18,10 @@
 # We use various delimiteris to register a new binary type.
 
 TST_CNT=6
+TST_SETUP=binfmt_misc02_setup
+TST_CLEANUP=binfmt_misc02_cleanup
 TST_TESTFUNC=do_test
-TST_NEEDS_CMDS="cat head"
+TST_NEEDS_CMDS="cat chmod head mktemp"
 
 
 recognised_unrecognised()
@@ -85,22 +87,46 @@ verify_binfmt_misc()
 	remove_binary_type "$mntpoint/$name"
 }
 
-do_test()
+binfmt_misc02_setup()
 {
-	local cat="$(command -v cat)"
+	# The interpreter path becomes a field of the registration string,
+	# which is written with ':', '.' and ',' as delimiters below, so it
+	# must not contain any of them.
+	case "$TMPDIR" in
+	*[:.,]*) tst_brk TCONF "TMPDIR '$TMPDIR' contains ':', '.' or ','";;
+	esac
+
+	binfmt_misc_setup
+
+	interp_dir=$(mktemp -d "$TMPDIR/ltp_binfmt_miscXXXXXX")
+	[ -d "$interp_dir" ] || tst_brk TBROK "Failed to create interpreter dir"
+
+	interp="$interp_dir/interp"
+	printf '#!/bin/sh\nexec %s "$1"\n' "$(command -v cat)" > "$interp" ||
+		tst_brk TBROK "Failed to write $interp"
+	ROD chmod +x "$interp"
+}
 
+binfmt_misc02_cleanup()
+{
+	[ -n "$interp_dir" ] && rm -rf "$interp_dir"
+	binfmt_misc_cleanup
+}
+
+do_test()
+{
 	case $1 in
-	1) verify_binfmt_misc ":textension:E::extension::$cat:" \
+	1) verify_binfmt_misc ":textension:E::extension::$interp:" \
 			      "$TST_DATAROOT/file.extension" "1";;
-	2) verify_binfmt_misc ":tmagic:M:1:This::$cat:" \
+	2) verify_binfmt_misc ":tmagic:M:1:This::$interp:" \
 			      "$TST_DATAROOT/file.magic" "1";;
-	3) verify_binfmt_misc ".textension.E..extension..$cat." \
+	3) verify_binfmt_misc ".textension.E..extension..$interp." \
 			      "$TST_DATAROOT/file.extension" "1";;
-	4) verify_binfmt_misc ",tmagic,M,1,This,,$cat," \
+	4) verify_binfmt_misc ",tmagic,M,1,This,,$interp," \
 			      "$TST_DATAROOT/file.magic" "1";;
-	5) verify_binfmt_misc ":textension:E::ltp::$cat:" \
+	5) verify_binfmt_misc ":textension:E::ltp::$interp:" \
 			      "$TST_DATAROOT/file.extension" "0";;
-	6) verify_binfmt_misc ":tmagic:M:0:This::$cat:" \
+	6) verify_binfmt_misc ":tmagic:M:0:This::$interp:" \
 			      "$TST_DATAROOT/file.magic" "0";;
 	esac
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
