Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2199C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 08:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41B2B3C9176
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 09:52:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 953383C90E7
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 09:52:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E60EF600CFA
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 09:52:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE5A7212BF;
 Mon, 20 Dec 2021 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639990367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVWUK8B4cv2NIHZGVsm45Bbc8Knpqg/4V2ABEipHZmE=;
 b=WB+td85iGfTrpy6S6LCBZDOXkxCdEcxJapKniU7IFruZlRLJnKuziNbKf2Trp2GqCBTb/5
 WcmiC54UYMCVJ3Cd38M716+iFP1b7m+NbblrBzOqoM12iteWyP4B7bidkt4Vm6SlaruVqx
 SeozmkuGnAFk8ULXe3bQiowvC/nIzVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639990367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVWUK8B4cv2NIHZGVsm45Bbc8Knpqg/4V2ABEipHZmE=;
 b=7gPS5bW9bLA5n7pkL/bYpJXRzl2gxvciCBbRDtfA78Jg8h9n8OfKZkl2UKg5Q2on8sm7W5
 RmOdtPggmc6bm6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB5E313B6F;
 Mon, 20 Dec 2021 08:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9ofCL19EwGGZfwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 08:52:47 +0000
Date: Mon, 20 Dec 2021 09:52:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YcBEXr/jD5haFLLU@pevik>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbxAuBpxXtPXIwYO@pevik> <61BC59C5.9090708@fujitsu.com>
 <Ybxnxs5t5lDpNS4U@pevik> <61BFF174.4060403@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61BFF174.4060403@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
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

> Hi Petr
> > Hi Xu,

> >>>> If zram-generator package is installed and works, then we can not remove zram module
> >>>> because zram swap is being used. This case needs a clean zram environment, change this
> >>>> test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
> >>>> still can add zram device and remove them in cleanup.

> >>> BTW this was added in v4.2-rc1 (6 years ago, 6566d1a32bf7 ("zram: add dynamic
> >>> device add/remove functionality")). Hopefully anybody still supporting older
> >>> kernels is using old LTP for it.
> >> Oh, I don't realize it before. I tested it on centos7 then I think this
> >> control interface maybe introduced long time ago.

> >> To be honst, I don't want to make this case more complex. How about
> >> adding  /sys/class/zram-control check after load zram module. If not,
> >> just report  case needs to use hot_add/hot_remove interface .

> > Would it work something like this?
> I don't want to use kernel version check because the hot_add/hot_remove 
> interface is easy to backport. I will send a v5
> 1) new kernel and not load zram kernel module, then modprobe and rmmod 
> is enough, doesn't need to use hot_add/hot_remove
> 2) new kernel and load zram kernel module or built in kernel, use 
> hot_add/hot_remove
> 3) old kernel and can be modprobe and rmmod, work as 1)
> 4)old kernel but is being used or built in kernel, then skip this case 
> like patch v3 does
Sure, make sense (although you didn't avoid more complexity).
Thanks working on this!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
