Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21603C54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 13:37:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C74583E4EE0
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 15:37:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DD173E1C4E
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 15:36:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4822E10009E3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 15:36:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEB733E25;
 Wed, 29 Jul 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97765779A1;
 Wed, 29 Jul 2026 13:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ColBI+0Bamr7AgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 13:36:45 +0000
Date: Wed, 29 Jul 2026 15:36:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260729133640.GA36478@pevik>
References: <20260729095730.29185-1-pvorel@suse.cz>
 <20260729095730.29185-3-pvorel@suse.cz>
 <56ad6458-25b4-4eee-ab1e-8d3c6d489aa8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56ad6458-25b4-4eee-ab1e-8d3c6d489aa8@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: BEB733E25
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

> Hi Petr,

> few comments below
Thanks!

> On 7/29/26 11:57 AM, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > The same as v1.

> >   include/tst_test.h |  9 ++++++++-
> >   lib/tst_test.c     | 39 +++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 47 insertions(+), 1 deletion(-)

> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index c69362485e..0910660827 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -280,6 +280,9 @@ struct tst_ulimit_val {
> >    *
> >    * @min_kver: A minimum kernel version supporting the filesystem whic=
h has been
> >    *            created with mkfs.
> > + *
> > + * @max_kver: A maximum kernel version supporting the filesystem which=
 has been
> > + *            created with mkfs.
> >    */
> >   struct tst_fs {
> >   	const char *type;
> > @@ -292,6 +295,7 @@ struct tst_fs {
> >   	const void *mnt_data;
> >   	const char *min_kver;
> > +	const char *max_kver;
> >   };
> >   /**
> > @@ -301,7 +305,9 @@ struct tst_fs {
> >    *        and each time passed an increasing counter value.
> >    * @options: An NULL optstr terminated array of struct tst_option.
> >    *
> > - * @min_kver: A minimal kernel version the test can run on. e.g. "3.10=
".
> > + * @min_kver: A minimal kernel version the test can run on. e.g. "4.4".
> s/minimal/minimum

You spotted more grammar errors so I trust you :). But can you please double
check that it'=F0 really correct? Minimal is an adjective, minimum is an ad=
jective
but also a noun and an adverb.

When googling I even found use of both in the same document :)
https://kubernetes.io/docs/reference/node/kernel-version-requirements/
"have minimum kernel version requirements"
"minimal kernel version requirement"

> > + *
> > + * @max_kver: A maximal kernel version the test can run on. e.g. "7.2".
> s/maximal/maximum
dtto

> Also, I assume test will *not be skipped* on kernel versions
> 7.1.1, 7.1.2 etc just with
> .max_kver=3D"7.1"

Good point, thanks =3D> v3 (sigh).

check_max_kver() needs to have this condition to take an account the sublev=
el.

-if (tst_kvercmp(v1, v2, v3) > 0) {
+if (tst_kvercmp(v1, v2, v3) >=3D 1024) {
		msg =3D "The test requires kernel %s or older";
...

Sublevel can be above 255 since 4.4.256
https://lwn.net/ml/linux-kernel/20210208145805.898658055@linuxfoundation.or=
g/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D9b82f13e7ef3

But it should be below 1024 (practically the highest sublevel has been 337).

Kind regards,
Petr

> maybe we should clarify.

> >    *
> >    * @supported_archs: A NULL terminated array of architectures the tes=
t runs on
> >    *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arc=
h() to
> > @@ -551,6 +557,7 @@ struct tst_fs {
> >   	struct tst_option *options;
> >   	const char *min_kver;
> > +	const char *max_kver;
> >   	const char *const *supported_archs;
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 778a1fed40..fa38b3a7a3 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1087,6 +1087,36 @@ static bool check_min_kver(const char *min_kver,=
 const int brk_nosupp)
> >   	return true;
> >   }
> > +/*
> > + * Check for the maximal required kernel version.
> > + *
> > + * return: true if the kernel version is low enough, false otherwise.

> This sounds a bit confusing. How about-

> Check the running kernel against the last version the test applies to.

Makes sense. Based on check_min_kver(), which was renamed from check_kver()=
 in
the previous commit. Could you have look on these as well. Anyway, if you h=
ave
time, having a look on docs wording as a separate effort would help.

> return: true if the kernel is old enough, false otherwise.

+1

> > + */
> > +static bool check_max_kver(const char *max_kver, const int brk_nosupp)
> > +{
> > +	char *msg;
> > +	int v1, v2, v3;
> > +
> > +	if (tst_parse_kver(max_kver, &v1, &v2, &v3)) {
> > +		tst_res(TWARN,
> > +			"Invalid kernel version %s, expected %%d.%%d.%%d",
> I wouldn't say 'kernel version is invalid'. maybe test isn't
> supported/applicable on..

tst_parse_kver() returns 1 on error =3D> this is really an error check.
Other thing is that the same error handling is on both places, but that's v=
ery
minor.

Kind regards,
Petr
...

> Thanks,
> Avinesh

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
