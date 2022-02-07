Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A90C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:29:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CC023C9B37
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:29:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B07F3C06E5
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:29:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB0C0600058
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:29:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7D6D210FB;
 Mon,  7 Feb 2022 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644233354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpRgfBQZ9FpxsPhpxWPlG2JISkdnQqQ0zPEYQyAVyVM=;
 b=VQJcPXiBQy0Z6mJbv85UBkZ7Cq3x2CSt45U1Px5lwpNwUaVIFqexPpYHoKUB8Q6aHOUzt3
 7zkYkOT6V+RJ3ZLF0p/LNozMfzho+KK3a+R+Z+es6DpkSTsSTpw1W2s/oYP9pUTBFMxVPC
 PHmbjdh7WOrTthZ9jelTdNQdAchomhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644233354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpRgfBQZ9FpxsPhpxWPlG2JISkdnQqQ0zPEYQyAVyVM=;
 b=Ly2S93km5WoCeApRvwdRY4ewHH0DrHKrFfnRMQDvur0FHk2xyY/zoXDXyfitFHSyY3wdGY
 hJ2SSdRl4Fep20Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5FBD13B9F;
 Mon,  7 Feb 2022 11:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zxg6M4oCAWJgXwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Feb 2022 11:29:14 +0000
Date: Mon, 7 Feb 2022 12:31:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgEDBRSBEUMK3dEF@yuki>
References: <61F36C39.9030806@fujitsu.com>
 <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
 <YgEB9/BvNhgIAl2n@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgEB9/BvNhgIAl2n@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx09: Add new test
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
Cc: xuyang2018.jy@cn.fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static void run(unsigned int i)
> > +{
> > +	tcases[i].tfunc();
> > +}
> OT: we may lack something in the API, when function like this need to be
> defined.

See:

https://lists.linux.it/pipermail/ltp/2017-October/005829.html
https://lists.linux.it/pipermail/ltp/2017-July/005132.html

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
