Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966C7CCD193
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 16:31:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3EA83CEFC9
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 18:31:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C74A33CEF68
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 18:30:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82D66600875
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 18:30:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F218211E4;
 Mon, 20 Oct 2025 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760977851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhN6HRE8p5lNdVhxgsXFwLwIER0MgrIka7nVoh/A/vk=;
 b=fW+CijUTiw0WIUsyiYIiPiSFaUYs2cLHTi1M67GPyldl1GII5RZs0EKYkTqfb7So/vbj3s
 vOP6tVnZq0DQDJfVxbMjLDjWtJiuQbzadryJjeMt004f6P7axBkgfvW/3M4DTh+1pBq5b8
 gSaMTdLNxMpWBjZLW85y+ZtU8tmgj8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760977851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhN6HRE8p5lNdVhxgsXFwLwIER0MgrIka7nVoh/A/vk=;
 b=wYI6iDZhQj6VTT8e0ihDSFcFpBaGubQahnVHXSTauJrMLkYp/uIi4Nue0HuqQP7ceKqcPA
 MSW4RZLVnkX78ICg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760977847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhN6HRE8p5lNdVhxgsXFwLwIER0MgrIka7nVoh/A/vk=;
 b=azckHhDf+nPatBblUmWcNiP23j+7743Yxf6Uc+6NlDkzGNZIvK2j2DPhEqpxvO5cgejXIb
 ExuhFeo99F6hgTBVrIIbcM7+wl1FPCyQ73zKVWLKBEgDe0TR54pYH0MQ6DsfEU43OgnJU9
 SoNAv4823B1HUOqcnxn2othHIvlwCjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760977847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhN6HRE8p5lNdVhxgsXFwLwIER0MgrIka7nVoh/A/vk=;
 b=hqGSclCTVYqXq+2ZvwsKGw/SLBNiMG1ZDnVjDM7K9eUULcZKS7QMtGUITZJxKId0r1EzY5
 4fH9cXOn5H95t9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F14D13A8E;
 Mon, 20 Oct 2025 16:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oUr9Hrdj9mgAGAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 16:30:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 2A1BBA088E; Mon, 20 Oct 2025 18:30:43 +0200 (CEST)
Date: Mon, 20 Oct 2025 18:30:43 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <og64ngvuxcrmbp265hd3n3jt7r4dfb3xsbmka5j3k7pn5r7nmj@q67mhkpmikz3>
References: <20251001145600.24767-1-jack@suse.cz>
 <20251020141643.GA404362@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251020141643.GA404362@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] name_to_handle_at: Add test cases for
 AT_HANDLE_FID
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 20-10-25 16:16:43, Petr Vorel wrote:
> Hi Jan,
> 
> > Add a few testcases verifying AT_HANDLE_FID flag.
> 
> Thanks for keeping tests updated, we really appreciate that.
> I wonder if the functionality got merged.

Not yet (due to my screwup with email). It should be merged later this week
at which point I'll resend the LTP patch with fixups Amir suggested and
proper kernel commit.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
