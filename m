Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A7DC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 08:57:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 104573CA110
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 09:57:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC8A93C9564
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 09:57:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5D2A51401750
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 09:57:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6371F383;
 Fri, 18 Feb 2022 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645174661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCDUV34WGgRtiy8fIQK5zwX5rquZrfxu50AW6OZQCy8=;
 b=Q/MYMcNVcjwdJ5DMAWu4A4H8BwWHiUIUXHwGwy8KcUrqNBDdUfy5eLWkUMiGIl3eq2pDgK
 /cijA0nz1BH3Thijj1eMpJQLxYREfchUJxwLi7OyUBltYyZzZ9KIm8Bj9FXRpUhFhtLmFz
 7mimcyvHTlMqtmKES0vrnzeW0Dm50eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645174661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCDUV34WGgRtiy8fIQK5zwX5rquZrfxu50AW6OZQCy8=;
 b=kUnzVMtpYKnQmy6BjQODhI5qHHRA+H6Lb/Ancz27YFPzpOoaYfsGUievD3Kz2g7DoH0w2f
 7rDqspTlBx2B6kCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4075813C34;
 Fri, 18 Feb 2022 08:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pwq2DYVfD2IwXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 08:57:41 +0000
Date: Fri, 18 Feb 2022 09:57:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg9fg4L26MRmbpny@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6f6p/rdFTfzkoR@pevik> <620F118E.3070306@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <620F118E.3070306@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> >> +	TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
> >> +	if (TST_RET != 0)
> >> +		tst_res(TFAIL, "pidfd_getfd() didn't get the same open file description");
> > Maybe just:
> >         TST_EXP_PASS_SILENT(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
> I think we can't use this macro here see below(kcmp manpage about return 
> value):
> 0 v1 is equal to v2; in other words, the two processes share the resource.

> 1   v1 is less than v2.

> 2   v1 is greater than v2.

> 3   v1 is not equal to v2, but ordering information is unavailable.

> On error, -1 is returned, and errno is set appropriately.

> So 1,2,3 are not invalid return value.
I'm sorry, you're right.

> TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
> if (TST_RET==-1) {
> 	tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
> 	goto free;
> } else {
> 	if (TST_RET < 0 || TST_RET > 3)
+1 (very nit: instead of if/else I'd use 2x if and (TST_RET < -1 || TST_RET > 3)
- readability).

Kind regards,
Petr

> 	tst_res(TFAIL, "kcmp invalid return value %ld", TST_RET);
> 	goto free;
> }

> free:
>   ....

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
