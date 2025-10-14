Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C8CCD18F
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 07:22:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E37C3CEC45
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 09:22:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E6913CEC2B
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:22:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 320A71400DEF
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:22:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 329A721CEC;
 Tue, 14 Oct 2025 07:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760426525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fe26/xOazryWB7sJMIupifcpWRrEdUtgGyJbibUlDPI=;
 b=sI7Fo4I4luJBP4IelfNB8l+dXmEPVAojgcKkNr1uPlZCyT9H8KeqpvLLMI/yCK/nFfXCxH
 +zdmukm5v6TDVylDueXLZ0ppPBll/j65NG/AoZvCvgzjJNWeGotXK7X6V6ASctyQNHX4h5
 pN+uHJSc2+qD+g4JtyUiNfEF582oBBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760426525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fe26/xOazryWB7sJMIupifcpWRrEdUtgGyJbibUlDPI=;
 b=n8wX/0td3ybbemIlDkptlgSy1kOqpD2MtebclDCRSSockA/TZN6GC/0W8eIicD6d+PyWDI
 piLL0vmKQjM0qNBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760426525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fe26/xOazryWB7sJMIupifcpWRrEdUtgGyJbibUlDPI=;
 b=sI7Fo4I4luJBP4IelfNB8l+dXmEPVAojgcKkNr1uPlZCyT9H8KeqpvLLMI/yCK/nFfXCxH
 +zdmukm5v6TDVylDueXLZ0ppPBll/j65NG/AoZvCvgzjJNWeGotXK7X6V6ASctyQNHX4h5
 pN+uHJSc2+qD+g4JtyUiNfEF582oBBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760426525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fe26/xOazryWB7sJMIupifcpWRrEdUtgGyJbibUlDPI=;
 b=n8wX/0td3ybbemIlDkptlgSy1kOqpD2MtebclDCRSSockA/TZN6GC/0W8eIicD6d+PyWDI
 piLL0vmKQjM0qNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1179C139B0;
 Tue, 14 Oct 2025 07:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GRFjAh367WhnUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Oct 2025 07:22:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Oct 2025 09:22:04 +0200
MIME-Version: 1.0
Message-Id: <20251014-remove_todo-v4-1-168fcfa74221@suse.com>
X-B4-Tracking: v=1; b=H4sIABv67WgC/33NywrCMBCF4VcpszaSay+ufA8RSZuJzaJGkhqU0
 nc37aqKuDwD3z8TRAwOIxyKCQImF52/5SF3BXS9vl2ROJM3cMoVo7QkAQef8DJ640nHG61qhXV
 LGWRxD2jdc62dznn3Lo4+vNZ4Ysv1dycxwohqdatsaavKqmN8RNx3foAlk/iGMvFJeaaGallqw
 yQK+UXFHyqWr0KgrKRodLOl8zy/AbQTgmMbAQAA
X-Change-ID: 20251006-remove_todo-c29a585e8b01
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760426525; l=6577;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=JretVhRPmNydVBAV0aOAjz464RU7qWADpSa7T/rQ9IA=;
 b=c1LixYemrYezJLPZA32iEwk3D5m4E2AhHOFGCYOYhp2tF8nvwZJzHFKY/+P9uZE2neSklnv56
 jMIjvbrE1bjCSwYidfP4Kj7ddlnfjCwRtfXEdjy5v/dK/dkQVK4c7IT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Remove TODO
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

TODO file is not updated and it talks about goals we already reached via
new LTP documentation. In general, it contains generic and random topics
which none is updating anymore, so it's better to remove it in order to
create less confusion for newcomers.

Instead, we create a todo list in the new documentation, providing a
more clear intention of what are the current LTP goals.

Acked-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- fix commit message
- point to tst_run_shell.c
- moved to developers
- fix git grep command
- Link to v3: https://lore.kernel.org/r/20251013-remove_todo-v3-1-533e47439a94@suse.com

Changes in v3:
- fix typo
- update command to generate test with old API
- add kirk link in TODO
- shell loader reference
- Link to v2: https://lore.kernel.org/r/20251013-remove_todo-v2-1-d0a46ad14e34@suse.com

Changes in v2:
- add doc/users/todo.rst section
- Link to v1: https://lore.kernel.org/r/20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com
---
 TODO                    | 39 --------------------------
 doc/developers/todo.rst | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 doc/index.rst           |  4 +++
 3 files changed, 77 insertions(+), 39 deletions(-)

diff --git a/TODO b/TODO
deleted file mode 100644
index fe0a3ab9b..000000000
--- a/TODO
+++ /dev/null
@@ -1,39 +0,0 @@
-LTP TODO
---------
-
-
-Write more syscall tests
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-Syscalls and new syscall flags are added to Linux kernel each development cycle
-and LTP still falls behind. Unfortunately there is no single place that would
-store comprehensive list of syscalls, but there are a few places to look at:
-
-One of the options would be looking at changes in man-pages git[1] in man2/
-directory to find out newly documented functionality.
-
-Another good source of information are kernel pages in LWN[2] weekly
-editions.
-
-Then there is linux-api mailing list[3] where changes in kernel userspace API
-should be discussed.
-
-[1] http://git.kernel.org/cgit/docs/man-pages/man-pages.git
-[2] http://lwn.net
-[3] http://dir.gmane.org/gmane.linux.kernel.api
-
-
-Rewrite old and add new controller testcases
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-We already started working on this with rewriting cgroup_fj testcases and
-newly added pids testcases. Have a look at testcases/kernel/controllers/.
-
-
-Shell tests cleanups
-~~~~~~~~~~~~~~~~~~~~
-
-There are numerous testcases written in shell that does not follow single style
-and use the broken-by-design binaries from tools/apicmds. These should be
-cleaned up and fixed to use the test.sh test library. These include most of
-tests in testcases/commands/ for example.
diff --git a/doc/developers/todo.rst b/doc/developers/todo.rst
new file mode 100644
index 000000000..f0adeec27
--- /dev/null
+++ b/doc/developers/todo.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+List of ongoing tasks
+=====================
+
+This is a comprehensive list of tasks where LTP maintainers are currently
+working on. Priorities might change over time, but these are the most important
+points which are currently being achieved.
+
+Fade out old tests runner
+-------------------------
+
+``runltp`` script is old and unmaintaned. We are slowly shifting to
+`kirk <https://github.com/linux-test-project/kirk>`_, that will be our official
+tests runner in the next future.
+
+kirk provides support for remote testing via Qemu, SSH, LTX, parallel
+execution and much more.
+
+Test new syscalls
+-----------------
+
+Syscalls and new syscalls flags are added to Linux kernel each development
+cycle and LTP still falls behind. Unfortunately there is no single place that
+would store comprehensive list of syscalls, but there are a few places to look
+at:
+
+- `man-pages repository <http://git.kernel.org/cgit/docs/man-pages/man-pages.git>`_
+  or the ``man2`` directory, where it's possible to find newly documented
+  functionalities.
+- `LWN <http://lwn.net>`_ weekly editions.
+- `linux-api mailing list <https://lore.kernel.org/linux-api/>`_ where
+  changes in kernel userspace API are discussed.
+- `LTP Github issues <https://github.com/linux-test-project/ltp/issues>`_
+
+Rewrite old API tests
+---------------------
+
+LTP has a long story and, at certain point of its development, new API were
+introduced to make kernel testing easier and more efficient. This happened when
+lots of tests were still using old, messy API.
+
+Some of these tests have been converted to the new API, but this process is
+still ongoing for many others. To have an overview of the tests using old API,
+please run the following command inside the LTP root folder:
+
+.. code-block:: bash
+
+        git --no-pager grep -l 'include "test\.h"' testcases/
+
+Fade out shell scripts
+----------------------
+
+LTP was initially thought as a generic framework for running tests with both
+shell and plain-C languages. Even if writing tests in shell script might seem
+easy, the reality is that debugging and maintaining certain test cases is
+difficult and slow down the whole validation process. This is particularly
+visible for cgroup tests, since shell doesn't add enough control over race
+conditions.
+
+LTP maintainers are working on converting shell scripts to plain-C tests, in
+order to reduce the impact that shell scripts might have on the overall kernel
+testing.
+
+For a complete list of shell tests, please run the following command inside the
+LTP root folder:
+
+.. code-block:: bash
+
+        git --no-pager grep -l -e '^\. .*_lib\.sh' -e '^\. .*test.sh'
+
+LTP also provides a shell loader implementation for plain-C tests using
+:master:`testcases/lib/tst_run_shell.c`.
diff --git a/doc/index.rst b/doc/index.rst
index acd16cdbf..06b75616f 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -30,6 +30,7 @@
    developers/build_system
    developers/debugging
    developers/documentation
+   developers/todo
 
 .. toctree::
    :maxdepth: 3
@@ -97,6 +98,9 @@ For developers
 :doc:`developers/documentation`
    How to use and develop LTP documentation
 
+:doc:`developers/todo`
+   List of tasks maintainers are working on
+
 For maintainers
 ---------------
 

---
base-commit: 79b7f212b3e56f1a4c33af3f61f66502b574cf1e
change-id: 20251006-remove_todo-c29a585e8b01

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
