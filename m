Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E3CDE000
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 13:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FC2A3E61E6
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 15:59:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 332863E613A
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 15:59:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B7391A009BC
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 15:59:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1F3E71BEA;
 Thu, 25 Jun 2026 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782395954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jQgMYpuLbSQu0j4fPzYl5RQJVI14n+PB9dm2haj+QE0=;
 b=IH26l0LTVb8pkDSqgFjr4I1Id0ex7OPpbg1kjWkgDtcEgxbzKBpPZ8BYGPBC2ywUGA7C3z
 qH1i4UEFD9Pu0dECC+4CqGQBQ5/MyY5aBWauUzqfwVIWxkUdPYj/acK/6Gh80tDWFsRwVd
 ERWXkbDK+cjS6W6kfUtvIz4wRi113Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782395954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jQgMYpuLbSQu0j4fPzYl5RQJVI14n+PB9dm2haj+QE0=;
 b=MThTn6UKTFn8YY1iGQZdxX3maBm7YyKTILsQ6yjHe8/dSWHWPpDrfHuVu8IUUD9aAPCZDs
 619aBKtbSf1TMSDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=La5hxUTk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+eabS6kE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782395953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jQgMYpuLbSQu0j4fPzYl5RQJVI14n+PB9dm2haj+QE0=;
 b=La5hxUTkX8WjZNNvYbMOKJG4c5YhqiWifWrK0M8DVuzKlkjPHYyVf3vq3W82Cb6KJpUIwc
 dKTsWUl0R37UIiGJSkTEBfo/KbBaJxpkftJVAIK9bDdTRYyXImHu5R+oXFS/56oJnGsmU+
 YOvY5E8CWWodB8asDLb8vjXc2j2LYgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782395953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jQgMYpuLbSQu0j4fPzYl5RQJVI14n+PB9dm2haj+QE0=;
 b=+eabS6kEWwtUakNfxRlSwfCUr39nvLfN3foVjirBY/c/zReZJHEC5YkWQ/0Fq7fvKpAY1T
 YLe6qMl++/XWSnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C280A779A8;
 Thu, 25 Jun 2026 13:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qgjoLDE0PWpGeAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jun 2026 13:59:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jun 2026 15:59:13 +0200
MIME-Version: 1.0
Message-Id: <20260625-metadata_linter-v3-1-a1bd491eb506@suse.com>
X-B4-Tracking: v=1; b=H4sIADA0PWoC/3WNQQqDMBBFryKzbkomasCueo9SypiMNVC1JGloE
 e/e6EooXb4/vDczBPaOA5yKGTwnF9w0ZigPBZiexjsLZzODkkpLrSoxcCRLkW4PN0b2okKTDw2
 2plWQrafnzr234uWauXchTv6zPUi4rv9bCQWK0ja11KgbInsOr8BHMw2wppLa6/WvrrKORAYtd
 xprudOXZfkCWJX3yewAAAA=
X-Change-ID: 20260624-metadata_linter-41c60691bcb2
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782395953; l=13972;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=A6fdTyftmhV/vuajKnZKzxNH4Hx1+0TIt9x4oLZwzyk=;
 b=BYlsWMnXsLbmUQH5JB7TlVGfRc/RaVYPSgn2ZwiJ5mbWscYJXGvzyKqjblCiSTReULBGhoK7a
 QFWjgtJZrBUD0FVjgytYxYmRWUhloFCL5Pe5du17fKddDl0c95tgcc6
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F1F3E71BEA
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] metadata: add linter for JSON file
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

Add a linter to verify that metadata contains the correct data. For now
it verifies that:

- groups tag is correct, according to the parent folders
- CVE value is well defined
- CVE number actually exists

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- make check for metadata
- set CVE number starting with 20XX
- error on invalid groups
- support other regression tags
- support other cve tags format
- exit 1 on error
- Link to v2: https://lore.kernel.org/r/20260625-metadata_linter-v2-1-1aac1def6150@suse.com

Changes in v2:
- fix --check-cve-online
- Link to v1: https://lore.kernel.org/r/20260624-metadata_linter-v1-1-3d9506169aad@suse.com
---
 .gitignore             |   1 +
 Makefile               |   2 +-
 metadata/Makefile      |  16 ++-
 metadata/lint.py       | 319 +++++++++++++++++++++++++++++++++++++++++++++++++
 metadata/tests/test.sh |  18 ++-
 5 files changed, 352 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index f10cd0c80e3655ad720e465f47c12ad0d51e7cd1..3450ded24840547bfc5ce572d6a73d8ce2605f20 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@ patches/
 *.run-test
 *.test
 logfile.*
+__pycache__
 
 /utils/benchmark/ebizzy-0.3/ebizzy
 
diff --git a/Makefile b/Makefile
index 2a7cf54caa4186b9a16402fefff778d6e0b2943d..04cdef295d0c2a66c4fbe6db5b4a30b299c191d7 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,7 @@ BOOTSTRAP_TARGETS	:= $(sort $(COMMON_TARGETS) $(CLEAN_TARGETS) $(INSTALL_TARGETS
 CLEAN_TARGETS		:= $(addsuffix -clean,$(CLEAN_TARGETS))
 INSTALL_TARGETS		:= $(addsuffix -install,$(INSTALL_TARGETS))
 MAKE_TARGETS		:= $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))
-CHECK_TARGETS		:= $(addsuffix -check,testcases lib)
+CHECK_TARGETS		:= $(addsuffix -check,testcases lib metadata)
 
 # There's no reason why we should run `all' twice. Otherwise we're just wasting
 # 3+ mins of useful CPU cycles on a modern machine, and even more time on an
diff --git a/metadata/Makefile b/metadata/Makefile
index 6939b9f76ccc5612e9f6b56e88bc0a2f60a03234..3aa5443604c65cf0f0335865ad13c129d3dddeec 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -8,6 +8,9 @@ include $(top_srcdir)/include/mk/functions.mk
 
 MAKE_TARGETS		:= ltp.json
 HOST_MAKE_TARGETS	:= metaparse metaparse-sh
+CHECK_TARGETS		:=
+CHECK_HEADER_TARGETS	:=
+SHELL_CHECK_TARGETS	:=
 INSTALL_DIR		= metadata
 
 .PHONY: ltp.json
@@ -15,7 +18,16 @@ INSTALL_DIR		= metadata
 ltp.json: metaparse metaparse-sh
 	$(abs_srcdir)/parse.sh > ltp.json
 
-test:
-	$(MAKE) -C $(abs_srcdir)/tests/ test
+.PHONY: lint
+lint: ltp.json
+	$(abs_srcdir)/lint.py ltp.json
+
+.PHONY: check
+check: test
+
+test: metaparse
+	$(MAKE) -C $(abs_srcdir)/tests/ test \
+		METAPARSE=$(abs_builddir)/metaparse \
+		LINT=$(abs_srcdir)/lint.py
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/metadata/lint.py b/metadata/lint.py
new file mode 100755
index 0000000000000000000000000000000000000000..d32cd27bd0af951aac873756a4cb123c3d29ed31
--- /dev/null
+++ b/metadata/lint.py
@@ -0,0 +1,319 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+"""
+Lint semantic consistency of generated metadata/ltp.json.
+
+This is not a schema validator; metaparse tests cover JSON shape. The linter
+checks metadata rules that depend on the final generated test catalog:
+
+  * Groups derived from the source path (the two nearest parent directories,
+    skipping 'kernel' and 'cve') must be present in test 'groups'. No other
+    groups are allowed unless they are listed in MANUAL_GROUPS.
+
+  * A CVE tag requires the 'cve' group and a linux-git tag requires the
+    'regression' group.
+
+  * Only known tag IDs are accepted and every tag must have exactly one value.
+
+  * CVE tag values must use a valid bare 20YY-NNNN[...] identifier. With
+    --check-cve-exists, every CVE is verified against the official CVE
+    Services API (https://cveawg.mitre.org).
+
+The input can be a full ltp.json file or a single test entry from metaparse,
+which is accepted on stdin with '-'.
+"""
+
+import argparse
+import json
+import os
+import re
+import sys
+from typing import (
+    Any,
+    Dict,
+    List,
+    Pattern,
+    Tuple,
+)
+
+CVE_RE: Pattern[str] = re.compile(r"^20[0-9]{2}-[0-9]{4,}$")
+CVE_API: str = "https://cveawg.mitre.org/api/cve/CVE-"
+SKIP_PATH_GROUPS: Tuple[str, ...] = ("kernel", "cve")
+VALID_TAGS: Tuple[str, ...] = ("CVE", "linux-git", "glibc-git", "musl-git")
+MANUAL_GROUPS: Tuple[str, ...] = (
+    # insert here the groups which need to be supported
+)
+
+
+def path_groups(fname: str) -> List[str]:
+    """
+    Return groups derived from the two nearest parent directories.
+    """
+    prefix = "testcases/"
+    if not fname.startswith(prefix):
+        return []
+
+    dirs = fname[len(prefix) :].split("/")[:-1]
+    return [grp for grp in reversed(dirs[-2:]) if grp not in SKIP_PATH_GROUPS]
+
+
+def tag_values(tags: List[List[str]], name: str) -> List[str]:
+    """
+    Return all values for metadata tags matching name.
+    """
+    return [
+        tag[1]
+        for tag in tags
+        if isinstance(tag, list)
+        and len(tag) == 2
+        and tag[0] == name
+        and isinstance(tag[1], str)
+    ]
+
+
+def has_tag(tags: List[List[str]], name: str) -> bool:
+    """
+    Return whether a metadata tag exists.
+    """
+    return any(
+        isinstance(tag, list) and len(tag) == 2 and tag[0] == name for tag in tags
+    )
+
+
+def expected_groups(conf: Dict[str, Any]) -> List[str]:
+    """
+    Return groups expected from test path and tags.
+    """
+    groups: List[str] = []
+    fname: str = conf.get("fname", "")
+    tags: List[List[str]] = conf.get("tags", [])
+
+    for group in path_groups(fname):
+        if group not in groups:
+            groups.append(group)
+
+    if has_tag(tags, "CVE") and "cve" not in groups:
+        groups.append("cve")
+
+    if has_tag(tags, "linux-git") and "regression" not in groups:
+        groups.append("regression")
+
+    return groups
+
+
+def lint_groups(name: str, conf: Dict[str, Any]) -> List[str]:
+    """
+    Return group lint errors for a single test.
+    """
+    errors: List[str] = []
+    groups: List[str] = conf.get("groups", [])
+    expected: List[str] = expected_groups(conf)
+    allowed: List[str] = expected + list(MANUAL_GROUPS)
+    missing: List[str] = [group for group in expected if group not in groups]
+    invalid: List[str] = [group for group in groups if group not in allowed]
+
+    if missing:
+        errors.append(f"{name}: missing groups: {', '.join(missing)}")
+
+    if invalid:
+        errors.append(f"{name}: invalid groups: {', '.join(invalid)}")
+
+    return errors
+
+
+def lint_tags(name: str, conf: Dict[str, Any]) -> List[str]:
+    """
+    Return generic tag lint errors for a single test.
+    """
+    errors: List[str] = []
+    tags: List[List[str]] = conf.get("tags", [])
+
+    for idx, tag in enumerate(tags):
+        if not isinstance(tag, list):
+            errors.append(f"{name}: tag #{idx} must be an array")
+            continue
+
+        if len(tag) != 2:
+            errors.append(f"{name}: tag #{idx} must have exactly 2 items")
+
+        if not tag:
+            continue
+
+        tag_id = tag[0]
+        if not isinstance(tag_id, str):
+            errors.append(f"{name}: tag #{idx} ID must be a string")
+        elif tag_id not in VALID_TAGS:
+            errors.append(f"{name}: unknown tag ID '{tag_id}'")
+
+        if len(tag) >= 2 and not isinstance(tag[1], str):
+            errors.append(f"{name}: tag #{idx} value must be a string")
+
+    return errors
+
+
+def lint_cve_format(name: str, conf: Dict[str, Any]) -> List[str]:
+    """
+    Return CVE format lint errors for a single test.
+    """
+    errors: List[str] = []
+    tags: List[List[str]] = conf.get("tags", [])
+
+    for cve in tag_values(tags, "CVE"):
+        if cve.upper().startswith("CVE-"):
+            errors.append(
+                f"{name}: CVE tag '{cve}' must not start with 'CVE-' prefix, "
+                "use the bare '20YY-NNNN' identifier"
+            )
+        elif not CVE_RE.match(cve):
+            errors.append(f"{name}: malformed CVE identifier '{cve}'")
+
+    return errors
+
+
+def cve_exists(cve: str, cache: Dict[str, bool]) -> bool:
+    """
+    Query the CVE Services API and cache the answer per identifier.
+    """
+    import urllib.error
+    import urllib.request
+
+    if cve in cache:
+        return cache[cve]
+
+    req = urllib.request.Request(CVE_API + cve, method="GET")
+    try:
+        with urllib.request.urlopen(req, timeout=30) as resp:
+            ok = resp.status == 200
+    except urllib.error.HTTPError as err:
+        if err.code == 404:
+            ok = False
+        else:
+            raise
+    except urllib.error.URLError as err:
+        raise RuntimeError(f"cannot reach CVE API: {err}") from err
+
+    cache[cve] = ok
+    return ok
+
+
+def lint_cve_existence(
+    name: str,
+    conf: Dict[str, Any],
+    cache: Dict[str, bool],
+) -> List[str]:
+    """
+    Return CVE existence lint errors for a single test.
+    """
+    errors: List[str] = []
+    tags: List[List[str]] = conf.get("tags", [])
+
+    for cve in tag_values(tags, "CVE"):
+        if CVE_RE.match(cve) and not cve_exists(cve, cache):
+            errors.append(f"{name}: CVE '{cve}' does not exist")
+
+    return errors
+
+
+def lint_tests(tests: Dict[str, Dict[str, Any]], check_cve_exists: bool) -> List[str]:
+    """
+    Return all lint errors for generated test metadata.
+    """
+    errors: List[str] = []
+    cache: Dict[str, bool] = {}
+
+    for name, conf in sorted(tests.items()):
+        errors += lint_tags(name, conf)
+        errors += lint_groups(name, conf)
+        errors += lint_cve_format(name, conf)
+        if check_cve_exists:
+            errors += lint_cve_existence(name, conf, cache)
+
+    return errors
+
+
+def parse_stdin(data: str) -> Dict[str, Any]:
+    """
+    Parse full metadata or a single metaparse entry from stdin.
+    """
+    try:
+        return json.loads(data)
+    except json.JSONDecodeError as err:
+        try:
+            return json.loads("{\n" + data + "\n}")
+        except json.JSONDecodeError:
+            raise err
+
+
+def extract_tests(metadata: Dict[str, Any]) -> Dict[str, Dict[str, Any]]:
+    """
+    Return the tests dictionary from full metadata or single-test input.
+    """
+    tests = metadata.get("tests")
+
+    if isinstance(tests, dict):
+        return tests
+
+    return metadata
+
+
+def main() -> int:
+    parser = argparse.ArgumentParser(
+        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
+    )
+    default = os.path.join(os.path.dirname(__file__), "ltp.json")
+    parser.add_argument(
+        "metadata",
+        nargs="?",
+        help=f"path to ltp.json, or '-' to read stdin (default: {default})",
+    )
+    parser.add_argument(
+        "--check-cve-online",
+        action="store_true",
+        help="verify CVE existence against the online CVE database",
+    )
+    args = parser.parse_args()
+
+    source = args.metadata or default
+
+    try:
+        if args.metadata == "-":
+            metadata: Dict[str, Any] = parse_stdin(sys.stdin.read())
+        elif args.metadata is None and not sys.stdin.isatty():
+            stdin_data = sys.stdin.read()
+            if stdin_data.strip():
+                source = "stdin"
+                metadata = parse_stdin(stdin_data)
+            else:
+                with open(default, encoding="utf-8") as data:
+                    metadata = json.load(data)
+        else:
+            with open(source, encoding="utf-8") as data:
+                metadata = json.load(data)
+    except FileNotFoundError:
+        print(
+            f"error: metadata file '{source}' not found "
+            "(run 'make' in metadata/ first)",
+            file=sys.stderr,
+        )
+        return 1
+    except json.JSONDecodeError as err:
+        print(f"error: failed to parse '{source}': {err}", file=sys.stderr)
+        return 1
+
+    tests: Dict[str, Dict[str, Any]] = extract_tests(metadata)
+    errors: List[str] = lint_tests(tests, args.check_cve_online)
+
+    for err in errors:
+        print(err, file=sys.stderr)
+
+    if errors:
+        print(f"\n{len(errors)} error(s) found in {len(tests)} tests", file=sys.stderr)
+        return 1
+
+    print(f"metadata lint: {len(tests)} tests OK")
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/metadata/tests/test.sh b/metadata/tests/test.sh
index 475d721df0019f982b81e42419ecd9e02fae1957..533ab0ab8b0661b0a8b9e492a33fadcf72a3aa52 100755
--- a/metadata/tests/test.sh
+++ b/metadata/tests/test.sh
@@ -2,8 +2,11 @@
 
 fail=0
 
+: "${METAPARSE:=../metaparse}"
+: "${LINT:=../lint.py}"
+
 for i in *.c; do
-	../metaparse $i > tmp.json
+	"$METAPARSE" "$i" > tmp.json
 	if ! diff tmp.json $i.json >/dev/null 2>&1; then
 		echo "***"
 		echo "$i output differs!"
@@ -11,6 +14,19 @@ for i in *.c; do
 		echo "***"
 		fail=1
 	fi
+
+	case $i in
+	groups.c|tags.c)
+		continue
+		;;
+	esac
+
+	if ! "$LINT" - < tmp.json; then
+		echo "***"
+		echo "$i lint failed!"
+		echo "***"
+		fail=1
+	fi
 done
 
 rm -f tmp.json

---
base-commit: 534222c4f3908e9642f913399e37a66fdd266bbe
change-id: 20260624-metadata_linter-41c60691bcb2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
