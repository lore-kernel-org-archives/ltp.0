Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B651D3176B
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 17:45:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4008A3D29F2
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 18:45:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FF543D0C46
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 18:45:31 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8CABC10006C6
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 18:45:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7A3721BC3;
 Tue,  5 Nov 2024 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730828729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGY0Ho7TJI46LjqCtw9Of380qqDsSS3lluZsNKrIVcY=;
 b=BLOhzeAyJRz3S9PU/qF/3hLLTaNtHk183oFAQxIeDTLga3QRvr5qCYH7o+2mAAyeH6O8KD
 wF+24MwKLSX9iHWcK58E1rNgDL30p7+7UlORxYDKvzguFuEms2TxgJC/ic479nWd6lniX1
 UH9KGYJOJdJW/P3IeUqlK7RCTb5DvOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730828729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGY0Ho7TJI46LjqCtw9Of380qqDsSS3lluZsNKrIVcY=;
 b=D0iDFrfOKC/S35K5HYcIwua+bBzBb0oWa5hQDFaAKdJpOyj3srVKaMo/MGeHnGI5odl/g+
 x3cI8zG3YEk/g5Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730828729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGY0Ho7TJI46LjqCtw9Of380qqDsSS3lluZsNKrIVcY=;
 b=BLOhzeAyJRz3S9PU/qF/3hLLTaNtHk183oFAQxIeDTLga3QRvr5qCYH7o+2mAAyeH6O8KD
 wF+24MwKLSX9iHWcK58E1rNgDL30p7+7UlORxYDKvzguFuEms2TxgJC/ic479nWd6lniX1
 UH9KGYJOJdJW/P3IeUqlK7RCTb5DvOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730828729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGY0Ho7TJI46LjqCtw9Of380qqDsSS3lluZsNKrIVcY=;
 b=D0iDFrfOKC/S35K5HYcIwua+bBzBb0oWa5hQDFaAKdJpOyj3srVKaMo/MGeHnGI5odl/g+
 x3cI8zG3YEk/g5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F9B01394A;
 Tue,  5 Nov 2024 17:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FsbBIrlZKmfIYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Nov 2024 17:45:29 +0000
Date: Tue, 5 Nov 2024 18:45:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZypZvessqhkfFwLJ@yuki.lan>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-4-d58791487919@suse.com>
 <Zyo8I-32MuJz_EFw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zyo8I-32MuJz_EFw@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
> >  	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
> > -		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> > +		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
>                                ^
> 			       This should be abi_current otherwise we
> 			       will fail on v1 only system.
                                 ^
                              Not exactly right either.

We have to pass:

MIN(abi, sizeof(struct tst_landlock_ruleset_attr_abi4))

To make sure that we enable either v1 or v4.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
