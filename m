Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C1CC02198
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 15:50:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC3813C925B
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 16:50:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B783D3C813C
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 16:50:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E67511000992
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 16:50:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7F541F7B8;
 Wed,  5 Feb 2025 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738770639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lyrq5sjXp0eTNjJqCN7X1PG6wTm5nEKlYOw3OWBMQqM=;
 b=h0i/4Gy9VltvgWN8xc7+x4rbVKFUKNGlgvo2zrDognYUeCSNgq7j6ZHFQS8swpiiC9AUoC
 A1F/gLseaZGJVZFwYfd4jEAwe9z5QVkui+SYQHLp1JSGtrFkssvpgNUsEiGP5kKFWsmvyj
 mvX38mkn8WNsyYJWgInTe9kSAPfykyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738770639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lyrq5sjXp0eTNjJqCN7X1PG6wTm5nEKlYOw3OWBMQqM=;
 b=GWM4malhaPuoV3XdKX4KArej5w4reZSHijKvTyjkGK9DTGy+8neCXwJJPJOj3qy8ta/mPj
 SmAkwlO5+yTnGNCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738770638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lyrq5sjXp0eTNjJqCN7X1PG6wTm5nEKlYOw3OWBMQqM=;
 b=OIa70JcznTf+4/zcHxYVY2qDpgeLU7vGwVSzXIt1GLzyJDwlQhMKs88L1wNsZto62gvDtt
 FnXMLHRlus8JYe7m+fl8a7qRmq/QGtAx//XS/prFQsL7zlFXC2EvDiNefGoqzBDYL/lGMn
 LsaHnq4Wzeq3QMVh881KM/lAyPUJ5+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738770638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lyrq5sjXp0eTNjJqCN7X1PG6wTm5nEKlYOw3OWBMQqM=;
 b=oq4FOsphmJI083N3GdY5S6haaWBv7v4lZ72MS4sDdqkqhtWh+x2BFlpetyFTbnwYCSOmqs
 JxDYMDVo7zk4MgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5501139D8;
 Wed,  5 Feb 2025 15:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a5J1Ls6Io2d/KgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Feb 2025 15:50:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Feb 2025 16:50:34 +0100
MIME-Version: 1.0
Message-Id: <20250205-doc_tests_list-v4-1-ae46e56073bb@suse.com>
X-B4-Tracking: v=1; b=H4sIAMmIo2cC/2XMSwrCMBSF4a1Ixkby1jhyHyIljxsb0FaaGpTSv
 ZvWSWmH53K/f0AJuggJnXcD6iDHFNumDLHfIVeb5g44+rIRI0wSyin2rat6SH2qHjH1mNoTC5K
 C4MGjgl4dhPiZg9db2XV5arvv3M90uv5TjPB1KlNMsQygtCNHS429pHeCg2ufaCplttRio1nR2
 jNtwDjHA19pvtRyo3nRVhEltPNglFnocRx/BhpMuicBAAA=
X-Change-ID: 20250131-doc_tests_list-1b82f51e43fd
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738770638; l=12088;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=nzeXbKC3AGzzYKbYdLSWjteOFvszf9Jf5I6IUUxMvrY=;
 b=hL6eAAqXbfoIerh1Sny3WGxeixII+JrP/0y6pUFEGDE+XkK9hLEn8N2qHDNh0BfaMXyTUr7Yd
 wufwvhwkLkqDmWx0fjIBJMfk/xywll1EkwA66u5dw2a9bcW3Ss0H1Uv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] doc: add tests catalog page
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

Acked-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This patch-set is meant to introduce a new page in the LTP
documentation, showing tests which are currently available with their
description and information.
---
Changes in v4:
- show maximum runtime with timeout text
- correct timeout text
- Link to v3: https://lore.kernel.org/r/20250205-doc_tests_list-v3-1-b60649cdea6a@suse.com

Changes in v3:
- fix table widths alignment
- add warning at the beginning of the test catalog
- Link to v2: https://lore.kernel.org/r/20250204-doc_tests_list-v2-1-9d29aeacc3f3@suse.com

Changes in v2:
- add setup
- cleanup code
- Link to v1: https://lore.kernel.org/r/20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com
---
 doc/.gitignore             |   1 +
 doc/conf.py                | 276 ++++++++++++++++++++++++++++++++++++++++++++-
 doc/index.rst              |   4 +
 doc/users/test_catalog.rst |   7 ++
 4 files changed, 284 insertions(+), 4 deletions(-)

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
index c6a84ea5810424ce6e1c21d81946c1819f10a3cc..96ace4c588198ca0184ff7a7460220dfd7c4dcd5 100644
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
@@ -256,6 +257,272 @@ def generate_syscalls_stats(_):
         stats.writelines(text)
 
 
+def _generate_tags_table(tags):
+    """
+    Generate the tags table from tags hash.
+    """
+    supported_url_ref = {
+        "linux-git": "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=",
+        "linux-stable-git": "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=",
+        "glibc-git": "https://sourceware.org/git/?p=glibc.git;a=commit;h=",
+        "musl-git": "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=",
+        "CVE": "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-",
+    }
+
+    table = [
+        '.. list-table::',
+        '   :header-rows: 1',
+        '',
+        '   * - Tag',
+        '     - Info',
+    ]
+
+    for tag in tags:
+        tag_key = tag[0]
+        tag_val = tag[1]
+
+        tag_url = supported_url_ref.get(tag_key, None)
+        if tag_url:
+            tag_val = f'`{tag_val} <{tag_url}{tag_val}>`_'
+
+        table.extend([
+            f'   * - {tag_key}',
+            f'     - {tag_val}',
+        ])
+
+    return table
+
+
+def _generate_options_table(options):
+    """
+    Generate the options table from the options hash.
+    """
+    table = [
+        '.. list-table::',
+        '   :header-rows: 1',
+        '',
+        '   * - Option',
+        '     - Description',
+    ]
+
+    for opt in options:
+        if not isinstance(opt, list):
+            table.clear()
+            break
+
+        key = opt[0]
+        val = opt[2]
+
+        if key.endswith(':'):
+            key = key[:-1] if key.endswith(':') else key
+
+        key = f'-{key}'
+
+        table.extend([
+            f'   * - {key}',
+            f'     - {val}',
+        ])
+
+    return table
+
+
+def _generate_setup_table(keys):
+    """
+    Generate the table with test setup configuration.
+    """
+    exclude = [
+        'child_needs_reinit',
+        'needs_checkpoints',
+        'resource_files',
+        'save_restore',
+        'forks_child',
+        'hugepages',
+        'options',
+        'timeout',
+        'runtime',
+        'ulimit',
+        'fname',
+        'tags',
+        'doc',
+    ]
+    my_keys = {k: v for k, v in keys.items() if k not in exclude}
+    if len(my_keys) == 0:
+        return []
+
+    table = [
+        '.. list-table::',
+        '   :header-rows: 1',
+        '',
+        '   * - Key',
+        '     - Value',
+    ]
+
+    keys_list = [
+        'needs_cgroup_ctrls',
+        'skip_filesystems',
+        'supported_archs',
+        'needs_kconfigs',
+        'needs_drivers',
+        'needs_cmds',
+        'caps',
+    ]
+
+    for key, value in my_keys.items():
+        if key in exclude:
+            continue
+
+        if key in keys_list:
+            if len(value) > 1:
+                table.extend([
+                    f'   * - {key}',
+                    f'     - | {value[0]}',
+                ])
+
+                for item in value[1:]:
+                    table.append(f'       | {item}')
+            else:
+                table.extend([
+                    f'   * - {key}',
+                    f'     - {value[0]}',
+                ])
+        elif key == 'filesystems':
+            values = []
+            for v in value:
+                for item in v:
+                    if isinstance(item, list):
+                        continue
+
+                    if item.startswith('.type'):
+                        values.append(item.replace('.type=', ''))
+
+            if len(values) > 1:
+                table.extend([
+                    f'   * - {key}',
+                    f'     - | {values[0]}',
+                ])
+
+                for item in values[1:]:
+                    table.append(f'       | {item}')
+            else:
+                table.extend([
+                    f'   * - {key}',
+                    f'     - {values[0]}',
+                ])
+        else:
+            table.extend([
+                f'   * - {key}',
+                f'     - {value}'
+            ])
+
+    return table
+
+
+def generate_test_catalog(_):
+    """
+    Generate the test catalog from ltp.json metadata file.
+    """
+    output = '_static/tests.rst'
+    metadata_file = '../metadata/ltp.json'
+    text = [
+        '.. warning::',
+        '    The following catalog has been generated using LTP metadata',
+        '    which is including only tests using the new :ref:`LTP C API`.',
+        '    For this reason, some old tests might be missing from the list.',
+        ''
+    ]
+
+    metadata = None
+    with open(metadata_file, 'r', encoding='utf-8') as data:
+        metadata = json.load(data)
+
+    timeout_def = metadata['defaults']['timeout']
+
+    for test_name, conf in metadata['tests'].items():
+        text.extend([
+            f'{test_name}',
+            len(test_name) * '-'
+        ])
+
+        # source url location
+        test_fname = conf.get('fname', None)
+        if test_fname:
+            text.extend([
+                '',
+                f"`source <{ltp_repo_base_url}/{test_fname}>`__",
+                ''
+            ])
+
+        # test description
+        desc = conf.get('doc', None)
+        if desc:
+            desc_text = []
+            for line in desc:
+                if line.startswith("[Description]"):
+                    desc_text.append("**Description**")
+                elif line.startswith("[Algorithm]"):
+                    desc_text.append("**Algorithm**")
+                else:
+                    desc_text.append(line)
+
+            text.extend([
+                '\n'.join(desc_text),
+            ])
+
+        # timeout information
+        timeout = conf.get('timeout', None)
+        if timeout:
+            text.extend([
+                '',
+                f'Test timeout is {timeout} seconds.',
+            ])
+        else:
+            text.extend([
+                '',
+                f'Test timeout defaults is {timeout_def} seconds.',
+            ])
+
+        # runtime information
+        runtime = conf.get('runtime', None)
+        if runtime:
+            text.extend([
+                f'Maximum runtime is {runtime} seconds.',
+                ''
+            ])
+        else:
+            text.append('')
+
+        # options information
+        opts = conf.get('options', None)
+        if opts:
+            text.append('')
+            text.extend(_generate_options_table(opts))
+            text.append('')
+
+        # tags information
+        tags = conf.get('tags', None)
+        if tags:
+            text.append('')
+            text.extend(_generate_tags_table(tags))
+            text.append('')
+
+        # developer information
+        text.append('')
+        text.extend(_generate_setup_table(conf))
+        text.append('')
+
+        # small separator between tests
+        text.extend([
+            '',
+            '.. raw:: html',
+            '',
+            '    <hr>',
+            '',
+        ])
+
+    with open(output, 'w+', encoding='utf-8') as new_tests:
+        new_tests.write('\n'.join(text))
+
+
 def setup(app):
     """
     Setup the current documentation, using self generated data and graphics
@@ -263,3 +530,4 @@ def setup(app):
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
base-commit: 07d79673a65f0f5f06c19507df4a15ceab22f2f9
change-id: 20250131-doc_tests_list-1b82f51e43fd

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
