Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6768C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:39:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7554D3CBDFB
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:39:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05CA3C88E3
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:39:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3570C1000B02
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:39:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BAA7121CA0;
 Wed,  3 Jan 2024 08:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704271147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
 b=EhgcP3XiJrKpxQnj9O76GVqnMGCksO5VPM54p5b1Ij8KWJ7H83exiHoaNFRDaCf9UFh2bg
 8cFkEnHmG3pjfSURXA04hwSQjcVBghHEKhikLCwywQrZ8FGQd4f7khz7knzzH0Y7xLHeiP
 1PBtLHkvlv0Ax4yJpXict5YhO9mWR+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704271147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
 b=UrbehE266lHkqG1BzBhz0z48A5EA2oUFSv1Fk6oePcwZsyg6HdVrQEB8+RztIu7J1O0FWt
 nbxqu9tlEJijJwCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704271147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
 b=EhgcP3XiJrKpxQnj9O76GVqnMGCksO5VPM54p5b1Ij8KWJ7H83exiHoaNFRDaCf9UFh2bg
 8cFkEnHmG3pjfSURXA04hwSQjcVBghHEKhikLCwywQrZ8FGQd4f7khz7knzzH0Y7xLHeiP
 1PBtLHkvlv0Ax4yJpXict5YhO9mWR+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704271147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
 b=UrbehE266lHkqG1BzBhz0z48A5EA2oUFSv1Fk6oePcwZsyg6HdVrQEB8+RztIu7J1O0FWt
 nbxqu9tlEJijJwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D45D1340C;
 Wed,  3 Jan 2024 08:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y92ZHSsdlWUdYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 08:39:07 +0000
Date: Wed, 3 Jan 2024 09:39:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240103083905.GA1073466@pevik>
References: <20240103015240.1065284-1-pvorel@suse.cz> <ZZUTsDX8bKPimLgD@rei>
 <ZZUVCr2AZ6clmYIl@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZUVCr2AZ6clmYIl@rei>
X-Spamd-Result: default: False [-3.34 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.04)[58.93%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> > > say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> > > from LTP. We have been actively removing UCLINUX from LTP during rewrite
> > > tests to new LTP API. This removes the rest from the old tests (which
> > > will be sooner or later rewritten to new API).

> > > Because the patchset is quite big, I did not want to send it to mailing
> > > lists (but I can do it if you want).

> > I agree that this should be done, but I'm not sure if we want to get
> > this in before the January release. I guess that such change would be
> > safer to merge just after the release so that we have a few months to
> > actually catch possible problems.

> Looking at the actuall changes it does not look awfuly complex, so maybe
> we can try to merge it before the pre-release testing and hopefully
> things will not break badly.

Thanks for a quick look. Both ways would work for me, depends on you and others.
Obviously fewer rebasing is better :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
