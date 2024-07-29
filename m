Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88238C3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 11:42:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79FC03D1D43
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 13:42:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58F963D1D3C
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:41:52 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1C7E860007E
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 13:41:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8CEB521C49;
 Mon, 29 Jul 2024 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722253309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWcMM4YVPQeLP0NUXSFfLygkhOwKI1fuLc41HjG7JEM=;
 b=bg0HxRf5xS9pxK3eBHbQlljh/AAFoBWYrgdGNpK+HSISkOCnMzE2GgrbJ5F4Cgw9mVojBW
 48rMhyX3T+eA9JYbedBEeEcdKujR+YZIKvGZj7RPlU6G9VEa/imBfHJU3fTm2GdOFH4knw
 y0IDSgoYRkOf43cyYv7QrJFFZijingk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722253309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWcMM4YVPQeLP0NUXSFfLygkhOwKI1fuLc41HjG7JEM=;
 b=W+PKNqilo7Btcpq42DfC9HN1NTD2zZygEgKyqH7UNhDvUDul+9em8YdXG+IAdDXCtG4fl3
 ZxyeoRILXVJiRGCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722253309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWcMM4YVPQeLP0NUXSFfLygkhOwKI1fuLc41HjG7JEM=;
 b=bg0HxRf5xS9pxK3eBHbQlljh/AAFoBWYrgdGNpK+HSISkOCnMzE2GgrbJ5F4Cgw9mVojBW
 48rMhyX3T+eA9JYbedBEeEcdKujR+YZIKvGZj7RPlU6G9VEa/imBfHJU3fTm2GdOFH4knw
 y0IDSgoYRkOf43cyYv7QrJFFZijingk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722253309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWcMM4YVPQeLP0NUXSFfLygkhOwKI1fuLc41HjG7JEM=;
 b=W+PKNqilo7Btcpq42DfC9HN1NTD2zZygEgKyqH7UNhDvUDul+9em8YdXG+IAdDXCtG4fl3
 ZxyeoRILXVJiRGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C3EA1368A;
 Mon, 29 Jul 2024 11:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFB/BP1/p2Y6NQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 11:41:49 +0000
Date: Mon, 29 Jul 2024 13:41:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240729114145.GA1234388@pevik>
References: <20240717171713.687339-1-pvorel@suse.cz>
 <20240717171713.687339-6-pvorel@suse.cz>
 <20240729073226.GA1223191@pevik> <ZqdlJJ1-AYAJsDcL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqdlJJ1-AYAJsDcL@yuki>
X-Spamd-Result: default: False [-0.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] runtest/sched: Add sched_football
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > I'm sorry, I haven't noticed, that realtime installs into a different directory:

> Uff, missed that as well. The INSTALL_DIR is set in the config.mk for
> the realtime tests to $(srcdir) so it copies the layout of the realtime
> directories.

Thanks for having a look.

> > cd ltp/testcases/realtime/func/sched_football
> > # make install
> > mkdir -p "/opt/ltp/testcases/realtime/func/sched_football"
> > install -m 00775   "ltp/testcases/realtime/func/sched_football/run_auto.sh" /opt/ltp/testcases/realtime/func/sched_football/run_auto.sh
> > install -m 00775   "ltp/testcases/realtime/func/sched_football/sched_football" /opt/ltp/testcases/realtime/func/sched_football/sched_football

> The minimal fix would be to overwrite the INSTALL_DIR for the
> sched_football testcase, that would be:

> diff --git a/testcases/realtime/func/sched_football/Makefile b/testcases/realtime/func/sched_football/Makefile
> index 9bc779efa..aac98eab6 100644
> --- a/testcases/realtime/func/sched_football/Makefile
> +++ b/testcases/realtime/func/sched_football/Makefile
> @@ -6,10 +6,11 @@

>  top_srcdir             ?= ../../../..

> -INSTALL_TARGETS                := run_auto.sh
>  include $(top_srcdir)/include/mk/env_pre.mk
>  include $(abs_srcdir)/../../config.mk

> +INSTALL_DIR=testcases/bin
> +
>  # TODO: integrate properly with LTP library
>  LDLIBS                 += -lltp
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

OK, quick fix. I'm for this to get problem fixed, but hope we sort realtime till
next release.

Thus 2 patches:
https://patchwork.ozlabs.org/project/ltp/list/?series=417019&state=*

Kind regards,
Petr

> We can move the source code around once we get to the realtime directory
> cleanup later on.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
