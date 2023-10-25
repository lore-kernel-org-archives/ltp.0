Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB9DC0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:51:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 873103CEC4F
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:51:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35823C8209
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:51:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 204F91A0C241
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:51:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EF2921D8C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698227480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI1HkaKngqReylLVufv32W8Qghs2NXSYaPDqWhfcAJI=;
 b=lwJhW12LhxSHx3mA11snkSnFn9zw6sCc7jzG3LXqDBIG6HaW/SfiST1hpOp9a0jmcyOmPH
 93miJXSgFYOXDajFrCEJzKG7kh8c226Yq8CFdi4cqyjs1xgLsl8Qw9NoOrEdQm3mQl0YRG
 tgoetokY50jl8RiShJbbTMkNOumY3OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698227480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI1HkaKngqReylLVufv32W8Qghs2NXSYaPDqWhfcAJI=;
 b=38BbwXgt26HGA9xfaSDc/XfS9CxPqVzfqxFUnwQ5B4Wzmr+kLCyKQXXaBMZ8L/u3M3Qa1m
 6zuqOny0E4mEVrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CF9D138E9
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9tPUCRjlOGXqKAAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:51:20 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 11:51:19 +0200
Message-ID: <4534034.LvFx2qVVIh@linux-9lzf>
In-Reply-To: <bddbae90-13a5-0947-a55a-089de6530d99@suse.cz>
References: <20231023160242.3605-1-mkittler@suse.de>
 <20231023160242.3605-6-mkittler@suse.de>
 <bddbae90-13a5-0947-a55a-089de6530d99@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.15 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.05)[59.98%];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]; CTE_CASE(0.50)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 5/5] Extend ioctl02 to test termio and termios
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Dienstag, 24. Oktober 2023, 17:54:27 CEST schrieb Martin Doucha:

> You don't need to duplicate the whole prepare_termio() function. You can
> either initialize both structures at once:
> termio.c_line = termios.c_line = 0;
> termio.c_cflag = termios.c_cflag = ...;

That's not possible with all the assignments because the variables have 
different types (e.g. unsigned short vs. unsigned int). These different types 
are the reason why there are different structs in the first place. (Of course it 
would technically be possible but introducing implicit conversions and relying 
on these conversions not being too lossy is a bad idea in my opinion.)

> of #define an init macro:
> #define TERM_INIT_VALUES { .c_line = 0, .c_cflag = ... }
> termio = (struct termio)TERM_INIT_VALUES;
> termios = (struct termios)TERM_INIT_VALUES;
> 

That is rather ugly but likely the way to go then. And I assume I'd call this 
"combined" prepare function during the setup then.

> Some code duplication is unavoidable here but the value validation can
> be simplified:
> 
> 1) Add another pair of termio+termios variables which will be
> initialized in setup() and passed only to SAFE_IOCTL(TCSETA/TCSETS).
> 
> 2) memset() the existing termio+termios variables before passing them to
> SAFE_IOCTL(TCGETA/TCGETS). As is, the test can pass even if
> TCGETA/TCGETS does nothing because they store data into a structure that
> already contains the exact same values.
> 
> 3) Define a macro to compare the "set" and "get" variables:
> #define CMP_ATTR(tcexp, tcval, attr) \
> 	if ((tcval).attr != (tcexp).attr) { \
> 		tst_res(TINFO, #attr " has incorrect value %o", \
> 			 (tcval).attr); \
> 		flag++; \
> 	}
> 
> Then all attribtute checks except the loop can be reduced to one line.
> 

I guess that is the least ugly way to use macros, indeed. (Supposedly better 
than just wrapping the whole function body into a macro.)





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
