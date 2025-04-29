Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9EAC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 15:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 793A43CBC36
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 17:20:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4BA03CBBE4
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:20:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 004F96002D6
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:20:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 917811F391;
 Tue, 29 Apr 2025 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745940001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4g1kkI1I3B2WR+W4KyRhVQsNwn5Epkz5r3EMAhGbHM=;
 b=K7ExWT2P9yiRW+LHKhh93WcKSdNl/1Lj16Ut6ympfxbddjK/80xNC1nQWeQq0IcDEIOdLx
 PaEdSYa3vkFrsHMfwJfgymGPaBoD5q5cUZ5E+kYjDk/Kirbhs1lN2fZT22ekUVDqdMPmsQ
 Oa+FjKTrBXk9QbfnEFK1/EWvfKW+YVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745940001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4g1kkI1I3B2WR+W4KyRhVQsNwn5Epkz5r3EMAhGbHM=;
 b=yTLoDJds3s2pgLup80hyE10C3OhW3ziPP+nGl3hXSJPTLCrxdfVLTSN1HoXG5q6ObP2JSf
 zcYuNdWIqSkRDBBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745940000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4g1kkI1I3B2WR+W4KyRhVQsNwn5Epkz5r3EMAhGbHM=;
 b=zTugqRhh2OE83ziwXPX+fSQh00GIxHObVx4mRCDRM1UC1rPXWnag26SE5WWQtsqm2Dj+Ij
 qtgoG8hO4aVEA3z7l1uRuDBncRvMmOgXSL9TgxcgKluagIiHt4J2MQLL+t/iygaqaF9T5B
 LRKZOj+JO8f7KB6ZaRhZ9yMAgLPknz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745940000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4g1kkI1I3B2WR+W4KyRhVQsNwn5Epkz5r3EMAhGbHM=;
 b=nh+a0WDfXt3iu76nOi8DMM7iLzpOzPz/K2rYrk3fs2EIAJ7v0WXXqYjFzbHlkw/7TvX8ll
 tJLzTDgfz2Gu+kAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8080B1340C;
 Tue, 29 Apr 2025 15:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ScIEHiDuEGhUDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Apr 2025 15:20:00 +0000
Date: Tue, 29 Apr 2025 17:20:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aBDuQdahWAlcm38G@yuki.lan>
References: <20250429135542.19680-1-chrubis@suse.cz>
 <6d9e6e5c-2453-4f81-add3-01c193776e7e@suse.com>
 <aBDq6PobtIDF2_nV@yuki.lan>
 <f2a81424-b035-433e-b299-07634039ef3c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f2a81424-b035-433e-b299-07634039ef3c@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Ok now it's more clear thanks.
> What about adding a macro like TST_TEST_TCONF that sets archs? At the =

> end, that's what we actually do already in the tst_test structure for =

> tconf_msg:
> =

> #define TST_TEST_TCONF(message)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
>  =A0=A0=A0=A0=A0=A0=A0 static struct tst_test test =3D { .tconf_msg =3D m=
essage=A0 } \
> =

> Something like:
> =

> #define TST_TEST_TCONF2(message, archs)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
>  =A0=A0=A0=A0=A0=A0=A0 static struct tst_test test =3D { .tconf_msg =3D m=
essage, =

> .supported_archs =3D archs=A0 } \

That will not get into the metadata, because the tst_test structure from
the TST_TEST_TCONF() is not parsed by the metadata extractor and that is
on purpose because the real data is in the other one.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
