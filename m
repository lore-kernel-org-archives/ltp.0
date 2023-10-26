Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A55C25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 08:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDD233CEC0A
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 10:36:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CD663CBE79
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:35:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 699DF1000EC3
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:35:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADED621AA1;
 Thu, 26 Oct 2023 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698309353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHADUr98MBrW7zAP5i3EZMzcaIZM14Z5NToIZXDSJQo=;
 b=fj6zhc3SliVKJQa69vcJ+7r+RLDPUQqxlO1WaYgMldBdNShm3C8GXncyU/lsRrYFJMfAwa
 k9JPDt7Mny8G9Jkhnf7cAbe2KbWDNe377fC6fJsjsjDSzPkVSAU0S1ALG/7NfnYdByl567
 CHLHIVV9yBOAGPNkI1CA2pGr1GUaKeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698309353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHADUr98MBrW7zAP5i3EZMzcaIZM14Z5NToIZXDSJQo=;
 b=B7Ls4mzB3ULVEbl45SzHbYpRwrdltWdtsQvGpO9YEQaT643fK44l0r+AZRT/EacIt5Hn7d
 KJf9asOtFr54kRCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E9A4133F5;
 Thu, 26 Oct 2023 08:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FXCtIekkOmWvEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 08:35:53 +0000
Date: Thu, 26 Oct 2023 10:35:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: iob <ybonatakis@suse.com>
Message-ID: <20231026083552.GA577670@pevik>
References: <20231025110835.28832-1-mkittler@suse.de>
 <20231025110835.28832-5-mkittler@suse.de>
 <20231025221349.GD477570@pevik> <87lebpnb4v.fsf@>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lebpnb4v.fsf@>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.99)[99.94%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 4/4] Extend ioctl02 to test termio and termios
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> >> +#define CMP_ATTR(tcexp, tcval, attr) \
> >> +	do { \
> >> +		if ((tcval).attr != (tcexp).attr) { \
> >> +			tst_res(TINFO, #attr " has incorrect value %o", \
> >> +				(tcval).attr); \
> >> +			flag++; \
> >> +		} \
> >> +	} while (0)
> >> +
> >> +#define CECK_CONTROL_CHARS(tcval) \
> Was this meant to named as CHECK_CONTROL_CHARS?

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
