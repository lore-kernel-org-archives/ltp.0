Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCC6CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:47:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 615D33E6A9C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:47:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEB8E3E6166
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:47:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CAF956009E6
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:47:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33E275C551;
 Wed,  6 May 2026 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778086038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hg24n/YwkHCJH+J7V1lxJufVu81bx8J0xgLmOIyC+gE=;
 b=P4BtHoSOMN7U6kNzxvhJnK5UTKb4WII47SHh7kH9SKSK3ddysl0Dxz7OCUG7Nq6evmnjd0
 U6kekLiR3Z7LMwhReYoTztxbV6ygKSRb2aP2QUEgp6eVn/A7ayeVYdP5S5+glFoMalnuzT
 NMjatfIdElyuUulH4JVNPhmtRe/EMeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778086038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hg24n/YwkHCJH+J7V1lxJufVu81bx8J0xgLmOIyC+gE=;
 b=5FneIHGqk/MIZQ6+b2OFd5ZdXAYq+xZ6W7U3mVYiJ4c8mY8Nbvf+StFnbswcHvUXrSp2bU
 5JQUgVPYdiCcG7DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778086038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hg24n/YwkHCJH+J7V1lxJufVu81bx8J0xgLmOIyC+gE=;
 b=P4BtHoSOMN7U6kNzxvhJnK5UTKb4WII47SHh7kH9SKSK3ddysl0Dxz7OCUG7Nq6evmnjd0
 U6kekLiR3Z7LMwhReYoTztxbV6ygKSRb2aP2QUEgp6eVn/A7ayeVYdP5S5+glFoMalnuzT
 NMjatfIdElyuUulH4JVNPhmtRe/EMeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778086038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hg24n/YwkHCJH+J7V1lxJufVu81bx8J0xgLmOIyC+gE=;
 b=5FneIHGqk/MIZQ6+b2OFd5ZdXAYq+xZ6W7U3mVYiJ4c8mY8Nbvf+StFnbswcHvUXrSp2bU
 5JQUgVPYdiCcG7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A7CF593A3;
 Wed,  6 May 2026 16:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3fcIBJZw+2kuNAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 May 2026 16:47:18 +0000
Date: Wed, 6 May 2026 18:47:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <aftwmBUir04jaik4@yuki.lan>
References: <20260428143614.69724-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260428143614.69724-1-sachinp@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] doc: generate CVE catalog documentation
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Add a Sphinx builder hook to parse runtest/cve and generate a
> comprehensive CVE catalog in a single documentation file.
> 
> The implementation:
> - Parses runtest/cve to extract CVE IDs, test names, and options
> - Generates a single CVE catalog file (_static/cve.rst) containing:
>   * Total CVE count
>   * All CVEs sorted in descending order (newest first)
>   * Table of CVEs:
>     - CVE ID
>     - Test name (Cross-references to test catalog entries)
> - Integrates CVE catalog into main documentation index

First of all, this is very cool idea, thanks for doing this!

> Closes: https://github.com/linux-test-project/ltp/issues/1254
> Cc: Andrea Cervesato <andrea.cervesato@suse.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
> ---
> V4 changes:
> - Simplified the CVE table (id, test name)
> - Removed individual CVE pages
> - v3 link https://lore.kernel.org/ltp/69f0b046.df0a0220.3765a8.f8e4@mx.google.com/T/#u
> 
> V3 changes:
> - CVEs sorted in descending order
> - append test name to CVE id : CVE (Test Name)
> - Separate page for CVE catalog
> - Link cve testcases to Test catalog entry
> - v2 link https://lore.kernel.org/ltp/0df5f75d-eb8f-428e-9888-bb7a90a6b1a4@linux.ibm.com/
> 
> V2 changes:
> - Replace Fixes tag by Closes
> - V1 link https://lore.kernel.org/ltp/20260423105304.59788-1-sachinp@linux.ibm.com/T/#u
> 
> ---
>  doc/Makefile              |  2 +-
>  doc/conf.py               | 91 +++++++++++++++++++++++++++++++++++++++
>  doc/index.rst             |  4 ++
>  doc/users/cve_catalog.rst |  6 +++
>  4 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 doc/users/cve_catalog.rst
> 
> diff --git a/doc/Makefile b/doc/Makefile
> index 3123b1cd7..e99cbe666 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -30,7 +30,7 @@ spelling:
>  	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
>  
>  clean:
> -	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
> +	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst _static/cve.rst syscalls.tbl \
>  		${abs_top_builddir}/metadata/ltp.json

This shouldn't be added here. the ltp.json is cleaned up by the
metadata/Makefile.

>  distclean: clean
> diff --git a/doc/conf.py b/doc/conf.py
> index 63d09352e..d692638a0 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -30,6 +30,15 @@ extensions = [
>      'sphinx.ext.extlinks',
>  ]
>  
> +# Configure autosectionlabel to prefix labels with document name
> +# This prevents duplicate labels when same test name appears in multiple files
> +autosectionlabel_prefix_document = True
> +# Only create labels for sections with unique names
> +autosectionlabel_maxdepth = 2
> +
> +# Suppress duplicate label warnings for kernel-doc generated content
> +suppress_warnings = ['autosectionlabel.*']
> +
>  exclude_patterns = ["html*", '_static*', '.venv*']
>  extlinks = {
>      'repo': (f'{ltp_repo}/%s', '%s'),
> @@ -535,6 +544,87 @@ def generate_test_catalog(_):
>      with open(output, 'w+', encoding='utf-8') as new_tests:
>          new_tests.write('\n'.join(text))
>  
> +def generate_cve_catalog(_):
> +    """
> +    Generate CVE catalog in a single file. Parse runtest/cve file and
> +    generate documentation with links to CVE databases and test sources.
> +    Similar to test_catalog, creates a single _static/cve.rst file with
> +    all CVE information.
> +    """
> +    output = '_static/cve.rst'
> +    runtest_cve = '../runtest/cve'

I do not like much that we depend on the cve runtest file, we want to
get rid of runtest files eventually and depend only on the ltp.json.

> +    metadata_file = '../metadata/ltp.json'
> +
> +    # Load metadata to check which tests exist in the catalog
> +    metadata = None
> +    try:
> +        with open(metadata_file, 'r', encoding='utf-8') as data:
> +            metadata = json.load(data)
> +    except FileNotFoundError:
> +        logger = sphinx.util.logging.getLogger(__name__)
> +        msg = f"Can't find metadata file ({metadata_file})"
> +        logger.warning(msg)
> +
> +    # Parse runtest/cve file
> +    cve_data = {}
> +
> +    try:
> +        with open(runtest_cve, 'r', encoding='utf-8') as f:
> +            for line in f:
> +                line = line.strip()
> +                if not line or line.startswith('#'):
> +                    continue
> +
> +                parts = line.split(None, 2)
> +                if len(parts) >= 2:
> +                    cve_id = parts[0].upper()
> +                    test_name = parts[1]

Moreover it's not guaranteed at all that this is a test name. It's
whatever needs to be excuted to run the test.

> +
> +                    cve_data[cve_id] = {
> +                        'cve_id': cve_id,
> +                        'test_name': test_name,
> +                    }
> +    except FileNotFoundError:
> +        logger = sphinx.util.logging.getLogger(__name__)
> +        msg = f"Can't find runtest/cve file ({runtest_cve})"
> +        logger.warning(msg)
> +        return
> +
> +    # Generate single CVE catalog file
> +    total_cves = len(cve_data)
> +    text = [
> +        '.. warning::',
> +        '    The following CVE catalog has been generated from the',
> +        '    runtest/cve file and includes all CVE reproducers in LTP.',
> +        '',
> +        f'LTP includes reproducers for {total_cves} known CVEs.',
> +        '',
> +        '.. list-table::',
> +        '   :header-rows: 1',
> +        '   :widths: 40 60',
> +        '',
> +        '   * - CVE ID',
> +        '     - Test Name',
> +    ]
> +
> +    # Add CVEs in descending order (newest first)
> +    for cve_id, cve_info in sorted(cve_data.items(), reverse=True):
> +        test_name = cve_info["test_name"]
> +
> +        # Only create cross-reference if test exists in metadata
> +        if metadata and test_name in metadata.get('tests', {}):
> +            test_anchor = f"users/test_catalog:{test_name}"
> +            test_link = f":ref:`{test_name} <{test_anchor}>`"
> +        else:
> +            test_link = f"``{test_name}``"
> +
> +        text.extend([
> +            f'   * - {cve_id}',
> +            f'     - {test_link}',
> +        ])

Can we please instead iterate over the "tests" in the metadata here and
collect all tests that have "CVE" key in "tags"?

That should be more straightforward since we do not need to parse two
files.

> +    with open(output, 'w+', encoding='utf-8') as cve_catalog:
> +        cve_catalog.write('\n'.join(text))
>  
>  def setup(app):
>      """
> @@ -543,4 +633,5 @@ def setup(app):
>      """
>      app.add_css_file('custom.css')
>      app.connect('builder-inited', generate_syscalls_stats)
> +    app.connect('builder-inited', generate_cve_catalog)
>      app.connect('builder-inited', generate_test_catalog)
> diff --git a/doc/index.rst b/doc/index.rst
> index 496a12f80..733495f51 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -12,6 +12,7 @@
>     users/testers_guide
>     users/supported_systems
>     users/stats
> +   users/cve_catalog
>     users/test_catalog
>  
>  .. toctree::
> @@ -58,6 +59,9 @@ For users
>  :doc:`users/stats`
>     Some LTP statistics
>  
> +:doc:`users/cve_catalog`
> +   LTP reproducers for known CVEs
> +
>  :doc:`users/test_catalog`
>     The LTP test catalog
>  
> diff --git a/doc/users/cve_catalog.rst b/doc/users/cve_catalog.rst
> new file mode 100644
> index 000000000..5a5b9b54a
> --- /dev/null
> +++ b/doc/users/cve_catalog.rst
> @@ -0,0 +1,6 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +CVE catalog
> +===========
> +
> +.. include:: ../_static/cve.rst
> -- 
> 2.39.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
