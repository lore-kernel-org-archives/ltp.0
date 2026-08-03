Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BC7C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:14:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69A2D3E7190
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:14:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D984D3E290C
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:14:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B46B140025A
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:14:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A58A7EFBB;
 Mon,  3 Aug 2026 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785748435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2/kpg4rS+jaa6KAJQFXFUZYe6ttacD9hPyGVhEuvLk=;
 b=1wEn5bdBxaPPauS2A9O6h1UAQPme7Bmg+9vpVMqxpXE6Im7Gbi/zH5Xa8aVBlf9t5k3pz6
 91My2zFK5AC/2ShtcR2eW42YeaayUlx5NTX4XcRspqaDeK+Mbz/MMytw0aRRqX87bwBrqt
 v45tE2Am4b3onEgtZ4mAzh+oP6iaiH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785748435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2/kpg4rS+jaa6KAJQFXFUZYe6ttacD9hPyGVhEuvLk=;
 b=vN2C3LB+47S4Bdlyn2Rz2JvkNtaLFc8bb3pC5wxMdvWZqmWEWAE5unmk93G6nz5SIAlzy9
 PH+y6ZABc3emfLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785748431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2/kpg4rS+jaa6KAJQFXFUZYe6ttacD9hPyGVhEuvLk=;
 b=KUKb2b6yu4gh/Wf3x8qmcOf2TduDE+WBn0zcMhuj3tX3qB+RUycAt0xobZaQT/Xq3GDspc
 g70M22hNkkU+lMLD2/v1nMJaZ0oH2ox1v0CdsuRa3DmbImPogYMnFjPX3M3UScsFZ9XWCV
 7vq4hcD0HrJQ7p65RZSlFMZAh3NaDyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785748431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2/kpg4rS+jaa6KAJQFXFUZYe6ttacD9hPyGVhEuvLk=;
 b=BjQG6OtzqNkdYyy2vmzdQvzLMd3RquHxeKZiBCMFxJILGpQ5p6AU22Z6gDAu9NJynzyF/N
 e98S+eS7vrgaK6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77CB8779C1;
 Mon,  3 Aug 2026 09:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zkwrE85bcGrDDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 09:13:50 +0000
Date: Mon, 3 Aug 2026 11:13:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260803091348.GA216243@pevik>
References: <20260731054548.133241-1-pvorel@suse.cz>
 <6a6c5226.d5b2c389.166717.d42a@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6c5226.d5b2c389.166717.d42a@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,ozlabs.org:url];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

Hi all,

since we have all active LTP maintainers enabled as patchwork maintainers in the
kernel.org instance [1] I'd like in few hours merge this patch to finally move
to patchwork.kernel.org. FYI we already have 18 patches on it, AI review is
there as well.

@Cyril @Li @Jan: Could you please ack this patch?

I wonder when to stop receiving patches on the old ozlabs instance [2] We should
probably ask for it soon so that people don't think we stop maintaining it. I
hoped that the last patch on that instance would be "Switch to
patchwork.kernel.org" [3], but there are new patches now. OTOH we then no longer
get updates for the old patchsets (there are 54 patches which aren't on the new
kernel.org instance + already 6 duplicates).

Other question is when to ask about for removing the old instance. I'd keep it
at least for some time (can be useful + there might be bookmarks, instance has
13079 patches, first one in 2018-02-28). WDYT?

Kind regards,
Petr

[1] https://patchwork.kernel.org/project/ltp/
[2] https://patchwork.ozlabs.org/project/ltp/list/
[3] https://patchwork.ozlabs.org/project/ltp/patch/20260731054548.133241-1-pvorel@suse.cz/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
