Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D9DC021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:35:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADC8E3C9C25
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 15:35:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C50693C0229
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 15:35:35 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5C71141555B
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 15:35:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B82E721172;
 Mon, 17 Feb 2025 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739802933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
 b=p5J/3NL4KxRExSu5gXw9fY5EhB69r+6uyAOv3qQe7EDPjk5ydAymqLhW8jf+zgtGff56DO
 t6YzJFn9m6cpK5jy8kabAr3G4Km7YuSasLy5CmbHOm0fADon/2UumYW9BXznOgh9m772ns
 c3X+QapQgRIqhJNbkIX78dNmbZAZdNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739802933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
 b=iDW3cZzdBu3Ru0iJRxUyyiGtoGckCIsWvzLX1NsvMQ3aK7PM1XSv3snufF2HFfBstFsFMl
 SOdaXooVmDz9tLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739802932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
 b=WVpaqwGuBuD3c0X65i7vW7Kd14WqlbO+OIXCdXwjCFTsOYO2uASdUyKGOUmEVkIhYKY31j
 RU3rX1zsoGzwH+s/qH+fIfyKR4WUURcfl3I5urgydfzm4JgzGEw6iaZz26s2faFMtxqL62
 KDXy3XyOOIlUYNbaavG9eEfWFq4RHJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739802932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
 b=yL5TndytC1khoRo/jPtRiT8GsVKSJu46g2k5sbvYs2Yiq8hQxcGWG2Oe6O7Qc1l53QhnQJ
 3EAn/t7s46iaBPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972E6133F9;
 Mon, 17 Feb 2025 14:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CjBmIzRJs2eBJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 14:35:32 +0000
Date: Mon, 17 Feb 2025 15:35:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250217143526.GA2402962@pevik>
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <f8d6c3fd-7b1d-4d16-b034-a2b01f956870@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8d6c3fd-7b1d-4d16-b034-a2b01f956870@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_security.sh: Fix SELinux detection
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!

Thanks for your review, merged as a needed fix.

Kind regards,
Petr

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

> On 2/17/25 14:08, Petr Vorel wrote:
> > Some SLES15 versions create /selinux directory which fails the detection
> > if SELinux is actually not enabled. Therefore detect if directory
> > actually contains the 'enforce' file.

> > Also drop /selinux directory detection and detect only /sys/fs/selinux,
> > /sys/fs/selinux mount point was added in kernel 3.0 in commit
> > 7a627e3b9a2b ("SELINUX: add /sys/fs/selinux mount point to put selinuxfs")
> > 14 years is enough, kernel 3.0 is not even supported in current LTP and
> > we don't even support /selinux in C API (tst_security.c).

> > Fixes: e7b804df65 ("shell: Add tst_security.sh helper")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/lib/tst_security.sh | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)

> > diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
> > index 05640234ea..356c28fc73 100644
> > --- a/testcases/lib/tst_security.sh
> > +++ b/testcases/lib/tst_security.sh
> > @@ -127,8 +127,7 @@ tst_get_selinux_dir()
> >   {
> >   	local dir="/sys/fs/selinux"
> > -	[ -d "$dir" ] || dir="/selinux"
> > -	[ -d "$dir" ] && echo "$dir"
> > +	[ -f "$dir/enforce" ] && echo "$dir"
> >   }
> >   # Get SELinux enforce file path

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
