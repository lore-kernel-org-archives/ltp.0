Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F9EC77B75
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 04:58:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058733CB2E3
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 06:58:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 853513CB2E3
 for <ltp@lists.linux.it>; Tue, 16 May 2023 06:58:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 312B210006B6
 for <ltp@lists.linux.it>; Tue, 16 May 2023 06:58:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B9FF21B51;
 Tue, 16 May 2023 04:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684213085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0StiBzp/FkCFRK3ibDwlkFBrsmIgnbnk8Jj33/k2vXI=;
 b=IuE/omnnGNOatl1jCE/E7T7U/fLDDgu77CPKwqeFnKtvxyk1SiWcrpKS6rH7rZDLVGhQaM
 xtBCT91Ogrw0j7G7mmJowuyVFBPHFAMzMlykSjUupDn27Gc4q7WqP3ReJ9XA7ZRFtgnPPI
 eezirHTMVuiMoBokYsyaepODNQ30SUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684213085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0StiBzp/FkCFRK3ibDwlkFBrsmIgnbnk8Jj33/k2vXI=;
 b=FyYsdTNG5SVJKPCppvj0f90rj3ZwGIk26yrixr1bqjFAcsMqQfNeQb4Rj+Uk2rcE759WxX
 8F6nIvFCd9kS8mAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C82BB138F5;
 Tue, 16 May 2023 04:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rFXJL1wNY2TsTQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 May 2023 04:58:04 +0000
Date: Tue, 16 May 2023 06:58:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230516045803.GA4238@pevik>
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
 <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
 <ZFoSZkkjVXQhdEpe@yuki>
 <CAEemH2fycnWnsMe7sKZn357zj5QZr_Y7+ML0GAAWeQGkASu47g@mail.gmail.com>
 <20230510130347.GA225439@pevik> <ZGIwYcx1sPGbL6eY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZGIwYcx1sPGbL6eY@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > I'll can do, what I did previously:
> > 	- new release commit and tag and create release in github from it
> >     - uploading tarballs
> > 	- release notes for shell API (mostly network shell API)

> > It'd be big help if Cyril managed to do release notes and the announcement.

> I'm ready at my side. Peter can you please proceed with tagging the git
> and tarball upload?

Sure, I'm about to do it now.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
