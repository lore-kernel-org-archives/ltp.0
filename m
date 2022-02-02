Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E291C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 14:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510403C98B7
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 15:22:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 886603C8DAA
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 15:22:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D22D91400DA0
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 15:22:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A680721128;
 Wed,  2 Feb 2022 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643811754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFKOPJuk1IdAkljF/XJSg7G3dUqJ+jpAmQxaqluSBbU=;
 b=AHn7yIdqtPhrxDRq1quEFqpeyTe5jFmr+L60G7vrf005InBjW7ZIR5Cmoeb8sm+G8p+b3p
 8rJvjhRjss2fujZyaY7nvdc6NsJdnI9SyuuA41jn/PEU+T8vo+mJ36KnwNmdeKQZPiE5bO
 +xhCfm3fFYkgtHfG6ZAXuXtEMnaQRms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643811754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFKOPJuk1IdAkljF/XJSg7G3dUqJ+jpAmQxaqluSBbU=;
 b=UUWSIi2XPje1hcJ2iZr0oQicYBTvjlf0eUnSx/n3fl9kPRuhEUUDeWiqk8ji01vqvA3NLX
 IxVwyP37RTlaWIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D86E13BBC;
 Wed,  2 Feb 2022 14:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RRI9FaqT+mHiaAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 14:22:34 +0000
Date: Wed, 2 Feb 2022 15:22:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YfqTqAjEPalXzOK7@pevik>
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> On Mon, Jan 10, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > v5.16 released => patchset merged.
> > Thanks!


> Guys,

> Looks like we have a regression.
> With kernel v5.17-rc1, test fanotify22 blocks on the first test case,
> because the expected ECORRUPTED event on remount,abort is never received.
> The multiple error test cases also fail for the same reason.

> Gabriel,

> Are you aware of any ext4 change that could explain this regression?

> In any case, Petr, I suggest adding a short timeout to the test
> instead of the default 5min.
> Test takes less than 1 second on my VM on v5.16, so...
We usually don't lower the default timeout, but here it's a good idea since here
it blocks. It's similar speed on my machine, but I'd be conservative and put
timeout 10 sec. Sending patch.

Kind regards,
Petr


> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
