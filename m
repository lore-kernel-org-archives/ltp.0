Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CECCD5BD0
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 11:15:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AFAE3E52A7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 13:15:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 722993D01C8
 for <ltp@lists.linux.it>; Mon, 25 May 2026 13:15:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CDBA360068C
 for <ltp@lists.linux.it>; Mon, 25 May 2026 13:15:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39AC564C3F;
 Mon, 25 May 2026 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779707718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33gK1s0oAByCqyBjkFEGTpwFaKqCgzP5+hCyonfoSz4=;
 b=Gx6xRER9cauHJRZCtzPsbRpTt4eQeKkumJv2pC9AhuMBTxVDvOEa7/shoBj+IM0YXm5FQX
 gG753xGS5McRLdE6c85S/lg9Nq6IzfHKFcHJUol+viNlF/xJy/OqjcJNCJ9WFco1ui37NP
 9YU0DdNNMp6itzTt8VW6lYQdUJC8kHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779707718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33gK1s0oAByCqyBjkFEGTpwFaKqCgzP5+hCyonfoSz4=;
 b=AXI3SmXfYoWe4UM0qCJqjKbXuphLG79jNpcbl949hHZNssif65kkQPQWOYzIP953ofpkWD
 a1kuHlP5FILouNCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gx6xRER9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AXI3SmXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779707718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33gK1s0oAByCqyBjkFEGTpwFaKqCgzP5+hCyonfoSz4=;
 b=Gx6xRER9cauHJRZCtzPsbRpTt4eQeKkumJv2pC9AhuMBTxVDvOEa7/shoBj+IM0YXm5FQX
 gG753xGS5McRLdE6c85S/lg9Nq6IzfHKFcHJUol+viNlF/xJy/OqjcJNCJ9WFco1ui37NP
 9YU0DdNNMp6itzTt8VW6lYQdUJC8kHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779707718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33gK1s0oAByCqyBjkFEGTpwFaKqCgzP5+hCyonfoSz4=;
 b=AXI3SmXfYoWe4UM0qCJqjKbXuphLG79jNpcbl949hHZNssif65kkQPQWOYzIP953ofpkWD
 a1kuHlP5FILouNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28FF459BF6;
 Mon, 25 May 2026 11:15:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QRUdCUYvFGrHcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 25 May 2026 11:15:18 +0000
Date: Mon, 25 May 2026 13:15:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ahQvOj1-I9f7Y8OS@yuki.lan>
References: <20260525073921.172426-1-pvorel@suse.cz>
 <ahQQEDozOrVesyQH@yuki.lan> <20260525094224.GA181471@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260525094224.GA181471@pevik>
X-Rspamd-Queue-Id: 39AC564C3F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] min_free_kbytes: TCONF on errno ENOMEM,
 add break
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
> > This looks suspicious. If we fail with the fork here that probably means
> > that the memory allocated by the previous iteration wasn't reclaimed
> > fast enough. Was this on a second or third iteration (we do three
> > iterations with different overcommit values)?
> 
> This is on one of my bare metal machines, first iteration:
> 
> min_free_kbytes.c:91: TINFO: Setting /proc/sys/vm/overcommit_memory to 2
> min_free_kbytes.c:95: TINFO: Setting /proc/sys/vm/min_free_kbytes to 67584
> min_free_kbytes.c:111: TBROK: fork: ENOMEM (12)
> tst_test.c:1933: TINFO: Killed the leftover descendant processes

With overcommit = 2 (never) this just means that memory on your machine
has been all consumed[1]. It may make sense to TCONF on overcommit=2 but
I'm not so sure the other two overcommit modes.

[1] The available memory is counted as swap + 50% of RAM

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
