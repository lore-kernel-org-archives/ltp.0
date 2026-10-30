Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF86606A321
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KUvDtszE;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H6uvbYwl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WDiOceD1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eDnD2l1y
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A20A3E9971
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 17:38:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03743C0224
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 17:38:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 69A152002C3
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 17:38:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACD2D1F822;
 Fri, 30 Oct 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793378294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO5viXuOvoOyIFaPsPWUM9xgdY3OIBIxb4ugLXeBCrQ=;
 b=KUvDtszEFEUydWLkq0Y3HXVeClfaoeara6OfLL8YVBVJ/uTqismr0Jb1jaSkDkJ36h+OTk
 ab772yao25ssNErzKXZ65extizWEyRzhTCpHpY7FqCU06ofyVTasPUtGM4ywcL+oJgYdbY
 1Q9t3kIIUM7SIfrJKNq3pBS8VPfCBYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793378294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO5viXuOvoOyIFaPsPWUM9xgdY3OIBIxb4ugLXeBCrQ=;
 b=H6uvbYwlFEbU570wgEWa3mOXUIiBHBv9vLnXp81xx/RQyxGdKabXJmua20WKUajdOynBIZ
 /uD4mfvrsVKFm2Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793378293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO5viXuOvoOyIFaPsPWUM9xgdY3OIBIxb4ugLXeBCrQ=;
 b=WDiOceD1cYOf9nkVqmRYMUuWURn5iKevsbD8F7UJimK77iXswtFfWv4qg44z28JyfaLBWg
 3RiRDsipZFxjdgABijDuwh8dXAAtozCz+GP/AwcM6z+WLI/enHtS5AyApXhe6NiRhdOj3T
 gK/v1vwS9GiMJ0zMyMyeJMt3JZJ4hM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793378293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO5viXuOvoOyIFaPsPWUM9xgdY3OIBIxb4ugLXeBCrQ=;
 b=eDnD2l1y826KI8LQ7AU38G36LEwUzek/w7pymF09PLuzXoNXoJPlaHP44xhcr1Al106D5x
 5d/9DJ5Nyuk4EGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6187213625;
 Fri, 30 Oct 2026 16:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m1zDDfXH5GokIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 16:38:13 +0000
Date: Fri, 30 Oct 2026 17:38:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edvard Conrad <edvard@tuta.io>
Message-ID: <20261030163807.GA13673@pevik>
References: <P58XUlU--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <P58XUlU--F-9@tuta.io>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3][STAGING] syscalls/fanotify26: Add test for
 nested permission events
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
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI Edvard, Amir, Jan,

FYI merged. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
