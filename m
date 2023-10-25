Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9747C25B6B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 22:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CF9D3CF8FD
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 00:31:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 213F43CEC3C
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:31:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60BB220090D
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:31:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 363CD1F74A;
 Wed, 25 Oct 2023 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698273083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkPu+mubOMV1EQOoITsnPn1VbM5lwxvobKoO5880tLA=;
 b=cNnXA6AimrQZXzyxGiYUoeftwLgToyg8a48p0aPg0LnvGvLgacJgS8Zqe2SVFYlqCyryt2
 us2tttpbZQfjuZfnnbi8zXBXtTm0dwplhDwsZGGEfmKtHfyO5YkHJO8lMk14v5HnrAqQ3o
 tENyeNi/wYhwqzwMmM2C/YKIw/q9h74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698273083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkPu+mubOMV1EQOoITsnPn1VbM5lwxvobKoO5880tLA=;
 b=6zAmiLElhSNfw9p2g9NP1bkuXoawnEJhsexluraCklQUeZiSAI2S+WzJM5r5OpDS91p33X
 pTAe5CAQObR6KpAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B25413524;
 Wed, 25 Oct 2023 22:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xCW7ADuXOWX2RgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 22:31:23 +0000
Date: Thu, 26 Oct 2023 00:31:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231025223121.GH477570@pevik>
References: <20231025110835.28832-1-mkittler@suse.de>
 <20231025110835.28832-3-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231025110835.28832-3-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] Make checks for termio flags more strict
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

Hi Marius,

...
> -	if (!
> -	    (termio.c_lflag
> -	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
> +	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
> +		 | NOFLSH)) {
Shouldn't this be using & ~() ?

	if ((termio.c_lflag & ~(ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {

Also the other two.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
