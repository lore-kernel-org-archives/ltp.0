Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DB9C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 12:55:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30D293CC001
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 13:55:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BBB13C1D84
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 13:55:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2525F1A0071A
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 13:55:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6397E1FD89;
 Thu, 16 Feb 2023 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676552102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPjXsu33mgQC24xhf1XgYg+Sgq6yGSH7lfH5ySv0sy4=;
 b=I6wAwRmbyePLZJZz4fZiGRa3bV4UqFOA/mLpIvVUYXJRdIASuZfJLM5w/0RXDzgpzFOMb9
 2pRXVATKF0tsssDr2UTWUvBFAAVmLCxZ8oKgY9pngkAEx9PsD3lUZ75UNJq+W2+iEt5+hh
 Y1k8XIvvAF/fUYyTy6Llxbjd3QBsObw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D41D813438;
 Thu, 16 Feb 2023 12:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s9EFKKQn7mPsTQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 16 Feb 2023 12:55:00 +0000
Date: Thu, 16 Feb 2023 07:54:57 -0500
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230216125457.GA31870@localhost>
References: <20230209131902.12260-1-wegao@suse.com>
 <20230213010924.12352-1-wegao@suse.com> <87a61go5ro.fsf@suse.de>
 <20230216094235.GA29664@localhost> <87h6vlregu.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h6vlregu.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig03: New test CVE-2022-0185
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 16, 2023 at 12:09:20PM +0000, Richard Palethorpe wrote:
> Hello,
> 
> >> We need to close and reopen the FD inside run() otherwise the test fails
> >> on BTRFS with -i2 because we have already filled the buffer.
> > Thanks for your feedback, i have some quesiton on this comments:
> > The error will happen when buffer is full filled on btrfs(means buffer len > pagesize), this is normal 
> > and current logic verfiy this logic for btrfs.
> 
> I'm not sure you understand what "-i2" means. The run() function can be
> called multiple times in a loop. If you do ./fsconfig03 -i2 then you
> will see the test fails.

Yes, i do not understand "-i2" before but i know this now : ) 
I will update and will send new patch soon!

> 
> That's because it executes run() twice and the second time
> TST_EXP_PASS_SILENT fails.
> 
> > Are you mean we need create another fd and continue do fsconfig on new fd once first fsconfig fails happen ? Correct 
> > me if i have misunderstanding.
> 
> This would also work.
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
