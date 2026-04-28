Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC55FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:50:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 092D93E2DD7
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:50:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 305C03E1AA1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:50:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA3342009DB
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:50:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28FD75BD47;
 Tue, 28 Apr 2026 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777377002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0J3VSUowAnBC219BGR6HpEH/gKazJLZ75TNdGZZIjMM=;
 b=spWdEUJf5MPK4ig+b9zZR6ygKktCBfws09t09zahlev2eB/BU5i3oNqdOyoJrnRHY7IrFs
 obZ/VQAvBgtFV3cR/w1J6Hw/OMaxx0z+zF+WHSg5kU3oFN1cN2I7UoHemPPBc0lpArBSTC
 e4stEoVAE2nsAtPau3EypOhipZb5OII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777377002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0J3VSUowAnBC219BGR6HpEH/gKazJLZ75TNdGZZIjMM=;
 b=vtbeV6/szLGWxxSnXiDEHTOX6M81hiT2FisLda1/IX7vzewR/nlqXct9EzLAeL1ZO2qge4
 zcW7IO3/ctn+ORBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777377002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0J3VSUowAnBC219BGR6HpEH/gKazJLZ75TNdGZZIjMM=;
 b=spWdEUJf5MPK4ig+b9zZR6ygKktCBfws09t09zahlev2eB/BU5i3oNqdOyoJrnRHY7IrFs
 obZ/VQAvBgtFV3cR/w1J6Hw/OMaxx0z+zF+WHSg5kU3oFN1cN2I7UoHemPPBc0lpArBSTC
 e4stEoVAE2nsAtPau3EypOhipZb5OII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777377002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0J3VSUowAnBC219BGR6HpEH/gKazJLZ75TNdGZZIjMM=;
 b=vtbeV6/szLGWxxSnXiDEHTOX6M81hiT2FisLda1/IX7vzewR/nlqXct9EzLAeL1ZO2qge4
 zcW7IO3/ctn+ORBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 192C5593B0;
 Tue, 28 Apr 2026 11:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TxXQBOqe8Gm9AgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 28 Apr 2026 11:50:02 +0000
Date: Tue, 28 Apr 2026 13:50:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir M <samir@linux.ibm.com>
Message-ID: <afCe6bDIKuRj1bVL@yuki.lan>
References: <20260408044431.128811-1-samir@linux.ibm.com>
 <adYi-71K4yb5-wu6@yuki.lan>
 <7f656e34-0e5a-43ad-9cfc-8584a4a537be@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f656e34-0e5a-43ad-9cfc-8584a4a537be@linux.ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nptl01: Fix "make check" warnings and errors
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
> > Again, no point in fixing the test without rewriting it into a new test
> > API.
> >
> 
> Hi,
> 
> Thanks for the feedback. I'd like to rewrite this using the new API. Can 
> you guide me on how to proceed?

You need to read the original code, understand what it does, and then
rewrite it using the new API. There is a lot of documentation at
https://linux-test-project.readthedocs.io/ in the FOR DEVELOPERS
section.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
