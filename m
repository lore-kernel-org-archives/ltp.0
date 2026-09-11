Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C706C88E4C
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 10:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9235F3E9203
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:13:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDE703C06B9
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 12:13:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2811E20034C
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 12:13:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AF291F896;
 Fri, 11 Sep 2026 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789121578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnV+GQCSZoa1LB3NYlo7c1kjpKNPrs6m9NePYLsL8MA=;
 b=QTyXHZ/tN8szLjHGuf4jXxtF8Zv95Tv81hnCW8riBGnF6JRqM6pDbqKlxlMbcmecZ7yIqA
 /jocGZHQHTCfrQ5N7V1Ts7qNfuYatpoczRJmxeb/738/FnhH3HS6u4V54UXaHgT0awQ6hR
 MeH5z2ngdok6wpDOvj6HQOEAvRPM4MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789121578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnV+GQCSZoa1LB3NYlo7c1kjpKNPrs6m9NePYLsL8MA=;
 b=31R5RUg4TDuLnmRgF//kSeRPPXxy0vm7HK1WXnVaUkmpXAh3QDNYjKjiqQx6LBm5ubLWgO
 ajvw8Twg09gO1GDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789121574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnV+GQCSZoa1LB3NYlo7c1kjpKNPrs6m9NePYLsL8MA=;
 b=F55yBRwRgfa/GzBMHfgJ8i/NFsznGLA7CWKthEejr0vHvlEZzqte8b9xMK/SfbYxvep31z
 St28PMVm7Y9z7hO0Ba0INiy1QTkpgBnwtxly70/Ad42rRpeDLP/3Qg9waIBjYTWcpCPcIM
 WeDLWDTVibOhudAFj/GqFIMIvQgCB1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789121574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnV+GQCSZoa1LB3NYlo7c1kjpKNPrs6m9NePYLsL8MA=;
 b=aCXWrzSmEBKsMcaTZZMLAGQl7m23FXFWQKB4wEjPRkFcumTIl9Sp2WT4KOgYOy3vHK0zD3
 ys9CJZjfZUMyqGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 406E513715;
 Fri, 11 Sep 2026 10:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7Nr2DCbUo2qbcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 10:12:54 +0000
Date: Fri, 11 Sep 2026 12:12:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260911101252.GA1443368@pevik>
References: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
 <6aa3a2b4.be490abf.30a09d.d9f7@mx.google.com>
 <aqOjPy8_kB0VlHIg@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqOjPy8_kB0VlHIg@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Check minimal supported kernel version
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

> Hi!
> > > +
> > > +	if (tst_kvercmp(v1, v2, v3) < 0)
> > > +		tst_brk(TWARN, "Kernel is older than minimal supported %s", TST_MIN_KVER);
> > > +}

> > @Cyril @Petr I'm wondering if this should be tst_res(TWARN, ..) instead.

> Sorry missed that, yes, that was the point I was trying to make, that
> this shouldn't exit the test. Only produce a message.

As I pointed in v1 even tst_res(TWARN) might be too aggressive as it makes all
tests exit with 4 (=> non-zero) due TWARN.

tst_res(TINFO, "WARNING: ...") would not do that and still warn users.

But since we at SUSE are probably the users of the oldest kernels we don't have
to worry that much. (+ I know it's already merged.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
