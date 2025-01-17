Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC636C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:18:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7003F3C7C40
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:18:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1787A3C2EE4
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:18:09 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6F4541009BCA
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:18:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7EBE1F37C;
 Fri, 17 Jan 2025 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737109086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJ5hbzrMCs2b8IYLqO6GvdsDNQFm2eMsJiorukflQhs=;
 b=oV9yM5u6cGJ2Ecpgl+RIvdfZ7OTpB+5NRtvkuIWuQaJ2kt8g8g7iKYcXF52avyq0TDjhK9
 UbCj7TXR7n2WWup9hR5par4xYcv7ZWHcw1njcbHdsMZJ9aACc2KFbi7C6L2huczoEWemZ1
 k+5XtIcfb5k6L3B8tZvJOq01/2ceWC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737109086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJ5hbzrMCs2b8IYLqO6GvdsDNQFm2eMsJiorukflQhs=;
 b=kw77JztuGHl+mh6n6ipV3YbwuNo87z8t2tuZ2qU93J07Oat4INz14XXnsNzrHwHgyNVbuR
 0uegffFeqm/N1PCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zcNXk0uA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3QVu7n+3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737109085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJ5hbzrMCs2b8IYLqO6GvdsDNQFm2eMsJiorukflQhs=;
 b=zcNXk0uAkGX4JaDBwaZkQbx1jZDBEio7aWpQk9Wb7JP55FW2hJPxTHo+sO/yNXeqF7WtdD
 W7+9rkjkazAI5HYb60VoJ0EN9So0yJvBX+NHL1FBFTS/NA/RuNzJDsX28WZxfTeJi8y1A7
 6UF2swb13r6vUTF0VTZblobhuo9iWMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737109085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJ5hbzrMCs2b8IYLqO6GvdsDNQFm2eMsJiorukflQhs=;
 b=3QVu7n+3W4GCOTifICaE7orTZBGiurao5uP2HgcjrKSeH49/veoTscPb2entNuBaSTDjeY
 A4xqAUK9v6TW/YAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F771139CB;
 Fri, 17 Jan 2025 10:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j9VbIV0uimdfbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 10:18:05 +0000
Date: Fri, 17 Jan 2025 11:18:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Petr Vorel <petr.vorel@gmail.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Li Wang <liwang@redhat.com>, Avinesh Kumar <akumar@suse.de>,
 Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250117101804.GA750287@pevik>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan> <20250117095742.GA749338@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117095742.GA749338@pevik>
X-Rspamd-Queue-Id: C7EBE1F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[suse.cz,lists.linux.it,gmail.com,suse.com,redhat.com,suse.de];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!
> > > This fixes errors on shell tests on netns backend (the default):

> > >     # PATH="/opt/ltp/testcases/bin:$PATH" ping01.sh
> > >     ...
> > >     ping01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > >     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
> > >     ping01 1 TINFO: add remote addr 10.0.0.1/24
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
> > >     ping01 1 TINFO: add remote addr fd00:1:1:1::1/64
> > >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > >     tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> > >     /opt/ltp/testcases/bin/ping01.sh: 1: eval: tst_kconfig.c:88:: not found
> > >     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
> > >     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
> > >     /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
> > >     /opt/ltp/testcases/bin/ping01.sh: 1: eval: tst_kconfig.c:88:: not found
> > >     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
> > >     /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
> > >     ping01 1 TINFO: Network config (local -- remote):
> > >     ping01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > >     ping01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24

> > This looks like there is something fundamentally wrong there. If there
> > is a TST_NO_DEFAULT_MAIN defined in the test, the test does not call
> > tst_run_tcases() and the timeout shouln't be set up.

> FYI tst_test.c:510 safe_clone(): call tst_multiply_timeout()

via:
tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);

I wonder if this should be wrapped with
#ifndef TST_NO_DEFAULT_MAIN

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
