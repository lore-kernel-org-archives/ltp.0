Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00CFCDB466
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 07:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1E243E531F
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 09:09:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06613E29F4
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 09:09:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9103F1A00A20
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 09:09:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4D477606A;
 Thu, 25 Jun 2026 07:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782371345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GaH5/CYQkyATmUgtlGBqqWzad4qwhAkZfoJpS0EP8ks=;
 b=h2ynIm4WTvrB/arj0JEHKSq/bLjTNJGvyB+Yab+QK5Nh2XU7hmk3udlR140I032nQHE+c0
 SXLb/YkvlFz/3L5P7NX/Exhne8d8SUXIsPANWEu+rtx8xKUSXRjpIBJIVd42J5zZV4PhwK
 UozWfDwLac8Wmz5O+7/6ovEbO6Lb8Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782371345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GaH5/CYQkyATmUgtlGBqqWzad4qwhAkZfoJpS0EP8ks=;
 b=y+kKgmUTfv6dA1HEyCV03/Nv6c0A2P65VXdx3aMX0IgpCaM/WXyuI40aB+T0B6TQz5vSAE
 Yj1enivW6NYmYjCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782371345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GaH5/CYQkyATmUgtlGBqqWzad4qwhAkZfoJpS0EP8ks=;
 b=h2ynIm4WTvrB/arj0JEHKSq/bLjTNJGvyB+Yab+QK5Nh2XU7hmk3udlR140I032nQHE+c0
 SXLb/YkvlFz/3L5P7NX/Exhne8d8SUXIsPANWEu+rtx8xKUSXRjpIBJIVd42J5zZV4PhwK
 UozWfDwLac8Wmz5O+7/6ovEbO6Lb8Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782371345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GaH5/CYQkyATmUgtlGBqqWzad4qwhAkZfoJpS0EP8ks=;
 b=y+kKgmUTfv6dA1HEyCV03/Nv6c0A2P65VXdx3aMX0IgpCaM/WXyuI40aB+T0B6TQz5vSAE
 Yj1enivW6NYmYjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D578779A8;
 Thu, 25 Jun 2026 07:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U83uGxHUPGoBbQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jun 2026 07:09:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jun 2026 09:09:04 +0200
MIME-Version: 1.0
Message-Id: <20260625-metadata_linter-v2-1-1aac1def6150@suse.com>
X-B4-Tracking: v=1; b=H4sIAA/UPGoC/3WNwQ7CIBBEf6XZsxgWKwme/A/TGAqr3cRSA0g0D
 f8u9u7xzWTerJAoMiU4dStEKpx4CQ3UrgM32XAnwb4xKKm01KoXM2XrbbbXB4dMUfToWmFwdKO
 CtnpGuvF7M16GxhOnvMTPdlDwl/53FRQoDt4cpUZtrPXn9Eq0d8sMQ631C4XCrQytAAAA
X-Change-ID: 20260624-metadata_linter-41c60691bcb2
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782371345; l=8517;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=qlAz8VEOfsnsQcfI/QAsWtJ3d+neuLs7GbedAX56NYc=;
 b=sgKBQZwA8eyjJDcWQLw6S1Hlkj86SDzGJFDV8WbEUxN4yKkwd+RzqCRhvBYpzpmfzrpQH85Ki
 Utg7ac7IBZABzKgia9sSVJBv7/4NzGNOs4VhHyCHbgBkfigYe6SAWEG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] metadata: add linter for JSON file
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
Changes in v2:
- fix --check-cve-online
- Link to v1: https://lore.kernel.org/r/20260624-metadata_linter-v1-1-3d9506169aad@suse.com
---
 .gitignore        |   1 +
 metadata/Makefile |   4 +
 metadata/lint.py  | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)

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
 
diff --git a/metadata/Makefile b/metadata/Makefile
index 6939b9f76ccc5612e9f6b56e88bc0a2f60a03234..641b02575d10d3af60975e14733a6085317758bc 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -15,6 +15,10 @@ INSTALL_DIR		= metadata
 ltp.json: metaparse metaparse-sh
 	$(abs_srcdir)/parse.sh > ltp.json
 
+.PHONY: lint
+lint: ltp.json
+	$(abs_srcdir)/lint.py ltp.json
+
 test:
 	$(MAKE) -C $(abs_srcdir)/tests/ test
 
diff --git a/metadata/lint.py b/metadata/lint.py
new file mode 100755
index 0000000000000000000000000000000000000000..4511ee9bd408af4b10cd8b3331f5f0589684aba1
--- /dev/null
+++ b/metadata/lint.py
@@ -0,0 +1,224 @@
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
+    skipping 'kernel' and 'cve') must be present in test 'groups'.
+
+  * A CVE tag requires the 'cve' group and a linux-git tag requires the
+    'regression' group.
+
+  * CVE tag values must use a valid bare YYYY-NNNN[...] identifier. With
+    --check-cve-exists, every CVE is verified against the official CVE
+    Services API (https://cveawg.mitre.org).
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
+CVE_RE: Pattern[str] = re.compile(r"^[0-9]{4}-[0-9]{4,}$")
+CVE_API: str = "https://cveawg.mitre.org/api/cve/CVE-"
+SKIP_PATH_GROUPS: Tuple[str, ...] = ("kernel", "cve")
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
+    return [tag[1] for tag in tags if len(tag) >= 2 and tag[0] == name]
+
+
+def has_tag(tags: List[List[str]], name: str) -> bool:
+    """
+    Return whether a metadata tag exists.
+    """
+    return any(tag and tag[0] == name for tag in tags)
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
+    missing: List[str] = [group for group in expected if group not in groups]
+
+    if missing:
+        errors.append(f"{name}: missing groups: {', '.join(missing)}")
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
+                "use the bare 'YYYY-NNNN' identifier"
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
+        errors += lint_groups(name, conf)
+        errors += lint_cve_format(name, conf)
+        if check_cve_exists:
+            errors += lint_cve_existence(name, conf, cache)
+
+    return errors
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
+        default=default,
+        help="path to the ltp.json metadata file (default: %(default)s)",
+    )
+    parser.add_argument(
+        "--check-cve-online",
+        action="store_true",
+        help="verify CVE existence against the online CVE database",
+    )
+    args = parser.parse_args()
+
+    try:
+        with open(args.metadata, encoding="utf-8") as data:
+            metadata: Dict[str, Any] = json.load(data)
+    except FileNotFoundError:
+        sys.exit(
+            f"error: metadata file '{args.metadata}' not found "
+            "(run 'make' in metadata/ first)"
+        )
+    except json.JSONDecodeError as err:
+        sys.exit(f"error: failed to parse '{args.metadata}': {err}")
+
+    tests: Dict[str, Dict[str, Any]] = metadata.get("tests", {})
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

---
base-commit: 534222c4f3908e9642f913399e37a66fdd266bbe
change-id: 20260624-metadata_linter-41c60691bcb2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
