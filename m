Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B92C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 11:33:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D7DE3C54F8
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 12:33:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBE0B3C2D90
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 12:33:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 585611BBFB2D
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 12:33:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A12A1F393;
 Fri, 24 Jan 2025 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737718385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7Ur7fHDHaWNchNXgDbKTqYnd18KHGVHrA9zccJeVrU=;
 b=Vy9E1ZCsOHATxCCk9js4YvoPaNdyipERMJFPOSq7P7P2YzKshXsnw8to2aX4bHrFvYjKcr
 V1+DzSEv36XKeWQFKhmW/YFkq2eiOg0L0GArS6bxZE/l7yubVoXmSXserY610Ms+PJxqJd
 CwUMuXwmvBCtw0OVH18D5LMZ/LpS0p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737718385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7Ur7fHDHaWNchNXgDbKTqYnd18KHGVHrA9zccJeVrU=;
 b=qenvCJoCxtHbvy5r3GW2dRo/XKh/nMtgxvk+WwhEahDQxPZM/IDnriGSOZdjLwOXv642R7
 bF/0jjecfDUO+JCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737718384;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7Ur7fHDHaWNchNXgDbKTqYnd18KHGVHrA9zccJeVrU=;
 b=OlJLZVku7u2ASM710czNLrBi24YE4eI9MLUfNw9r8rpehg9cP3wjH+wC0GYVfRDoWGpKoZ
 RAYBnudNYvXTi3/xQOp8yfrFefYqwOFPTq4nar0nE3EXTllt+uidkSeEXT/ct6nb03yuu8
 bTueMjKBw9+AsiyFg+KKOKO9xZxd44k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737718384;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7Ur7fHDHaWNchNXgDbKTqYnd18KHGVHrA9zccJeVrU=;
 b=rjKAbtWQC5BwLRg1VOh6XXCo1ZTwpgkFjC41veArvNOjCHChKdLJC/MztZgAmYUVkSjqgP
 +jP8cjjT17aj+ACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 614E213AF0;
 Fri, 24 Jan 2025 11:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UbqkFnB6k2cnZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jan 2025 11:33:04 +0000
Date: Fri, 24 Jan 2025 12:32:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250124113259.GA191428@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122205023.GA48906@pevik> <Z5NveZVCczMxwDpP@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z5NveZVCczMxwDpP@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > We have git freeze before new release. But IMHO this should go in.
> > It works well on v6.13, I'll retest it on SLES kernels.

> We are going to release LTP next week, I would say that it's not enough
> time to properly test these changes and that the timing was too
> unfortunate this time. I would deffer merging after the release.

Fair enough, let's merge it after.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
