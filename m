Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F0BC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:41:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A42C3C7C34
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:41:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1F153C1117
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:41:02 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5F11F22C39B
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:41:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 229C721181;
 Fri, 17 Jan 2025 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737106861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QRXOUJguMsZL5T0UH00yTl2FqjRmkwkOUU88KWBcSk=;
 b=kDzotwM0/qPNp2xgMvYqF75OEdd3EW9w4je9JXWDw+haFTrqwg9XAy22vxGdi1YCUCx3bt
 Z9v26GTcsbf7H+FqIx30IXWN+tQUo6tycbMl6t8miBpBEUFnR/SeYQWOnWUziXzw+ZtgeF
 K1zbrs53lLlQa+ZI4C5ZbBpezwwbQUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737106861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QRXOUJguMsZL5T0UH00yTl2FqjRmkwkOUU88KWBcSk=;
 b=7IitmOsK88KvZHJ1H+JOtUl0ilfsj4+RIX8vs5cMLoS8R82m52JNi6jKQ2Rn/P6PAe1JVH
 0F/gANa3O3LHXHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737106860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QRXOUJguMsZL5T0UH00yTl2FqjRmkwkOUU88KWBcSk=;
 b=LcMUKdtm4MDMJTrYlg2GOpKNnxf9r7bkV/aauLjhm1xndHDV4wMvsp885RUCnLL84MdYwg
 8HihCE+nanzjjh6ZGAi/IaAazpujLvbHZ8tI09Rjir/eEvjVzmXrMzWx5NUhV4nwZD2NFC
 tevID1eO5PP1VpEOWQcHJ6+V1clznNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737106860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QRXOUJguMsZL5T0UH00yTl2FqjRmkwkOUU88KWBcSk=;
 b=OuQGJHnutKPpBSCXEuV8YZMTsOCBzhNb72snRWe3sL3mZXQdIevs7EgPDP3anlEpy68z7b
 y4rRllCOwsngk2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B36C139CB;
 Fri, 17 Jan 2025 09:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fhszAqwlimdzNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 09:41:00 +0000
Date: Fri, 17 Jan 2025 10:40:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4oln8S422XIUExH@yuki.lan>
References: <20250117084118.740225-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117084118.740225-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,redhat.com,suse.de,suse.cz];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, ping01.sh:url,
 yuki.lan:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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
> This fixes errors on shell tests on netns backend (the default):
> 
>     # PATH="/opt/ltp/testcases/bin:$PATH" ping01.sh
>     ...
>     ping01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
>     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
>     ping01 1 TINFO: add remote addr 10.0.0.1/24
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
>     ping01 1 TINFO: add remote addr fd00:1:1:1::1/64
>     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
>     /opt/ltp/testcases/bin/ping01.sh: 1: eval: tst_kconfig.c:88:: not found
>     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
>     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
>     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
>     /opt/ltp/testcases/bin/ping01.sh: 1: eval: tst_kconfig.c:88:: not found
>     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
>     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
>     ping01 1 TINFO: Network config (local -- remote):
>     ping01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
>     ping01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24

This looks like there is something fundamentally wrong there. If there
is a TST_NO_DEFAULT_MAIN defined in the test, the test does not call
tst_run_tcases() and the timeout shouln't be set up.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
