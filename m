Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4802BC4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 13:06:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946993CFAE1
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 15:06:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D92843CFA7C
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 15:06:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51DBE60713F
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 15:06:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A47B5F80C;
 Tue, 16 Apr 2024 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713272787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srl12wr18AsPL4ItmEhyszUyUTjEIZmhNzL5RA2HDi0=;
 b=daOOqRzjLie907didHGLC3mST8ppCEJQROBnUVv2VeteYCCNzqWDWoel+m9XG+Y8ih2JQF
 F/aBjyZ+lSv9s0XW3PegK9nELw6uB6MyvhTX+BvvAQ2HemKa+Aofm9pTQHw7i0Jg9JuudZ
 OiZx3AskiyK78GNnR9uJtRqSAszUZdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713272787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srl12wr18AsPL4ItmEhyszUyUTjEIZmhNzL5RA2HDi0=;
 b=Xz+oSN1HY9Pg0Dt+pvlKIws1bt5H8p2pdthcFd7KD+RBgdSP9zJLugisIZ8LxF94fnne2j
 PTSymzPnOg7BkuDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=daOOqRzj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xz+oSN1H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713272787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srl12wr18AsPL4ItmEhyszUyUTjEIZmhNzL5RA2HDi0=;
 b=daOOqRzjLie907didHGLC3mST8ppCEJQROBnUVv2VeteYCCNzqWDWoel+m9XG+Y8ih2JQF
 F/aBjyZ+lSv9s0XW3PegK9nELw6uB6MyvhTX+BvvAQ2HemKa+Aofm9pTQHw7i0Jg9JuudZ
 OiZx3AskiyK78GNnR9uJtRqSAszUZdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713272787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srl12wr18AsPL4ItmEhyszUyUTjEIZmhNzL5RA2HDi0=;
 b=Xz+oSN1HY9Pg0Dt+pvlKIws1bt5H8p2pdthcFd7KD+RBgdSP9zJLugisIZ8LxF94fnne2j
 PTSymzPnOg7BkuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D92113432;
 Tue, 16 Apr 2024 13:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cVNZFNN3HmaiUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 16 Apr 2024 13:06:27 +0000
Date: Tue, 16 Apr 2024 15:08:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zh54TZT7boknYdN8@rei>
References: <20240415121719.3798-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240415121719.3798-1-andrea.cervesato@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8A47B5F80C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: Add new API conversion stats
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

> +def generate_old_api_stats(_):
> +    """
> +    Generate statistics for old API tests. We enter the tests folder and we
> +    count all tests implementations using old API. The way we count them, is to
> +    open every *.c file and to verify that "#include <test.h>" directive is
> +    present.
> +    """
> +    output = '_static/old_api.rst'
> +
> +    old_regex = re.compile(r'#include.*[<"\']test\.h[>"\']')
> +    new_regex = re.compile(r'#include.*[<"\']tst_test\.h[>"\']')
> +
> +    old_tests = 0
> +    new_tests = 0
> +
> +    for root, _, files in os.walk('../testcases'):
> +        for fname in files:
> +            if not fname.endswith('.c'):
> +                continue

There are at least two cases where the test.h header is included
indirectly from a test specific header. I guess that it would be cleaner
to actually fix these tests instead of working around it here.

> +            path = os.path.join(root, fname)
> +            with open(path, 'r', errors='ignore') as fdata:
> +                for line in fdata:
> +                    if old_regex.match(line):
> +                        old_tests += 1
> +                        break
> +
> +                    if new_regex.match(line):
> +                        new_tests += 1
> +                        break
> +
> +    if old_tests == 0 and new_tests == 0:
> +        return
> +
> +    text = [
> +        'New API conversion status\n',
> +        '-------------------------\n\n',
> +        'The current LTP refactoring plan aims to convert all LTP test\n',
> +        f'cases using the new LTP API. There are currently **{old_tests}** tests\n',
> +        f'which need to be converted and **{new_tests}** have been converted\n',
> +        'already.\n',
> +    ]
> +
> +    with open(output, 'w+') as stats:
> +        stats.writelines(text)

Maybe we should generate a table with the test filenames and links to
github code here? So that people interested in rewriting these tests
could check here and click on the filename to see the code?

>  def generate_syscalls_stats(_):
>      """
>      Generate statistics for syscalls. We fetch the syscalls list from the kernel
> @@ -198,4 +245,5 @@ def generate_syscalls_stats(_):
>  
>  def setup(app):
>      app.add_css_file('custom.css')
> +    app.connect('builder-inited', generate_old_api_stats)
>      app.connect('builder-inited', generate_syscalls_stats)
> diff --git a/doc/users/stats.rst b/doc/users/stats.rst
> index 7073442aa..a8b322b5f 100644
> --- a/doc/users/stats.rst
> +++ b/doc/users/stats.rst
> @@ -6,4 +6,5 @@ Statistics
>  In this section we collect some statistics related to the current state of
>  LTP tests.
>  
> +.. include:: ../_static/old_api.rst
>  .. include:: ../_static/syscalls.rst
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
