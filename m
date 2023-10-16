Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292E6CDB474
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD5FB3CFD38
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:44:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62E3D3CF5A6
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19B5E20117C
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 177D221C64;
 Mon, 16 Oct 2023 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wp044LP7nPEnGwwGNNgvcaUnBgsBH7ZVmOpQMePD6o=;
 b=K0Dxp/+lLImQdAa8i9zXHPuMePcJyPKRox1+yKvOG4mYzoHqniwt4mARaLpfy/fJ8ekvYZ
 JJ47xaEeEsG+ugyww9fHrySmysyGmrHyn23fbu9U/sw02rKk/ykWZ+K9SD4aVpSj2Z7vnn
 t+/GB6BkjSJLSCBvbrK0bSDFDngS1Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wp044LP7nPEnGwwGNNgvcaUnBgsBH7ZVmOpQMePD6o=;
 b=KF5FLiAdjvk23Ca7NcXbXkR5DjJs/5h2wPAWI0YrY499M9Xpx9EuQGZLD/a5RlySBMC9X1
 4UuI92IEnmg2gzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8118139F9;
 Mon, 16 Oct 2023 18:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8D/wJY2ELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:02 +0200
Message-ID: <20231016184408.879977-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016184408.879977-1-pvorel@suse.cz>
References: <20231016184408.879977-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-2.99)[-0.998];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/7] doc: Remove ltp-run-files.txt
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

This file contained runtest file description + list of various scripts
in testcases directory. Scripts list are outdated (some has been
already deleted, others will be deleted).

The format of the LTP runtest file is described in
doc/C-Test-Case-Tutorial.asciidoc and
doc/Test-Writing-Guidelines.asciidoc, improve the description.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/Test-Writing-Guidelines.asciidoc | 12 ++++
 doc/ltp-run-files.txt                | 96 ----------------------------
 2 files changed, 12 insertions(+), 96 deletions(-)
 delete mode 100644 doc/ltp-run-files.txt

diff --git a/doc/Test-Writing-Guidelines.asciidoc b/doc/Test-Writing-Guidelines.asciidoc
index 0db852ae6..a81404fa6 100644
--- a/doc/Test-Writing-Guidelines.asciidoc
+++ b/doc/Test-Writing-Guidelines.asciidoc
@@ -262,6 +262,18 @@ The list of tests to be executed is stored in runtest files under the
 stored in 'scenario_groups/default'. When you add a test you should add
 corresponding entries into some runtest file(s) as well.
 
+Each line of runtest file contain one test. First item is the test name
+('shell_test01', 'splice02'). All other items, separated by space will be
+executed ('echo "SUCCESS" | shell_pipe01.sh', 'splice02 -s 20').
+
+[source,sh]
+-------------------------------------------------------------------------------
+shell_test01 echo "SUCCESS" | shell_pipe01.sh
+splice02 splice02 -s 20
+-------------------------------------------------------------------------------
+
+Blank lines and lines starting with a '#' (comments) are ignored.
+
 For syscall tests (these placed under 'testcases/kernel/syscalls/') use
 'runtest/syscalls' file, for kernel related tests for memory management we
 have 'runtest/mm', etc.
diff --git a/doc/ltp-run-files.txt b/doc/ltp-run-files.txt
deleted file mode 100644
index 3f405b387..000000000
--- a/doc/ltp-run-files.txt
+++ /dev/null
@@ -1,96 +0,0 @@
-The runtest files contain a list of test cases to be executed.
-
-File Format
------------
-
-Lines starting with a '#' are comments and blank lines are ignored.
-
-Otherwise, lines start with a test name followed by white space, then some
-shell script to be executed. For example
-
-Test Name
-|       Delimiter               Test case argument
-|       |                       |
-v       v                       v
-splice02 seq 1 20000 | splice02 splice02-temp
-         ^             ^                    ^
-         |             |                    |
-         |             Test case executable |
-         -----------Shell script-------------
-
-So the splice02 runtest entry pipes the output of seq into the splice02 test
-executable. Most runtest entries are simpler than this, for example
-
-splice03 splice03
-
-Here the test name and executable have the same name and no arguments have
-been supplied.
-
-Run test files should start with a comment describing the tests they contain,
-e.g.
-
-#DESCRIPTION:Kernel system calls
-
-Note that the LTP has absorbed a number of other projects. Some of these have
-been fully converted to the LTP format, others have runtest files generated
-for them during installation, while some use a shell script to integrate them
-with the other tests.
-
-Test suites
------------
-
- - syscalls  (except epoll, see below)
- - fs
- - fsx
- - dio
- - mm
- - ipc
- - sched
- - math
- - pty
-
-if run network tests flag is passed these additional tests are run
- - tcp_cmds
- - multicast
- - rpc
- - nfs
-
-To test filesystem with LVM
-- testscripts/lvmtest.sh
-
-Device Mapper tests
- - ltpdmmapper.sh
-
-Network tests
- - network.sh
- - testcases/network/sockets/ltpSockets.sh
-
-other filesystem or disk type tests
- - autofs1.sh
- - autofs4.sh
- - diskio.sh
- - isofs.sh
- - sysfs.sh
-
-AIO/DIO filesystem tests
- - ltp-aiodio.sh
-
-Device driver tests (may not run on all platforms)
- - acpi
- - agp
- - base
- - drm
- - include
- - nls
- - pci
- - tbio
- - usb
-
-Open_hpi_testsuite
- - run_tests
-
-Open_posix_testsuite
- - run_tests
-
-
-testcases/kernel/syscalls/epoll - The tests require additional installation files. See the README in the epoll directory.
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
