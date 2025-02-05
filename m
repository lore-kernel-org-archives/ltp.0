Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF869C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 23:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF2053C91DA
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 00:21:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FF3C3C919F
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 00:20:54 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E7C96225B7B
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 00:20:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66DF51F381;
 Wed,  5 Feb 2025 23:20:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5055E139D8;
 Wed,  5 Feb 2025 23:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5R2VElLyo2c3JwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Feb 2025 23:20:50 +0000
Date: Thu, 6 Feb 2025 00:20:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250205232049.GA1528001@pevik>
References: <20250205-doc_tests_list-v4-1-ae46e56073bb@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250205-doc_tests_list-v4-1-ae46e56073bb@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 66DF51F381
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] doc: add tests catalog page
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

generally LGTM, thanks for working on it.

1) clickable (referenced) keys

I asked keys (e.g. needs_root) to be referenced to be clickable to the
relevant API.  This allows reader to click and read relevant info about the key.

2) git commit description of referenced tags

Perl code was able to take git description.  E.g. instead of plain "d2f007dbe7e4"
it got:
d2f007dbe7e4 ("userns: also map extents in the reverse map to kernel IDs")

I understand you don't want to bother with it, but it was more descriptive.
I guess using github API or simple fetching web page on git.kernel.org and
take content of "commit-subject" would work, but it'd be slow and we could hit
some access limits from the provider. I can have look into this afterwards (I
don't want to block this issue).

3) CSS fix of some tables

Code on tables with keys and values (e.g. needs_kconfigs) looks ugly, when there
are more items.  E.g. needs_kconfigs at icmp_rate_limit01, which has:
CONFIG_VETH
CONFIG_USER_NS=y
CONFIG_NET_NS=y

The ugly part is margin-bottom: 24px; from class="line-block".
Single item line uses <p></p>.

I looked into docs (https://tables-with-sphinx.readthedocs.io/en/latest/),
but than I realized it's a simple CSS issue. It can be fixed by adding
into doc/_static/custom.css:

/* remove margin for multiline cells */
.rst-content table td div.line-block {
    margin-bottom: 0;
}

I can send it as a separate patch if you don't want to bother with it.

> +def _generate_tags_table(tags):
> +    """
> +    Generate the tags table from tags hash.
> +    """

nit: conf.py is getting slightly big. I need to remember that public functions
are these which generates stats.html and test_catalog.html. Maybe having
functions or setup() which references them on the top would help reader to start
with relevant code.
...

> +def _generate_setup_table(keys):
> +    """
> +    Generate the table with test setup configuration.
> +    """
> +    exclude = [
This list is slightly confusing for a reader. I would expect there will be no
options in generated docs nor tags. Obviously they are processed separately.

> +        'child_needs_reinit',
> +        'needs_checkpoints',
> +        'resource_files',
Maybe add this? e.g. creat07 requires also creat07_child. That might be useful
for somebody to see that test needs another LTP binary.

> +        'save_restore',
This is useful, it shows which /proc/sys files are touched.

> +        'forks_child',
> +        'hugepages',
I know that these are cryptic:
.hugepages = {1, TST_NEEDS},
.hugepages = {TST_NO_HUGEPAGES},
but trying to filter out info may cause people prefer using 'git grep' sources
instead of searching in 'ctrl+F' in this nice documentation.

> +        'options',
> +        'timeout',
> +        'runtime',
Cyril already asked for runtime, IMHO important to have.

> +        'ulimit',
Also ulimit is useful.


> +        'fname',
> +        'tags',
> +        'doc',
> +    ]
...
> +def generate_test_catalog(_):
> +    """
> +    Generate the test catalog from ltp.json metadata file.
> +    """
> +    output = '_static/tests.rst'
> +    metadata_file = '../metadata/ltp.json'
> +    text = [
> +        '.. warning::',
> +        '    The following catalog has been generated using LTP metadata',
> +        '    which is including only tests using the new :ref:`LTP C API`.',
> +        '    For this reason, some old tests might be missing from the list.',
Besides the fact that *all* tests using legacy API are skipped I don't think
user is interested why they aren't included. I would just note that only tests
which use new :ref:`LTP C API` are here listed.

> +        ''
> +    ]
> +
> +    metadata = None
> +    with open(metadata_file, 'r', encoding='utf-8') as data:
> +        metadata = json.load(data)
> +
> +    timeout_def = metadata['defaults']['timeout']
> +
> +    for test_name, conf in metadata['tests'].items():
> +        text.extend([
> +            f'{test_name}',
> +            len(test_name) * '-'
> +        ])
> +
> +        # source url location
> +        test_fname = conf.get('fname', None)
> +        if test_fname:
> +            text.extend([
> +                '',
> +                f"`source <{ltp_repo_base_url}/{test_fname}>`__",
> +                ''
> +            ])
> +
> +        # test description
> +        desc = conf.get('doc', None)
> +        if desc:
> +            desc_text = []
> +            for line in desc:
> +                if line.startswith("[Description]"):
> +                    desc_text.append("**Description**")
I suggested about deleting all [Description] from the code. I see no value in
it, but it forces reader to scroll more (it prolongs the page).

> +                elif line.startswith("[Algorithm]"):
> +                    desc_text.append("**Algorithm**")
> +                else:
> +                    desc_text.append(line)
NOTE: because there are more titles in "[..]" (there can be anything, why not
just replace \[(.*)\] with **\1** ?
> +
> +            text.extend([
> +                '\n'.join(desc_text),
> +            ])
> +
> +
> +        # developer information
For me would be more obvious comment something like: "parse struct tst_test content".

Kind regards,
Petr

> +        text.append('')
> +        text.extend(_generate_setup_table(conf))
> +        text.append('')
> +
> +        # small separator between tests
> +        text.extend([
> +            '',
> +            '.. raw:: html',
> +            '',
> +            '    <hr>',
> +            '',
> +        ])
> +
> +    with open(output, 'w+', encoding='utf-8') as new_tests:
> +        new_tests.write('\n'.join(text))
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
