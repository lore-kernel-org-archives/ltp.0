Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FB0E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:26:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDF933ED466
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 15:26:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B4573ED454
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 15:25:52 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A97EA10009FD
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 15:25:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D39BF1F396;
 Thu, 19 Dec 2024 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734618350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIiyhFngO+AEuf+mslon4OlWunySyVjuIk9LrEu8qAM=;
 b=o5UUVF6uX2icTKWzPevJdm/TdtccRQhsvFCCpceyRlsjRfcxl38X5iq5Ltn1NZ8M6J8U9X
 5iykHWskN+cu8VpS6cEXneOhAJ/YW/F3Rl7BjTpzr4osvpZdH21f6Nqo80crOwKyVxAcAZ
 sm32Ko7hrZHivw8YkBRIHUL/SrK8ig0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734618350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIiyhFngO+AEuf+mslon4OlWunySyVjuIk9LrEu8qAM=;
 b=D2sy/LZUU0nEuJDmjBJnJPvNrY/qVaGO52y0j3KbJzu6GpIQq/67DFRHE1FfMQ8AEx8E7S
 vU7L3cMX2EtxenDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734618350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIiyhFngO+AEuf+mslon4OlWunySyVjuIk9LrEu8qAM=;
 b=o5UUVF6uX2icTKWzPevJdm/TdtccRQhsvFCCpceyRlsjRfcxl38X5iq5Ltn1NZ8M6J8U9X
 5iykHWskN+cu8VpS6cEXneOhAJ/YW/F3Rl7BjTpzr4osvpZdH21f6Nqo80crOwKyVxAcAZ
 sm32Ko7hrZHivw8YkBRIHUL/SrK8ig0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734618350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIiyhFngO+AEuf+mslon4OlWunySyVjuIk9LrEu8qAM=;
 b=D2sy/LZUU0nEuJDmjBJnJPvNrY/qVaGO52y0j3KbJzu6GpIQq/67DFRHE1FfMQ8AEx8E7S
 vU7L3cMX2EtxenDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C7113A77;
 Thu, 19 Dec 2024 14:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UZG5Lu4sZGdbKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Dec 2024 14:25:50 +0000
Date: Thu, 19 Dec 2024 15:25:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z2Qs8IOAEerQb9SY@yuki.lan>
References: <20241218190029.15015-1-chrubis@suse.cz>
 <20241218190029.15015-9-chrubis@suse.cz>
 <20241219141656.GC115746@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241219141656.GC115746@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,yuki.lan:mid]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/9] metadata: metaparse: Add a few pre-defined
 macros
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
> > +/* pre-defined macros that makes the output cleaner. */
> > +static const struct macro {
> > +	char *from;
> > +	char *to;
> > +} internal_macros[] = {
> > +	{"TST_CG_V2", "2"},
> > +	{"TST_CG_V1", "1"},
> > +	{"TST_KB", "1024"},
> > +	{"TST_MB", "1048576"},
> > +	{"TST_GB", "1073741824"},
> I guess we need a number for calculation (e.g. 1 * TST_GB)
> Otherwise 1 GB would be more readable than a big number.

The metadata are supposed to be read by a computer, so indeed the number
is better. I guess that we can convert it to something more sensible in
the perl script that generates the html pages.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
