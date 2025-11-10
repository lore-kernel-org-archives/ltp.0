Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED25FCCFA13
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 10:23:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D6713CF56D
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 11:23:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FAC03CF55A
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:23:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 279DA20076D
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:23:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 314171F397
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762770199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DWwENtj5ix2BZ39DTOHWdbRS4i1ZKcLUHophLOebgaY=;
 b=1pvCz1asKN2ac8ZWGL5gFhAPMxFRWv2FluiuJNQ90ycZ/RIFiminYF0kpuLfaY5QlwJ8mZ
 TP9KSDHSRWt1Ow6pUjurwYLtZvYZT173kDVdM6G9G6zR16MZAafewjGbraBpS99XsSh2Nn
 Uh0VXzCIY2FqWmVzDse7ONcU7o2P2pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762770199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DWwENtj5ix2BZ39DTOHWdbRS4i1ZKcLUHophLOebgaY=;
 b=7sm9a8U+q80plcWuAVUrA+WSHtlhbf+Ndu05eOeRCVpNyAjMaWku5dGdUV2Z/e5HaAAjIT
 XOIyDOwSg8JzBrBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1pvCz1as;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7sm9a8U+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762770199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DWwENtj5ix2BZ39DTOHWdbRS4i1ZKcLUHophLOebgaY=;
 b=1pvCz1asKN2ac8ZWGL5gFhAPMxFRWv2FluiuJNQ90ycZ/RIFiminYF0kpuLfaY5QlwJ8mZ
 TP9KSDHSRWt1Ow6pUjurwYLtZvYZT173kDVdM6G9G6zR16MZAafewjGbraBpS99XsSh2Nn
 Uh0VXzCIY2FqWmVzDse7ONcU7o2P2pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762770199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DWwENtj5ix2BZ39DTOHWdbRS4i1ZKcLUHophLOebgaY=;
 b=7sm9a8U+q80plcWuAVUrA+WSHtlhbf+Ndu05eOeRCVpNyAjMaWku5dGdUV2Z/e5HaAAjIT
 XOIyDOwSg8JzBrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 165DC14342
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wNDQAxe9EWkvHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:23:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 11:24:07 +0100
Message-ID: <20251110102407.15308-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 314171F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: Add basic shell test description
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
---
 doc/developers/api_shell_tests.rst | 91 ++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
index b6e8560d9..bad9f1f4b 100644
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
+   # Copyright 2099 Foo Bar <foo.bar@email.com>
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
+The shell loader test library uses the C test library internally by parsing a
+special JSON formatted comment and initializing it accordingly. The JSON format
+is nearly 1:1 serialization of the C tst_test structure into a JSON. The
+environment must be always preset even when it's empty.
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
+`tst_loader.sh`. This will, among other things, start the `tst_run_shell`
+binary, that will parse the shell test environment comment and initialize the C
+test library accordingly.
+
+.. code-block:: shell
+
+   . tst_loader.sh
+
+At this point everything has been set up and we can finally write the test
+function. The test results are reported by the usual functions `tst_res` and
+`tst_brk`. As in the C API these functions store results into a piece of shared
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
+must source the `tst_run.sh` script.
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
+
+Test setup and cleanup
+----------------------
+
+The test setup and cleanup functions are optioinal and passed via variables.
+Similarily to the C API the setup is executed exactly once at the start of the
+test and the test cleanup is executed at the test end or when test was
+interrupted by `tst_brk`.
+
+.. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
+   :language: shell
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
