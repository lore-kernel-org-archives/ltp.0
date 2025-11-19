Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F4CF258C
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 09:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B7053CF971
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 10:35:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 458803C79B8
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 10:34:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93B142009F4
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 10:34:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C54620371;
 Wed, 19 Nov 2025 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763544891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FK8ML3AuHutHbEcW0gWgFuezLj+eh4WWyFRbJzaA6po=;
 b=LZm6QLLw9Q9qSqgtcmbaGRJ+H16HxASKNM/hdmBUhfjV+oouu9znUW9pFSLXKde/qKMWT9
 idUSVmSnNs8sPpC9eUiqF0D6Yr/jy6XPmJKINpcZNw5o7WocpwJEPnFzX/TFyZvmNfSQS0
 wFkZ8Pfos918MeSKswwN+Q9mV6d4XEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763544891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FK8ML3AuHutHbEcW0gWgFuezLj+eh4WWyFRbJzaA6po=;
 b=LrJARgShhjGgwGXpRWmaOGkccZwkrtZUwExJx/og3hItdD0fSc+GKjEFyZau6IdgEL1Nal
 A1KiYlc7+yqsqpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763544891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FK8ML3AuHutHbEcW0gWgFuezLj+eh4WWyFRbJzaA6po=;
 b=LZm6QLLw9Q9qSqgtcmbaGRJ+H16HxASKNM/hdmBUhfjV+oouu9znUW9pFSLXKde/qKMWT9
 idUSVmSnNs8sPpC9eUiqF0D6Yr/jy6XPmJKINpcZNw5o7WocpwJEPnFzX/TFyZvmNfSQS0
 wFkZ8Pfos918MeSKswwN+Q9mV6d4XEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763544891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FK8ML3AuHutHbEcW0gWgFuezLj+eh4WWyFRbJzaA6po=;
 b=LrJARgShhjGgwGXpRWmaOGkccZwkrtZUwExJx/og3hItdD0fSc+GKjEFyZau6IdgEL1Nal
 A1KiYlc7+yqsqpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDA7A3EA61;
 Wed, 19 Nov 2025 09:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zMhBOTqPHWnuVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 19 Nov 2025 09:34:50 +0000
Date: Wed, 19 Nov 2025 10:35:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <aR2PZrrGERn-CCXg@yuki.lan>
References: <20251114180157.1207278-1-piotr.kubaj@intel.com>
 <aRy4Zhle9JJANzuW@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRy4Zhle9JJANzuW@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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
Cc: tomasz.ossowski@intel.com, helena.anna.dubel@intel.com, ltp@lists.linux.it,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +# ---
> > +# env
> > +# {
> > +#  "needs_root": true,
> > +#  "supported_archs": ["x86", "x86_64"],
> > +#  "needs_cmds": ["stress-ng"]
> > +# }
> > +# ---
> > +
> > +export LTP_TIMEOUT_MUL=6
> 
> Instead of this the test needs to set up runtime in the environment
> properly. I will send a patch for the tst_run_shell.c that adds support
> for runtime to the JSON env tomorrow.

Patch send. All you need to do in this test is to set the "min_runtime"
to the upper bound of the time the test will take and the test timeout
should be calculated accordingly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
