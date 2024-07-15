Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D389C3DA5D
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 10:39:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E42463D1A1B
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:39:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FD3A3D199A
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 12:39:22 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5F3B20116A
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 12:39:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3310D1F80D;
 Mon, 15 Jul 2024 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721039958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6pAR+ucDyE2F5Sw7jng/2nnOsKPwQR/1WC6HBKu90s=;
 b=09egAf6ppxIpqwxYnAdf7/Og4ENyFqvOiX40Q9CSkaZhcWJfcCy5J/RtsmrpQeZZixXLxD
 fY+1t/KmYbEk3JOtzqOMTLt5u9ZSLOPXM3v4OgUAQ/TrwyZkpIdQXbE8rUobXHgO354/Ed
 M3840QdVA1VPSzrWEW51Yg5H70sO2TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721039958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6pAR+ucDyE2F5Sw7jng/2nnOsKPwQR/1WC6HBKu90s=;
 b=i3iF2o4qZq48WAvKuFYMpYUfeD6BjzvWiE4Gk1Z6Kba58sW0M4iqiWGeR8pL6SqRKlpZfF
 AM7As5+3YpooYoDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kimaXF3b;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xz3vM0EO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721039957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6pAR+ucDyE2F5Sw7jng/2nnOsKPwQR/1WC6HBKu90s=;
 b=kimaXF3bi1m4l7ZBkDvElOWo2O2cpJq0WePVUlsNO6IzcsM41DSx08FIf8Ajo3a2PXmumE
 Zgalauaeis8lXxzST8hajWX2/mXmJENp76DGKiAVA7b0ANSLu+QrflTZNrIskoyDo+tGeM
 0jP7NOXetchS22+Cply//beF6O3APrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721039957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6pAR+ucDyE2F5Sw7jng/2nnOsKPwQR/1WC6HBKu90s=;
 b=Xz3vM0EOXVSfMXEjKx8AbP5OoUk5sI0DnrOvyBciC4kS68jlSJcbKYlcnwBlTzPPqMT9wb
 gYvDQPUREDkY/9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23593137EB;
 Mon, 15 Jul 2024 10:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WQKZB1X8lGYLJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jul 2024 10:39:17 +0000
Date: Mon, 15 Jul 2024 12:38:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZpT8QdtUZydGj6lN@yuki>
References: <20240711104400.63355-1-pvorel@suse.cz>
 <20240711104400.63355-2-pvorel@suse.cz> <ZpERtIxWiodTJiYS@rei>
 <20240712132205.GA145191@pevik> <ZpE5q627g9bpxfwj@yuki>
 <20240712190926.GA399927@pevik> <ZpTmyoh2J1zvWHwO@yuki>
 <20240715095213.GA424468@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240715095213.GA424468@pevik>
X-Rspamd-Queue-Id: 3310D1F80D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] sched_football: Rewrite into new API
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
Cc: John Stultz <jstultz@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > And the main problem with our build system is not the tooling we choose,
> > but the complexity imposed by the out-of-tree build implemented in the
> > complex makefiles. As far as I can tell 99% of the problems would be
> > solved by ripping out out-of-tree support, which would remove most of
> > the code we have in there.
> 
> +1 for removal. I wonder if anybody finds a time to do that.

That is unfortunatelly a major task...

> > > But back to the reality, would it be possible to merge this even with broken
> > > dependency? I'm not sure myself.
> 
> > I will double check the code, before adding my final reviewed-by.
> 
> Thank you! It still bothers me that building sched_football does not trigger
> building a library, but at least it will work for a full build (building whole
> LTP).

It's even more subtle, there are more things to consider. The test
should be rebuild even if any of the headers it includes change, which
is not detected properly at the moment. For that to work first thing the
build system has to do is to generate a dependencies with $(CC) -MM and
then include them in the build system.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
