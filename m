Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44A9C3DA59
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 09:07:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86A033D1A18
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 11:07:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB6013CDECA
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 11:07:36 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E0E4600D2B
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 11:07:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA7451F808;
 Mon, 15 Jul 2024 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721034455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZnU3Zd1djfb7NXkkFE+ZwQhHGAl9MZBRQPUHdb/sT0=;
 b=oKx1a4q0rDaNcmwaojtA08/qNERJQgUhQJBejzfUFaioUK0tafvDMi4TwG66lBTBu9ecgC
 N0USgmhVlA5w9K8vFDebTW9foND+okKPMAVynTbFU8T87Eb+8AAmtnsysH4dpBafTFrD8B
 hicuHMh/DaIsYpevfHsvKOyuBzw1uPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721034455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZnU3Zd1djfb7NXkkFE+ZwQhHGAl9MZBRQPUHdb/sT0=;
 b=wKvQSBDzYvIRYbR73mQ1AUvYmwwyy3VHZwS+U2GStsGbUGYg1Zo5smWV+blPZxASAFJbo0
 Q7/o0BTzbjrBLOAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T+kJskEb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/f77gwld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721034454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZnU3Zd1djfb7NXkkFE+ZwQhHGAl9MZBRQPUHdb/sT0=;
 b=T+kJskEb3E9BGWPHxEF8FwFZ/veKW7xoIX51aBaSP0poA6n8IIDL+uro4y1M7jc3xHWTKu
 +i8iwsanZUXfMIfOsQvypc/XxWFaMkdYlr98g3j1T1XVk43nTWkdN5/YlmVPOsq0+SMqpn
 nZs3eARjkFIbz76M7HImpVaZP1A5lv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721034454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZnU3Zd1djfb7NXkkFE+ZwQhHGAl9MZBRQPUHdb/sT0=;
 b=/f77gwldP4xD9cCwVufDY9zEwYq21ZLFpxFZk6GSH7hiOnfOkxQofHFv2mAvkbZmfWvKHa
 acLRxKSn5tUbTnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C934C134AB;
 Mon, 15 Jul 2024 09:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /iutL9bmlGaCCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jul 2024 09:07:34 +0000
Date: Mon, 15 Jul 2024 11:07:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZpTmyoh2J1zvWHwO@yuki>
References: <20240711104400.63355-1-pvorel@suse.cz>
 <20240711104400.63355-2-pvorel@suse.cz> <ZpERtIxWiodTJiYS@rei>
 <20240712132205.GA145191@pevik> <ZpE5q627g9bpxfwj@yuki>
 <20240712190926.GA399927@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240712190926.GA399927@pevik>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DA7451F808
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
> I hoped there is something I just overlooked. Even I'm not a big fan of meson,
> instead of implementing something own I would consider migrating to it.
> Looking into Andrea's POV, where he did at least some work [1].

I'm afraid that meson is not good choice for us. LTP has to be able to
be compiled everywhere even on ten years old distribution and very
restricted embedded devices, hence I would like us to stay on the most
common and stable build system tooling out there. Which is plain old
make.

And the main problem with our build system is not the tooling we choose,
but the complexity imposed by the out-of-tree build implemented in the
complex makefiles. As far as I can tell 99% of the problems would be
solved by ripping out out-of-tree support, which would remove most of
the code we have in there.

> But back to the reality, would it be possible to merge this even with broken
> dependency? I'm not sure myself.

I will double check the code, before adding my final reviewed-by.

Also this is a step number one. I think that we should enable the
realtime compilation by default and the sched_football should be added
to the scheduller runtest file as well, so that it's executed by default
as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
