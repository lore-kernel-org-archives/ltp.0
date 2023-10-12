Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4BBCDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:29:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8C9E3CD439
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:29:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 408903C8B68
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:28:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D942100095E
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:28:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C132A1F74B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697102931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrS1D7JMy8b1RZC42zP0pugrd+QlKjN18LPIWTmfRGk=;
 b=fRcZmo1ITPQAIa+dW4BIEeVJOAqIYz2UtsorI96Fc1Sox/4YnC3MoAVEjDkz6DCmfrJmLi
 2tNmsUYjWKk1zAS358YD747t3LoMrtsnkC+0JOnGzH6QxOvjn9JHh7nywLWIy4+RWdNPu1
 YMTQE5WV/yh7+J2IuygFCUJxD6xxHl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697102931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrS1D7JMy8b1RZC42zP0pugrd+QlKjN18LPIWTmfRGk=;
 b=Nxu0l6w/xDg82gktxYmm7aT/ZLUi5y8Wz026sec3Gi5k0ZXC9KTL0hpu1XPEZbc3zPv/qK
 wEiKMNjccQeIYfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B32C9139ED
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 09:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZH7WKlO8J2WSbQAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 09:28:51 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 11:28:51 +0200
Message-ID: <4867816.31r3eYUQgx@linux-9lzf>
In-Reply-To: <20231011162428.583911-1-pvorel@suse.cz>
References: <20231011162428.583911-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] swapon01: Test on all filesystems, cleanup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I guess the code would work and looks generally good to merge. In fact, I 
tested `.all_filesystems = 1`  myself yesterday. It is just the question 
whether we actually want it. Is there really coverage to be gained (or does 
the kernel just the same under the hood anyway regardless of the filesystem)?

> Test on all filesystems to increase coverage.  btrfs and tmpfs
> currently does not support swap file, but keep it in case this get
> changed in the future.

Considering btrfs does not support it I guess that means the kernel does 
indeed different things under the hood so the coverage might be beneficial. (If 
it was just about tmpfs then I'd say it makes no sense to put a swapfile there 
in any case and it will therefore likely never be supported.)

Reviewed-by: Marius Kittler <mkittler@suse.de>




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
