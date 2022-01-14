Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419D8C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:21:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44E583C9535
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:21:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD76B3C58A8
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:21:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63D6A600E2E
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:21:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69693219A6;
 Fri, 14 Jan 2022 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642170100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zt1vFHsK2F8eKVO1QcxDYlb6fTT15iGQuZmLpGoPeE=;
 b=lWE1NWTjNCPcxSytoh/VOewXhsFSYBEP6TOYREFZTWczOUP5cMlJLBFKIe9VC9Uz26AsrL
 y3p8TYt2V+5qnKPQxG2/u9y8ZUIlcJvzT1+SqlFCnjj5JOJRfwsGqr6WsGobX93Qqm4A/N
 60mTMHMfDQv7RCSK8pja1o3tE4isiBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642170100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zt1vFHsK2F8eKVO1QcxDYlb6fTT15iGQuZmLpGoPeE=;
 b=uL6xeOMX9+AVmWt0HSUjd12wXB7nu/tYZFdENAMCOMQv0sqKZ7Aar9mzsrWNwaRwAK6Pot
 GsLwgjH3FEAIv7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5636E13B7F;
 Fri, 14 Jan 2022 14:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2q22E/SG4WE1LgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 14 Jan 2022 14:21:40 +0000
Date: Fri, 14 Jan 2022 15:23:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YeGHV+Gnmo59SXeL@yuki>
References: <20220114125513.895-1-pvorel@suse.cz> <YeGEunEuwPvNFxyS@yuki>
 <95394feb-6474-d1ca-13d8-3d1c35e781b9@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95394feb-6474-d1ca-13d8-3d1c35e781b9@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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
> >> Previously with --disable-metadata output didn't mention that metadata
> >> are disabled and printed config which was not used. Now:
> >>
> >> $ ./configure --disable-metadata
> > 
> > Slightly off topic, should we rename this to --disable-docparse or
> > --disable-autodoc?
> > 
> > Since we split the metadata generator from the documentation and the
> > metadata are now genereated unconditionally...
> > 
> 
> I would love that and I would reintroduce disable-metadata in that case,
> to completely disable it.
> The question is: Will this break some builds because of semantic changes?

The JSON metadata file is going to replace the runtest files some day,
at least that is the longterm plan. Also the parser that extracts the
metadata from the sources is rather fast, compared to the LTP build and
it's self contained. There is really no reason to have a switch to
disable the metadat extraction step.

The documentation build, on the other hand, is rather slow and requires
asciidoc, which is the reason why there is a switch that can be used to
disable that. The only problem here is that the name is a bit confusing
now.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
