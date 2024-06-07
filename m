Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9588BC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 15:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 136173D0AA8
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 17:45:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34F903CFBD1
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 17:45:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DD5D1400078
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 17:45:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E26C621A86;
 Fri,  7 Jun 2024 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717775123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf22BuRMcB6UpWUIMcXs0U1NvPJzyr8jlOc0zrodxBk=;
 b=lLkaI61sixHWTE/m0BenCEUkVtoLWmCIRzTmF5SNj4xkJMT1/Gv7mK1jjo7nK52RKL9YEF
 /HR1REDGsys+g/R5/dF4zbmiRv0CT6OxulBwzCP3l7zRMMaGblnjysIFXImmfRh2HNAkaz
 FB33/GE364Op1x6cO+Rj6z6DnC9cGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717775123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf22BuRMcB6UpWUIMcXs0U1NvPJzyr8jlOc0zrodxBk=;
 b=mmFPtqWop5czSFhgKsWYbGL0PIsGPjc+orENSZKPPt5++QW401oWcas7yh5jXnM3ugH3qf
 OSU9NcwOFwBY+zBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717775122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf22BuRMcB6UpWUIMcXs0U1NvPJzyr8jlOc0zrodxBk=;
 b=vs1o0jnnHHyZn3G1PfnGPQMV7LJ6fNA0jkc0/HxXXG5H5pSVK+IzeM61ysSx2gUgGvi6Si
 UtVJM0H1BjXPl9+pwG4+N6EqjmspwVjsKOEJdtVbZv9xnXqx87nwfyTkIYaG7lC+cTpDUc
 IVYLLpSG0el+fDvG5jMCSr0IaZF743M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717775122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf22BuRMcB6UpWUIMcXs0U1NvPJzyr8jlOc0zrodxBk=;
 b=HK4oMqCxOU5UsMsy+qx5lrKpSVQ9h4XgJbJPXm7ip0xANtW+rs90Fyqve+o8GlBa3aQYA9
 nGapm3vutflRdACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D282D134C7;
 Fri,  7 Jun 2024 15:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9PF1MhIrY2aUIwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jun 2024 15:45:22 +0000
Date: Fri, 7 Jun 2024 17:45:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <ZmMrBnkIXKfrF8Xv@yuki>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > kirk is not perfect but already much better than old runltp script.
> > Let's deprecate runltp and propagate kirk.
> > =

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > =A0runltp | 13 +++++++++++++
> > =A01 file changed, 13 insertions(+)
> =

> I'd note that Yocto Project's CI is still using runltp and we have no
> recipe for kirk, or any experience of using it.

That's why runltp isn't going to disappear without a deprecation period,
the idea is to add the deprecation and wait a few releases before the
final removal, that in practical terms means at least a year, possibly
two for users to explore the replacement and give us feedback.

> This does therefore worry me a little bit, there appears to be a lot
> of complexity in kirk we don't need.

I would say that there is a complexity that you do not think that you
need but in reality you do. First of all the assumption that you can
have the test runner that keeps the results and overall state on the
same machine that runs the tests is the most flawed of them all. So
running the tests over some kind of connection is the basis design
principle of kirk. That allows us to easily and safely detect when we
crash kernels with our tests, which tend to happen more often than most
people think. And I can go about all the things that are there because
of a good reasons for hours.

That being said, the current kirk implementation ended up more complex
than I would like it, and that is something to improve over the
deprecation period. The general idea is to allow users to experiment
with kirk, even when it's not perfect to get feedback and ideally make
it usable for most usecases before we get rid of runltp for good.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
