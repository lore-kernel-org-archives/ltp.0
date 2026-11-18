Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0467E606A31C
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xsido7fL;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WTG3Y4lp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xsido7fL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WTG3Y4lp
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A40903E9331
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 10:10:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12BBD3CA4C8
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:10:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CAAC2600719
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:10:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6561F7F6;
 Wed, 18 Nov 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794993034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UE6LeIlHuM5bhj23VAzzdayeTyYW2THWRhKeA+kElNw=;
 b=xsido7fLvAVybIcVdQ62sLkL7hS/C+F0g/c9O9bJswr/bl5ZzHlPeAPMhSuuIIxXQiyACw
 RZzigw6DIk0sDO4wmDCnyalortxG7iIRcJZnKpO8x+H1j0QQDUxUSovH9J4mciI8Fqzei2
 medSNmIRUEJFV1Fp45QF2hL7O7nLFJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794993034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UE6LeIlHuM5bhj23VAzzdayeTyYW2THWRhKeA+kElNw=;
 b=WTG3Y4lpm1UBw1wTfgtKOafN9G6VfZsYGZR51oeeo/8tRawH4bIcC1zZ+KVx09WrvL8X5v
 KBG7o/V6jLCITkBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794993034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UE6LeIlHuM5bhj23VAzzdayeTyYW2THWRhKeA+kElNw=;
 b=xsido7fLvAVybIcVdQ62sLkL7hS/C+F0g/c9O9bJswr/bl5ZzHlPeAPMhSuuIIxXQiyACw
 RZzigw6DIk0sDO4wmDCnyalortxG7iIRcJZnKpO8x+H1j0QQDUxUSovH9J4mciI8Fqzei2
 medSNmIRUEJFV1Fp45QF2hL7O7nLFJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794993034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UE6LeIlHuM5bhj23VAzzdayeTyYW2THWRhKeA+kElNw=;
 b=WTG3Y4lpm1UBw1wTfgtKOafN9G6VfZsYGZR51oeeo/8tRawH4bIcC1zZ+KVx09WrvL8X5v
 KBG7o/V6jLCITkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B2351334C;
 Wed, 18 Nov 2026 09:10:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y/SeNIlr/WpVbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Nov 2026 09:10:34 +0000
Date: Wed, 18 Nov 2026 10:11:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Darren Chang <chihsheng@google.com>
Message-ID: <av1rphtgXHMQzG9Z@yuki.lan>
References: <20261118063445.2137150-1-chihsheng@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118063445.2137150-1-chihsheng@google.com>
X-Spamd-Result: default: False [-17.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sys_block_queue01: Accept plain "none" in
 queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +	/*
> +	 * elv_iosched_show() emits plain "none\n" without brackets for queues
> +	 * that do not support I/O schedulers (bio-based devices prior to 6.5,
> +	 * and BLK_MQ_F_NO_SCHED devices prior to 6.14).
> +	 */
> +	if (!strcmp(sched, "none")) {
> +		tst_res(TPASS, PATH_SYS_BLOCK "/%s/queue/scheduler = 'none'", dev);
> +		return;
> +	}
> +
> +	TST_SYSFS_ASSERT_CHOICE(sched_allowed, NULL, 0,
> +				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);


This does not make any sense. Why haven't you simply added "none" to the
sched_allowed array instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
