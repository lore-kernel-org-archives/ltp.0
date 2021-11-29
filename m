Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB69C433F5
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 11:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B9E3C6355
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 12:53:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24E913C08C7
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 12:53:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 31DC2600C7D
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 12:53:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FA5D1FCA1;
 Mon, 29 Nov 2021 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638186799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfR39UMot+R+2t6Q+o7aewfNxk8aCsbra7GsSEswbJw=;
 b=sTOXsDCHMUswG+eSfjdWee2vo12ad2rCqIMTUMH5dP/F9UxMj7UIVVYQrqTDQC0pNB8wK+
 QDSmJOpPPkKMH7/0FaoulRp+wD/0R/Opqmi0hwF6sRpMNmPkWg4nmXVErUACgfYDSuE9z3
 nB/lUwXlS9W7Fs+ArkFeKaaFEGaPaU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638186799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfR39UMot+R+2t6Q+o7aewfNxk8aCsbra7GsSEswbJw=;
 b=jHWRxufvy/KzR3YJeGvioeuM5H1JunaHzpaDOZalh8ZFU1t4ZNWzz0UjRrclZQ+QCZOWGu
 t8vtt4KBhfv2BHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3708E13A86;
 Mon, 29 Nov 2021 11:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mciRDC+/pGFIIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 29 Nov 2021 11:53:19 +0000
Date: Mon, 29 Nov 2021 12:54:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YaS/dbbn3cRobeIp@yuki>
References: <YaS0F9/ZyPtZi5zE@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YaS0F9/ZyPtZi5zE@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Using shellcheck for shell make check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> checkbashisms does not detect all things: e.g. not catching {1..$FILE_COUNT}
> [1]. Maybe we should reconsider using *also* shellcheck as Joerg suggested
> (keep checkbashisms).
> 
> I don't like shellcheck output, but it can detects errors checkbashisms cannot
> detect (checkbashisms is regexp based, but shellcheck IMHO evaluates the code).
> Also it's configurable, thus ve could disable check we don't like or enable only
> what we want to check. Or we can run just --severity=warning or
> --severity=error. If you're not against it, I can have look into this.

Sounds good, the more automated checks we have the less we will spend on
review...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
