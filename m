Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902B606A324
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qcJAU9bB;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VrIhH8fJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qcJAU9bB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VrIhH8fJ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0766F3EA8E9
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 13:56:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 269BE3C26A1
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:56:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 672C51000486
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:56:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F78F1FE8B;
 Fri, 27 Nov 2026 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795784166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FAMe0gWzM2RUQPW+qpPYcGhH/1vaxNa8szjEZaTvUik=;
 b=qcJAU9bBNJzb+UpvYS4dMReQRzpKy1hUTcL10QF/DovBAKMeLKYsxePqs3P4iCMDPbsb6g
 ET+th2fcnW9Yrk6nqg6IY5uv39ucxPoGALOEV/CNG4Ez8A1xhvc+ZupZX9o+vsc0zqpyvH
 dfQ5hIxbm4MEvFAwDsQ0vHErtuzBv/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795784166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FAMe0gWzM2RUQPW+qpPYcGhH/1vaxNa8szjEZaTvUik=;
 b=VrIhH8fJMksQu2AllJW1DBVlzLcIUUUHpSc2nikvf93jylS0fWGkQWuvodd8OAtpdo/QJy
 Tn2k13r5rLpJw5DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795784166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FAMe0gWzM2RUQPW+qpPYcGhH/1vaxNa8szjEZaTvUik=;
 b=qcJAU9bBNJzb+UpvYS4dMReQRzpKy1hUTcL10QF/DovBAKMeLKYsxePqs3P4iCMDPbsb6g
 ET+th2fcnW9Yrk6nqg6IY5uv39ucxPoGALOEV/CNG4Ez8A1xhvc+ZupZX9o+vsc0zqpyvH
 dfQ5hIxbm4MEvFAwDsQ0vHErtuzBv/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795784166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FAMe0gWzM2RUQPW+qpPYcGhH/1vaxNa8szjEZaTvUik=;
 b=VrIhH8fJMksQu2AllJW1DBVlzLcIUUUHpSc2nikvf93jylS0fWGkQWuvodd8OAtpdo/QJy
 Tn2k13r5rLpJw5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 406F2134E8;
 Fri, 27 Nov 2026 12:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8C6TB+Z9CWsncwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Nov 2026 12:56:06 +0000
Date: Fri, 27 Nov 2026 13:56:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.ibm.com>
Message-ID: <awl-Bmy1RCu3nbA8@yuki.lan>
References: <20261024023044.80055-1-samir@linux.ibm.com>
 <20261024023044.80055-3-samir@linux.ibm.com>
 <awl5wbt7yGBnRwnh@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <awl5wbt7yGBnRwnh@yuki.lan>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/4] sched/psi: Add psi_multiple_trigger01 test
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
> > +static struct tst_test test = {
> > +	.tcnt = ARRAY_SIZE(tests),
> > +	.test = run,
> > +	.setup = setup,
> > +	.needs_root = 1,
> > +	.caps = (struct tst_cap []) {
> > +		TST_CAP(TST_CAP_REQ, CAP_SYS_RESOURCE),
> > +		{}
> > +	},
> > +	.needs_kconfigs = (const char *const[]) {
> > +		"CONFIG_PSI=y",
> > +		NULL
> > +	},
> 
> Here as well .save_restore

Scratch that please, it's pretty clear from the code that the triggers
are per fd and destroyed on close()

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
