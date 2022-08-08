Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED5C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 07:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B07F33C9595
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 09:15:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0DF3C1364
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 09:14:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B4D7260067A
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 09:14:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 478FA3433E;
 Mon,  8 Aug 2022 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659942885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XiMeEBFHES2jtQfMTMW6UtxAR90E//4QSoLOawRPNA=;
 b=uw+U+zXJhgd6IvgJC6JyaZHxA2cLJ8rMKxKDArGIJ7EaeDcvAAUbwQy5oXx0fQfrb0Zcx3
 48+PB/6FBmeo5CbIiUSVsfgp//qFbe6vWzLfHiIPFkG54jOoJA6TChy7LLnp5NBSHm8rAU
 aN+3ZagcyhCTWeoz3ksUXq8IxG9cW2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659942885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XiMeEBFHES2jtQfMTMW6UtxAR90E//4QSoLOawRPNA=;
 b=fQvNN11sndoakvSLFbCvgerDBtTIgd4GQGZs5d+A4xkJ4Y7QUNGc9KB2s8HFDQF2sXIIQ2
 lvzHyPRXOWrx3WBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1147413A7C;
 Mon,  8 Aug 2022 07:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CDKgAuW38GLMLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 07:14:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 09:14:39 +0200
Message-Id: <20220808071439.741-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808071439.741-1-pvorel@suse.cz>
References: <20220808071439.741-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc/c-test-tutorial-simple.txt: Use links,
 README.md
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Symlinks to LTP wiki are more friendly for people reading web (likely
the most of the people) while styl readable when reading locally.

Adding links to git format-patch and send-email (people can google, but
again be nice to readers on the web).

Fix local name: s/README/README.md/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-tutorial-simple.txt | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index c09613e37..c25a5f4d2 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -24,15 +24,16 @@ and has some general knowledge of Operating Systems. Experienced Linux
 developers may find it too verbose while people new to system level Linux
 development may find it overwhelming.
 
-Comments and feedback are welcome, please direct them to the mailing list (see
-+README+).
+Comments and feedback are welcome, please direct them to
+https://lists.linux.it/listinfo/ltp[the mailing list].
 
 1. Getting Started
 ------------------
 
-Git-clone the main LTP repository as described in the +README+ and change
-directory to the checked-out Git repository. We recommend installing the LTP
-and running one of the tests mentioned in the Quick guide (in the +README+) to
+Git-clone the main LTP repository as described in
+https://github.com/linux-test-project/ltp#quick-guide-to-running-the-tests[the +README.md+]
+and change directory to the checked-out Git repository. We recommend installing the LTP
+and running one of the tests mentioned in the Quick guide (in the +README.md+) to
 ensure you are starting from a good state.
 
 We also recommended cloning the Linux kernel repository for reference, this
@@ -220,7 +221,7 @@ $ ./statx01
 
 This should build the test and then run it. However, even though the test is
 in the +syscalls+ directory it won't be automatically ran as part of the
-_syscalls_ test group (remember +./runltp -f syscalls+ from the +README+?). For
+_syscalls_ test group (remember +./runltp -f syscalls+ from the +README.md+?). For
 this we need to add it to the +runtest+ file. So open +runtest/statx+ and add
 the lines starting with a +++.
 
@@ -315,7 +316,7 @@ Check coding style with `make check`
 3.4 Install the LTP and run the test with runtest
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Run +statx01+ on its own; similar to the +madvise+ tests in the +README+.
+Run +statx01+ on its own; similar to the +madvise+ tests in the +README.md+.
 
 4. Call the system call
 -----------------------
@@ -980,9 +981,9 @@ of the conflict. Usually, all you need to do is remove the lines you don't
 want, stage the changes and continue the 'rebase' with +git rebase
 --continue+.
 
-In order to create a patch e-mail we use +git format-patch+, we can then send
-that e-mail using +git send-email+. It is also possible to import the patch
-(+mbox+) file into a number of e-mail programs.
+In order to create a patch e-mail we use https://git-scm.com/docs/git-format-patch[+git format-patch+],
+we can then send that e-mail using https://git-scm.com/docs/git-send-email[+git send-email+].
+It is also possible to import the patch (+mbox+) file into a number of e-mail programs.
 
 [source,shell]
 --------------------------------------------------------------------------------
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
