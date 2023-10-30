Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681C1C4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 11:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B96553CEABC
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 12:07:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 870B03C6D29
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:06:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B126F20090A
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:06:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BF9D21CFB;
 Mon, 30 Oct 2023 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698664010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4wIzsTF5w3+1KPzqtg+N57BEvPcJEH3xAZmj6tKybo=;
 b=qDE33NB200lkH6qxBOumaMz+FbjEoyasXE0ll9mGNaZOaAJHGTavG6Yk6ksXiWLnVs2/ue
 ryTgZOPi3SXrF14fHn0jZn2f8LXyBEA+fCYAA8FC7Rmuw1lMTYQZq7rHy9LflswMOF3cad
 ka8+4iBwFwcSk3UWVMUO6siH14FLjHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698664010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4wIzsTF5w3+1KPzqtg+N57BEvPcJEH3xAZmj6tKybo=;
 b=0kpPvF4PK+bfFjWX5fPwNSUrIWr3JiAFhggej42uYLiGx+C4ymOebbeZSBYLJ1uYTMDwhJ
 qRXH9e5oVyPcyoBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09900138EF;
 Mon, 30 Oct 2023 11:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KRCXAEqOP2VVQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 30 Oct 2023 11:06:50 +0000
Date: Mon, 30 Oct 2023 12:06:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231030110648.GA28443@pevik>
References: <20231027190029.3820505-1-edliaw@google.com>
 <20231030074045.GB9167@pevik> <ZT-AKQIX28-Dm63M@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZT-AKQIX28-Dm63M@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.24 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.94)[99.74%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getpgid01: On Android,
 pgid(1) is 0 instead of 1
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > +static int get_init_pgid()
> > static int get_init_pgid(void)

> > We still use -std=gnu99, thus we need that otherwise compiler complains
> > warning: old-style function definition [-Wold-style-definition].

> > It can be fixed during merge.

> With that fixed:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Great, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
