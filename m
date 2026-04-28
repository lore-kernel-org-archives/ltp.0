Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87931FF886C
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:58:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D0293E49E5
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:58:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BFE73E2542
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:58:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB20B100078C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:58:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A9086A7E7;
 Tue, 28 Apr 2026 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777366694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCb2PJEDAzC0FlHAWpFKpdTNmijNjbkLG2NfBzIepwE=;
 b=jD04qjEMp0smSiVaLVKfykji+E2CtoxgT4oRRZojo9ybfTxdDK7b9uAUQmPQfllYh4CwtP
 V9rArE1G2Snjc0IAFyfU73M571DbGndfTFw3ymtYbfVVwdUwjcPEeGURJw3ZAJBqh+d9u5
 rvgxTLZHlCUB3ye55HohEcrA2KbULv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777366694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCb2PJEDAzC0FlHAWpFKpdTNmijNjbkLG2NfBzIepwE=;
 b=TaYB3lNcar7Nd5KVd/AiYy7ZXZSm2gv6BXoonvbYnq/taRC3n5OQVUb0vqdgnd0LlAzAE1
 rxe/ZwLpCglrfOAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777366694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCb2PJEDAzC0FlHAWpFKpdTNmijNjbkLG2NfBzIepwE=;
 b=jD04qjEMp0smSiVaLVKfykji+E2CtoxgT4oRRZojo9ybfTxdDK7b9uAUQmPQfllYh4CwtP
 V9rArE1G2Snjc0IAFyfU73M571DbGndfTFw3ymtYbfVVwdUwjcPEeGURJw3ZAJBqh+d9u5
 rvgxTLZHlCUB3ye55HohEcrA2KbULv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777366694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCb2PJEDAzC0FlHAWpFKpdTNmijNjbkLG2NfBzIepwE=;
 b=TaYB3lNcar7Nd5KVd/AiYy7ZXZSm2gv6BXoonvbYnq/taRC3n5OQVUb0vqdgnd0LlAzAE1
 rxe/ZwLpCglrfOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FB68593B0;
 Tue, 28 Apr 2026 08:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ighiEqZ28GlQVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 08:58:14 +0000
Date: Tue, 28 Apr 2026 10:58:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260428085813.GA883305@pevik>
References: <20260424121845.10914-1-sachinp@linux.ibm.com>
 <69f05e59.7b0a0220.32d441.7979@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69f05e59.7b0a0220.32d441.7979@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: generate CVE catalog documentation
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

Hi,

...
> > The implementation:
> > - Parses runtest/cve to extract CVE IDs, test names, and options
> > - Generates a single CVE catalog file (_static/cves.rst) containing:

> Please use just 'cve.rst' instead of 'cves.rst'. The plural is not
> providing any info here.

+1

> > +def generate_cve_catalog(_):
> > +    """
> > +    Generate CVE catalog in a single file. Parse runtest/cve file and
> > +    generate documentation with links to CVE databases and test sources.
> > +    Similar to test_catalog, creates a single _static/cves.rst file with
> > +    all CVE information.
> > +    """
> > +    output = '_static/cves.rst'
> > +    runtest_cve = '../runtest/cve'
> > +
> > +    # Parse runtest/cve file
> > +    cve_data = {}
> > +    cve_pattern = re.compile(r'^(cve-(\d{4})-\d+)\s+(\S+)(?:\s+(.*))?$')

> Do we need a regexp for this? The runtest file is well defining the
> following structure:

>   <cve-id> <binary> <arg0> <arg1> ..

> We only need to split lines which are not starting with # char,
> considering space as separator.

+1

...
> What about generating only a simple reference table? There are only 3
> information we need: CVE ID, test binary, year.

> | ID | Test name | Year |
> -------------------------
> | .. |    ..     |  ..  |

Do we need year in a column at all? If we like separating by year, we can make
more tables each being just for a particular year.

> etc..

> There's no need to have a direct link to the CVE, since we already pointing
> CVE to the Test catalog anyway.

OTOH it would not harm (people interested at CVE will have look mostly on this
page, that would save them one click.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
