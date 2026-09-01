Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57730C61DD6
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 08:48:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D46B53E96AF
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 10:48:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BEFF3E20CA
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 10:47:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C03891A008B0
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 10:47:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D2B71FDD9;
 Tue,  1 Sep 2026 08:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788252464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW1FE/qkgvdrgU49vQvT2kqPYLeDaydp1OsSOrTnlP8=;
 b=IKTNNBcvlO29mwZ6R085A5DNsth0FhRiw2iJI/OdU+U9SxPNCSkUnEiMAhOE9UQKy1KvC9
 iMsPRj34qk9eFLK0LTwwbblDxJVusvr/7ajNBTZjKDtjCzBz0XAhsSIVYzILeMZysFzWsv
 itftg2CNF3B4QGXCmr4TE4TFirlIMig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788252464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW1FE/qkgvdrgU49vQvT2kqPYLeDaydp1OsSOrTnlP8=;
 b=Lu/kwvPC3EnHmZkzaWTjWRAufpDxkGKS68DWUdnZungrMY8cEKFVIRhMhw4EHGUHxQm5zN
 hxRrdt0yEs59ixBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l1Q0R6dx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SzKaKLQQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788252460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW1FE/qkgvdrgU49vQvT2kqPYLeDaydp1OsSOrTnlP8=;
 b=l1Q0R6dxW+LdeaxlT19qLnpFtIco2axMCehgHce2VV6J5ya089fmeeCcp+Mqb48qCK7FoD
 D8mTa6fgKyFvpw8WhvD2p+GQ9R3RomhEThSzMTC9crKpp6jCnLWda/p8D9jqvtxEjOt7LK
 fu5GAbbFR8N2q8OwD017PgFMPsMU5QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788252460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW1FE/qkgvdrgU49vQvT2kqPYLeDaydp1OsSOrTnlP8=;
 b=SzKaKLQQ57/yo5YU0/UcAsKgzSxK9rBL0UvU/wymc3Vph4oz0ktAilS22SR0WFJ94cY4nW
 JwwCJLNiId4w1fBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6513413515;
 Tue,  1 Sep 2026 08:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AnKlGCyRlmr5GAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 01 Sep 2026 08:47:40 +0000
Date: Tue, 1 Sep 2026 10:47:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <apaRM2eYb2NbUs5O@yuki.lan>
References: <ao7sDiRA4JguwRUl@autotest-wegao.qe.prg2.suse.org>
 <6a8ff007.b1f9e4c6.15919c.5636@mx.google.com>
 <apBH_mTl9lUxbGdZ@yuki.lan>
 <apYysdNBmxPxyn3z@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <apYysdNBmxPxyn3z@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Queue-Id: 8D2B71FDD9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
> > index 4e6023399..2c0c6fb02 100644
> > --- a/testcases/kernel/mem/mmapstress/mmapstress06.c
> > +++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
> > @@ -59,8 +59,9 @@ static void run_test(void)
> >  
> >                 for (size_t i = 0; i < map_size; i += page_size) {
> >                         mmapaddr[i] = 'a';
> > -                       if ((i % (2 * 1024 * 1024)) == 0)
> > -                               usleep(1000);
> > +
> > +                       if (i >= mem_limit && !(i % (2 * 1024 * 1024)))
> > +                               usleep(100000);
> >                 }
> > 
> > The testrun increses to 6s from 1s but it makes the OOM very unlikely to
> > happen.
> Thanks for your suggestion.
> I have tested above solution in our openqa setup but still encounter failure, 3 test cases
> still failure with oom after run 100 cases. Maybe slow down dirty loop
> is still too late?

AFAIK the swapping does not start until we are over the limit, so
slowing it down before we reach the limit is not going to change
anything. For v2 cgroup we can also set a soft limit memory.high to
slightly smaller number than memory.max, whith that the kernel would
start the swapping once memory.high was reached.

Something as:

if (!TST_CG_VER_IS_V1(cg_child, memory))
        SAFE_CG_PRINT(cg_child, "memory.high", "%lu", mem_limit - mem_limit/8);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
