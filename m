Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FA0CCA476
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 12:29:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6943A3CEBCA
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 14:29:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DDFC3CEB87
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 14:29:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 351741A0091C
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 14:29:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 663311F385;
 Mon, 13 Oct 2025 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760358563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2hAAdpb8nHvlXcO12JoW/6HF0Knn0Nwuicjjzzk0ZM=;
 b=D+oZm7vvL0s2ykN0jlDdIdZQYMVszUdPs9oC4f1pUwKkRGIusBXfUqBnHBcDVv0hck7K+L
 foTmwwP5WSaLMY58upQIUPdHrfzBNx9U9iOoNWn9nIgz0g2JyGk3TZLEn6rKZwHwvrtcPu
 HZ2Wr3sNrXJAvFC0oLRd18LXdT8XMKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760358563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2hAAdpb8nHvlXcO12JoW/6HF0Knn0Nwuicjjzzk0ZM=;
 b=n1FXAcJpqypz0nSMqtHBzv4GQXw2E9aWxj/p3O/NROuxRUrBbXyO0kDj2CSUj46QNzJ+CP
 X0ea6Afudnp74QDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D+oZm7vv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n1FXAcJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760358563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2hAAdpb8nHvlXcO12JoW/6HF0Knn0Nwuicjjzzk0ZM=;
 b=D+oZm7vvL0s2ykN0jlDdIdZQYMVszUdPs9oC4f1pUwKkRGIusBXfUqBnHBcDVv0hck7K+L
 foTmwwP5WSaLMY58upQIUPdHrfzBNx9U9iOoNWn9nIgz0g2JyGk3TZLEn6rKZwHwvrtcPu
 HZ2Wr3sNrXJAvFC0oLRd18LXdT8XMKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760358563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2hAAdpb8nHvlXcO12JoW/6HF0Knn0Nwuicjjzzk0ZM=;
 b=n1FXAcJpqypz0nSMqtHBzv4GQXw2E9aWxj/p3O/NROuxRUrBbXyO0kDj2CSUj46QNzJ+CP
 X0ea6Afudnp74QDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EF1B13874;
 Mon, 13 Oct 2025 12:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pz8mBaPw7Gj1IQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Oct 2025 12:29:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Oct 2025 14:29:19 +0200
MIME-Version: 1.0
Message-Id: <20251013-remove_todo-v2-1-d0a46ad14e34@suse.com>
X-B4-Tracking: v=1; b=H4sIAJ7w7GgC/23MQQ7CIBCF4as0sxYDJNNWV96jaQzQwbJox0Alm
 oa7i127/F/yvh0SxUAJrs0OkXJIgdca+tSAm836IBGm2qClRiVlKyItnOm+8cTC6YvBHqm3UkF
 9PCP58D60Yaw9h7Rx/Bx4Vr/1v5OVUAKtsehb33Ueb+mV6Ox4gbGU8gVn8F5kpQAAAA==
X-Change-ID: 20251006-remove_todo-c29a585e8b01
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760358562; l=5260;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=VKCanxZFQ6dKB66TAYejaWETrw4Euum7Iv+rl2cKR9s=;
 b=rHyhk7MOgn1FZN7f64k5i/h0YZ35Hcr5lfI9DimS5jQb+hXv8Ot5n6PMuYAlYoA3qbKtB2wZI
 pjRDDKwMXMhAn4eM62J6X9Pd6+X10ArcP1USmjX1AcVj/myjq/euq/5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 663311F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Remove TODO
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
create less confusion for new comers.

Instead, we create a todo list in the new documentation, providing a
more clear intention of what are the current LTP goals.

Acked-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- add doc/users/todo.rst section
- Link to v1: https://lore.kernel.org/r/20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com
---
 TODO               | 39 ---------------------------------------
 doc/index.rst      |  4 ++++
 doc/users/todo.rst | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 39 deletions(-)

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
diff --git a/doc/index.rst b/doc/index.rst
index acd16cdbf..6cfe21e8d 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -13,6 +13,7 @@
    users/supported_systems
    users/stats
    users/test_catalog
+   users/todo
 
 .. toctree::
    :maxdepth: 3
@@ -59,6 +60,9 @@ For users
 :doc:`users/test_catalog`
    The LTP test catalog
 
+:doc:`users/todo`
+   List of tasks maintainers are working on
+
 For developers
 --------------
 
diff --git a/doc/users/todo.rst b/doc/users/todo.rst
new file mode 100644
index 000000000..a8d8f9d37
--- /dev/null
+++ b/doc/users/todo.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+List of ongoing tasks
+=====================
+
+This is a comprehensive list of tasks where LTP maintainers are currently
+working on. Priorities might change over time, but these are the most important
+points which are currently being achieved.
+
+Test new syscalls
+-----------------
+
+Syscalls and new syscalls flags are added to Linux kernel each development
+cycle and LTP still falls behind. Unfortunately there is no single place that
+would store comprehensive list of syscalls, but there are a few places to look
+at:
+
+- `man-pages repo <http://git.kernel.org/cgit/docs/man-pages/man-pages.git>`_,
+  or the ``man2`` directory, where it's possible to find newly documented
+  functionalities.
+- `LWN <http://lwn.net>`_ weekly editions.
+- `linux-api mailing list <http://dir.gmane.org/gmane.linux.kernel.api>`_, where
+  changes in kernel userspace API are discussed.
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
+you can run the following command inside the LTP root folder:
+
+.. code-block:: bash
+
+        $ wc -l $(grep -R '"test\.h"' --include="*.c" testcases/kernel/ | cut -d: -f1) | sort -g
+
+Fade out shell scripts
+----------------------
+
+LTP was initially thought as a generic framework for running tests with both
+shell and plain-C languages. Even if writing tests in shell script might seem
+easy, the reality is that debugging and maintaining certain test cases is
+difficult and slow down the whole validation process.
+
+LTP maintainers are working on converting shell scripts to plain-C tests, in
+order to reduce the impact that shell scripts might have on the overall kernel
+testing.

---
base-commit: 79b7f212b3e56f1a4c33af3f61f66502b574cf1e
change-id: 20251006-remove_todo-c29a585e8b01

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
