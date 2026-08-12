Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139EBC5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 738B43E6CDC
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:16:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E3FE3DAD38
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:16:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 780AF1400425
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:16:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 409B182321;
 Wed, 12 Aug 2026 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786540567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNJ84Ia021gstYfF/Pvs6r2l/V3bnmX0BmLHvJR/XSI=;
 b=H3sBpiqEY9QwIR79p2n3quVk+MEpE5hFd642ZnpA88vxPo/Z1bHQMkHxiukuemdHtiR/b0
 aoEv1m5rbze9qhpsNOxY82NF7tG/KdQF9DY/TyopGjDYDMjigCS9CXfEOUV0ACJ6grBJck
 tzCu1YIgXHhynL43p91SxprCX1iQl0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786540567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNJ84Ia021gstYfF/Pvs6r2l/V3bnmX0BmLHvJR/XSI=;
 b=tjgd07w6MGJgqoPrQk0bLH20BW+xOxWfkJHjzKzS43nElY8jmAJoPSJiQ4idpuCUO+VoVC
 9vSSGUWdV5y4d2Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786540563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNJ84Ia021gstYfF/Pvs6r2l/V3bnmX0BmLHvJR/XSI=;
 b=Ef4vQKAp/+lFb0iqtCd98dJU6Fxo1fPkWOYvVguYrJ8AoNEyIR6lVKONQrW3CBHAx4PWqc
 1oVUVW7jbl9ZA6MJzdO/mGT7EpxTvTIPfzW0RAz13QNm5ESK9RU3MtP0sKlt6vOOFmHp+w
 zPyqTFOMt92lhhtXKALUF9USkCADQHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786540563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNJ84Ia021gstYfF/Pvs6r2l/V3bnmX0BmLHvJR/XSI=;
 b=hlIMzSPhlg49oAObeiRWq1BaNoSZHdwaRBeEWkNDDLSCvfYFec1V733FxW1G+bGiE0CgWQ
 azZ4oXf557KCbKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6A7D779B1;
 Wed, 12 Aug 2026 13:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MyiyNRJyfGraVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Aug 2026 13:16:02 +0000
Date: Wed, 12 Aug 2026 15:16:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260812131601.GD1758016@pevik>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTci_fnDEztVVT@yuki.lan> <20260812123007.GA1758016@pevik>
 <anxql8XI7tWx_2gR@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anxql8XI7tWx_2gR@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Uff, this is quite ugly. What exactly are we trying to do?

> > I hoped that was explained in the comment above the code:
> >  .max_kver = "7.0" should run the test not only kernel <= 7.0,
> > but also all stable kernels: 7.0.x.
> > OTOH if there is something backported to stable kernel and one specifies:
> > .max_kver = "7.0.5" it will be compared just to <= 7.0.5.

> > Sure, this can be avoided if .max_kver = "7.0" is not inclusive,
> > i.e. < 7.0 (one would have to use .max_kver = "7.1"), which is less
> > intuitive, because .min_kver is inclusive).

> Or maybe instead of 7.0 the tests should require something as "7.0.*"
> to make it clear that it will run on any 7.0.X patchlevel. And the
> parser vould set the v3 to INT_MAX if it sees '*' as the value for v3.

For me was quite obvious that 7.0.x should ideally have the same main features
as 7.0, just contain fixes. But for others it'd be confusing that 7.0 means
something different in .max_kver then in .min_kver. But the same applies to
"7.0.*", adding it to .min_kver will break the runtime code.

Of course, only if we agree we want .max_kver at all.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
