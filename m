Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D78EB64D9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 19:42:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FC8F3CE146
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 21:42:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC71D3CC739
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 21:42:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0FED31A007E9
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 21:42:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E01AE2183F;
 Thu, 29 Jun 2023 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688067752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1O9yXE4yZybQBwVywgiwqLloX2XrNRfa5AiKkb5E2E=;
 b=kN6CKNO0Br5xsNEnB9in/27E5Vx26BeEE6rm+/6DJ8eqOrWUEzmjgBNs4zI0sE9uVf1QIg
 1B73lEINE04a1htUWekWCWYmXKSvf06Ns7jPIWjlu54NBd2ie49LnXtbAtuTmTon1WVP12
 PoHaFxEqwe5EIcSltclEV9otqdpaeBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688067752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1O9yXE4yZybQBwVywgiwqLloX2XrNRfa5AiKkb5E2E=;
 b=4Vf+TpD6FPb1a1J+d0GzOvkgbEpYR8RL11A+TUzrXD2gz6FziLinIPRSw2fieATtMHGwGn
 lS85z70kD/wDFsCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76F3713905;
 Thu, 29 Jun 2023 19:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 386IG6jenWR3KgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jun 2023 19:42:32 +0000
Date: Thu, 29 Jun 2023 21:42:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Randolph Lin <randolph@andestech.com>, minachou@andestech.com,
 tim609@andestech.com, kester.tw@gmail.com, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20230629194229.GA240654@pevik>
References: <20230627105334.2358121-1-randolph@andestech.com>
 <20230627125704.GA36835@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627125704.GA36835@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl04: Allow __NR_waitid in the
 syscall filter
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Randolph, all,

thanks, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
