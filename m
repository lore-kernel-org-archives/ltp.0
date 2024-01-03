Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44652C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:22:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E33F3CE77D
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:22:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEA8B3C1816
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:22:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C91D1000246
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:22:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3ADB821E6E;
 Wed,  3 Jan 2024 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704270136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFdF1bSdlRSwfRVYP3SCwVAJaV5qwzM+A20oaQw+w7Y=;
 b=EvLtC52IP3Jsokz1VXKGc4rh3Ng0Eco8+ulzT0WyiZQPPqqO5qycQnEvoF8VQKA/ND5zH8
 5Pfu0Z3Uev5MN2szUWHBEQ+5k3ab8KwlaL8LY2YF0oM4ZejAV2cjfZaJYhBqGMJ6eiY2M3
 3uX88vC0MUExK6rFsOUTdiMlvmco3Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704270136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFdF1bSdlRSwfRVYP3SCwVAJaV5qwzM+A20oaQw+w7Y=;
 b=0XUCdprjcyGif3QKxMhYxs2MfjIejipxZW31ddDU1hwlNUmSZ8RI4QlDw/EZ2tPYSVzoIp
 YVoQr0eTVsFVSiBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704270134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFdF1bSdlRSwfRVYP3SCwVAJaV5qwzM+A20oaQw+w7Y=;
 b=e0W8/N+WcggCGSElsVZ4M+ifRkInSG6Q3LoIXZgPUzH57KTFpqdxO74t0Me1HouVfbsmPi
 NT+2zmpwXHcY8/D2wXyzaSlHjDG6X/oIfWlSS+EM7fO6fhiHVFRSiVm3oK/rsTpJmFyMu6
 T8QmTYVwYDo/f3XYLZkGqMAjwtu8QS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704270134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFdF1bSdlRSwfRVYP3SCwVAJaV5qwzM+A20oaQw+w7Y=;
 b=jXqYsyoI/HzBh8mjTso5IJahJIXU1HOsXLKhY+BYc7wMXuhGIt8B5JwTh0ivkuqjxefnop
 TXyDBe1KaAUVO+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29AF51340C;
 Wed,  3 Jan 2024 08:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dmc6CTYZlWXqXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 08:22:14 +0000
Date: Wed, 3 Jan 2024 09:21:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZUZBfdTGaQ7huVg@rei>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik> <20231227144839.GB757946@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231227144839.GB757946@pevik>
X-Spamd-Result: default: False [-0.58 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.98)[86.91%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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
> @Li @Cyril: are you ok to test libc getcwd() wrapper implementations on NULL
> buffer in getcwd01.c? Or we just skip NULL buffer test on all libc?
> I would be ok to test it, because change in the implementation can influence
> lots of user space software, although glibc or any other libc can obviously
> change it's behavior.

I guess that the easiest solution is to run the test in a child and pass
the test both on EFAULT and child being killed by SIGSEGV. Any special
cases and ifdefs are assuming something that is not promised and will
have to be changed sooner or later.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
