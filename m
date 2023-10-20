Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEB4C001DF
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 14:44:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98BD83CEED2
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 16:44:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A57983CD029
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 16:43:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 99C4B1BB9FC8
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 16:43:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73B691F750;
 Fri, 20 Oct 2023 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697813028;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4zBQ6WeLkLJiMv6w0wZAkMILs0z3sDWWp5yW60ryUE=;
 b=X3EaOqasD0a7Yiy3QqC6l24gN65vhF/J1n64rhNsPbQIE8j+Rpm3ptmIVi+BGgJmM8QGrR
 jzdkcc7leObaKnrSVyV40ZZi4PSRSUKfz+at0UF7lqVRoaFuwNeOpyr/5lyksN5fKCEA7c
 g2vWADmYbvk44eajnzvDmPBbb+/NzLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697813028;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4zBQ6WeLkLJiMv6w0wZAkMILs0z3sDWWp5yW60ryUE=;
 b=+w22NvTdxG4pBzbPT7M0rcr/Jn2zYu+znLLoRmMauhTJnDraipt6gYURptYRg32pm2F2+W
 xlz3fEPrXr66DbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C43D138E2;
 Fri, 20 Oct 2023 14:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rNnJCCSSMmV7TgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 Oct 2023 14:43:48 +0000
Date: Fri, 20 Oct 2023 16:43:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20231020144346.GA8789@pevik>
References: <20231020110918.26066-1-pvorel@suse.cz>
 <20231020110918.26066-2-pvorel@suse.cz>
 <ca93e490-bd8e-3ecc-9426-9637bb9a6c6b@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ca93e490-bd8e-3ecc-9426-9637bb9a6c6b@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.26 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.96)[99.82%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setsockopt10: Use lapi/{socket,
 tcp}.h to fix compilation
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI Martin,
> Hi,
> I've checked that setsockopt10 will compile on SLE-15SP1. For both patches:

thanks for testing. So we now have covered distros based with 4.12 and 5.3
kernels and glibc 2.26.

Merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
