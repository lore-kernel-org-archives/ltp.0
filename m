Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFFFC5AD7B
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 05:36:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A02B3CE2C2
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:36:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAAB33CBE80
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 07:36:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2DF6D1A003CA
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 07:36:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7A813E01;
 Tue, 11 Aug 2026 05:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786426569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAbB9AHM8Dr+8ixnxXBoEHyywU7nUE503vaYWYOeoqw=;
 b=jkYGoFAJjrWGuU8l3BbkjnhYJATMLuGBCP57futtneARLUXeSCzhAdjifILoUoP5FwnHvm
 1iHCaA/dN/2fY0b231VhuHzSiyn/ub7ZQMakPpsASELpEM7DEBhZjZTfPooIYLlTsnWNc2
 flnt+uZNnbFyZHo6DVeRnvWAQkmNAsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786426569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAbB9AHM8Dr+8ixnxXBoEHyywU7nUE503vaYWYOeoqw=;
 b=TJQ6wTmldZ+dWetg/r9cK3OXOHg/KK2J9QJJ+THJLQTczcWP4VONeLrp9YeDGWfwRRKVbs
 efkUfax4/m69pVBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786426564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAbB9AHM8Dr+8ixnxXBoEHyywU7nUE503vaYWYOeoqw=;
 b=sG5UK3buNYbFIecdL57Z27gAyU0/8jS+1VADnCeUi7yDSK666Uz/51SNYm5C96Ip/obzLv
 ms7NvUghIbOq+Ne1yPOZOJKb+yM7yOzoA3L0DJ2Ps50iAKBXphek9lv8qT4jJSDy9i3ms1
 PcOJimYPekH2dYnutRCUKIPMOlWH50E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786426564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAbB9AHM8Dr+8ixnxXBoEHyywU7nUE503vaYWYOeoqw=;
 b=LMxEXOhwapIBMDyrhqxcnQUrxzxzufhATjpTJfPsLyDMiQnULUCwbxOHSL2W5hKfkDw+AC
 9PW+kjMPGIy3qfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E385C779B2;
 Tue, 11 Aug 2026 05:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s/H0MsO0empnHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 05:36:03 +0000
Date: Tue, 11 Aug 2026 07:35:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260811053554.GA1613289@pevik>
References: <20260810180620.GF1049677@pevik>
 <6a7a1506.e11288f4.339403.080c@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a7a1506.e11288f4.339403.080c@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cve/sctphantom: Add reproducer for
 CVE-2026-64564
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> > Nice reproducer, full of magic. Generally LGTM, few notes bellow?
> > Acked-by: Petr Vorel <pvorel@suse.cz>
> > Tested-by: Petr Vorel <pvorel@suse.cz>

> > > +static void setup(void)
> > > +{
> > > +	int fd;
> > > +	const struct tst_path_val sysctls[] = {
> > > +		{"/proc/sys/net/sctp/addip_enable", "1", TST_SR_TCONF},
> > > +		{"/proc/sys/net/sctp/addip_noauth_enable", "1", TST_SR_TCONF},
> > > +		{}
> > > +	};
> > Can't this be part of .save_restore in struct tst_test?

> I had to move it inside setup/cleanup because we need to load sctp module
> _before_ setting the addip_enable, which is available only after loading
> the module.

Thanks for info!

> > > +	const struct tst_path_val *sysctl;
> > > +
> > > +	tst_modprobe("sctp", NULL);
> > ...

> > > +
> > > +/*
> > > + * The freed transport is released by an RCU callback; once it is gone,
> > > + * reading the association status dereferences the stale primary_path,
> > > + * which KASAN reports as a use-after-free.
> > > + */
> > > +static void probe_uaf(void)
> > > +{
> > > +	uint8_t buf[512];
> > > +	long delay = 1;
> > > +	int i;
> > > +
> > > +	tst_res(TINFO, "probing the stale primary path via SCTP_STATUS");
> > > +
> > > +	for (i = 0; i < 12; i++) {
> > > +		socklen_t len = sizeof(buf);
> > > +
> > > +		TEST(getsockopt(cli_fd, SOL_SCTP, SCTP_STATUS, buf, &len));
> > What is the point of using TEST() macro here. Why not run getsockopt() directly?

> Yeah I also removed it, but then messed up with undo history :-)
> I will remove it again.

Good, it can be removed before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
