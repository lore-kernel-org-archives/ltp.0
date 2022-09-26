Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C6CC32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 09:56:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 394483CAE0E
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 11:56:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F362B3CADCF
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:56:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 424571400B8A
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:56:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96FD71FDC8;
 Mon, 26 Sep 2022 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664186190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hWyY0i58kCxwdD53l/V0sH907NibYNfGw4hNwMSkGjQ=;
 b=rDC+ag//16A2W2XTM6eB5Hg40SbvFR+9YD9YtmWlugIEXr+5H6W1XGdFSq6sTQCrv6OFMo
 LKwQvTZ1Sn+pg66L3ZI/v8OUpPt0v4nfnPFoiQNI4002gpsIOeMca2uZJhJuJuOkWdzFes
 FL3GoEdGDFP4NN880aZ2i2Ozt0H9B0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664186190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hWyY0i58kCxwdD53l/V0sH907NibYNfGw4hNwMSkGjQ=;
 b=t5GkVNVN5TVAEzgVOSGlghGFt208Xj48ygk+j3EY/mBn0bfdoEBbdmYpuaBn2r0diy50+z
 K0rK8jF8eKWPmDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A3F139BD;
 Mon, 26 Sep 2022 09:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6kpzH053MWORBgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 26 Sep 2022 09:56:30 +0000
Date: Mon, 26 Sep 2022 11:58:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YzF3wLk9cMTdU1z7@yuki>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Well, if more than three people are involved in the release work,
> I think that the release workflow should be arranged in time order,
> otherwise, we're easily going to fall into chaos. e.g.
> 
> Assumption work starting from the second week of the release month:
> 
> 1. Collecting the patch list for a new release, like this email does (Cyril)
> 
> 2. Reviewing and merging the patch list of step1 (All maintainers,
> LTP-users)
> 
> 3. Pre-release widely testing, we need to explicitly post results in step1
> email (Petr, Li Wang)
> 
> 4. Tiny fix according to pre-release testing result (All maintainers, users)
> 
> 5. Writing release note (Cyril)
> 
> 6. Uploading tarballs (Petr)
> 
> 7. Announcement email of LTP release (Cyril)

Lets move on with the plannig, I would say that we are done with step 2.
and we should move to step 3.

Also I would go for a release date at the end of the month that is 30.9.

Does everyone agree?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
