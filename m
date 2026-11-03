Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72BA606A324
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UWvPJT9O;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=R3huakXO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UWvPJT9O;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=R3huakXO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0972E3CA39C
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 21:03:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C52B63C9C3D
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 21:03:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2BDEC1400046
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 21:03:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39EEC1F83B;
 Tue,  3 Nov 2026 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793736220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpqYyFtoJu+lVtUxCPpI0Ah4c/W6+OoNo9yjwGauai0=;
 b=UWvPJT9ON+w3jt2SNCOfwIFGNSmxmWe1ZbTWAh1wl7Z8uqxaJZV3ODo5YuwzgnQ89dXiDH
 BMAelaogZaXeZEKiHh8y7Wb1o6Xe90Dx3wlL0X1J1rZUEt3B5LAIep3jL4joB9dcYcpUzB
 +NczhnjXRbiCPM3Q+os65gmxtJoiBRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793736220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpqYyFtoJu+lVtUxCPpI0Ah4c/W6+OoNo9yjwGauai0=;
 b=R3huakXOFxfBAPkMKpKofzDXu8ISg6ohjj3jN2ctzYCM25e3Gnx4VAjHpaIhK0s2OvbFJ9
 fGWzi/b6xFZIhBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793736220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpqYyFtoJu+lVtUxCPpI0Ah4c/W6+OoNo9yjwGauai0=;
 b=UWvPJT9ON+w3jt2SNCOfwIFGNSmxmWe1ZbTWAh1wl7Z8uqxaJZV3ODo5YuwzgnQ89dXiDH
 BMAelaogZaXeZEKiHh8y7Wb1o6Xe90Dx3wlL0X1J1rZUEt3B5LAIep3jL4joB9dcYcpUzB
 +NczhnjXRbiCPM3Q+os65gmxtJoiBRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793736220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpqYyFtoJu+lVtUxCPpI0Ah4c/W6+OoNo9yjwGauai0=;
 b=R3huakXOFxfBAPkMKpKofzDXu8ISg6ohjj3jN2ctzYCM25e3Gnx4VAjHpaIhK0s2OvbFJ9
 fGWzi/b6xFZIhBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BB3A134B8;
 Tue,  3 Nov 2026 20:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /I2sGRs+6mrtXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Nov 2026 20:03:39 +0000
Date: Tue, 3 Nov 2026 21:03:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20261103200333.GA154873@pevik>
References: <P5I00QE--F-9@tuta.io>
 <CAOQ4uxhZL5Vk1NQ+Q4MW1f9kRLD0wWvAHZp-c8UwaESpyq+c-A@mail.gmail.com>
 <auoPxzIaqjk7qUma@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <auoPxzIaqjk7qUma@yuki.lan>
X-Spam-Level: 
X-Spamd-Result: default: False [-16.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it,tuta.io];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -16.50
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Move from staging to syscalls
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Edvard Conrad <edvard@tuta.io>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > On the other hand, Petr, this is not a new feature, it is a real bug fix.
> > Are we holding off on running tests on newly found bugs
> > until those bugs are fixed upstream?

> I do not think that we need to hold off tests for bugs. The rule we have
> has been introduced since newly added kernel ABIs are subject to change
> in the rc phases.

Yes that's true, this is a different case. Anyway, if all distro users test with
LTP releases (they are using master branch), I'm ok to merge before fix is
merged and it's hash added to the test.

We are using LTP master branch for testing SLES in development and openSUSE
Tumbleweed, filtering these errors involves some work, but that's ok.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
