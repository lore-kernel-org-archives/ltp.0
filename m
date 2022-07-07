Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9205C433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 16:51:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B6583CA2B7
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 18:51:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40FF03CA1EF
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 18:51:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7DA2C20039F
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 18:51:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 958B91F8E6;
 Thu,  7 Jul 2022 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657212659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VtD0mXMQYRUHPktOVU8AmWHZZ9pZeCHzxT3v98W1eYw=;
 b=ssdCtWGzlq1gSh7AYNOd3gETz9WJ/SOZbiidbm1hvXzNIZNuWCqcZig2iZXj4CnZra3ZPn
 bzH6jtUJLecfoo44Vm0fP2ytoWl9m3ZZCm5FFX7QbZPcBlzPQy3ffI5zG85HO/vFL88pl/
 2gI3DckBUCmoQszvSQUTuP2WAy4RKkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657212659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VtD0mXMQYRUHPktOVU8AmWHZZ9pZeCHzxT3v98W1eYw=;
 b=Z60c/8k8VgfpYi/LVMZxQdYC8DMJYoDjNa16Vk4io1nfYyO+Bw7sVzoiR5qC+TaKCIGtDJ
 ivLmyHNKi1KorKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 151F913461;
 Thu,  7 Jul 2022 16:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YEj/MfIOx2JybgAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 07 Jul 2022 16:50:58 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 22:20:54 +0530
Message-Id: <20220707165054.16723-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Typo and grammar corrections in the documentation
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 README.md                       | 2 +-
 doc/c-test-tutorial-simple.txt  | 6 +++---
 doc/test-writing-guidelines.txt | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/README.md b/README.md
index 3a0fd7f96..b86b81942 100644
--- a/README.md
+++ b/README.md
@@ -206,4 +206,4 @@ Although we accept GitHub pull requests, the preferred way is sending patches to
 It's a good idea to test patches on GitHub Actions before posting to mailing
 list. Our GitHub Actions setup covers various architectures and distributions in
 order to make sure LTP compiles cleanly on most common configurations.
-For testing you need to just to push your changes to your own LTP fork on GitHub.
+For testing you need to just push your changes to your own LTP fork on GitHub.
diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index 867c26532..06d2ca55d 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -228,12 +228,12 @@ the lines starting with a +++.
 --------------------------------------------------------------------------------
  statvfs01 statvfs01
  statvfs02 statvfs02
- 
+
 +statx01 statx01
 +
  stime01 stime01
  stime02 stime02
- 
+
 --------------------------------------------------------------------------------
 
 The +runtest+ files are in a two column format. The first column is the test
@@ -1053,7 +1053,7 @@ systems programming across multiple Kernel and C lib versions as well as
 different hardware architectures. The important thing to take away from this
 is that you have to be conscientious of what will happen on systems different
 from yours. The LTP has a huge and varied user base, so situations you may
-thing are unlikely can and do happen to somebody.
+think are unlikely can and do happen to somebody.
 
 Of course you don't want to spend time allowing for situations which may never
 arise either, so you have to do your research and think about each situation
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 8ca014d45..552bbef63 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -150,7 +150,7 @@ When writing testcases in shell write in *portable shell* only, it's a good
 idea to try to run the test using alternative shell (alternative to bash, for
 example dash) too.
 
-*Portable shell* means Shell Command Language as defined by POSIX with a
+*Portable shell* means Shell Command Language as defined by POSIX with an
 exception of few widely used extensions, namely 'local' keyword used inside of
 functions and '-o' and '-a' test parameters (that are marked as obsolete in
 POSIX).
@@ -215,7 +215,7 @@ expression of kernel config variables that has to be satisfied in order for a
 test to run. This is mostly used for kernel namespaces at the moment.
 
 Sometimes it also makes sense to define a few macros instead of creating
-configure test. One example are Linux specific POSIX clock ids in
+configure test. One example is Linux specific POSIX clock ids in
 'include/lapi/posix_clocks.h'.
 
 3.1 Dealing with messed up legacy code
@@ -304,7 +304,7 @@ See 'testcases/commands/file/' for example.
 5.3 Subexecutables
 ^^^^^^^^^^^^^^^^^^
 
-If you test needs to execute a binary, place it in the same directory as the
+If your test needs to execute a binary, place it in the same directory as the
 testcase and name the file starting with '${test_binary_name}_'.  Once the
 test is executed by the framework, the path to the directory with all LTP
 binaries is added to the '$PATH' and you can execute it just by its name.
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
