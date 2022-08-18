Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34078C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:28:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE98D3CA1B5
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 13:28:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E0A33CA155
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:28:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E5167100061F
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:28:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B60985BDFE;
 Thu, 18 Aug 2022 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660822109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52uM/uWZ0VDt/vom63V5uOWSqqnIVymzuJcqNwduUUM=;
 b=wH/pfHMcz3SdjBxU7xNRUJcP3u9UBAYOiSGUoqty0Yl7nIO2BKsmTJTf76fOHitcsHJp/h
 XMyukHYsPsZmd8vg3pUW7SKk3fptp/3ZmaKR+tRDBfQmUnVHVU4yipLyC8sLbbWphy1O9B
 u+aRxsbkSEOI8l2acq2bawZDaT1mvHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660822109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52uM/uWZ0VDt/vom63V5uOWSqqnIVymzuJcqNwduUUM=;
 b=BxUxoSzLImBa9WhqR9MUvGub1N+YrwQQcoPHdZwi6gO5wgqtqvplDUb9y3hQCpNQHAmNgl
 CWig8EJ1uwvyeoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D796139B7;
 Thu, 18 Aug 2022 11:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IGDwJV0i/mJILAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 18 Aug 2022 11:28:29 +0000
Date: Thu, 18 Aug 2022 13:30:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yv4i0gWiHTkfWB5m@yuki>
References: <20220817204015.31420-1-pvorel@suse.cz> <Yv4MBF79PnJKJbwm@yuki>
 <Yv4eiT5L+M7dMkQ5@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yv4eiT5L+M7dMkQ5@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] API: Allow to use xfs filesystems < 300 MB
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
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 automated-testing@yoctoproject.org, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I'm starting to wonder if we should start tracking minimal FS size per
> > filesystem since btrfs and xfs will likely to continue to grow and with
> > that we will end up disabling the whole fs related testing on embedded
> > boards with a little disk space. If we tracked that per filesystem we
> > would be able to skip a subset of filesystems when there is not enough
> > space. The downside is obviously that we would have to add a bit more
> > complexity to the test library.
> 
> Maybe I could for start rewrite v2 (I've sent it without Cc kernel devs now it's
> mainly LTP internal thing) as it just to have 300 MB for XFS and 256 MB for the
> rest. That would require to specify filesystem when acquiring device (NULL would
> be for the default filesystem), that's would be worth if embedded folks counter
> each MB. It'd be nice to hear from them.

The 256MB limit was set previously due to btrfs, I bet that we can
create smaller images for ext filesytems for example.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
