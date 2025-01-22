Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05BCC02182
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:27:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2D23C300B
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 14:27:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8243C2F40
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:26:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A25B41015E27
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:26:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BCB5321267;
 Wed, 22 Jan 2025 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737552403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWeaSvtXBN24NgosrfInRQeDzKkfvQB3gesu4o30xYI=;
 b=HupTw36e5mNo6n4cxMnPkOoZ1X/USZdM99QMY7VwoLSaHdC68j341lIXUN6Ck1TIzwSlI7
 iqZuOa1nDg+qR3mpUj1qrSKoGaIrEAbbqogMBykpLYTbxn/HndQxJtb9GwzNnz8CAXX9wr
 2kxrOcgBpkRW4MjpbnZ+SQcG67e04+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737552403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWeaSvtXBN24NgosrfInRQeDzKkfvQB3gesu4o30xYI=;
 b=GStIOjSpXJ2bfkn9Daw4M9d6VOobVidDtkOGmxU9oq/laxlqbsmyg97AtDqm0JCosxDOYE
 rKw/Zhpa2nQu5oAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HupTw36e;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GStIOjSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737552403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWeaSvtXBN24NgosrfInRQeDzKkfvQB3gesu4o30xYI=;
 b=HupTw36e5mNo6n4cxMnPkOoZ1X/USZdM99QMY7VwoLSaHdC68j341lIXUN6Ck1TIzwSlI7
 iqZuOa1nDg+qR3mpUj1qrSKoGaIrEAbbqogMBykpLYTbxn/HndQxJtb9GwzNnz8CAXX9wr
 2kxrOcgBpkRW4MjpbnZ+SQcG67e04+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737552403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWeaSvtXBN24NgosrfInRQeDzKkfvQB3gesu4o30xYI=;
 b=GStIOjSpXJ2bfkn9Daw4M9d6VOobVidDtkOGmxU9oq/laxlqbsmyg97AtDqm0JCosxDOYE
 rKw/Zhpa2nQu5oAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676AB13AAB;
 Wed, 22 Jan 2025 13:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ICzhExPykGfwcwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Jan 2025 13:26:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 Jan 2025 14:26:40 +0100
MIME-Version: 1.0
Message-Id: <20250122-cyril_script_update_timeouts-v2-1-c29846cc0925@suse.com>
References: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
In-Reply-To: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737552402; l=8362;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=6/VnucAAd7yH70USqoRxG2Ij7kbP4L6V/vpDbOM2uXo=;
 b=k97iFp1Juf1Mlt9z9ocWt3oOC2lhFwN7hd0qlTS2Wpat+1uxqnw1rveTnr0N94lQnqIRV5Diu
 Afa1EvXgYTgCeTLi69OY9EqLuYfmMrosNyqBh7OQeYo871BR5Ec6QDb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: BCB5321267
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] scripts: Add simple script for calculating
 timeouts
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

From: Cyril Hrubis <chrubis@suse.cz>

This script parses JSON results from kirk and LTP metadata in order
calculate timeouts for tests based on the result file. It can also patch
tests automatically.

The script does:

- Take the results and pick all tests that run for longer than 0.5s.
  Multiplie the time with a constant (currently 1.2) to get a suggested
  timeout.

- Exclude tests that have runtime defined since these are controlled
  by the runtime (that filters out all fuzzy sync tests).

  There is a special case for timer tests that defines runtime only
  dynamically in the timer library code. This should be possibly fixed
  with special value for the .runtime in tst_test. E.g.
  TST_RUNTIME_DYNAMIC for tests that only set runtime in the setup.

- Normalize the timeout for a single filesystem run if test is running for
  more than one filesystem.

- Verify if tests are build on top of old library by checking at
  metadata file

- Update test with a  with newly calculated timeout.
  By default we only increase timeouts but that can be overridden using
  the -o option.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 scripts/calctimeouts.py | 232 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/scripts/calctimeouts.py b/scripts/calctimeouts.py
new file mode 100755
index 0000000000000000000000000000000000000000..754c6ec286e815d15309eb4fa6079ee9fdb819f9
--- /dev/null
+++ b/scripts/calctimeouts.py
@@ -0,0 +1,232 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+This script parses JSON results from kirk and LTP metadata in order to
+calculate timeouts for tests based on the results file.
+It can also patch tests automatically and replace the calculated timeout.
+"""
+
+import re
+import os
+import json
+import argparse
+
+# The test runtime is multiplied by this to get a timeout
+TIMEOUT_MUL = 1.2
+
+
+def _sed(fname, expr, replace):
+    """
+    Pythonic version of sed command.
+    """
+    content = []
+    matcher = re.compile(expr)
+
+    with open(fname, 'r', encoding="utf-8") as data:
+        for line in data:
+            match = matcher.search(line)
+            if not match:
+                content.append(line)
+            else:
+                content.append(replace)
+
+    with open(fname, 'w', encoding="utf-8") as data:
+        data.writelines(content)
+
+
+def _patch(ltp_dir, fname, new_timeout, override):
+    """
+    If `override` is True, it patches a test file, searching for timeout and
+    replacing it with `new_timeout`.
+    """
+    orig_timeout = None
+    file_path = os.path.join(ltp_dir, fname)
+
+    with open(file_path, 'r', encoding="utf-8") as c_source:
+        matcher = re.compile(r'\s*.timeout\s*=\s*(\d+).')
+        for line in c_source:
+            match = matcher.search(line)
+            if not match:
+                continue
+
+            timeout = match.group(1)
+            orig_timeout = int(timeout)
+
+    if orig_timeout:
+        if orig_timeout < new_timeout or override:
+            print(f"CHANGE {fname} timeout {orig_timeout} -> {new_timeout}")
+            _sed(file_path, r".timeout = [0-9]*,\n",
+                 f"\t.timeout = {new_timeout},\n")
+        else:
+            print(f"KEEP   {fname} timeout {orig_timeout} (new {new_timeout})")
+    else:
+        print(f"ADD    {fname} timeout {new_timeout}")
+        _sed(file_path,
+             "static struct tst_test test = {",
+             "static struct tst_test test = {\n"
+             f"\t.timeout = {new_timeout},\n")
+
+
+def _patch_all(ltp_dir, timeouts, override):
+    """
+    Patch all tests.
+    """
+    for timeout in timeouts:
+        if timeout['path']:
+            _patch(ltp_dir, timeout['path'], timeout['timeout'], override)
+
+
+def _print_table(timeouts):
+    """
+    Print the timeouts table.
+    """
+    timeouts.sort(key=lambda x: x['timeout'], reverse=True)
+
+    total = 0
+
+    print("Old library tests\n-----------------\n")
+    for timeout in timeouts:
+        if not timeout['newlib']:
+            print(f"{timeout['name']:30s} {timeout['timeout']}")
+            total += 1
+
+    print(f"\n\t{total} tests in total")
+
+    total = 0
+
+    print("\nNew library tests\n-----------------\n")
+    for timeout in timeouts:
+        if timeout['newlib']:
+            print(f"{timeout['name']:30s} {timeout['timeout']}")
+            total += 1
+
+    print(f"\n\t{total} tests in total")
+
+
+def _parse_data(ltp_dir, results_path):
+    """
+    Parse results data and metadata, then it generates timeouts data.
+    """
+    timeouts = []
+    results = None
+    metadata = None
+
+    with open(results_path, 'r', encoding="utf-8") as file:
+        results = json.load(file)
+
+    metadata_path = os.path.join(ltp_dir, 'metadata', 'ltp.json')
+    with open(metadata_path, 'r', encoding="utf-8") as file:
+        metadata = json.load(file)
+
+    for test in results['results']:
+        name = test['test_fqn']
+        duration = test['test']['duration']
+
+        # if test runs for all_filesystems, normalize runtime to one filesystem
+        filesystems = max(1, test['test']['log'].count('TINFO: Formatting /'))
+
+        # check if test is new library test
+        test_is_newlib = name in metadata['tests']
+
+        # store test file path
+        path = None
+        if test_is_newlib:
+            path = metadata['tests'][name]['fname']
+
+        test_has_runtime = False
+        if test_is_newlib:
+            # filter out tests with runtime
+            test_has_runtime = 'runtime' in metadata['tests'][name]
+
+            # timer tests define runtime dynamically in timer library
+            test_has_runtime = 'sample' in metadata['tests'][name]
+
+        # select tests that does not have runtime and which are executed
+        # for a long time
+        if not test_has_runtime and duration >= 0.5:
+            data = {}
+            data["name"] = name
+            data["timeout"] = int(TIMEOUT_MUL * duration/filesystems + 0.5)
+            data["newlib"] = test_is_newlib
+            data["path"] = path
+
+            timeouts.append(data)
+
+    return timeouts
+
+
+def _file_exists(filepath):
+    """
+    Check if the given file path exists.
+    """
+    if not os.path.isfile(filepath):
+        raise argparse.ArgumentTypeError(
+            f"The file '{filepath}' does not exist.")
+    return filepath
+
+
+def _dir_exists(dirpath):
+    """
+    Check if the given directory path exists.
+    """
+    if not os.path.isdir(dirpath):
+        raise argparse.ArgumentTypeError(
+            f"The directory '{dirpath}' does not exist.")
+    return dirpath
+
+
+def run():
+    """
+    Entry point of the script.
+    """
+    parser = argparse.ArgumentParser(
+        description="Script to calculate LTP tests timeouts")
+
+    parser.add_argument(
+        '-l',
+        '--ltp-dir',
+        type=_dir_exists,
+        help='LTP source code directory',
+        default='..')
+
+    parser.add_argument(
+        '-r',
+        '--results',
+        type=_file_exists,
+        required=True,
+        help='kirk results.json file location')
+
+    parser.add_argument(
+        '-o',
+        '--override',
+        default=False,
+        action='store_true',
+        help='Always override test timeouts')
+
+    parser.add_argument(
+        '-p',
+        '--patch',
+        default=False,
+        action='store_true',
+        help='Patch tests with updated timeout')
+
+    parser.add_argument(
+        '-t',
+        '--print-table',
+        default=True,
+        action='store_true',
+        help='Print table with suggested timeouts')
+
+    args = parser.parse_args()
+
+    timeouts = _parse_data(args.ltp_dir, args.results)
+
+    if args.print_table:
+        _print_table(timeouts)
+
+    if args.patch:
+        _patch_all(args.ltp_dir, timeouts, args.override)
+
+
+if __name__ == "__main__":
+    run()

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
