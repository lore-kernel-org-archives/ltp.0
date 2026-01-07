Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C6CFD64D
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 15:06:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16F5B3C30D8
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:06:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 600963C2B7D
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:05:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 353F81A00215
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:05:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F5BE5C1BF;
 Wed,  7 Jan 2026 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767798343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZ6rXdugVrtOweOSGJXjS0aOOReLfE3o5u+7rJnB6Qo=;
 b=u15VvDcAxWAi6EHHMfLgDBmOKuJU2AJdNlu10Ll+KEGokRmIiZdurURF5dhXfYIVlB8CGc
 Gg816mYvPUuaPqx6YrJcnrm+IHc23eddmqvkm7/N1U5nNpjQvaLhAm61n3hffkiEuQDvSA
 0Yq4MBp1TRd8mGAonn5IVdJBDqR/z04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767798343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZ6rXdugVrtOweOSGJXjS0aOOReLfE3o5u+7rJnB6Qo=;
 b=e9qYTUvyJ770NiRaUnPw5EVuEaIVv69b2fW2RS6ogKn59QKVys+zGfeOZUPWMhYS4GdSpI
 kexmB2R8pWQQhgAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767798343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZ6rXdugVrtOweOSGJXjS0aOOReLfE3o5u+7rJnB6Qo=;
 b=u15VvDcAxWAi6EHHMfLgDBmOKuJU2AJdNlu10Ll+KEGokRmIiZdurURF5dhXfYIVlB8CGc
 Gg816mYvPUuaPqx6YrJcnrm+IHc23eddmqvkm7/N1U5nNpjQvaLhAm61n3hffkiEuQDvSA
 0Yq4MBp1TRd8mGAonn5IVdJBDqR/z04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767798343;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZ6rXdugVrtOweOSGJXjS0aOOReLfE3o5u+7rJnB6Qo=;
 b=e9qYTUvyJ770NiRaUnPw5EVuEaIVv69b2fW2RS6ogKn59QKVys+zGfeOZUPWMhYS4GdSpI
 kexmB2R8pWQQhgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF4C93EA63;
 Wed,  7 Jan 2026 15:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9soxLEZ2XmnPaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 15:05:42 +0000
Date: Wed, 7 Jan 2026 16:05:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260107150541.GA781042@pevik>
References: <20260107111133.27041-1-chrubis@suse.cz>
 <20260107111133.27041-2-chrubis@suse.cz>
 <20260107113155.GB753482@pevik>
 <DFICR5JD80LT.3B77J5KV4VLAY@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFICR5JD80LT.3B77J5KV4VLAY@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: Document process_state
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

> Hi!

> > @Andrea: I wish sphinx doc would warn about "undescribed" and I thought it did
> > in the past, but I don't see it.

> That's not sphinx, but the 'linuxdoc.rstKernelDoc' plugin we are using.
> It's developed for the kernel documentation (perhaps, we might upgrade
> it to the newest version) and it doesn't provide this.

I tried to update linuxdoc in the past. I remember warning were always there.

Update to 20240924 has only:
* a87ed0a ("[fix] export option to kernel-doc directive")
* 942fecd ("[fix]] kernel_include.py: cope with docutils 0.21")

And warnings are still there. But I might send a patch, better to stay on the
latest release (there are few more fixes, but unreleased).

> > Also we have too many (~ 220x) warnings:
> > "WARNING: duplicate label description, other instance in ..." it's not usable.
> > Any hint you could have look on it? If we solve this warning would get useful.


> The warnings you see are generated by:

> 	pip install linuxdoc
> 	linuxdoc.lintdoc include/

Thanks for a hint.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
