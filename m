Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35543C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 10:08:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6653CF8DB
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 12:07:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E678B3CF81A
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 12:07:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 74B5D1000C27
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 12:07:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBD0D5FB38;
 Fri, 12 Apr 2024 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712916460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Td+XYzXyj9LjFm94pQveiZs72tzg57MFK8PO5gTeT9w=;
 b=1OLupHeINf8/usCsfdL+QvisAkyO/4HvZcGQOUr5hCPZWXDNlUDx7FxeVwTrGrSTvyyj21
 +ugxKYYP1xtJURh2j0sHt8kMkPdkUTiWHn/XmnQ4EedE6AGExMRvQFqxbc86ZfLS7lZNUC
 10oo9PN4jSFsRSX+rWlc8k4ryffl9MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712916460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Td+XYzXyj9LjFm94pQveiZs72tzg57MFK8PO5gTeT9w=;
 b=Uux25yFq4knDIgOkoO9Ag9MLA1pTtbCjxCBDQKJmWOXqK+Au9GChmTVmzJhW9RlMQb+0Jf
 0GKDyZYUzUN1WUAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712916460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Td+XYzXyj9LjFm94pQveiZs72tzg57MFK8PO5gTeT9w=;
 b=1OLupHeINf8/usCsfdL+QvisAkyO/4HvZcGQOUr5hCPZWXDNlUDx7FxeVwTrGrSTvyyj21
 +ugxKYYP1xtJURh2j0sHt8kMkPdkUTiWHn/XmnQ4EedE6AGExMRvQFqxbc86ZfLS7lZNUC
 10oo9PN4jSFsRSX+rWlc8k4ryffl9MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712916460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Td+XYzXyj9LjFm94pQveiZs72tzg57MFK8PO5gTeT9w=;
 b=Uux25yFq4knDIgOkoO9Ag9MLA1pTtbCjxCBDQKJmWOXqK+Au9GChmTVmzJhW9RlMQb+0Jf
 0GKDyZYUzUN1WUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A43AD13942;
 Fri, 12 Apr 2024 10:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CRUDJuwHGWYjHwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Apr 2024 10:07:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 12 Apr 2024 12:07:39 +0200
Message-Id: <20240412100739.1169-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: Documentation usage and development
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

This patch adds a section for developers, explaining how to use and
build the new LTP documentation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/documentation.rst | 49 ++++++++++++++++++++++++++++++++
 doc/index.rst                    |  4 +++
 2 files changed, 53 insertions(+)
 create mode 100644 doc/developers/documentation.rst

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
new file mode 100644
index 000000000..5b112bcaf
--- /dev/null
+++ b/doc/developers/documentation.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Documentation
+=============
+
+This section explains how to use and develop the LTP documentation. The current
+documentation format is written using
+`reStructedText <https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html>`_
+and it's built on top of `Sphinx <https://www.sphinx-doc.org/en/master/>`_.
+
+Building documentation
+~~~~~~~~~~~~~~~~~~~~~~
+
+First of all, to build the documentation we must be sure that all dependences
+have been installed (please check ``doc/requirements.txt`` file). Sometimes the
+Linux distros are providing them, but the best way is to use ``virtualenv``
+command as following:
+
+.. code-block:: bash
+
+    cd doc
+
+    # prepare virtual enviroment
+    python -m virtualenv .venv
+    source .venv/bin/activate
+
+    pip install sphinx
+    pip install -r requirements.txt
+
+    # build documentation
+    make
+
+Once the procedure has been completed, documentation will be visible at
+``doc/html/index.html``.
+
+.. warning::
+
+    The current ``.readthedocs.yml`` workflow is using ``Python 3.6`` because
+    other Python versions were causing issues. No other version has been tested,
+    but it should work anyway.
+
+Validating spelling
+~~~~~~~~~~~~~~~~~~~
+
+To check documentation words spelling, we provide support for
+`aspell <http://aspell.net/>`_, so make sure that it's installed. The
+documentation can be tested via ``make spelling`` command. Output will be
+visible in the ``doc/build`` folder and, if any error will be found, a warning
+message will be shown.
diff --git a/doc/index.rst b/doc/index.rst
index 80820ab51..653449cc4 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -27,6 +27,7 @@
    developers/ltp_library
    developers/build_system
    developers/debugging
+   developers/documentation
 
 .. toctree::
    :maxdepth: 3
@@ -88,6 +89,9 @@ For developers
 :doc:`developers/debugging`
    How to debug LTP tests
 
+:doc:`developers/documentation`
+   How to use and develop LTP documentation
+
 For maintainers
 ---------------
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
