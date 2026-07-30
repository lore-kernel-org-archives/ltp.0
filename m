Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D64C55167
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07E993E7253
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 16:09:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F39C63E7255
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 16:08:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0AB951400B90
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 16:08:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C9E740CE;
 Thu, 30 Jul 2026 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785420519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fleaN6WLVz14GmNl0HbY8rZUYZ/Kiriw8OeP5lCV4eI=;
 b=K43c+i6/OHoTqxIsOLbbVubsXZuLg5YKjD09E+Gm4YG6edRrDXtejGwI6mKzOULVbaaIuT
 Ncu+vz16lPtPHfWYzlbOLbpC3hszsrvGaUVxoy7N4VJJRLa5dIUNpdWOvz/qqGk67L703F
 R1Ekj6bKNWBxHhElMjvSRjUqKvutXcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785420519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fleaN6WLVz14GmNl0HbY8rZUYZ/Kiriw8OeP5lCV4eI=;
 b=nJqRPXfqF7PsXqASx2LGpkTBgIynF0UR+Z3EGAcjJ0qBLeZEhMzHpTwocx90lmDhcuTHqp
 VwEPnf/4HFcbB9Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KQKpD2Zb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SGB4iNX1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785420514;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fleaN6WLVz14GmNl0HbY8rZUYZ/Kiriw8OeP5lCV4eI=;
 b=KQKpD2ZbCy/7/a4M+dYFGyG7WUABqXK9Cnc1A3/Eif9fFteNB2q8eVdO3oYY7LOd7nlXYH
 mWb9ohIsxX/OVyO8htKlVNI9RSC8Ede36HoWykwxGUKMCRlA2VLM0tH6JVXF442AiF7Jrw
 /eb9ALnvxn3ATfGMqzoBu7BhLvkbflA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785420514;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fleaN6WLVz14GmNl0HbY8rZUYZ/Kiriw8OeP5lCV4eI=;
 b=SGB4iNX1DB3P3gAYCxZF2GDohMmSo88FN2aoaj0pRdkWmjRLSXtDBBWkL0adiC/x1LSBjq
 YV6elbzfPPxIN6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5677779CC;
 Thu, 30 Jul 2026 14:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1CnGKeFaa2pBDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Jul 2026 14:08:33 +0000
Date: Thu, 30 Jul 2026 16:08:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260730140828.GA83115@pevik>
References: <20260729095730.29185-1-pvorel@suse.cz>
 <20260729095730.29185-3-pvorel@suse.cz>
 <56ad6458-25b4-4eee-ab1e-8d3c6d489aa8@suse.com>
 <20260729133640.GA36478@pevik>
 <5e27b4ff-af04-49ef-a830-934164486892@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e27b4ff-af04-49ef-a830-934164486892@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,lwn.net:url,kubernetes.io:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 3C9E740CE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> > > > - * @min_kver: A minimal kernel version the test can run on. e.g. "=
3.10".
> > > > + * @min_kver: A minimal kernel version the test can run on. e.g. "=
4.4".
> > > s/minimal/minimum

> > You spotted more grammar errors so I trust you :). But can you please d=
ouble
> > check that it'=F0 really correct? Minimal is an adjective, minimum is a=
n adjective
> > but also a noun and an adverb.

> > When googling I even found use of both in the same document :)
> > https://kubernetes.io/docs/reference/node/kernel-version-requirements/
> > "have minimum kernel version requirements"
> > "minimal kernel version requirement"
> I see we are using minimal in many places already. I think both wordings
> are correct. Just that 'maximal kernel version' sounded a bit odd to me.
> So please ignore my comment here.

Np.

> > > > + *
> > > > + * @max_kver: A maximal kernel version the test can run on. e.g. "=
7.2".
> > > s/maximal/maximum
> > dtto

> > > Also, I assume test will *not be skipped* on kernel versions
> > > 7.1.1, 7.1.2 etc just with
> > > .max_kver=3D"7.1"

> > Good point, thanks =3D> v3 (sigh).

> > check_max_kver() needs to have this condition to take an account the su=
blevel.

> > -if (tst_kvercmp(v1, v2, v3) > 0) {
> > +if (tst_kvercmp(v1, v2, v3) >=3D 1024) {
> > 		msg =3D "The test requires kernel %s or older";
> And will this be fine with -
> .max_kver=3D"7.1.5"
> on SUT with v7.2.0 ?

Indeed, this will not be skipped. The reason is that for .max_kver=3D"7.1"
(e.g. without the 3rd number) we want to behave like 7.1.1023 (i.e. 3rd num=
ber
being the highest possible number so that any 7.1 version is ok, which is
achieved by > 1024 instead of 0). If we want also .max_kver=3D"7.1.5" compa=
re
as is (i.e. 7.1.5), it should be something like (untested):

if (tst_kvercmp(v1, v2, v3) > (!v3 ? 1023 : 0)) {
	msg =3D "The test requires kernel %s or older";

And that behavior would have to be for sure well documented.
WDYT?

> sorry, haven't tested yet.

> > ...

> > Sublevel can be above 255 since 4.4.256
> > https://lwn.net/ml/linux-kernel/20210208145805.898658055@linuxfoundatio=
n.org/
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9b82f13e7ef3

> > But it should be below 1024 (practically the highest sublevel has been =
337).

> > Kind regards,
> > Petr

> > > maybe we should clarify.

> > > >     *
> > > >     * @supported_archs: A NULL terminated array of architectures th=
e test runs on
> > > >     *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_o=
n_arch() to
> > > > @@ -551,6 +557,7 @@ struct tst_fs {
> > > >    	struct tst_option *options;
> > > >    	const char *min_kver;
> > > > +	const char *max_kver;
> > > >    	const char *const *supported_archs;
> > > > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > > > index 778a1fed40..fa38b3a7a3 100644
> > > > --- a/lib/tst_test.c
> > > > +++ b/lib/tst_test.c
> > > > @@ -1087,6 +1087,36 @@ static bool check_min_kver(const char *min_k=
ver, const int brk_nosupp)
> > > >    	return true;
> > > >    }
> > > > +/*
> > > > + * Check for the maximal required kernel version.
> > > > + *
> > > > + * return: true if the kernel version is low enough, false otherwi=
se.

> > > This sounds a bit confusing. How about-

> > > Check the running kernel against the last version the test applies to.

> > Makes sense. Based on check_min_kver(), which was renamed from check_kv=
er() in
> > the previous commit. Could you have look on these as well. Anyway, if y=
ou have
> > time, having a look on docs wording as a separate effort would help.
> sure, I will see if I find something worth reporting.

+1


> > > return: true if the kernel is old enough, false otherwise.

> > +1

> > > > + */
> > > > +static bool check_max_kver(const char *max_kver, const int brk_nos=
upp)
> > > > +{
> > > > +	char *msg;
> > > > +	int v1, v2, v3;
> > > > +
> > > > +	if (tst_parse_kver(max_kver, &v1, &v2, &v3)) {
> > > > +		tst_res(TWARN,
> > > > +			"Invalid kernel version %s, expected %%d.%%d.%%d",
> > > I wouldn't say 'kernel version is invalid'. maybe test isn't
> > > supported/applicable on..

> > tst_parse_kver() returns 1 on error =3D> this is really an error check.
> > Other thing is that the same error handling is on both places, but that=
's very
> > minor.
> sorry, my bad. I misunderstood this. Please ignore.

np.

Kind regards,
Petr

> > Kind regards,
> > Petr
> > ...

> > > Thanks,
> > > Avinesh


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
