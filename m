Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7EC3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C75053D3872
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:55:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C14023CE830
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:55:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EB31720723C
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:55:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 079561F83C;
 Wed, 10 Jul 2024 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720626927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2uSXwoOwcbJPE6Yd/HGAgr92HQelpkWyFazHBW0ppuI=;
 b=WIutUH98kuR72yrbfMQeUGsJ9XVup4isSOy/4iGayfGLyvzmQe4kIIOEfz6pmp4kCX4p4Q
 x5Rpnupwil7g5qhjnixMyB2jmypWGna3WXHqYWJzmK5kzwU4EkRklmMpdHUYsC0OJXMbxP
 GIFaTMiBGUSnFmV0cSba7tcYtugRVHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720626927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2uSXwoOwcbJPE6Yd/HGAgr92HQelpkWyFazHBW0ppuI=;
 b=DnaPPwJYZQeh7wMuLTxYgrOZHrlY/rHxcGyJ6TLJnTD1LGJC3/x+OK3ekm8l3VJyyEANbd
 TWa9zCqLQ5E/AOCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WIutUH98;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DnaPPwJY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720626927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2uSXwoOwcbJPE6Yd/HGAgr92HQelpkWyFazHBW0ppuI=;
 b=WIutUH98kuR72yrbfMQeUGsJ9XVup4isSOy/4iGayfGLyvzmQe4kIIOEfz6pmp4kCX4p4Q
 x5Rpnupwil7g5qhjnixMyB2jmypWGna3WXHqYWJzmK5kzwU4EkRklmMpdHUYsC0OJXMbxP
 GIFaTMiBGUSnFmV0cSba7tcYtugRVHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720626927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2uSXwoOwcbJPE6Yd/HGAgr92HQelpkWyFazHBW0ppuI=;
 b=DnaPPwJYZQeh7wMuLTxYgrOZHrlY/rHxcGyJ6TLJnTD1LGJC3/x+OK3ekm8l3VJyyEANbd
 TWa9zCqLQ5E/AOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C827C137D2;
 Wed, 10 Jul 2024 15:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4L+1L+6ujmbgVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jul 2024 15:55:26 +0000
Date: Wed, 10 Jul 2024 17:55:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240710155521.GC300896@pevik>
References: <20240612112311.10334-1-chrubis@suse.cz>
 <20240701095032.18930-1-joe.liu@mediatek.com>
 <ZoQTD_QLwP8w9sPe@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZoQTD_QLwP8w9sPe@yuki>
X-Rspamd-Queue-Id: 079561F83C
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: alix.wu@mediatek.com, "joe.liu" <joe.liu@mediatek.com>, ltp@lists.linux.it,
 xufeifei1@oppo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,
all,

> Hi!
> > > What kernel version do you use?
> > We are now using kernel 5.15

> > > Do you run LTP with background tasks to keep the CPU bussy?
> > Yes, we are testing LTP with Android VTS. And the test environment is under Android Launcher.

> > > Do you have any custom patches for kernel scheduller applied?
> > I think there is no any patch applied for kernel scheduller.

> > > It really looks like something unexpected is happening at your end.

> > Actually, the same kernel version using 64bit kernel can pass the ltp test.



> > 1. for 32bit kernel, we have this log

> > 32bit kernel
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:161: TINFO: do_test by pid 4523
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4523
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 4524
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4524
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 0
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:176: TINFO: go loop, current pid is 4523
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:145: TINFO: current ppid is 4523, current pid is 4524, go to child() start

> > main pid is 4523, child pid is 4524, and we only see child pid is working (checking by top)

> > 4524 root         20   0  14M 472K    0 R 85.7   0.0   0:14.93 starvation_v4 -t 1000000 -l 1000000 <-- cpu_load by top

> So this looks like we managed to reproduce the issue the test was trying
> to catch. The child is hogging the CPU and the parent process cannot
> proceed. And I suppose that this happens only on 32bit because 32bit is
> less tested these days.

I guess we can merge this, right?
Or we still not sure whether this is really kernel bug not related to the
change?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
