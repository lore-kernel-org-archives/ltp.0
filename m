Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F63C55182
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 13:07:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 571243E7198
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 15:07:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05853E1B9F
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 15:07:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1EE4760008E
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 15:07:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE2C97F0FE;
 Mon,  3 Aug 2026 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785762449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCV6p2RSARRdJZfl/WrtC0rWuiY5zotrc66eH3/Bbew=;
 b=DBBk/rxK7WW+f7jJ2NX0o2umL2dXzo4iJeHVMba6qQD7S9RtOhyPO/mawv1bWauDgutmxg
 3ppeWv6lf/hG1OcXPfdpQ1YRJcHaK45mGDETS6olIQAC80OS6zpwiOGz47IF2goFL0U8Zx
 2pK/ywPCSGERMFYFZNxQeCRc+nkggUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785762449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCV6p2RSARRdJZfl/WrtC0rWuiY5zotrc66eH3/Bbew=;
 b=1EQE4VEgAKZS/u9CSLfgj+e/dTasku+ZOBIhwdPOI1qSAm6+UgcRXO+QYa9Anf+6+IPuow
 Mzd/15fg0nluT6Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GEiWXOR7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ohk3UAGK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785762445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCV6p2RSARRdJZfl/WrtC0rWuiY5zotrc66eH3/Bbew=;
 b=GEiWXOR7f2+JUaiObSERebHwG3jb6J059+QdhfXMgju7lElaccjnalr8oATWEPOiZDv5io
 1ljAE1QKBSxGaGW+bB5KtKx3ADYC5lvNiVGRxw4rZiDeJyz/mvmWYBP8fvq9/nGq0vhmoM
 Gvg9yPBXAQNoFgeEQuQK2O0+C87UhQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785762445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCV6p2RSARRdJZfl/WrtC0rWuiY5zotrc66eH3/Bbew=;
 b=Ohk3UAGKb3Q7mPqKsKNyL3BDB8wEja+Tby6RaBjFycOzawgRhe2Ukw+jX0nR1lOMG6qt1y
 +woQ6MAxfQlhkUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91311779C1;
 Mon,  3 Aug 2026 13:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YtDQII2ScGr0cQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Aug 2026 13:07:25 +0000
Date: Mon, 3 Aug 2026 15:07:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <anCSiSrmcM1BTfmd@yuki.lan>
References: <20260625-metadata_linter-v3-1-a1bd491eb506@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260625-metadata_linter-v3-1-a1bd491eb506@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,lint.py:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,mitre.org:url];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,lint.py:url,mitre.org:url];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: AE2C97F0FE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] metadata: add linter for JSON file
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
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/metadata/lint.py b/metadata/lint.py
> new file mode 100755
> index 0000000000000000000000000000000000000000..d32cd27bd0af951aac873756a4cb123c3d29ed31
> --- /dev/null
> +++ b/metadata/lint.py
> @@ -0,0 +1,319 @@
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
> +    skipping 'kernel' and 'cve') must be present in test 'groups'. No other
> +    groups are allowed unless they are listed in MANUAL_GROUPS.
> +
> +  * A CVE tag requires the 'cve' group and a linux-git tag requires the
> +    'regression' group.
> +
> +  * Only known tag IDs are accepted and every tag must have exactly one value.
> +
> +  * CVE tag values must use a valid bare 20YY-NNNN[...] identifier. With
> +    --check-cve-exists, every CVE is verified against the official CVE
> +    Services API (https://cveawg.mitre.org).
> +
> +The input can be a full ltp.json file or a single test entry from metaparse,
> +which is accepted on stdin with '-'.
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
> +CVE_RE: Pattern[str] = re.compile(r"^20[0-9]{2}-[0-9]{4,}$")
> +CVE_API: str = "https://cveawg.mitre.org/api/cve/CVE-"
> +SKIP_PATH_GROUPS: Tuple[str, ...] = ("kernel", "cve")
> +VALID_TAGS: Tuple[str, ...] = ("CVE", "linux-git", "glibc-git", "musl-git")
> +MANUAL_GROUPS: Tuple[str, ...] = (
> +    # insert here the groups which need to be supported
> +)
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
> +    return [
> +        tag[1]
> +        for tag in tags
> +        if isinstance(tag, list)
> +        and len(tag) == 2
> +        and tag[0] == name
> +        and isinstance(tag[1], str)
> +    ]
> +
> +
> +def has_tag(tags: List[List[str]], name: str) -> bool:
> +    """
> +    Return whether a metadata tag exists.
> +    """
> +    return any(
> +        isinstance(tag, list) and len(tag) == 2 and tag[0] == name for tag in tags
> +    )
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
> +    allowed: List[str] = expected + list(MANUAL_GROUPS)
> +    missing: List[str] = [group for group in expected if group not in groups]
> +    invalid: List[str] = [group for group in groups if group not in allowed]
> +
> +    if missing:
> +        errors.append(f"{name}: missing groups: {', '.join(missing)}")
> +
> +    if invalid:
> +        errors.append(f"{name}: invalid groups: {', '.join(invalid)}")
> +
> +    return errors
> +
> +
> +def lint_tags(name: str, conf: Dict[str, Any]) -> List[str]:
> +    """
> +    Return generic tag lint errors for a single test.
> +    """
> +    errors: List[str] = []
> +    tags: List[List[str]] = conf.get("tags", [])
> +
> +    for idx, tag in enumerate(tags):
> +        if not isinstance(tag, list):
> +            errors.append(f"{name}: tag #{idx} must be an array")
> +            continue
> +
> +        if len(tag) != 2:
> +            errors.append(f"{name}: tag #{idx} must have exactly 2 items")
> +
> +        if not tag:
> +            continue
> +
> +        tag_id = tag[0]
> +        if not isinstance(tag_id, str):
> +            errors.append(f"{name}: tag #{idx} ID must be a string")
> +        elif tag_id not in VALID_TAGS:
> +            errors.append(f"{name}: unknown tag ID '{tag_id}'")
> +
> +        if len(tag) >= 2 and not isinstance(tag[1], str):
> +            errors.append(f"{name}: tag #{idx} value must be a string")
> +
> +    return errors
> +
> +
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
> +                "use the bare '20YY-NNNN' identifier"
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
> +
> +
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
> +        errors += lint_tags(name, conf)
> +        errors += lint_groups(name, conf)
> +        errors += lint_cve_format(name, conf)
> +        if check_cve_exists:
> +            errors += lint_cve_existence(name, conf, cache)
> +
> +    return errors
> +
> +
> +def parse_stdin(data: str) -> Dict[str, Any]:
> +    """
> +    Parse full metadata or a single metaparse entry from stdin.
> +    """
> +    try:
> +        return json.loads(data)
> +    except json.JSONDecodeError as err:
> +        try:
> +            return json.loads("{\n" + data + "\n}")
> +        except json.JSONDecodeError:
> +            raise err
> +
> +
> +def extract_tests(metadata: Dict[str, Any]) -> Dict[str, Dict[str, Any]]:
> +    """
> +    Return the tests dictionary from full metadata or single-test input.
> +    """
> +    tests = metadata.get("tests")
> +
> +    if isinstance(tests, dict):
> +        return tests
> +
> +    return metadata
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
> +        help=f"path to ltp.json, or '-' to read stdin (default: {default})",
> +    )
> +    parser.add_argument(
> +        "--check-cve-online",
> +        action="store_true",
> +        help="verify CVE existence against the online CVE database",
> +    )
> +    args = parser.parse_args()
> +
> +    source = args.metadata or default
> +
> +    try:
> +        if args.metadata == "-":
> +            metadata: Dict[str, Any] = parse_stdin(sys.stdin.read())
> +        elif args.metadata is None and not sys.stdin.isatty():
> +            stdin_data = sys.stdin.read()
> +            if stdin_data.strip():
> +                source = "stdin"
> +                metadata = parse_stdin(stdin_data)
> +            else:
> +                with open(default, encoding="utf-8") as data:
> +                    metadata = json.load(data)
> +        else:
> +            with open(source, encoding="utf-8") as data:
> +                metadata = json.load(data)
> +    except FileNotFoundError:
> +        print(
> +            f"error: metadata file '{source}' not found "
> +            "(run 'make' in metadata/ first)",
> +            file=sys.stderr,
> +        )
> +        return 1
> +    except json.JSONDecodeError as err:
> +        print(f"error: failed to parse '{source}': {err}", file=sys.stderr)
> +        return 1
> +
> +    tests: Dict[str, Dict[str, Any]] = extract_tests(metadata)
> +    errors: List[str] = lint_tests(tests, args.check_cve_online)

What I had in mind for make check is that there would be a single test
mode "-t" switch and we would skip the extract_tests and passed the JSON
right to lint_tests()

./metaparse foo.c | lint.py -t


The assertions looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
