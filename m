Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1982C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 19:55:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4931D3CEF26
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 20:55:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B4FE3CAF8E
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:55:25 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75F0B140004B
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:55:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D6B82216A;
 Sun, 21 Jan 2024 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705866921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG/B7kSAInc751etKWExabAZJuAwNM6kHs3n50ploo0=;
 b=pu6fE9E3ANCG7UkNtrNWNq5ICJK4RVuFRZtLss1UykJFmqsHbcrfKsrjgfwiwcKy1RG3Zl
 I52FAYWbFcFK1TlKNdPHhauPaj9TuJJrjJ4dmpfnXMz7wy5xRCRrRpuR4G7AipBh/9+ekz
 g/Wi5yAXA5or+q0q7zCHsnfeUAIJhvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705866921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG/B7kSAInc751etKWExabAZJuAwNM6kHs3n50ploo0=;
 b=0/GLIGnJ0R+wnOHxit+FR6RdthZqNgreIqPLBEDjPxJnk/NyIoaEi5jiWxyey1ZkgVVWAe
 P9nXVlTRahWxC/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705866921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG/B7kSAInc751etKWExabAZJuAwNM6kHs3n50ploo0=;
 b=pu6fE9E3ANCG7UkNtrNWNq5ICJK4RVuFRZtLss1UykJFmqsHbcrfKsrjgfwiwcKy1RG3Zl
 I52FAYWbFcFK1TlKNdPHhauPaj9TuJJrjJ4dmpfnXMz7wy5xRCRrRpuR4G7AipBh/9+ekz
 g/Wi5yAXA5or+q0q7zCHsnfeUAIJhvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705866921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG/B7kSAInc751etKWExabAZJuAwNM6kHs3n50ploo0=;
 b=0/GLIGnJ0R+wnOHxit+FR6RdthZqNgreIqPLBEDjPxJnk/NyIoaEi5jiWxyey1ZkgVVWAe
 P9nXVlTRahWxC/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC2BF139A1;
 Sun, 21 Jan 2024 19:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ErBkNqh2rWVaLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 21 Jan 2024 19:55:20 +0000
Date: Sun, 21 Jan 2024 20:55:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Message-ID: <20240121195519.GG51882@pevik>
References: <20240115155936.3235-1-subramanya.swamy.linux@gmail.com>
 <20240116162822.GB2606232@pevik>
 <13597a4e-fdf8-4897-a167-28e2ef0a5ad3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13597a4e-fdf8-4897-a167-28e2ef0a5ad3@gmail.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pu6fE9E3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0/GLIGnJ"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FREEMAIL_TO(0.00)[gmail.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 3D6B82216A
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] isofs.sh:Use genisoimage/xorrisofs instead of
 mkisofs
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

> Hi Petr,

> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thank you for reviewing the patch.

> On 16/01/24 21:58, Petr Vorel wrote:
> > Hi Subramanya,

> > > Debain uses genisoimage/xorrisofs and Centos uses xorrisofs
> > > both genisoimage & xorrisofs have symlinks to mkisofs
> > > xorrisofs doesn't support -hfs option & supports only -hfsplus option
> > > genisoimage supports both -hfs & -hfsplus options
> > Well, there are 3 tools (although not all in all distros):

> > * Debian
> > for i in mkisofs genisoimage xorriso; do echo "=3D=3D=3D $i =3D=3D=3D";=
 $i; echo; done
> > =3D=3D=3D mkisofs =3D=3D=3D
> > genisoimage: Missing pathspec.
> > Usage: genisoimage [options] -o file directory ...

> > Use genisoimage -help
> > to get a list of valid options.

> > Report problems todebburn-devel@lists.alioth.debian.org.

> > =3D=3D=3D genisoimage =3D=3D=3D
> > genisoimage: Missing pathspec.
> > Usage: genisoimage [options] -o file directory ...

> > Use genisoimage -help
> > to get a list of valid options.

> > Report problems todebburn-devel@lists.alioth.debian.org.

> > =3D=3D=3D xorriso =3D=3D=3D
> > xorriso 1.5.2 : RockRidge filesystem manipulator, libburnia project.

> > usage : xorriso [commands]
> >          More is told by command -help
> > =3D> Debian has genisoimage and xorriso

> > * openSUSE Tumbleweed

> > $ for i in mkisofs genisoimage xorriso; do echo "=3D=3D=3D $i =3D=3D=3D=
"; $i; echo; done
> > =3D=3D=3D mkisofs =3D=3D=3D
> > mkisofs: Missing pathspec.
> > Usage: mkisofs [options] [-find] file... [find expression]

> > Use mkisofs -help
> > to get a list all of valid options.

> > Use mkisofs -find -help
> > to get a list of all valid -find options.

> > Most important Options:
> > 	-posix-H		Follow sylinks encountered on command line
> > 	-posix-L		Follow all symlinks
> > 	-posix-P		Do not follow symlinks (default)
> > 	-o FILE, -output FILE	Set output file name
> > 	-R, -rock		Generate Rock Ridge directory information
> > 	-r, -rational-rock	Generate rationalized Rock Ridge directory info
> > 	-J, -joliet		Generate Joliet directory information
> > 	-print-size		Print estimated filesystem size and exit
> > 	-UDF			Generate UDF file system
> > 	-dvd-audio		Generate DVD-Audio compliant UDF file system
> > 	-dvd-video		Generate DVD-Video compliant UDF file system
> > 	-dvd-hybrid		Generate a hybrid (DVD-Audio/DVD-Video) compliant UDF fil=
e system
> > 	-iso-level LEVEL	Set ISO9660 level (1..3) or 4 for ISO9660 v 2
> > 	-V ID, -volid ID	Set Volume ID
> > 	-graft-points		Allow to use graft points for filenames
> > 	-M FILE, -prev-session FILE	Set path to previous session to merge

> > =3D=3D=3D genisoimage =3D=3D=3D
> >   genisoimage: command not found

> > =3D=3D=3D xorriso =3D=3D=3D
> > xorriso 1.5.6 : RockRidge filesystem manipulator, libburnia project.

> > usage : xorriso [commands]
> >          More is told by command -help

> > =3D> openSUSE Tumbleweed has mkisofs and xorriso (genisoimage is not of=
ficially
> > supported)

> > How about to run test 3x - for mkisofs, genisoimage and xorriso. There =
would be
> > TCONF when file does not exist. And also detection if the binary is the=
 expected
> > one? Something like this:

> > TST_TESTFUNC=3Ddo_test
> > TST_CNT=3D3

> > do_test()
> > {
> > 	case $1 in
> > 	1) MKISOFS_CMD=3D"mkisofs";;
> > 	2) MKISOFS_CMD=3D"genisoimage"
> > 	   HFSOPT=3D"-hfsplus -D -hfs -D";;
> > 	3) MKISOFS_CMD=3D"xorriso"
> > 	   HFSOPT=3D"-hfsplus -D";;
> > 	esac

> > 	if ! tst_cmd_available $MKISOFS_CMD; then
> > 		tst_res TCONF "Missing '$MKISOFS_CMD'"
> > 		return
> > 	fi

> > 	if ! $CMD 2>&1 | grep -q "$MKISOFS_CMD"; then
> > 		tst_res TCONF "'$MKISOFS_CMD' is a symlink to another tool"
> > 		return
> > 	fi







> > 	... (rest of original do_test + $HFSOPT use)
> > }

> > Does it make sense to you?

> Yes you're right this covers distro's which supports all 3 tools & skips =
on
> symlinks for mkisofs in case of xorriso & genisoimage , will create v2 wi=
th
> changes

If you're quick enough - e.g. tomorrow (there is already a git freeze [1]) =
we
might include that in this release (release is next week). If not, it will =
be
merged after the release.

[1] ps://lore.kernel.org/ltp/Zak5QdHCUyUmJ5x4@yuki/

> Just a thought , is it good to have theses lines in contribution guidelin=
e ?

> =A0pkgs required by tests should be tested on openSUSE,debian,centos etc.

Well, we cannot expect patch authors to send on more distros. But maybe some
suggestion "testing patch on more kernel versions or on more linux distribu=
tions
is recommended."

We also appreciate, if users do testing during git freeze (to find problems
before upcoming release).

Kind regards,
Petr

> Since i believe=A0 LTP=A0 is supported on all widely used distros

> > Kind regards,
> > Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
