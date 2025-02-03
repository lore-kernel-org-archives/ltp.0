Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB2CC02193
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 09:38:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05A393C8EA8
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:38:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DECD93C8E74
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:38:12 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 172E46190DF
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:38:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3D71F37C
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738575490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3h6ZEfombIkWJaFS7svdF/GZSnSVJkVC6MC6+ThaCfI=;
 b=aFsih/zY3TbOZpPkJy/P9/Zaucp6f0pfN0WrFqG3vOwheRaVXK7BXyfdAFpzY0rgVLj/R1
 ljru37QVtwfMiRstIq/tPcK5B8wkxO0CMIBBHt/UqZpqQjzsAyjGZy4T4y12iZTA5rd5l4
 arxYE83CtIUe6A7v382hhYsr0elRHjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738575490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3h6ZEfombIkWJaFS7svdF/GZSnSVJkVC6MC6+ThaCfI=;
 b=p9ZL88n2ipSPI8/THTaYGg5fGRIfqTrdWesgSQyeppeWFGRHhQuHgRl/dzLWhQxM+T409R
 CwuPmMmvE2Ed7SCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="aFsih/zY";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p9ZL88n2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738575490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3h6ZEfombIkWJaFS7svdF/GZSnSVJkVC6MC6+ThaCfI=;
 b=aFsih/zY3TbOZpPkJy/P9/Zaucp6f0pfN0WrFqG3vOwheRaVXK7BXyfdAFpzY0rgVLj/R1
 ljru37QVtwfMiRstIq/tPcK5B8wkxO0CMIBBHt/UqZpqQjzsAyjGZy4T4y12iZTA5rd5l4
 arxYE83CtIUe6A7v382hhYsr0elRHjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738575490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3h6ZEfombIkWJaFS7svdF/GZSnSVJkVC6MC6+ThaCfI=;
 b=p9ZL88n2ipSPI8/THTaYGg5fGRIfqTrdWesgSQyeppeWFGRHhQuHgRl/dzLWhQxM+T409R
 CwuPmMmvE2Ed7SCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78B8413A78
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 09:38:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 686aGYKOoGe0YwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 09:38:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 03 Feb 2025 10:38:04 +0100
MIME-Version: 1.0
Message-Id: <20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com>
X-B4-Tracking: v=1; b=H4sIAHuOoGcC/x3MQQqAIBBA0avErBMaLYiuEiGlYw1EhSMRSHdPW
 r7F/xmEIpPAUGWIdLPweRRgXYHb5mMlxb4YdKO7Bg0qfzqbSJLYnSUpXHodOqTWBA8luiIFfv7
 hOL3vB3mBY8ZgAAAA
X-Change-ID: 20250131-doc_tests_list-1b82f51e43fd
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738575490; l=7045;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Qf2IIlYkxCiS7S4PtAfHsKLMRh/v8tM1Xr1hNfrN0G4=;
 b=7u8A0MQHHQ6OzezODx+Q0Top8U3yo5hIMgc88h7ywa+ix8u29WB7raOCy0xbSYMgrg+K8N/kj
 FJWAL1lAEoCC4wFe8Sli5sw9OJgVj3QsM8UWOEaBLcu0X3djVx1F5UX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 8F3D71F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: add tests catalog page
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

Add a new section in the LTP documentation website, where we list all
tests which are available in LTP and supporting new API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This patch-set is meant to introduce a new page in the LTP
documentation, showing tests which are currently available with their
description and information.
---
 doc/.gitignore             |   1 +
 doc/conf.py                | 101 +++++++++++++++++++++++++++++++++++++++++++--
 doc/index.rst              |   4 ++
 doc/users/test_catalog.rst |   7 ++++
 4 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/doc/.gitignore b/doc/.gitignore
index 173179852070f25acb6a729975df9d52d171b422..2b05a1ec368573778cfe7ee6a1cb5d6c5ecb0b5a 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1,4 +1,5 @@
 html/
 build/
 _static/syscalls.rst
+_static/tests.rst
 syscalls.tbl
diff --git a/doc/conf.py b/doc/conf.py
index c6a84ea5810424ce6e1c21d81946c1819f10a3cc..2ecfeb80ece1e14f94b757f26fa5e08fb79f1c69 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -5,6 +5,7 @@
 
 import os
 import re
+import json
 import socket
 import urllib.request
 import sphinx
@@ -17,6 +18,7 @@ copyright = '2024, Linux Test Project'
 author = 'Linux Test Project'
 release = '1.0'
 ltp_repo = 'https://github.com/linux-test-project/ltp'
+ltp_repo_base_url = f"{ltp_repo}/tree/master"
 
 # -- General configuration ---------------------------------------------------
 # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
@@ -25,7 +27,7 @@ extensions = [
     'linuxdoc.rstKernelDoc',
     'sphinxcontrib.spelling',
     'sphinx.ext.autosectionlabel',
-    'sphinx.ext.extlinks'
+    'sphinx.ext.extlinks',
 ]
 
 exclude_patterns = ["html*", '_static*']
@@ -138,7 +140,6 @@ def generate_syscalls_stats(_):
     if error:
         return
 
-    syscalls_base_url = f"{ltp_repo}/tree/master"
     text = [
         'Syscalls\n',
         '--------\n\n',
@@ -176,7 +177,7 @@ def generate_syscalls_stats(_):
             path = dirpath.replace('../', '')
             name = match.group('name')
 
-            ltp_syscalls[name] = f'{syscalls_base_url}/{path}'
+            ltp_syscalls[name] = f'{ltp_repo_base_url}/{path}'
 
     # compare kernel syscalls with LTP tested syscalls
     syscalls = {}
@@ -186,7 +187,7 @@ def generate_syscalls_stats(_):
 
         if kersc not in syscalls:
             if kersc in white_list:
-                syscalls[kersc] = f'{syscalls_base_url}/{white_list[kersc]}'
+                syscalls[kersc] = f'{ltp_repo_base_url}/{white_list[kersc]}'
                 continue
 
             syscalls[kersc] = None
@@ -256,6 +257,97 @@ def generate_syscalls_stats(_):
         stats.writelines(text)
 
 
+def generate_test_catalog(_):
+    """
+    Generate the test catalog from ltp.json metadata file.
+    """
+    output = '_static/tests.rst'
+    metadata_file = '../metadata/ltp.json'
+    cve_url = "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
+    commit_url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
+    timeout_def = 0
+    text = []
+
+    metadata = None
+    with open(metadata_file, 'r', encoding='utf-8') as data:
+        metadata = json.load(data)
+
+    timeout_def = metadata['defaults']['timeout']
+
+    for test_name, conf in metadata['tests'].items():
+        text.extend([
+            f'{test_name}\n',
+            len(test_name) * '-' + '\n'
+        ])
+
+        # source url location
+        test_fname = conf.get('fname', None)
+        if test_fname:
+            text.append(f"\n`source <{ltp_repo_base_url}/{test_fname}>`_\n\n")
+
+        # test description
+        desc = conf.get('doc', None)
+        if desc:
+            desc_text = []
+            for line in desc:
+                if line.startswith("[Descr"):
+                    desc_text.append("**Description**")
+                elif line.startswith("[Algo"):
+                    desc_text.append("**Algorithm**")
+                else:
+                    desc_text.append(line)
+
+            text.extend([
+                '\n'.join(desc_text),
+                '\n'
+            ])
+
+        timeout = conf.get('timeout', None)
+        if timeout:
+            text.append(f'\nTest timeout to {timeout} seconds.')
+        else:
+            text.append(f'\nTest timeout defaults to {timeout_def} seconds.')
+
+        text.append('\n\n')
+
+        # tags information
+        tags = conf.get('tags', None)
+        if tags:
+            text.extend([
+                '\n.. list-table::\n',
+                '   :widths: 50 50\n'
+                '   :header-rows: 1\n\n',
+                '   * - Tag\n',
+                '     - Info\n',
+            ])
+
+            for tag in tags:
+                tag_key = tag[0]
+                tag_val = tag[1]
+
+                if tag_key == 'CVE':
+                    tag_val = f'`{tag_val} <{cve_url}{tag_val}>`_'
+                elif tag_key == 'linux-git':
+                    tag_val = f'`{tag_val} <{commit_url}{tag_val}>`_'
+
+                text.extend([
+                    f'   * - {tag_key}\n',
+                    f'     - {tag_val}\n',
+                ])
+
+            text.append('\n')
+
+        # small separator between tests
+        text.extend([
+            '\n',
+            '.. raw:: html\n\n',
+            '    <hr>\n\n',
+        ])
+
+    with open(output, 'w+', encoding='utf-8') as new_tests:
+        new_tests.writelines(text)
+
+
 def setup(app):
     """
     Setup the current documentation, using self generated data and graphics
@@ -263,3 +355,4 @@ def setup(app):
     """
     app.add_css_file('custom.css')
     app.connect('builder-inited', generate_syscalls_stats)
+    app.connect('builder-inited', generate_test_catalog)
diff --git a/doc/index.rst b/doc/index.rst
index b907ac36f0c9328c576d25dee5777d808c2e5119..c00a59d31345142e78deb74eacc9da2941291d76 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -11,6 +11,7 @@
    users/setup_tests
    users/supported_systems
    users/stats
+   users/test_catalog
 
 .. toctree::
    :maxdepth: 3
@@ -54,6 +55,9 @@ For users
 :doc:`users/stats`
    Some LTP statistics
 
+:doc:`users/test_catalog`
+   The LTP test catalog
+
 For developers
 --------------
 
diff --git a/doc/users/test_catalog.rst b/doc/users/test_catalog.rst
new file mode 100644
index 0000000000000000000000000000000000000000..b1674f9dc614ea04a89cf084e92b72c6862a5f48
--- /dev/null
+++ b/doc/users/test_catalog.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Test catalog
+============
+
+.. include:: ../_static/tests.rst
+

---
base-commit: 728759506cbe08612183275b3543007d1c47f7f4
change-id: 20250131-doc_tests_list-1b82f51e43fd

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
