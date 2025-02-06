Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372AFC0219B
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 10:17:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A04803C4CF0
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 11:17:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6723C4BF2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 11:16:43 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EC8E31BD675C
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 11:16:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C3062115F;
 Thu,  6 Feb 2025 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738837001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alBYpEa8MMoXGwrQxT3+p1EkRYSz5kJ/gQkV/s1w4v4=;
 b=qrz/BmchlHgVb8LqGIqrboRLSbYD1CVBYEgj8Duq3+EvYQ4kXrcOvkmz2NWJZsMaUSK7YX
 Q1Qf4m5P6fXyv5wxtgpip98SZ/NHyVNBbb3eSjkG21r6+COF95JvoDFHjJsRRBGqS37Cs3
 mZLteMJcZfsRZkCsBPNDm268oHtT5rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738837001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alBYpEa8MMoXGwrQxT3+p1EkRYSz5kJ/gQkV/s1w4v4=;
 b=e8Gb0kd8XhG+EiZLMkgpM92phV3jGGfgwZdte/7hOQH27Ob93MFqr7M/AjMJvvZQ7Ij1qo
 k+ZhRQZoCu+wAMAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qrz/Bmch";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e8Gb0kd8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738837001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alBYpEa8MMoXGwrQxT3+p1EkRYSz5kJ/gQkV/s1w4v4=;
 b=qrz/BmchlHgVb8LqGIqrboRLSbYD1CVBYEgj8Duq3+EvYQ4kXrcOvkmz2NWJZsMaUSK7YX
 Q1Qf4m5P6fXyv5wxtgpip98SZ/NHyVNBbb3eSjkG21r6+COF95JvoDFHjJsRRBGqS37Cs3
 mZLteMJcZfsRZkCsBPNDm268oHtT5rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738837001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alBYpEa8MMoXGwrQxT3+p1EkRYSz5kJ/gQkV/s1w4v4=;
 b=e8Gb0kd8XhG+EiZLMkgpM92phV3jGGfgwZdte/7hOQH27Ob93MFqr7M/AjMJvvZQ7Ij1qo
 k+ZhRQZoCu+wAMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE0B813697;
 Thu,  6 Feb 2025 10:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WL+DMgiMpGccVQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Feb 2025 10:16:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Feb 2025 11:16:34 +0100
MIME-Version: 1.0
Message-Id: <20250206-doc_tests_list-v5-2-52110e1421a9@suse.com>
References: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
In-Reply-To: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738836999; l=11102;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=pmqpUG83yN68BV3e1Qdc1PTklTPkJomo2oNpc3kwiBI=;
 b=32y1ELHUNAZS17YEXCDZroL9B8VG0VCvhtTjzbxNgNmqhTjAWjWrM+Snri+Ezj32EuAStboLz
 yyb6Olg5+iYDaSOuh33mmJa0pGaga80LVmTJ3cwZczHg8EmoWLvDloO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 7C3062115F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] doc: add tests catalog page
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
 doc/.gitignore             |   1 +
 doc/conf.py                | 274 ++++++++++++++++++++++++++++++++++++++++++++-
 doc/index.rst              |   4 +
 doc/users/test_catalog.rst |   7 ++
 4 files changed, 282 insertions(+), 4 deletions(-)

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
index c6a84ea5810424ce6e1c21d81946c1819f10a3cc..0bebd0e2426c1c4155e39c1db918f38d92e88fd8 100644
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
@@ -256,6 +257,270 @@ def generate_syscalls_stats(_):
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
+def _generate_table_cell(key, values):
+    """
+    Generate a cell which can be multiline if value is a list.
+    """
+    cell = []
+
+    if len(values) > 1:
+        cell.extend([
+            f'   * - {key}',
+            f'     - | {values[0]}',
+        ])
+
+        for item in values[1:]:
+            cell.append(f'       | {item}')
+    else:
+        cell.extend([
+            f'   * - {key}',
+            f'     - {values[0]}',
+        ])
+
+    return cell
+
+
+def _generate_setup_table(keys):
+    """
+    Generate the table with test setup configuration.
+    """
+    exclude = [
+        # following keys are already handled
+        'options',
+        'runtime',
+        'timeout',
+        'fname',
+        'doc',
+        # following keys don't need to be shown
+        'child_needs_reinit',
+        'needs_checkpoints',
+        'forks_child',
+        'tags',
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
+    values = []
+
+    for key, value in my_keys.items():
+        if key in exclude:
+            continue
+
+        values.clear()
+
+        if key == 'ulimit':
+            for item in value:
+                values.append(f'{item[0]} : {item[1]}')
+        elif key == 'hugepages':
+            if len(value) == 1:
+                values.append(f'{value[0]}')
+            else:
+                values.append(f'{value[0]}, {value[1]}')
+        elif key == 'filesystems':
+            for v in value:
+                for item in v:
+                    if isinstance(item, list):
+                        continue
+
+                    if item.startswith('.type'):
+                        values.append(item.replace('.type=', ''))
+        elif key == "save_restore":
+            for item in value:
+                values.append(item[0])
+        else:
+            if isinstance(value, list):
+                values.extend(value)
+            else:
+                values.append(value)
+
+        table.extend(_generate_table_cell(key, values))
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
+        # parse struct tst_test content
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
@@ -263,3 +528,4 @@ def setup(app):
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

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
