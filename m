Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E10C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 14:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0FB63CF4DD
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 15:03:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F32873CC371
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 15:02:46 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 558FC6020AA
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 15:02:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 570FB22222;
 Fri,  9 Feb 2024 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707487365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=riHLLzceHdQZetvvSnEXBVUjjQInu7jcgyfqi82b6eo=;
 b=MfnxUoNuU3R7fCWeVHmWT5CrmgKVtkvky9hvrqgb4Zei7B+0jdiP+59SPsWuRuVHGxX+pl
 QbIP/PQkP24VL4+bEYvwBk17DORxfLJvjT/qO43/faDcvT1u+kuU7hIMvvqSQGJFJ6R+bk
 Fod2SUbjYKZ7668/WR0DzOH7KlkJsA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707487365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=riHLLzceHdQZetvvSnEXBVUjjQInu7jcgyfqi82b6eo=;
 b=VO/mg+AoL+e/lZqm7x2ymnWwqY1ePHuSyzduR/p7QtUjV7lArmfFofuO/bTsrfQyQnxPqp
 MtwqyYa/skmJGfBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707487365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=riHLLzceHdQZetvvSnEXBVUjjQInu7jcgyfqi82b6eo=;
 b=MfnxUoNuU3R7fCWeVHmWT5CrmgKVtkvky9hvrqgb4Zei7B+0jdiP+59SPsWuRuVHGxX+pl
 QbIP/PQkP24VL4+bEYvwBk17DORxfLJvjT/qO43/faDcvT1u+kuU7hIMvvqSQGJFJ6R+bk
 Fod2SUbjYKZ7668/WR0DzOH7KlkJsA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707487365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=riHLLzceHdQZetvvSnEXBVUjjQInu7jcgyfqi82b6eo=;
 b=VO/mg+AoL+e/lZqm7x2ymnWwqY1ePHuSyzduR/p7QtUjV7lArmfFofuO/bTsrfQyQnxPqp
 MtwqyYa/skmJGfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19CA2139E7;
 Fri,  9 Feb 2024 14:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nGUYBIUwxmX+aAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 14:02:45 +0000
Date: Fri, 9 Feb 2024 15:02:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240209140238.GA285754@pevik>
References: <20231116152108.10155-1-andrea.cervesato@suse.de>
 <20240209135445.GA280250@pevik>
 <4dbe786e-0701-4e83-be4d-79176454ac44@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4dbe786e-0701-4e83-be4d-79176454ac44@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.90 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.40)[90.95%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactor timer_getoverrun test using new LTP
 API
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

Hi Andrea,

> Hi Petr,

> Yes, indeed it's not needed.
> Can you please correct it before merge?
Sure, amended and merged. Thanks!

Kind regards,
Petr

> Thanks,
> Andrea

> On 2/9/24 14:54, Petr Vorel wrote:
> > Hi Andrea,

> > > +++ b/testcases/kernel/syscalls/timer_getoverrun/Makefile
> > > @@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
> > >   include $(top_srcdir)/include/mk/testcases.mk
> > > +LDLIBS			:= -lrt $(LDLIBS)
> > Shouldn't we merge without -lrt, when we test only raw syscalls?
> > If yes, it can be merged before merging.

> > Otherwise LGTM.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
