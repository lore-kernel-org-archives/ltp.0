Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDA3C9830D
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 08:02:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D310B3E61C1
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 10:02:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39D6B3C6EE3
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:02:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5C3A6008EA
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:02:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F409521D52;
 Fri, 25 Sep 2026 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790323325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR7fmtReU83AwM4gGgZuWQGRB+usuU9eob1rMmH1/ZU=;
 b=nXAXRfi05WOZApnUI0bsFYdNI9AH+j8SzIugcN93f9EPzdDTtqANuzPfMgiCLlAW/PJIVF
 t/sgQX2UZZxNpe6BtgwihxeHxtE22dAoOEi+m8a6T91sxytS0/IFLNCW/eTFowRfOhd1lq
 iLs8qm4lUlPPcMurQCWEuv2hPvBCSnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790323325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR7fmtReU83AwM4gGgZuWQGRB+usuU9eob1rMmH1/ZU=;
 b=+A8x079xcnDgWaSlp6tsI5RvEnxshM3cPdgnoYWwidMEzgMsrnAVmX/JVliqxzcPn0liRp
 JLI1ZtFjaQFd4jAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790323320;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR7fmtReU83AwM4gGgZuWQGRB+usuU9eob1rMmH1/ZU=;
 b=pD5dXeqUGEmctC5n4ZbonofPV+2jaQnyzQ4+qtveDcWn8F9u8NFEd8VdgG6D2ptHjGMVbS
 HSSTfGd9BAuIKLg/eNOEEieKiyZLvzJaY2KlGWApB5lS9IrN3fYYoA1RSp1QvhDPs6MNwz
 SB/FFRXXh4Y3zeGxv64xqb1Abpc15bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790323320;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR7fmtReU83AwM4gGgZuWQGRB+usuU9eob1rMmH1/ZU=;
 b=E3lJ2ZsJdGWXT3yk10P90mq97nm8B6ScfvOkmUosHC3ovcYvnKtfyrQTBKITuiHm79DuIo
 hShfiblko5cfl6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A45F31389C;
 Fri, 25 Sep 2026 08:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HyJXH3cqtmoTMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Sep 2026 08:01:59 +0000
Date: Fri, 25 Sep 2026 10:01:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260925080154.GC2387785@pevik>
References: <20260924112514.2375626-2-pvorel@suse.cz>
 <20260924132408.4225-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260924132408.4225-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] tst_assert: Use 'long long' to fix 32bit compat mode
 truncation
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

Hi all,

> Hi Andrea,

> On Thu, 24 Sep 2026 13:25:12 +0200, Andrea Cervesato wrote:
> > [PATCH 1/3] tst_assert: Use 'long long' to fix 32bit compat mode trunca=
tion

> --- [PATCH 1/3] ---

> > @@ -25,16 +25,17 @@ void tst_assert_int(const char *file, const int lin=
eno, const char *path, int va

> >  void tst_assert_ulong(const char *file, const int lineno, const char *=
path, unsigned long val)
> >  {
> > -	unsigned long sys_val;
> > +	unsigned long long sys_val;

> > -	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
> > +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);

> > -	if (val =3D=3D sys_val) {
> > +	if (val =3D=3D (unsigned long)sys_val) {
> >  		tst_res_(file, lineno, TPASS, "%s =3D %lu", path, val);
nit: maybe we should print also sys_val.
> >  		return;
> >  	}

> > -	tst_res_(file, lineno, TFAIL, "%s !=3D %lu got %lu", path, val, sys_v=
al);
> > +	tst_res_(file, lineno, TFAIL, "%s !=3D %lu got %lu",
> > +		path, val, (unsigned long)sys_val);
nit: and here maybe also print the raw value:
> >  }

	if (val =3D=3D (unsigned long)sys_val) {
		tst_res_(file, lineno, TPASS, "%s =3D %lu (%llu)", path, val, sys_val);
		return;
	}

	tst_res_(file, lineno, TFAIL, "%s !=3D %lu got %lu (%llu)",
		path, val, (unsigned long)sys_val, sys_val);

It would print sometimes unnecessary info:

shmctl03.c:26: TPASS: info.shmmin =3D=3D 1 (1)
shmctl03.c:30: TPASS: INT_MAX <=3D shmmax (2147483647 <=3D 4294967295)
shmctl03.c:34: TPASS: /proc/sys/kernel/shmmni =3D 4096 (4096)
shmctl03.c:35: TPASS: /proc/sys/kernel/shmall =3D 4294967040 (1152921504606=
846720)

> Casting sys_val to (unsigned long) truncates values exceeding ULONG_MAX on
> 32-bit systems, causing false passes when (sys_val & 0xFFFFFFFF) =3D=3D v=
al and
> printing a truncated value on failure. Compare values without truncation
> using (unsigned long long)val =3D=3D sys_val, and print sys_val with %llu=
 on
> mismatch. Handling of 32-bit compat truncation for /proc/sys/kernel/shmall
> should be done in shmctl03.c instead of altering generic library assertio=
ns.

Hm, looking further into it, this really does a behavior change on 32 bit,
because tst_assert_ulong() now compares only the low 32 bits. E.g.
file which contains 4294967301 passes against an expected=A05. I'm not real=
ly sure
we want this. If yes, it should be documented.

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
