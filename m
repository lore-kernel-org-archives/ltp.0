Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C77ECC6B12
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 16:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACE153EB107
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 18:04:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 072FD3E8CB6
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 18:04:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B18C10009DA
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 18:04:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48B3322027;
 Tue, 13 Oct 2026 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791907457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jIwFhj0nJjDHJp21V5yhSlveadGpHWjIuoBFPPD1ho=;
 b=cvs01EKajiHfk1Ol1Kla9QJUCey8EdrsC6kUlgs1UNLe+lmH0z03GZCM+HKS30Z7t7N9sm
 O5t3D10q2wiojMAxwgOl9EUT4QXj9klAJPzRVQOkgBkMcEKkO8mh8PtfLFvl6Du4BTDzx9
 Uukk3xGPfpRc/6CDG6J3YAoTEcf4BMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791907457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jIwFhj0nJjDHJp21V5yhSlveadGpHWjIuoBFPPD1ho=;
 b=tMJOQ6kBEWzPNuMUXX7balbJaJqtN5g3yizGsV6ERcKblUfdK+irmphYhTKv5UEZyeUlxL
 0nZruR0q5vJwdICw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791907457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jIwFhj0nJjDHJp21V5yhSlveadGpHWjIuoBFPPD1ho=;
 b=cvs01EKajiHfk1Ol1Kla9QJUCey8EdrsC6kUlgs1UNLe+lmH0z03GZCM+HKS30Z7t7N9sm
 O5t3D10q2wiojMAxwgOl9EUT4QXj9klAJPzRVQOkgBkMcEKkO8mh8PtfLFvl6Du4BTDzx9
 Uukk3xGPfpRc/6CDG6J3YAoTEcf4BMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791907457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jIwFhj0nJjDHJp21V5yhSlveadGpHWjIuoBFPPD1ho=;
 b=tMJOQ6kBEWzPNuMUXX7balbJaJqtN5g3yizGsV6ERcKblUfdK+irmphYhTKv5UEZyeUlxL
 0nZruR0q5vJwdICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3AC113341;
 Tue, 13 Oct 2026 16:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2O9pMYBWzmrvIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 13 Oct 2026 16:04:16 +0000
Date: Tue, 13 Oct 2026 18:04:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Message-ID: <20261013160415.GA79598@pevik>
References: <20261002130546.1236713-1-wakel@google.com>
 <20261007095938.GA3295049@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261007095938.GA3295049@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl: Fix struct keyctl_dh_params build on
 Bionic
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Wake Liu, Cyril,

> > Bionic generates its copy of the UAPI headers with the C++ keyword

> Ah, we forget on the most used C++ libc when we prepared 71353a6c009b.

> > 'private' renamed to '__linux_private', so its struct keyctl_dh_params
> > only provides the 'priv' alias added in kernel 4.20. Since keyctl25-28
> > were switched to 'private', they fail to build on Android:

> >     error: no member named 'private' in 'struct keyctl_dh_params'

> > Detect the 'private' member in configure and access the member via a
> > new KEYCTL_DH_PRIVATE() macro, which falls back to 'priv' when
> > 'private' is not available, similar to FSID_VAL_MEMBER() in
> > lapi/fanotify.h.

> > Checking for 'private' rather than 'priv' leaves every build whose UAPI
> > headers provide 'private' unchanged, including headers older than 4.20
> > which lack 'priv'. It also makes 'priv' the default when configure is
> > not run, as in the Android build, which uses a hand-maintained
> > config.h. The LTP fallback definition provides both members.

> > Fixes: 71353a6c009b ("keyctl: Use struct keyctl_dh_params 'private' instead of 'priv'")
> > Signed-off-by: Wake Liu <wakel@google.com>

> Looks like we cannot avoid struct keyctl_dh_params.private. Make sense.
> Cc Cyril just in case he has some different idea.

Thank you.  Indeed this autotools fix is the safest way. I verified the it did
not break the original fix in 71353a6c009b (SLE12-SP5) and merged as
6262a5fc31 ("keyctl: Fix struct keyctl_dh_params build on Bionic")

I'm also going to send a follow up to simplify struct keyctl_dh_params again.
(Probably union is not needed any more.)

Kind regards,
Petr

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
