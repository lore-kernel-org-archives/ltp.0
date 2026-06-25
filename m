Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301B0CDB479
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 10:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1465B3E614A
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 12:42:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55E723E1809
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 12:42:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3EFE86002C9
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 12:42:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEAB5762E0;
 Thu, 25 Jun 2026 10:42:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAE7779A8;
 Thu, 25 Jun 2026 10:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y8NIKREGPWp3OwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Jun 2026 10:42:25 +0000
Date: Thu, 25 Jun 2026 12:42:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aj0GFfssb2dRhBSm@yuki.lan>
References: <20260625-metadata_linter-v2-1-1aac1def6150@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260625-metadata_linter-v2-1-1aac1def6150@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BEAB5762E0
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] metadata: add linter for JSON file
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/metadata/Makefile b/metadata/Makefile
> index 6939b9f76ccc5612e9f6b56e88bc0a2f60a03234..641b02575d10d3af60975e14733a6085317758bc 100644
> --- a/metadata/Makefile
> +++ b/metadata/Makefile
> @@ -15,6 +15,10 @@ INSTALL_DIR		= metadata
>  ltp.json: metaparse metaparse-sh
>  	$(abs_srcdir)/parse.sh > ltp.json
>  
> +.PHONY: lint
> +lint: ltp.json
> +	$(abs_srcdir)/lint.py ltp.json

I wonder how to plug this into make check. If the linter could read
single test data from stdin we could do something as:

$(top_builddir)/metadata/metaparse foo.c | $(abs_scrdir)/lint.py

>  test:
>  	$(MAKE) -C $(abs_srcdir)/tests/ test
>  
> diff --git a/metadata/lint.py b/metadata/lint.py
> new file mode 100755
> index 0000000000000000000000000000000000000000..4511ee9bd408af4b10cd8b3331f5f0589684aba1
> --- /dev/null
> +++ b/metadata/lint.py
> @@ -0,0 +1,224 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 Linux Test Project
> +"""
> +Lint semantic consistency of generated metadata/ltp.json.
> +
> +This is not a schema validator; metaparse tests cover JSON shape. The linter
> +checks metadata rules that depend on the final generated test catalog:
> +
> +  * Groups derived from the source path (the two nearest parent directories,
> +    skipping 'kernel' and 'cve') must be present in test 'groups'.
> +
> +  * A CVE tag requires the 'cve' group and a linux-git tag requires the
> +    'regression' group.
> +
> +  * CVE tag values must use a valid bare YYYY-NNNN[...] identifier. With
> +    --check-cve-exists, every CVE is verified against the official CVE
> +    Services API (https://cveawg.mitre.org).
> +"""
> +
> +import argparse
> +import json
> +import os
> +import re
> +import sys
> +from typing import (
> +    Any,
> +    Dict,
> +    List,
> +    Pattern,
> +    Tuple,
> +)
> +
> +CVE_RE: Pattern[str] = re.compile(r"^[0-9]{4}-[0-9]{4,}$")
                                         ^
We can be stricter here, all the CVEs start with 20 and are going to be
like that for the next 75 years.


> +CVE_API: str = "https://cveawg.mitre.org/api/cve/CVE-"
> +SKIP_PATH_GROUPS: Tuple[str, ...] = ("kernel", "cve")
> +
> +
> +def path_groups(fname: str) -> List[str]:
> +    """
> +    Return groups derived from the two nearest parent directories.
> +    """
> +    prefix = "testcases/"
> +    if not fname.startswith(prefix):
> +        return []
> +
> +    dirs = fname[len(prefix) :].split("/")[:-1]
> +    return [grp for grp in reversed(dirs[-2:]) if grp not in SKIP_PATH_GROUPS]
> +
> +
> +def tag_values(tags: List[List[str]], name: str) -> List[str]:
> +    """
> +    Return all values for metadata tags matching name.
> +    """
> +    return [tag[1] for tag in tags if len(tag) >= 2 and tag[0] == name]
> +
> +
> +def has_tag(tags: List[List[str]], name: str) -> bool:
> +    """
> +    Return whether a metadata tag exists.
> +    """
> +    return any(tag and tag[0] == name for tag in tags)
> +
> +
> +def expected_groups(conf: Dict[str, Any]) -> List[str]:
> +    """
> +    Return groups expected from test path and tags.
> +    """
> +    groups: List[str] = []
> +    fname: str = conf.get("fname", "")
> +    tags: List[List[str]] = conf.get("tags", [])
> +
> +    for group in path_groups(fname):
> +        if group not in groups:
> +            groups.append(group)
> +
> +    if has_tag(tags, "CVE") and "cve" not in groups:
> +        groups.append("cve")
> +
> +    if has_tag(tags, "linux-git") and "regression" not in groups:
> +        groups.append("regression")
> +
> +    return groups
> +
> +
> +def lint_groups(name: str, conf: Dict[str, Any]) -> List[str]:
> +    """
> +    Return group lint errors for a single test.
> +    """
> +    errors: List[str] = []
> +    groups: List[str] = conf.get("groups", [])
> +    expected: List[str] = expected_groups(conf)
> +    missing: List[str] = [group for group in expected if group not in groups]
> +
> +    if missing:
> +        errors.append(f"{name}: missing groups: {', '.join(missing)}")
> +
> +    return errors

Can we also error on invalid groups?

Invalid group would be anything that is not in the expected groups or in
a hand written list of groups (which will be added later and maintained
by hand as needed).

> +def lint_cve_format(name: str, conf: Dict[str, Any]) -> List[str]:
> +    """
> +    Return CVE format lint errors for a single test.
> +    """
> +    errors: List[str] = []
> +    tags: List[List[str]] = conf.get("tags", [])
> +
> +    for cve in tag_values(tags, "CVE"):
> +        if cve.upper().startswith("CVE-"):
> +            errors.append(
> +                f"{name}: CVE tag '{cve}' must not start with 'CVE-' prefix, "
> +                "use the bare 'YYYY-NNNN' identifier"
> +            )
> +        elif not CVE_RE.match(cve):
> +            errors.append(f"{name}: malformed CVE identifier '{cve}'")
> +
> +    return errors
> +
> +
> +def cve_exists(cve: str, cache: Dict[str, bool]) -> bool:
> +    """
> +    Query the CVE Services API and cache the answer per identifier.
> +    """
> +    import urllib.error
> +    import urllib.request
> +
> +    if cve in cache:
> +        return cache[cve]
> +
> +    req = urllib.request.Request(CVE_API + cve, method="GET")
> +    try:
> +        with urllib.request.urlopen(req, timeout=30) as resp:
> +            ok = resp.status == 200
> +    except urllib.error.HTTPError as err:
> +        if err.code == 404:
> +            ok = False
> +        else:
> +            raise
> +    except urllib.error.URLError as err:
> +        raise RuntimeError(f"cannot reach CVE API: {err}") from err
> +
> +    cache[cve] = ok
> +    return ok

Looking at the CVE JSON reply here there are even links to kernel
commits. If we wanted we could even parse the links and select these
that contain "torvalds" and end up with a hash and cross check the
linux-git hashes.

> +def lint_cve_existence(
> +    name: str,
> +    conf: Dict[str, Any],
> +    cache: Dict[str, bool],
> +) -> List[str]:
> +    """
> +    Return CVE existence lint errors for a single test.
> +    """
> +    errors: List[str] = []
> +    tags: List[List[str]] = conf.get("tags", [])
> +
> +    for cve in tag_values(tags, "CVE"):
> +        if CVE_RE.match(cve) and not cve_exists(cve, cache):
> +            errors.append(f"{name}: CVE '{cve}' does not exist")
> +
> +    return errors
> +
> +
> +def lint_tests(tests: Dict[str, Dict[str, Any]], check_cve_exists: bool) -> List[str]:
> +    """
> +    Return all lint errors for generated test metadata.
> +    """
> +    errors: List[str] = []
> +    cache: Dict[str, bool] = {}
> +
> +    for name, conf in sorted(tests.items()):
> +        errors += lint_groups(name, conf)

We are missing a check that there are only know tag IDs present. At the
moment we support tags "cve", "linux-git", "glibc-git" and "musl-git".
Anything else is a garbage and should error out.

At the same time I do not see assert on the tag array lenght anywhere.
What happens when we have {"cve", "2022-289", "apple"} in the tags?

I guess that we need generic check_tag function that would assert that
there are only valid tags in the tags array and that the lenghts match.

> +        errors += lint_cve_format(name, conf)
> +        if check_cve_exists:
> +            errors += lint_cve_existence(name, conf, cache)
> +
> +    return errors
> +
> +
> +def main() -> int:
> +    parser = argparse.ArgumentParser(
> +        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
> +    )
> +    default = os.path.join(os.path.dirname(__file__), "ltp.json")
> +    parser.add_argument(
> +        "metadata",
> +        nargs="?",
> +        default=default,
> +        help="path to the ltp.json metadata file (default: %(default)s)",
> +    )
> +    parser.add_argument(
> +        "--check-cve-online",
> +        action="store_true",
> +        help="verify CVE existence against the online CVE database",
> +    )
> +    args = parser.parse_args()
> +
> +    try:
> +        with open(args.metadata, encoding="utf-8") as data:
> +            metadata: Dict[str, Any] = json.load(data)
> +    except FileNotFoundError:
> +        sys.exit(
> +            f"error: metadata file '{args.metadata}' not found "
> +            "(run 'make' in metadata/ first)"
> +        )
> +    except json.JSONDecodeError as err:
> +        sys.exit(f"error: failed to parse '{args.metadata}': {err}")
            ^
	    We should print the error and the exit with failure
	    (return 1) here as well.


> +    tests: Dict[str, Dict[str, Any]] = metadata.get("tests", {})
> +    errors: List[str] = lint_tests(tests, args.check_cve_online)
> +
> +    for err in errors:
> +        print(err, file=sys.stderr)
> +
> +    if errors:
> +        print(f"\n{len(errors)} error(s) found in {len(tests)} tests", file=sys.stderr)
> +        return 1
> +
> +    print(f"metadata lint: {len(tests)} tests OK")
> +    return 0
> +
> +
> +if __name__ == "__main__":
> +    sys.exit(main())
> 
> ---
> base-commit: 534222c4f3908e9642f913399e37a66fdd266bbe
> change-id: 20260624-metadata_linter-41c60691bcb2
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
