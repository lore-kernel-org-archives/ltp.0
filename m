Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEABC4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 12:17:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E1EB3CF9FC
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 14:17:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9EB3CF759
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 14:17:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA2C2600796
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 14:17:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4DBB21B61;
 Mon, 15 Apr 2024 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713183444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UKp5aDl10SqNC519gE9ZAZ6Yc0bHfhoLXfD+TZ4dysc=;
 b=JLAWKkMxWCnI3DfqIV2Oo8aAL+FigVa7IyrW+A8QLVvfDok+q+aXEXVbjSba9xT17JzVTU
 o/BKXXt85tLvN7leXoqLMXn0/ohk2uz3jHuulRnIrOEXh2sTP5aTDlYl0OvR2ZuCr4Z6sO
 i88FFLq+Y1KLedwveaFvx0J9FQlgYSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713183444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UKp5aDl10SqNC519gE9ZAZ6Yc0bHfhoLXfD+TZ4dysc=;
 b=eAHbjxpbweDJApHM6/9DRqnRIZNtiWq3fxB42b7VtQbT1GMyX3fKI/SxdV8wtsU+LKGLSC
 xmGMbvgsUI0oemAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713183444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UKp5aDl10SqNC519gE9ZAZ6Yc0bHfhoLXfD+TZ4dysc=;
 b=JLAWKkMxWCnI3DfqIV2Oo8aAL+FigVa7IyrW+A8QLVvfDok+q+aXEXVbjSba9xT17JzVTU
 o/BKXXt85tLvN7leXoqLMXn0/ohk2uz3jHuulRnIrOEXh2sTP5aTDlYl0OvR2ZuCr4Z6sO
 i88FFLq+Y1KLedwveaFvx0J9FQlgYSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713183444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UKp5aDl10SqNC519gE9ZAZ6Yc0bHfhoLXfD+TZ4dysc=;
 b=eAHbjxpbweDJApHM6/9DRqnRIZNtiWq3fxB42b7VtQbT1GMyX3fKI/SxdV8wtsU+LKGLSC
 xmGMbvgsUI0oemAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D6CA1386E;
 Mon, 15 Apr 2024 12:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rrtzJNQaHWbVeAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Apr 2024 12:17:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 15 Apr 2024 14:17:19 +0200
Message-Id: <20240415121719.3798-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: Add new API conversion stats
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

Show inside documentation what's the status of the current LTP
refactoring plan that aims to convert all tests into the new API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/.gitignore      |  1 +
 doc/conf.py         | 48 +++++++++++++++++++++++++++++++++++++++++++++
 doc/users/stats.rst |  1 +
 3 files changed, 50 insertions(+)

diff --git a/doc/.gitignore b/doc/.gitignore
index 173179852..ab979ad18 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1,4 +1,5 @@
 html/
 build/
 _static/syscalls.rst
+_static/old_api.rst
 syscalls.tbl
diff --git a/doc/conf.py b/doc/conf.py
index fb3e83cf2..2cec90a64 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -39,6 +39,53 @@ html_theme = 'sphinx_rtd_theme'
 html_static_path = ['_static']
 
 
+def generate_old_api_stats(_):
+    """
+    Generate statistics for old API tests. We enter the tests folder and we
+    count all tests implementations using old API. The way we count them, is to
+    open every *.c file and to verify that "#include <test.h>" directive is
+    present.
+    """
+    output = '_static/old_api.rst'
+
+    old_regex = re.compile(r'#include.*[<"\']test\.h[>"\']')
+    new_regex = re.compile(r'#include.*[<"\']tst_test\.h[>"\']')
+
+    old_tests = 0
+    new_tests = 0
+
+    for root, _, files in os.walk('../testcases'):
+        for fname in files:
+            if not fname.endswith('.c'):
+                continue
+
+            path = os.path.join(root, fname)
+            with open(path, 'r', errors='ignore') as fdata:
+                for line in fdata:
+                    if old_regex.match(line):
+                        old_tests += 1
+                        break
+
+                    if new_regex.match(line):
+                        new_tests += 1
+                        break
+
+    if old_tests == 0 and new_tests == 0:
+        return
+
+    text = [
+        'New API conversion status\n',
+        '-------------------------\n\n',
+        'The current LTP refactoring plan aims to convert all LTP test\n',
+        f'cases using the new LTP API. There are currently **{old_tests}** tests\n',
+        f'which need to be converted and **{new_tests}** have been converted\n',
+        'already.\n',
+    ]
+
+    with open(output, 'w+') as stats:
+        stats.writelines(text)
+
+
 def generate_syscalls_stats(_):
     """
     Generate statistics for syscalls. We fetch the syscalls list from the kernel
@@ -198,4 +245,5 @@ def generate_syscalls_stats(_):
 
 def setup(app):
     app.add_css_file('custom.css')
+    app.connect('builder-inited', generate_old_api_stats)
     app.connect('builder-inited', generate_syscalls_stats)
diff --git a/doc/users/stats.rst b/doc/users/stats.rst
index 7073442aa..a8b322b5f 100644
--- a/doc/users/stats.rst
+++ b/doc/users/stats.rst
@@ -6,4 +6,5 @@ Statistics
 In this section we collect some statistics related to the current state of
 LTP tests.
 
+.. include:: ../_static/old_api.rst
 .. include:: ../_static/syscalls.rst
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
