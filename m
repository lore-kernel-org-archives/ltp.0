Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14617C433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 07:12:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2DBC3C9AA2
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 09:12:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26EC03C95F9
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 09:12:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BD19140074F
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 09:12:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02EF4210E5;
 Mon, 28 Mar 2022 07:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648451545;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7oK2wfjcCqsVk0j3UtbXUpA8vQ4MNNu9mtjIytZ7GY=;
 b=XllNhn8YrFtuA1zuL7jY3q//0oScgn0oB+AeHlTF4xWEN/d9NlW6GWXqrlmUgzivrvvycf
 Hn6A9n66ZoQuyAPitmJIO/rqpoYfd3x9C9cX9M1gp11874CSOG7lbzOYStDrUCWrmGltwo
 uy3GUZkmG6ALN14QNfGC7NjgTLZFKqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648451545;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7oK2wfjcCqsVk0j3UtbXUpA8vQ4MNNu9mtjIytZ7GY=;
 b=HqTHLRynUbHL1zaFjgVc3jK6eTxvX9i5fH/stDiIKlM9Kc4X6LOK+x7EvV/yOQFUbinzdb
 Xxc93vCyP3oIdHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 435F013AFE;
 Mon, 28 Mar 2022 07:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VyJTDthfQWKybAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Mar 2022 07:12:24 +0000
Date: Mon, 28 Mar 2022 09:12:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YkFf1kADD405PRdW@pevik>
References: <1648243376-5306-1-git-send-email-daisl.fnst@fujitsu.com>
 <Yj2WSuxQ583m3uQG@pevik> <62414819.2010802@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62414819.2010802@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/umount2_02: remove useless TST_ERR
 assignment
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

> Hi Petr,Dai
> > Hi Dai,

> >> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> >> ---
> >>   testcases/kernel/syscalls/umount2/umount2_02.c | 1 -
> >>   1 file changed, 1 deletion(-)

> >> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
> >> index 4c3b30e..d1aed11 100644
> >> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
> >> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> >> @@ -69,7 +69,6 @@ static int umount2_retry(const char *target, int flags)
> >>   	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
> >>   		target, flags);

> >> -	TST_ERR = EBUSY;

> > Not sure if the for loop in umount2_retry() could overwrite the original errno.
> IMO,  in this wrapper, we don't need to use TEST macro and we can use 
> umount2 directly.

+1

Kind regards,
Petr

> Best Regards
> Yang Xu

> > Kind regards,
> > Petr

> >>   	return -1;
> >>   }


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
