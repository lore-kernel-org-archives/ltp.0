Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75669CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:23:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0DC03CDD37
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:23:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 272B63C100C
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:23:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 47DA2200CF5
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:23:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7517F21850;
 Mon, 25 Sep 2023 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695648181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9RNn8hF7F6VPwXigIGj6z8xZsu7diWX5PmBhMSBFkQ=;
 b=wRpHRo9g4ZU2geJADOIzEo/Urk1bAlnGxrThPTLnSeQyz/ubTz3+DZN5ndFTkT371JNzx+
 yaR9z8m0o3tQNFop6O85BCwB5B4qRbox+zcCMDH6Jr8M6guQiQFwNB6Rx0qhHanktVd85v
 UBr3h4IFvZJcexRWCvQOP6WLUUgyNRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695648181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9RNn8hF7F6VPwXigIGj6z8xZsu7diWX5PmBhMSBFkQ=;
 b=eSHZnoVbSGO/f+tKP1P/2RlNtsReAjlOTde+H7gIFMQl/u4x+oM3gurahBUfgxTvB+ZSDK
 +JHnNvQ/VUc4wYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F4DD13580;
 Mon, 25 Sep 2023 13:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9B5HDrWJEWU2DQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 13:23:01 +0000
Date: Mon, 25 Sep 2023 15:22:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230925132259.GC60471@pevik>
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-3-mdoucha@suse.cz> <ZQ2C_Ha_DNH_nx7q@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQ2C_Ha_DNH_nx7q@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] nfs03.sh: Wait for all files to be removed
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

I merged these two patches.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
