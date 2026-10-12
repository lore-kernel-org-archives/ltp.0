Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFE606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=hAAwJJ13;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=YKY8In3n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792659512; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=+KZS4Uhovc+YHNMDuHCDwh+PXET9MFY1lpytNoAieQA=;
 b=hAAwJJ13E7WGN4iNdi72uR8c51DoF5VLbLhr+Ngg/tbEQ6AGbZJg8ZfjnAwvXf7RL6x+s
 3rYiodgpey8hIS/V8FWmi2KeKqDNBFh3TrP8gmAw2oY9B72iIVElyh0ArbnjVJBWCxXFzI+
 tKSKjTLOr1WAUcPD/X2U0ZzpzS918eY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E37303D2334
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8C093E2729
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 08:02:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6383B200077
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 08:02:28 +0200 (CEST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AA6CC3F19A
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791784947;
 bh=GZG9SmIYcAvWuQ37YdocwqT8qaJE+Y4wIGH8P2FLc/A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YKY8In3nytGdQnnOp72bFRUcqDF+lSmN0MhCMQCYCsWH+D0KHoAy4KJOZ0DOQdQXp
 Y1UjFIvI/bCLZmjk/cW/gr2fbqmgMZLVOnAZ5wpYiLx+qB37sxT6djvz9Tip8+XUTl
 NHbMnvYBBXpfr6Jj+Y0phYoXNPYQUwQr1rcnK6gbgLf+YuVqcCYwMJ2MPBXYvV+hS4
 xtk8iCD9qxMTyIjfBlX7iv3HWNdCP5wibm3H2nWnwCGExFKBE0N7+1AsFdnac7nySf
 vY2lr254+zhwI6szRueHpbWNeynmsqTFgK7eqrabwCi7CKLemROfX/+P5weZUvdd6i
 h7kXohX0P71vetjLwPvBS/A4klgUpGBLTo3t7vyetDNkSRECjtz6zrjoA/SeXRVL2B
 elezCuHueBhj/A5O23STRZA+ErDIuWNhH0JZ8YwowIEtnLFJW7FDZP9aMY+yzaXpQC
 BdHAYrGSPT5svOIYaHS0i4la9DIZ2X3UPpW1UnWSlS/nE23V6S1Mq2y6Y9NRancNTf
 09uiOvOPuIacMzl4VCgUWNAAGOAE/zwq7tpyq/iNaH5THWHalaMwCD5FGMLswPbNfA
 IQFUvmphkASr1I4XlS6fj0hTMvRU1z+rZ4kjn9PRF+bJJi78B5AQgIepIKivYy/Zrc
 ndTb/e6iM7XreIzVN+zezsqY=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso3431123a12.3
 for <ltp@lists.linux.it>; Sun, 11 Oct 2026 23:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791784946; x=1792389746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GZG9SmIYcAvWuQ37YdocwqT8qaJE+Y4wIGH8P2FLc/A=;
 b=cOYzcCWqEBJ9JY6Cc5jxufR868HQ49QtxwRSn8VSsHI8feHcGPgqusbOUdL/WtMlZs
 0BUoLIpcukbyMZFOR/cf2TsFM4HXRAH/q9X+zXLXrCy3ogBJ3cy++FlA2606B9K7W8xG
 Nqi1+jM7FN2eMHe+j2Gfx358jpWUDd4l49Q/Rr9DpCoNt8MsEm+4SXbDODGuf61KSr4m
 rIqMg2CGvrfR+5hl5gcrQ6AlooWCViPZRTaqIKU/WqFxRsRj56pmz7wEumZTAwg/Jmsl
 F83/YAgz7JGuxgsu0Cg3M5g4YtFUtY82Uo/bgbnogbuk1+asM246peTpOfrvogVn3rrp
 Yy7Q==
X-Gm-Message-State: AFq9FYKYZUuz86RJgc6byQ3HghTpWdVQnIYJCTN9gshb1DOXaeLNnQ8n
 NGss6/o0XE36BhRs4DA/XNYgjbU+pjtK/jWfvf7uQs/xai5i4NZCjHM1gq5p/WWUu8GIm9UurqD
 TAdby0efvBeYldPEGiphiAadevYf0Ag94y8CQJ5uGDjwdAoU6+XuNb9OIJtRlwTV1VIbaQ1zgQg
 rC
X-Gm-Gg: AYBFou28jlTx6I1eWku6Yv668Lb+JBbf1h0scqI3zGxcI+icBdfOFZ2M6ndhtDdnsdT
 vlVRIvBwwsTHGzcXi42SHWscQnY0vpf283Oyzz+vmfYR8wrFnCMVB0drrG7vr28QmPczdH12ptz
 x2gBJ63la+T3lJaFk7O/fc2E4moMJ3/PyT2z5bbsISIOYjOR/c8OLGcV4OlZrgyX92acAk7+IOw
 ckUI6P30+OwJ3ShUVFlLCiolF61SKZRD7zYWT2YiOrrZCHpVU2hnYHz8j9ze5T92/1S4mxriV6i
 AZHIDWKRBE3B6+lNTvl9ktXlewJxXphc/tTDaJp/VPEle+bu5c1cN3v1xUjzY9toUbOBbO9VSnN
 5FTeVHofW9yJvgvessHWqTYtuAKxJ4sN+wKay5wG1acOkGph5351BYBPjtqc8oX6q
X-Received: by 2002:a05:6a21:7e05:b0:3e1:ea3:ccdd with SMTP id
 adf61e73a8af0-3e16bdd35b9mr7864178637.13.1791784945919; 
 Sun, 11 Oct 2026 23:02:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:7e05:b0:3e1:ea3:ccdd with SMTP id
 adf61e73a8af0-3e16bdd35b9mr7864155637.13.1791784945520; 
 Sun, 11 Oct 2026 23:02:25 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd5fe84dc3dsm825413a12.13.2026.10.11.23.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 23:02:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 12 Oct 2026 14:03:34 +0800
Message-ID: <20261012060336.36147-1-kuan-ying.lee@canonical.com>
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
