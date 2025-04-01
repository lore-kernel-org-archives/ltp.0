Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518E4C36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:21:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D379B3CAFC4
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:21:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14D2E3CAE53
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:21:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C3AAA10009A0
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:21:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60916211C6;
 Tue,  1 Apr 2025 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743502894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sy8hMLEXdfZ+wTvIxjKgMrOi72vaepmaudPblg2C1xA=;
 b=pEYjoebBxsw7HB4LwCB5osrVbJd5QKI5NvbBp+3oahiE7MFCt3f8fEzHfnnmNOZvoT2Hlr
 oTlD5icpAChFSQavTWgUkoTOaUtSqA3KiQALr0KdLLonDOgcoexaph2Sok0vsgx2p8btCI
 SQ+UQQ5Vo6a3eSheNwk8vLJfnCtbtck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743502894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sy8hMLEXdfZ+wTvIxjKgMrOi72vaepmaudPblg2C1xA=;
 b=DK8sOMtenG3GfEGag18jYls+ZKvqfaId87lrZMqcsEjc/kv+YUzEzxbdDDCk+NKiTF/bZP
 tNcANGa7++XRhrBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743502894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sy8hMLEXdfZ+wTvIxjKgMrOi72vaepmaudPblg2C1xA=;
 b=pEYjoebBxsw7HB4LwCB5osrVbJd5QKI5NvbBp+3oahiE7MFCt3f8fEzHfnnmNOZvoT2Hlr
 oTlD5icpAChFSQavTWgUkoTOaUtSqA3KiQALr0KdLLonDOgcoexaph2Sok0vsgx2p8btCI
 SQ+UQQ5Vo6a3eSheNwk8vLJfnCtbtck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743502894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sy8hMLEXdfZ+wTvIxjKgMrOi72vaepmaudPblg2C1xA=;
 b=DK8sOMtenG3GfEGag18jYls+ZKvqfaId87lrZMqcsEjc/kv+YUzEzxbdDDCk+NKiTF/bZP
 tNcANGa7++XRhrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3843D138A5;
 Tue,  1 Apr 2025 10:21:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ALlQDC6+62erEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 10:21:34 +0000
Date: Tue, 1 Apr 2025 12:21:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250401102132.GA345164@pevik>
References: <20250331-conversions-modify_ldt-v5-0-fd6ea1491956@suse.com>
 <20250331-conversions-modify_ldt-v5-1-fd6ea1491956@suse.com>
 <20250401084827.GA329205@pevik>
 <be455754-b62e-47f6-97bf-086f90078fa1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be455754-b62e-47f6-97bf-086f90078fa1@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
Cc: Linux Test Project <ltp@lists.linux.it>, rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> On 4/1/25 10:48, Petr Vorel wrote:
> > nit: IMHO modify_ldt() is not used anywhere outside lapi file, right?
> > I would also consider instead of creating modify_ldt() just put raw syscall:

> > 	rval = tst_syscall(__NR_modify_ldt, func, &ptr, bytecount);

> Just yesterday I got a review from @Cyril asking me to add syscalls function
> definition which are missing inside the lapi/.h header. The reason is that
> we want to fallback libc and eventually check for HAVE_FUNCT_* via
> autotools.

> In general I agree with this approach.

OK, no problem, thanks for info.

Kind regards,
Petr

> Kind regards,
> Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
