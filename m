Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCF3D44D46
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 10:38:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83AEC3D3135
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:38:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72C203D3127
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:38:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 97D0260083D
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:38:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF9D921C2C;
 Wed,  6 Nov 2024 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730889495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92Muy1p+1dUQCVwNRaCjoMzeG5MBu+SpmxzT6HvnpKc=;
 b=AHsu6B0XEtHkqajMxln3l97KaDqkGMypzRb7Xzcmhs8pmgILcMhGomFqAFpoXfc2PEpMgV
 hvcnvnBOszprfz6UzTUN9+2V3PFlDcHxlCmh4dFTnmo+h82hrn7+tA7Dc5I1JeJqETMsTF
 D9OhHtP+kjrdP0/eSaCM0FRv2a9v8Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730889495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92Muy1p+1dUQCVwNRaCjoMzeG5MBu+SpmxzT6HvnpKc=;
 b=UgRct8bT6vIFUTYcl+qHZiqXw6XlTaUtEZ4R1XTNbmbcm9BVhu4s2KBvToYDxb3SVlw4Be
 G3Khg1YWRKiJAPAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730889494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92Muy1p+1dUQCVwNRaCjoMzeG5MBu+SpmxzT6HvnpKc=;
 b=g51A6+kJEeOByaNdT4UWPbIqcbd/6NjOEQs2zT470lnYdBcCM4y4s7earV7YmfazXgkVLA
 kQfm/5IZgNsUKJjWL97Z8IS3mZO99Y63XQhtlLr4tog36WaEY0gWnPauFU8miCDAQPXEKx
 dmGJwa7BylUMakon8E/I8/rVwbmJ8iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730889494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92Muy1p+1dUQCVwNRaCjoMzeG5MBu+SpmxzT6HvnpKc=;
 b=svfyyI8aD2Dfv4NrzfnVQW2FFAO6OxCgb4xZAypGd4KDkqZ4H8c9NF3432AVxpVO+6xHke
 qT+fHKBmGO7pUFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0AB513736;
 Wed,  6 Nov 2024 10:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GDOdMhZHK2egagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 Nov 2024 10:38:14 +0000
Date: Wed, 6 Nov 2024 11:38:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZytHE-4rpsrycuI_@yuki.lan>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-4-d58791487919@suse.com>
 <Zyo8I-32MuJz_EFw@yuki.lan>
 <d3f0719e-a1e3-4eb1-8613-1506d137351a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d3f0719e-a1e3-4eb1-8613-1506d137351a@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] Add error coverage for landlock network
 support
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
> >> -	verify_landlock_is_enabled();
> >> +	abi_current = verify_landlock_is_enabled();
> >>   
> >>   	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
> >>   
> >>   	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
> >> -		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> >> +		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
> >                                 ^
> > 			       This should be abi_current otherwise we
> > 			       will fail on v1 only system.
> >
> >>   }
> >>   
> 
> In what sense? abi4 is already the last one. At least the last supported 
> by LTP.

Because if we request abi4 it will fail on kernels that only support
abi1. We try hard to skip the abi4 tests, but we wouldn't get there at
all on abi1 kernel because we would fail to create the ruleset_fd in the
test setup.

And we cannot initialize the abi to anything newer than abi4 either,
because we pass abi4 structure in the test. It's fine that we pass abi4
structure on abi1 system here, because the test only checks for invalid
cases and all we need here is to pass a valid attr and size so that we
get rejected by the kernel on the rest of the parameters.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
