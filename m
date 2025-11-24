Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E79CFD313
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 16:42:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B92D3C85A7
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 17:42:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C31403C8483
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 17:42:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A046D10008FE
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 17:42:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B7B15BCE7;
 Mon, 24 Nov 2025 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764002533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NQfMSpDXgr1dH5/ZmHxnh4+BOWpp5/qgfAHlSDiS+AI=;
 b=ekpiA2bHAqqckhjM3Pil8cCm9VbVEX3c9Hs2Ws/ti/O1XDucjRvsEfwhU7mRzOeUmWfpj8
 2wCYZMc3ank+aVx9Knjp/Mm6lA48mPIkE1/0v2k4TmuTqruH2YHvFnXrDtEFO9vAwzpDdg
 0BidVBYeifQjTnsbI0KLnKsUMu71dGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764002533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NQfMSpDXgr1dH5/ZmHxnh4+BOWpp5/qgfAHlSDiS+AI=;
 b=zod/gG92Qxt6qJ/yx51X6XbL+fekMmXeA/PR6N8TCsSH+IoeP1svSfBRX/t4dOSYFPNA9i
 498d+Y1y4cEporBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ekpiA2bH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="zod/gG92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764002533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NQfMSpDXgr1dH5/ZmHxnh4+BOWpp5/qgfAHlSDiS+AI=;
 b=ekpiA2bHAqqckhjM3Pil8cCm9VbVEX3c9Hs2Ws/ti/O1XDucjRvsEfwhU7mRzOeUmWfpj8
 2wCYZMc3ank+aVx9Knjp/Mm6lA48mPIkE1/0v2k4TmuTqruH2YHvFnXrDtEFO9vAwzpDdg
 0BidVBYeifQjTnsbI0KLnKsUMu71dGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764002533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NQfMSpDXgr1dH5/ZmHxnh4+BOWpp5/qgfAHlSDiS+AI=;
 b=zod/gG92Qxt6qJ/yx51X6XbL+fekMmXeA/PR6N8TCsSH+IoeP1svSfBRX/t4dOSYFPNA9i
 498d+Y1y4cEporBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B2923EA63;
 Mon, 24 Nov 2025 16:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hMMOIeWKJGkYEgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Nov 2025 16:42:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Nov 2025 17:43:07 +0100
Message-ID: <20251124164307.20516-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9B7B15BCE7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] doc: Add basic shell test description
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Avinesh Kumar <akumar@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py                        |  1 +
 doc/developers/api_shell_tests.rst | 91 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

Changes in v2:

- fixed typos
- added links as requested by Petr

diff --git a/doc/conf.py b/doc/conf.py
index 86f6fe2b7..e8488bff7 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -34,6 +34,7 @@ exclude_patterns = ["html*", '_static*', '.venv*']
 extlinks = {
     'repo': (f'{ltp_repo}/%s', '%s'),
     'master': (f'{ltp_repo}/blob/master/%s', '%s'),
+    'shell_lib': (f'{ltp_repo}/blob/master/testcases/lib/%s', '%s'),
     'git_man': ('https://git-scm.com/docs/git-%s', 'git %s'),
     'man2': ('https://man7.org/linux/man-pages/man2/%s.2.html', '%s(2)'),
     'man3': ('https://man7.org/linux/man-pages/man3/%s.3.html', '%s(3)'),
diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
index b6e8560d9..ccfc0e071 100644
--- a/doc/developers/api_shell_tests.rst
+++ b/doc/developers/api_shell_tests.rst
@@ -2,3 +2,94 @@
 
 LTP shell API
 =============
+
+Shell API overview
+------------------
+
+First lines of the shell test should be a shebang, a license, and copyrights.
+
+.. code-block:: shell
+
+   #!/bin/sh
+   # SPDX-License-Identifier: GPL-2.0-or-later
+   # Copyright 2099 Foo Bar <foo.bar@example.org>
+
+A documentation comment block formatted in ReStructuredText should follow right
+after these lines. This comment is parsed and exported into the LTP
+documentation at https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
+
+.. code-block:: shell
+
+   # ---
+   # doc
+   # Test for a foo bar.
+   #
+   # This test is testing foo by checking that bar is doing xyz.
+   # ---
+
+The shell loader test library uses the :doc:`../developers/api_c_tests`
+internally by parsing a special JSON formatted comment and
+initializing it accordingly. The JSON format is nearly 1:1 serialization of the
+:ref:`struct tst_test` into a JSON. The environment must be always preset even
+when it's empty.
+
+.. code-block:: shell
+
+   # ---
+   # env
+   # {
+   #  "needs_root": true,
+   #  "needs_tmpdir": true,
+   #  "needs_kconfigs": ["CONFIG_NUMA=y"],
+   #  "tags": {
+   #   ["linux-git", "432fd03240fa"]
+   #  }
+   # }
+
+After the documentation and environment has been laid out we finally import the
+:shell_lib:`tst_loader.sh`. This will, among other things, start the
+:shell_lib:`tst_run_shell.c` binary, that will parse the shell test environment
+comment and initialize the C test library accordingly.
+
+.. code-block:: shell
+
+   . tst_loader.sh
+
+At this point everything has been set up and we can finally write the test
+function. The test results are reported by the usual functions :ref:`tst_res` and
+:ref:`tst_brk`. As in the C API these functions store results into a piece of shared
+memory as soon as they return so there is no need to propagate results event
+from child processes.
+
+.. code-block:: shell
+
+   tst_test()
+   {
+        tst_res TPASS "Bar enabled Foo"
+   }
+
+In order for the test to be actually executed the very last line of the script
+must source the :shell_lib:`tst_run.sh` script.
+
+.. code-block:: shell
+
+   . tst_run.sh
+
+In order to run a test from a LTP tree a few directories has to be added to the
+`$PATH`. Note that the number of `../` may depend on the depth of the current
+directory relative to the LTP root.
+
+.. code-block:: shell
+
+   $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
+
+Test setup and cleanup
+----------------------
+
+The test setup and cleanup functions are optional and passed via variables.
+Similarily to the C API the setup is executed exactly once at the start of the
+test and the test cleanup is executed at the test end or when test was
+interrupted by ref:`tst_brk`.
+
+   .. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
+   :language: shell
-- 
2.51.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
