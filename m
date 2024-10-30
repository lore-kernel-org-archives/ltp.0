Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510B7D6B6B7
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 17:44:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A36EA3CB4C3
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 18:44:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E86313C7257
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 18:43:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C2A1647BF2
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 18:43:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D75E31FB87;
 Wed, 30 Oct 2024 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730310228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MdzjEFcQweaUY3n9Lyx1FBtXnn2tTYUAk0jHaAbOak=;
 b=QfV291CEDjxEVQR5TBqF19uE4s3tenlzCzZHgwcIwgb7cmd6RKCSQCGSw2jgRSPWRGbZoT
 7/pEo1LpNYlocWlZAbDXyyqM/FZNuoxumbNhcCYwOo1tW/Vofo7wqM9FbXLmyNpHtraDzR
 yldmCIsAEG3+L+kS2u1MG7dyl8FP1Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730310228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MdzjEFcQweaUY3n9Lyx1FBtXnn2tTYUAk0jHaAbOak=;
 b=xYp1d2NzOfsBoVZlfLMkGR9Ih+MlS69+6z9KatRReV279MfnDy5kS7WUj7PV8SbFcDc+PY
 zeDt4ddkZFWt30Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730310227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MdzjEFcQweaUY3n9Lyx1FBtXnn2tTYUAk0jHaAbOak=;
 b=FhEvuVmI6HpYorq/CQ98CgP4zVre/x3Lbmj8zeJe37VfkzCIU4c/Y+nfKo38598TPwu/L7
 AsiZFLB/cQU07js288EdNhgdCf7a/PSuiCJabhE1MkmF/oz8CfD0wHTZTfmfZgds+CEiaj
 NklVhRHmt0Hj55Myu8p3m3Df9QFFxtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730310227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MdzjEFcQweaUY3n9Lyx1FBtXnn2tTYUAk0jHaAbOak=;
 b=pW6nRncMeNb+oboQ+OFg+ZiFzhR5vRWQ+kcMPuOveZ6UHAhs3Ht4lf6/45x8PbFwSVMXHb
 IvtApCBrKZPFHIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C06E513A7C;
 Wed, 30 Oct 2024 17:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SbsPLFNwImdaSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Oct 2024 17:43:47 +0000
Date: Wed, 30 Oct 2024 18:43:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZyJwSAHQzUyubmh_@yuki.lan>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
 <ZyI42B6qhZCf0Qwo@yuki.lan>
 <4e4ff14e-43d8-4a97-8dd6-f8609cd38404@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4e4ff14e-43d8-4a97-8dd6-f8609cd38404@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Refactor regen.sh script to generate
 syscalls
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
> > This will generate multiple fallback definitions, one per architecture
> > for common syscall, there was a good reason why these files were parsed
> > by awk with sort -u
> I wrote the code a few weeks ago, so I needed to read it again to 
> understand the reason.
> 
> If you take a look at the drop_bad_entries() and generate_tables() you 
> will see that `sort` command is used to remove duplicates and to sort 
> the entire list per architecture.

No no, this is the code that generates the actuall LTP header and what
you do here is:

	for each architecture:
		for each syscall in architecture:
			generate fallback with invalid value


And what you need to do is:

	read all syscall names for all architectures and do sort -u then
	generate fallback with invalid value


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
