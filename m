Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFB8D61015
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 12:59:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1ACB3CC121
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 13:59:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4721A3CAFF7
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 13:58:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 18CEC1A00A51
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 13:58:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B232A340F5;
 Thu, 29 Jan 2026 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769691521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLb9WsA7KNPAisYzFQGPufdZ82dAk9D8Sk3XGb0UYls=;
 b=tvE9//XYglJc47tfQEnO0M/AxzWGFMTmyZ0vw2Rmg97SzD2oENYrSrAgginOrZJtKZ9uMH
 Avht8uXuDveEtF+EbjoUCj9Y2ocvfJNd+OAjR8zlF+FL0wdu8eX92ayvMl/yEKHDIoNGcx
 MCA+7m8FFkBHLM42T693T7aoaFnNTLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769691521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLb9WsA7KNPAisYzFQGPufdZ82dAk9D8Sk3XGb0UYls=;
 b=K4RF0uH9JHUGE1eaqHjTaTpdW6aQCyBvMLrQu405hHHvjl78YxkBKK2NthD6TJ1ROn//oe
 Hhr2NeKE9Cfyh8BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tvE9//XY";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K4RF0uH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769691521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLb9WsA7KNPAisYzFQGPufdZ82dAk9D8Sk3XGb0UYls=;
 b=tvE9//XYglJc47tfQEnO0M/AxzWGFMTmyZ0vw2Rmg97SzD2oENYrSrAgginOrZJtKZ9uMH
 Avht8uXuDveEtF+EbjoUCj9Y2ocvfJNd+OAjR8zlF+FL0wdu8eX92ayvMl/yEKHDIoNGcx
 MCA+7m8FFkBHLM42T693T7aoaFnNTLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769691521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLb9WsA7KNPAisYzFQGPufdZ82dAk9D8Sk3XGb0UYls=;
 b=K4RF0uH9JHUGE1eaqHjTaTpdW6aQCyBvMLrQu405hHHvjl78YxkBKK2NthD6TJ1ROn//oe
 Hhr2NeKE9Cfyh8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67A023EA61;
 Thu, 29 Jan 2026 12:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0HhlFoFZe2lQfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jan 2026 12:58:41 +0000
Date: Thu, 29 Jan 2026 13:58:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260129125840.GA102011@pevik>
References: <20260123124952.338065-2-piotr.kubaj@intel.com>
 <20260123202521.GB367190@pevik>
 <c3447fef150c0ad541c4628b50fc84cf19debb23.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3447fef150c0ad541c4628b50fc84cf19debb23.camel@intel.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; TO_DN_EQ_ADDR_SOME(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: B232A340F5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] thermal: add new test group
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

...
> > > +static void run(void)
> > > +{
> > > +	bool status = 1;
> > > +	char line[8192];
> > > +	uint64_t interrupt_init[nproc], interrupt_later[nproc];
> > > +
> > > +	read_interrupts(interrupt_init, nproc);
> > > +
> > > +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> > > +	struct dirent *entry;
> > > +	int tz_counter = 0;
> > > +
> > > +	while ((entry = SAFE_READDIR(dir))) {
> > > +		if ((strncmp(entry->d_name, "thermal_zone",
> > > sizeof("thermal_zone"))) > 0)
> > > +			tz_counter++;
> > > +	}
> > > +	SAFE_CLOSEDIR(dir);
> > > +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
> > As I noted previously, at least this part will not change if you run
> > test more
> > times, does it? Why not to move it to the setup()?

> > Imagine running test 1000x iterations:
> > ./thermal_interrupt_events -i 1000

> > Why to waste time with reading it again?

> > The only exception might be reading interrupts. I would expect it's
> > ok to have
> > only the initial state (read in the setup() as well), but maybe (when
> > test run
> > with more iterations via -i x) it needs to have the updated state
> > (from the
> > previous iteration).
> That part is still in consultation with our architect.

Thank you! Of course, it's ok to keep it if it's needed.

...
> > > +	for (int i = 0; i < tz_counter; i++) {
> > > +		if (x86_pkg_temp_tz[i]) {

> > run() is quite long. Maybe move content of of this loop would help.
> > Something like this (use whatever function name) would help the
> > readability.

> > 	for (int i = 0; i < tz_counter; i++) {
> > 		if (x86_pkg_temp_tz[i])
> > 			test_zone(x86_pkg_temp_tz[i]);
> > 	}
> > Maybe even split the while part into it's own function.
> Changed. I wanted to avoid creating functions that were only used once.

Understand, but there is also code readability which matters.

...
> > > +
> > > +			while (sleep_time > 0) {
> > > +				tst_res(TDEBUG, "Running for %f
> > > seconds, then sleeping for %d seconds", run_time, sleep_time);
> > nit: %f should be %d, right?
> run_time is double, because difftime returns double. Switching to %d
> causes a warning. If you prefer, I might add casting to int and then
> %d.

The output looks better but it's very minor.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
