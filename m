Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A47DD6EC05
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 12:19:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C7373DC078
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 13:19:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4542E3D935D
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:19:25 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A760D1401714
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:19:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 661D921151;
 Fri, 29 Nov 2024 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732882763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8InESh+cpaFe4MEIzRJG5AZCct7WR0cKZB4fsA/wQw=;
 b=Ga9i9xi/+Whq4kL8WJ7yl8TEkbWrQXUUhSJBCb4LwJ0uVD+YewUA5YWwgvbJaYzFC5CqdB
 o8czUYOhclpMplDVbO7NtKAeQs4c2AdYAElFUlfe9KYG6QvXbGmmsoHpxksF/dJOV44CUE
 a3X8Yu2c6MVE0mXuMdUV3ZG+wPeFDBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732882763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8InESh+cpaFe4MEIzRJG5AZCct7WR0cKZB4fsA/wQw=;
 b=qhT+44WEk7uK+wzzG2ScqJin57iVnE9ZZY3EvSqRF5kbRAnJvur2H0WZfXnhvgGLrbu9n1
 JlvW901KCi6vfLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732882763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8InESh+cpaFe4MEIzRJG5AZCct7WR0cKZB4fsA/wQw=;
 b=Ga9i9xi/+Whq4kL8WJ7yl8TEkbWrQXUUhSJBCb4LwJ0uVD+YewUA5YWwgvbJaYzFC5CqdB
 o8czUYOhclpMplDVbO7NtKAeQs4c2AdYAElFUlfe9KYG6QvXbGmmsoHpxksF/dJOV44CUE
 a3X8Yu2c6MVE0mXuMdUV3ZG+wPeFDBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732882763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8InESh+cpaFe4MEIzRJG5AZCct7WR0cKZB4fsA/wQw=;
 b=qhT+44WEk7uK+wzzG2ScqJin57iVnE9ZZY3EvSqRF5kbRAnJvur2H0WZfXnhvgGLrbu9n1
 JlvW901KCi6vfLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4895C133F3;
 Fri, 29 Nov 2024 12:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6TSCD0uxSWevCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Nov 2024 12:19:23 +0000
Date: Fri, 29 Nov 2024 13:19:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: R Akshay Dharmapuri <raghavendra.akshay@alifsemi.com>
Message-ID: <Z0mxVDtNLLCOSMqS@yuki.lan>
References: <LV1PR22MB60148DD23B9B82A8673231BEF52A2@LV1PR22MB6014.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <LV1PR22MB60148DD23B9B82A8673231BEF52A2@LV1PR22MB6014.namprd22.prod.outlook.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Regarding LTP testing on target hardware linux kernel
 5.4.25 arm 32 bit
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Wanted to enquire in the apis regarding running single tests :
> 
> cd testcases/kernel/syscalls/foo
> $ make
> $ PATH=$PATH:$PWD ./foo01
> 
> 
> cd testcases/lib
> $ make
> $ cd ../commands/foo
> $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
>
> The above folder foo is not present in syscalls and commands..

You have to replace the foo with the actual test binary name. Foo and
bar are words used in examples when users needs to substitute them with
something else.

> Also wanted to enquire in process of running single tests. How does it
> test and difference between single running and installing all at once.

You can run a single test without installing LTP first. If you want to
run all tests in a row automatically you have to install LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
