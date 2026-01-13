Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F77CD2F35C
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 19:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 814643C19E1
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 20:48:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C4C03C2C22
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 20:48:13 +0100 (CET)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8611B6002C4
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 20:48:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=fHylp8jH5KZ7OVUeiARBt6GlHeZR7Ql4vpJE35s0Duo=; b=YJgWeCx5kzaJOdCT3m3j5DsSHC
 sJxUmacx9GHzzwINBV46c2/J7LtkqIR/8BtY2u/AFvR3rExrNJfT2vm3kNMGSIB1iZYdazY+1Vd+R
 56oMLvA+ah3NTTjBpACZgXLNWD3FrXm3xaz4gPHSvtkm0d1bMBY98+1avt6SF+/HsefbrMAGtubAC
 AeLZ+CG/D16ermNcB8kijBDxeQ/nVb1QYKOjXnTzleBPvYgRWvXdLqhDGFmDHFrrHuVSbA8NIWbOE
 QnE+UVO1BfMnnJirW6n/jZ82SxFku3ahMm78o6BnaLAf3PJz2uvAk+c6VB8pccgawJJkTHQ5kMG5f
 NkkcxkcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat
 Linux)) id 1vfkOW-0000000FX0e-3NHr; Tue, 13 Jan 2026 19:49:37 +0000
Date: Tue, 13 Jan 2026 19:49:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: ltp@lists.linux.it
Message-ID: <20260113194936.GQ3634291@ZenIV>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames longer
 than PATH_MAX
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
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

	There are different causes of ENAMETOOLONG.  It might come from
filesystem rejecting an excessively long pathname component, but there's
also "pathname is longer than PATH_MAX bytes, including terminating NUL"
and that doesn't get checked anywhere.

	Ran into that when a braino in kernel patch broke that logics
(ending up with cutoff too low) and that didn't get caught by LTP run.

	Patch below adds the checks to one of the tests that do deal
with the other source of ENAMETOOLONG; it almost certainly not the
right use of infrastructure, though.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index 6e53b7fef..e8dd5121d 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -11,6 +11,8 @@
 #include "tst_test.h"
 
 static char long_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+static char long_path[PATH_MAX+1];
+static char shorter_path[PATH_MAX];
 static char noexist_dir[] = "noexistdir";
 
 static struct tcase {
@@ -20,16 +22,23 @@ static struct tcase {
 	{long_dir, ENAMETOOLONG},
 	{noexist_dir, ENOENT},
 	{0, EFAULT}, // bad_addr
+	{long_path, ENAMETOOLONG},
+	{shorter_path, 0},
 };
 
 static void verify_chdir(unsigned int i)
 {
-	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
+	if (tcases[i].exp_errno)
+		TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
+	else
+		TST_EXP_PASS(chdir(tcases[i].dir), "chdir()");
 }
 
 static void setup(void)
 {
 	tcases[2].dir = tst_get_bad_addr(NULL);
+	memset(long_path, '/', PATH_MAX);
+	memset(shorter_path, '/', PATH_MAX - 1);
 }
 
 static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
