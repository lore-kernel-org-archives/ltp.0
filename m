Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B967CCD18D
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 14:20:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD52A3CEBF3
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 16:20:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C52A3CEBA3
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 16:20:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 127561400C70
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 16:20:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9590B211E6;
 Mon, 13 Oct 2025 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760365231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCUDzcfSn/cTVylTviSXLjuVvneQT+OtEXo+aBX1Spc=;
 b=Wek14HhOAEVGOiv/YVRIbqxqKeF5TdictfPpiXIOwg7tI2eu5HiuoK2qQ4ZtxHNdiQRlFy
 OhYElMgSLx+R6sHkd0pmkC9TUgUgoNXSPzcr7htPpcfrZZExPnog26J0uyXKDBDREMEsNI
 YwmRC+uR3+f8r//02upwN/YGWvrliqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760365231;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCUDzcfSn/cTVylTviSXLjuVvneQT+OtEXo+aBX1Spc=;
 b=iSrUtXoVmGMZ1AwNFlmAbosn4vCLVspLVRwOK9wb4RvAA+eMLJMrZ9cYJxC6QzYIX7KG4t
 M7G0FHbOQmn4UuBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760365231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCUDzcfSn/cTVylTviSXLjuVvneQT+OtEXo+aBX1Spc=;
 b=Wek14HhOAEVGOiv/YVRIbqxqKeF5TdictfPpiXIOwg7tI2eu5HiuoK2qQ4ZtxHNdiQRlFy
 OhYElMgSLx+R6sHkd0pmkC9TUgUgoNXSPzcr7htPpcfrZZExPnog26J0uyXKDBDREMEsNI
 YwmRC+uR3+f8r//02upwN/YGWvrliqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760365231;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XCUDzcfSn/cTVylTviSXLjuVvneQT+OtEXo+aBX1Spc=;
 b=iSrUtXoVmGMZ1AwNFlmAbosn4vCLVspLVRwOK9wb4RvAA+eMLJMrZ9cYJxC6QzYIX7KG4t
 M7G0FHbOQmn4UuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CD4A13874;
 Mon, 13 Oct 2025 14:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gdlmDq8K7Wg2EQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Oct 2025 14:20:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Oct 2025 16:20:29 +0200
MIME-Version: 1.0
Message-Id: <20251013-remove_todo-v3-1-533e47439a94@suse.com>
X-B4-Tracking: v=1; b=H4sIAKwK7WgC/23MQQ6CMBCF4auQWVvTaSmgK+9hjCl0Kl1ATYuNh
 nB3CytMXL6XfP8MkYKjCOdihkDJRefHPOShgK7X44OYM3mD4EIh5xULNPhE98kbzzpx0qpR1LQ
 cIYtnIOveW+16y7t3cfLhs8UTru//TkKGTLW6VbaydW3VJb4iHTs/wJpJYkdR/lKRqeG6rLTBk
 mS5o8uyfAHHv+/U4AAAAA==
X-Change-ID: 20251006-remove_todo-c29a585e8b01
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760365231; l=6364;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=ugXII5OHt9hb306dh6aiggW7OCHNKXwiPZ2Vfm6FyNo=;
 b=+8SV/8S/Dx914/S6KUiZ2pDF1UB3EUr3syUl2sW05jm46hYRTDyokzbSCpg5BdWBoELDNNpuJ
 a7S6+gp3y4ECvaZjE7e8liRxJNpn+2s5JVxgsJmJp4uYYOhkn302RzY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Remove TODO
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
 TODO               | 39 ----------------------------
 doc/index.rst      |  4 +++
 doc/users/todo.rst | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 39 deletions(-)

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
index 000000000..2484eaf32
--- /dev/null
+++ b/doc/users/todo.rst
@@ -0,0 +1,74 @@
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
+        git --no-pager grep 'include "test\.h"' testcases/ | cut -d: -f1
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
+``tst_run_script`` features. Please take a look at the
+:doc:`LTP API <../developers/api_c_tests>`.

---
base-commit: 79b7f212b3e56f1a4c33af3f61f66502b574cf1e
change-id: 20251006-remove_todo-c29a585e8b01

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
