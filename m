Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D91C38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:34:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C530D3CA8BB
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:34:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83A93CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:34:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B9A3014010FD
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:34:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ABEE20F55;
 Fri,  2 Sep 2022 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662111251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=073jVDqs2gJ4E9HOSKTpy5bvF6tAeS+6Yzr+o0bVxkE=;
 b=pBHJUglfUNAQRie5yQllMTGqCf9FZyUqN5w+KKIX+o+kwhVvcxT1+g3o20jFoFTZJI4EoN
 xBbFrbs98nQmwMLQ5+ZqshAw04qEgE/qok/QlPfdjfuxEwjItdWQsZm2MHhswWq7Z1Trut
 QTeqlZE8FBzLbjmw/4+FBYtGhUx6JPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662111251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=073jVDqs2gJ4E9HOSKTpy5bvF6tAeS+6Yzr+o0bVxkE=;
 b=rd6vXEe+B8RcFCoeCbtq98dNXbdFM9Cu+v+YGmNFUfHkwS6lhY4FtT552VuXWyG6lfNYoJ
 DsEFDEnB9+MYaMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CC9313328;
 Fri,  2 Sep 2022 09:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JKbbEBPOEWMiFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 09:34:11 +0000
Date: Fri, 2 Sep 2022 11:34:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YxHOEQwMwvhmq8Mh@pevik>
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-2-pvorel@suse.cz> <87bkry2kv8.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bkry2kv8.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/10] tst_test.sh: Fix tst_mkfs() for tmpfs
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
Cc: ltp@lists.linux.it, automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> Hello,

> No response and seems reasonable, please merge!

> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Thanks a lot for your review! I suppose you mean your ack for whole patchset.

If yes, I'll merge all but the last RFC commit which needs more work (i.e.
TST_ALL_FILESYSTEMS infrastructure although nothing uses it yet).

Merging would help me not having to rebase this work after finishing and get
merged "Track minimal size per filesystem" [1] (originally I thought that one
would go first, but TST_ALL_FILESYSTEMS infrastructure is ready now).

I also plan to convert df01.sh and mkfs01.sh to TST_ALL_FILESYSTEMS.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=315621


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
