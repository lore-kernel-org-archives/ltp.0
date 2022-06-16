Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D771DC43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 16:57:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C34B3C72FC
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 18:57:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED5DF3C282E
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 18:57:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0E53E200D10
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 18:57:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 349F21F8BB;
 Thu, 16 Jun 2022 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655398643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0psA3XmKSFX/VhOLvnZ/OzGBsnbXUFG+3g8fmorZYc=;
 b=U2VOfwp5oZaoxHmZ5UrgOLn7rLesx3+s2JWBRXDVNleW87bbJWRFiRJKI4I3k1O1OxBUaJ
 CVmudtwxXM1EC3StG+8d2VT6WkxGsf06NRjows1nmhrjHh0+gzlviMlKvKSHNFTxT8vKP/
 ISatjwrPvfOqUtm8KM9EwZ7p+TwpLsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655398643;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0psA3XmKSFX/VhOLvnZ/OzGBsnbXUFG+3g8fmorZYc=;
 b=Q/GJm2LvHq86EgbO1NxqZXvMjMja9+uwDPoFK7VxJgKndineE9ifr1ZCZghuQdXx/yuhXD
 w72c7S3S258HNdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F16211344E;
 Thu, 16 Jun 2022 16:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id niU2OfJgq2JxYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 16:57:22 +0000
Date: Thu, 16 Jun 2022 18:57:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Yqtg8aDdaHMpSKm0@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-4-amir73il@gmail.com>
 <20220614102609.matiab5wmhc43nm4@quack3.lan>
 <CAOQ4uxitmPwwGHiAonZjyqJKG=+SvzraGG9ot1=a2iNrcscAAQ@mail.gmail.com>
 <YqswlUo82GnEzEnE@pevik>
 <CAOQ4uxhOitNbnQVCx0RdEh2ne6wMnFD-UEc=+QHpGn_7Xez81w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhOitNbnQVCx0RdEh2ne6wMnFD-UEc=+QHpGn_7Xez81w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] syscalls/fanotify10: Watch directory that is
 not the mount path
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

...
> > Both ways work for me. Could you please rebase your LTP fork, do either of these
> > changes and ping me to pull?

> Done:
> https://github.com/amir73il/ltp/commits/fan_evictable

Thanks a lot, merged!

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
