Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7724FC27C5F
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 14:11:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBB063D0AAE
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:11:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469DF3CFBD1
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:11:36 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 69F2A1A01092
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:11:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABA761FBA2;
 Fri,  7 Jun 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72A8213A42;
 Fri,  7 Jun 2024 14:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cEdcGRcVY2b3AwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 14:11:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 16:11:28 +0200
Message-ID: <20240607141131.111470-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607141131.111470-1-pvorel@suse.cz>
References: <20240607141131.111470-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: ABA761FBA2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc: Link API pages, rename title
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

Rename pages to be able to use them in links via :doc:.

We loose code formatting when linking code with :ref: struct tst_test,
but IMHO having a link is more important (usability).

Using :ref: requires to enable sphinx.ext.autosectionlabel plugin.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py                        |  1 +
 doc/developers/api_c_tests.rst     |  4 ++--
 doc/developers/api_shell_tests.rst |  4 ++--
 doc/developers/ltp_library.rst     |  5 +++--
 doc/maintainers/patch_review.rst   | 10 +++++-----
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 9525ad7bb..ac1220450 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -23,6 +23,7 @@ release = '1.0'
 extensions = [
     'linuxdoc.rstKernelDoc',
     'sphinxcontrib.spelling',
+    'sphinx.ext.autosectionlabel',
     'sphinx.ext.extlinks'
 ]
 
diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 2a9f3e7b9..164f82504 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -4,8 +4,8 @@
 .. Include headers in this file with:
 .. .. kernel-doc:: ../../include/tst_test.h
 
-Developing using C API
-======================
+LTP C API
+=========
 
 Core LTP API
 ------------
diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
index 2fb2a5068..b6e8560d9 100644
--- a/doc/developers/api_shell_tests.rst
+++ b/doc/developers/api_shell_tests.rst
@@ -1,4 +1,4 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-Developing using shell API
-==========================
+LTP shell API
+=============
diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
index 723781feb..c10366516 100644
--- a/doc/developers/ltp_library.rst
+++ b/doc/developers/ltp_library.rst
@@ -6,8 +6,9 @@ LTP Library guidelines
 General Rules
 -------------
 
-When we extend library API, we need to apply the same general rules that we use
-when writing tests, plus:
+For extending the LTP library API it applies the same general rules as
+for :doc:`writing tests <../developers/writing_tests>`
+(with strong focus on readability and simplicity), plus:
 
 #. LTP library tests must go inside :master:`lib/newlib_tests` directory
 #. LTP documentation has to be updated according to API changes
diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
index 0561ffd9d..36caaf23b 100644
--- a/doc/maintainers/patch_review.rst
+++ b/doc/maintainers/patch_review.rst
@@ -146,17 +146,17 @@ New test should
 C tests
 ~~~~~~~
 
-* Use the new C API, implementing ``struct tst_test``
+* Use :doc:`../developers/api_c_tests`, implementing :ref:`struct tst_test`
 * Test binaries are added into corresponding ``.gitignore`` files
 * Check coding style with ``make check``
 * Docparse documentation
-* If a test is a regression test it should include ``.tags`` in the
-  ``struct tst_test`` definition
+* If a test is a regression test it should include :ref:`.tags<struct tst_tag>` in the
+  :ref:`struct tst_test` definition
 
 Shell tests
 ~~~~~~~~~~~
 
-* Use new shell API
+* Use :doc:`../developers/api_shell_tests`
 * Check coding style with ``make check``
 * If a test is a regression test it should include related kernel or glibc
   commits as a comment
@@ -164,4 +164,4 @@ Shell tests
 LTP library
 ~~~~~~~~~~~
 
-For patchset touching the LTP library, follow the LTP library guidelines.
+For patchset touching the LTP library, follow :doc:`../developers/ltp_library`.
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
