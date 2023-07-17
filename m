Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98929EB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 06:44:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C42D3CDDD8
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 08:44:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4763C999C
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 08:44:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 20A13600691
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 08:44:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBDE91F74C;
 Mon, 17 Jul 2023 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689576259;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elliSoHPO9IUYVJpSiCoE0GPbt81MfVETmWY6EHMQVY=;
 b=Q6YVxXD/pl1IVPbHfU8tTKHPwdp+jRWrz5UaWNBkFCRsFk9Ya05xlQyoP6Bz3RZoLif1Xu
 sIrWfEnR+BEpCVS9KRyFZfD0IJ631j866/f7hF3cr4CKzm5LPiNG6SCtcDy86sJGPu8QKG
 vhU0qG82kG1i7AqYLvA15msqcyPLtUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689576259;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elliSoHPO9IUYVJpSiCoE0GPbt81MfVETmWY6EHMQVY=;
 b=u4HangfwtsnkiPF7UoWXYOU9uZMU1Vd5k7wp6DFdeYCUISbbDUf488zVRWAMbWuEjPg6o7
 DTUNG55qafrY3CBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58088138F8;
 Mon, 17 Jul 2023 06:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uh6GD0PjtGRKcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jul 2023 06:44:19 +0000
Date: Mon, 17 Jul 2023 08:44:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230717064418.GD1083725@pevik>
References: <20230716053530.1629416-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230716053530.1629416-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] Tests for fanotify on anonymous pipe
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> Petr,

> This tests for a behavior that we consider broken since the dawn of
> fanotify.

> The fix was merged to v6.5-rc1.
> I've already posted backport patches for kernels > v5.0 [1].
> I am not planning to post backport patches for older kernels.

> Even though the two new test cases do not use FAN_REPORT_FID,
> fanotify14 requires FAN_REPORT_FID, so it is not going to run these
> test cases on kernel < v5.1 anyway.

> You suggested to wait for stable tree to apply the backports [2],
> but this seems to be taking time.  Since I am going on vacation next
> week, I am posting these tests, so you can merge them whenever you like.

I was probably too conservative, whole patchset merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
