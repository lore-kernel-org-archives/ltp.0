Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A1C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 12:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ACB23C2773
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 13:35:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A2633C2621
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:34:52 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2619562A12D
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:34:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BF8E21157
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737462891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVmEfN7LkR7We2IKG06h70uVYzEiUvnjjD35yE2v7pY=;
 b=NdCOL2Surf+nKi6Bu8kl+AsK9/aRuHDqEox9l2sYq4dFIpvVg09rQwv64s0t823X+9/EwV
 ohROjfrZyHCOE+b4bzkRYA8hpfN1vZk90F5+WvCCQKGSmm1rO2T2HluVavGJAYLuo8c6tS
 gACw9T9x7lLG5legL9NTCUxuEyG+NSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737462891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVmEfN7LkR7We2IKG06h70uVYzEiUvnjjD35yE2v7pY=;
 b=iwKv7ezWp4o+xzi4i3j0r4PyPAR7f5j1EUbW03G+WiyqSOp98tASU9pEawu2kf8wDHqRF5
 U3J6UT9ugrCcc/CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737462891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVmEfN7LkR7We2IKG06h70uVYzEiUvnjjD35yE2v7pY=;
 b=NdCOL2Surf+nKi6Bu8kl+AsK9/aRuHDqEox9l2sYq4dFIpvVg09rQwv64s0t823X+9/EwV
 ohROjfrZyHCOE+b4bzkRYA8hpfN1vZk90F5+WvCCQKGSmm1rO2T2HluVavGJAYLuo8c6tS
 gACw9T9x7lLG5legL9NTCUxuEyG+NSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737462891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVmEfN7LkR7We2IKG06h70uVYzEiUvnjjD35yE2v7pY=;
 b=iwKv7ezWp4o+xzi4i3j0r4PyPAR7f5j1EUbW03G+WiyqSOp98tASU9pEawu2kf8wDHqRF5
 U3J6UT9ugrCcc/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 093121387C
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rExYAWuUj2cLVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 13:34:43 +0100
Message-ID: <20250121123444.5380-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250121123444.5380-1-chrubis@suse.cz>
References: <20250121123444.5380-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] scripts: Add simple script for calculating
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

This script parses JSON results from kirk and LTP metadata in order
calculate timeouts for tests based on the result file and can even patch
tests automatically.

The script does:

- Take the results and pick all tests that run for longer than 0.5s.
  Multiplies the time with a constant (currently 1.2) to get a suggested
  timeout.

- Exclude tests that have runtime defined since these are controller
  by the runtime (that filters out all fuzzy sync tests).

  There is a special case for timer tests that define runtime only
  dynamically in the timer library code. This should be possibly fixed
  with special value for the .runtime in tst_test. E.g.
  TST_RUNTIME_DYNAMIC for tests that only set runtime in the setup.

- Normalize the timeout per a single filesystem run if test is running for
  more than one filesystem.

- Tests that do not have a metadata record are old library tests which
  which cannot be patched but are printed in a separate table if we
  request a table to be printed.

- If patching option is selected tests are update with newly calculated
  timeout. By default we only increase timeouts but that can be
  overrided with the -o option.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 scripts/calc_timeouts.py | 133 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100755 scripts/calc_timeouts.py

diff --git a/scripts/calc_timeouts.py b/scripts/calc_timeouts.py
new file mode 100755
index 000000000..c69ab8f57
--- /dev/null
+++ b/scripts/calc_timeouts.py
@@ -0,0 +1,133 @@
+#!/usr/bin/python
+import re
+import json
+import getopt
+import sys
+from os import system
+
+# Top level directory path
+top_dir = '../'
+
+# The test runtime is multiplied by this to get a timeout
+timeout_mul = 1.2
+
+def patch(fname, new_timeout, patch_override):
+
+    orig_timeout = None
+    file_path = top_dir + fname
+
+    with open(file_path, 'r') as c_source:
+        for line in c_source:
+            timeout = re.search(r'\s*.timeout\s*=\s*(\d+).', line)
+            if timeout:
+                orig_timeout = int(timeout.group(1))
+
+    if orig_timeout:
+        if orig_timeout < new_timeout or patch_override:
+            print("CHANGE %s timeout %i -> %i" % (fname, orig_timeout, new_timeout))
+            system("sed -i 's/\\.timeout = [0-9]*/\\.timeout = " + str(new_timeout) + "/' " + file_path)
+        else:
+            print("KEEP   %s timeout %i (new %i)" % (fname, orig_timeout, new_timeout))
+    else:
+        print("ADD    %s timeout %i" % (fname, new_timeout))
+        system("sed -i '/static struct tst_test test = {/a\\\\t.timeout = " + str(new_timeout) + ",' " + file_path)
+
+def patch_all(timeouts, patch_override):
+    for timeout in timeouts:
+        if timeout[3]:
+            patch(timeout[3], timeout[1], patch_override)
+
+def print_table(timeouts):
+    timeouts.sort(key=lambda x: x[1], reverse=True)
+
+    total = 0;
+
+    print("Old library tests\n-----------------\n");
+    for timeout in timeouts:
+        if not timeout[2]:
+            print("%-30s %i" % (timeout[0], timeout[1]))
+            total+=1
+
+    print("\n\t%i tests in total" % total)
+
+    total = 0;
+
+    print("\nNew library tests\n-----------------\n");
+    for timeout in timeouts:
+        if timeout[2]:
+            print("%-30s %i" % (timeout[0], timeout[1]))
+            total+=1
+
+    print("\n\t%i tests in total" % total)
+
+def parse_data(results_path):
+    timeouts = []
+
+    with open(results_path, 'r') as file:
+        results = json.load(file)
+
+    with open(top_dir + 'metadata/ltp.json', 'r') as file:
+        metadata = json.load(file)
+
+    for test in results['results']:
+        name = test['test_fqn']
+        duration = test['test']['duration']
+        # If test runs for all_filesystems normalize the runtime per a single filesystem
+        filesystems = max(1, test['test']['log'].count('TINFO: Formatting /'))
+        # Check if test is new library test
+        test_is_newlib = name in metadata['tests']
+        # Store test file path
+        path = None if not test_is_newlib else metadata['tests'][name]['fname']
+        # Filter out tests with runtime
+        test_has_runtime = False if not test_is_newlib else 'runtime' in metadata['tests'][name]
+        # Timer tests define runtime dynamically in timer library
+        if test_is_newlib and 'sample' in metadata['tests'][name]:
+            test_has_runtime = True
+        # Select tests that does not have runtime and are executed for longer time
+        if not test_has_runtime and duration >= 0.5:
+            timeouts.append((name, int(timeout_mul * duration/filesystems + 0.5), test_is_newlib, path))
+
+    return timeouts
+
+def print_help():
+    print('calc_timeouts.py [OPTION] [RESULT].json')
+    print('\t-h prints this help')
+    print('\t-o override test timeouts, by default timeouts are only increased')
+    print('\t-p patch testcases with updated timeouts')
+    print('\t-t prints table of tests with suggested timeouts')
+
+try:
+    opts, args = getopt.getopt(sys.argv[1:], "hopt")
+except:
+    print_help()
+    sys.exit(1)
+
+opt_print_table = False
+opt_patch_tests = False
+opt_patch_override = False
+
+for opt,arg in opts:
+    if opt == '-h':
+        print_help()
+        sys.exit(0)
+    if opt == '-o':
+        opt_patch_override = True
+    if opt == '-p':
+        opt_patch_tests = True
+    if opt == '-t':
+        opt_print_table = True
+
+if not opt_print_table and not opt_patch_tests:
+    print("No action selected!\n")
+    print_help()
+    sys.exit(1)
+
+results = args[0] if args else 'results.json'
+
+timeouts = parse_data(results)
+
+if opt_print_table:
+    print_table(timeouts)
+
+if opt_patch_tests:
+    patch_all(timeouts, opt_patch_override)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
