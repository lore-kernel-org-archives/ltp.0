Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2828606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eIS7pyp2;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=42fdJEIY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wVn+jgMR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+9InmsnW
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC9103D26C5
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:05:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCCF33D2411
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:04:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5525E600666
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:04:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6DB61F397;
 Thu, 22 Oct 2026 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792674289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8CoDTjr7/osXQrjDFQ6RZ4K+TFsz0rkaDNhFrqsubYE=;
 b=eIS7pyp2tPM3Uq/Fa0oLxSpXBMUxrckTevJXIOeDDOzx4WCgvdVVYqkPT/YbOnM0Zbie18
 Q4oZ8QZDgCkIZIElge0pHBKOkvLDORQeJDLMOI4bEN4WbUcv2pDI6gTNxouAZ6GMPjH8eN
 BN2DG0Nkb1n8C08bNwllbu7r3hgNj0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792674289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8CoDTjr7/osXQrjDFQ6RZ4K+TFsz0rkaDNhFrqsubYE=;
 b=42fdJEIYrG6Gxv9y5kmXrD3XLydAhlccm9o/xDKQJKlkh8Ud+9iVoawqqvPJo3UDOlvP7z
 bZj9qRRwpyqAUBBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792674288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8CoDTjr7/osXQrjDFQ6RZ4K+TFsz0rkaDNhFrqsubYE=;
 b=wVn+jgMRARfb8JgwmkG5MqtUp7sypLhraG6xr/gn6YVsZFoWSFXrpv8B824Zj/RYFpQdRQ
 qw3kOEG7x3nm2HMJlGTbPppDojrDwKOA6x2Hg0jQYIjVj6nlM7ykuBXf+e79qWC+C+v1Gs
 F8Uv5dQbzyK1+HN6biE7InzgwbO+LGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792674288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8CoDTjr7/osXQrjDFQ6RZ4K+TFsz0rkaDNhFrqsubYE=;
 b=+9InmsnWyn0hEE68KyNlEnY7FdHUNNGGG8qqIe9D21LMJ1pCg2yuTLu/OGfHJ8MAhjlw8F
 C3nuYd9kc7HcQEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75B79134E6;
 Thu, 22 Oct 2026 13:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /hrkEvAJ2mqxUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Oct 2026 13:04:48 +0000
Date: Thu, 22 Oct 2026 15:05:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <atoJ_ZxkVYBtuffj@yuki.lan>
References: <20261021084933.19097-1-wegao@suse.com>
 <20261021133446.9440-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021133446.9440-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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
> > +	if (dev1[0])
> > +		tst_detach_device(dev1);
> > +
> > +	if (dev2[0])
> > +		tst_detach_device(dev2);
> 
> High severity: If another process claims a loop device between
> tst_find_free_loopdev() and LOOP_SET_FD, attachment fails with EBUSY but
> leaves dev1/dev2 populated, so tst_brk() runs this cleanup against the other
> process's device. Track attachment ownership, including partial-attachment
> failures, and detach only associations created by this test.

This should be probably solved in the test library, we would need a
tst_attach_loopdev() function that would retry the lookup for a free
device on EBUSY.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
