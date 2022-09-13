Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B12C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:51:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF1E03CAB8E
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 12:51:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D6703CA6CB
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 12:51:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B28F81A008A2
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 12:51:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83A9634B9D;
 Tue, 13 Sep 2022 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663066288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCwr1+ROqByITka24Tmcrmqji+nr9PSB98M+vTwjssg=;
 b=cwsqca984Z466scOmToN7denDNSOykEAfx3kymC0RBt8kqPiC1shaavzVQm9sUtIVXipj7
 /MRpVKMZC1PPMxcpXzhgvhlAvjGam7p5+aJn7Q6C3v3V2TUWe9uaUc+dz/j7tYTa8aJDTp
 38DC6l/dTTAPekUB/i6fX9c8vH7rt2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663066288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCwr1+ROqByITka24Tmcrmqji+nr9PSB98M+vTwjssg=;
 b=3uiHsD0hl7lfNXBlsqdd2KDx1HT1m38NTOtpt8SY8SLHwkZk3SCwtw1R7Vd5ZIxmf4/y3w
 TR/BgK75t+4W8cDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71402139B3;
 Tue, 13 Sep 2022 10:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /5bgGrBgIGPSVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 13 Sep 2022 10:51:28 +0000
Date: Tue, 13 Sep 2022 12:53:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YyBhJI26oHNG7tUk@yuki>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-6-pvorel@suse.cz> <Yx9JPQimBEpXFa4+@yuki>
 <Yx+YtBZOKje6FbWS@pevik> <YyA763/Rx1Do8DHx@yuki>
 <YyBPBLi9l+q1KJXr@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyBPBLi9l+q1KJXr@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 05/10] tst_supported_fs: Support skip list when
 query single fs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Yes, as far as I can tell this commit implement function that is called
> > from the previous patch.
> I'm really slow on this. Which function do you mean please?
> 
> "[v5,05/10] tst_supported_fs: Support skip list when query single fs" implements
> just tst_fs_is_supported_skiplist() which is not used in "[v5,04/10]
> tst_supported_fs: Implement skip list".

My bad, I confused the tst_fs_is_suppored() and
tst_fs_is_supported_skiplist() yesterday.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
