Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E4C3600C
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 12:57:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94E003CABC3
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 14:57:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9463CABC3
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 14:56:47 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 061BA2005F5
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 14:56:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 614E02117C;
 Mon, 31 Mar 2025 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743425805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpDbFYmBnBTFZ5BBUJsifqVepyo2RmsDjQr3K7upm8w=;
 b=FPOpdtdwxCDkUg2xw76kEVgqDI6jd3LGKC7UskNqwUV6ixFrxVrtvlOp+NhP8qcka9xCU2
 vBPDDn/jszX7ULvhFuSAyLVn41oy8T/j/cnEjllQbx0x1qHfo5LFuqbbuaVnpVeaV4j6X6
 S/yR3M38d4p90xNSudqNsydINiX61FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743425805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpDbFYmBnBTFZ5BBUJsifqVepyo2RmsDjQr3K7upm8w=;
 b=U9hltwUf7NUpjvHP1YGJZ9+6GGke1j0BQWly61CLSuV2mE6knfY83lULaIfQmiaJQ7qVQf
 EZA7E4mtwPliU5CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743425805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpDbFYmBnBTFZ5BBUJsifqVepyo2RmsDjQr3K7upm8w=;
 b=FPOpdtdwxCDkUg2xw76kEVgqDI6jd3LGKC7UskNqwUV6ixFrxVrtvlOp+NhP8qcka9xCU2
 vBPDDn/jszX7ULvhFuSAyLVn41oy8T/j/cnEjllQbx0x1qHfo5LFuqbbuaVnpVeaV4j6X6
 S/yR3M38d4p90xNSudqNsydINiX61FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743425805;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpDbFYmBnBTFZ5BBUJsifqVepyo2RmsDjQr3K7upm8w=;
 b=U9hltwUf7NUpjvHP1YGJZ9+6GGke1j0BQWly61CLSuV2mE6knfY83lULaIfQmiaJQ7qVQf
 EZA7E4mtwPliU5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2814139A1;
 Mon, 31 Mar 2025 12:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7AqBMQqR6mdlFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 12:56:42 +0000
Date: Mon, 31 Mar 2025 14:56:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250331125640.GA215711@pevik>
References: <Z-pP_i-Iq4PSjoT3@stanley.mountain>
 <Z-p-7Q8OIJYai2Xp@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-p-7Q8OIJYai2Xp@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linaro.org:email]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pty: Update slave device permission check to allow 0600
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
Cc: ltp@lists.linux.it, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > Systemd changed the default permissions for PTY slave devices from 0620
> > to 0600 in response to CVE-2024-28085.  Allow either 0620 or 0600 as
> > valid permissions.

> > Link: https://security-tracker.debian.org/tracker/CVE-2024-28085
> > Link: https://github.com/systemd/systemd/commit/a4d18914751e687c9e44f22fe4e5f95b843a45c8
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Tested-by: Anders Roxell <anders.roxell@linaro.org>

> > diff --git a/testcases/kernel/pty/common.h b/testcases/kernel/pty/common.h
> > index 51760b1d39fa..7cda16096d4d 100644
> > --- a/testcases/kernel/pty/common.h
> > +++ b/testcases/kernel/pty/common.h
> > @@ -54,7 +54,8 @@ static inline int open_slave(const int masterfd)
> >  			st.st_uid, uid);
> >  	}

> > -	if (st.st_mode != (S_IFCHR | 0620)) {
> > +	if (st.st_mode != (S_IFCHR | 0620) &&
> > +	    st.st_mode != (S_IFCHR | 0600)) {
> >  		tst_brk(TBROK, "unexpected slave device permission: %o",
> >  			st.st_mode);
> >  	}

> Looks good to me:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

LGTM as well.

I was thinking a bit if whether to check just for owner
permission and ignore group or other, e.g.:

st.st_mode != (S_IFCHR | S_ISUID | S_ISGID)) {

But we probably want strict permission checking, thus:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
