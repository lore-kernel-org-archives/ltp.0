Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87312ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B17EC3CA6A8
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:48:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 725753C1351
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:48:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6A96E1A00925
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:48:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF6DB1F8B4;
 Wed, 31 Aug 2022 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661950097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=akIq+UuukQW32CGSntdAaYsawtz5x4nSp7Y8MyxEjTY=;
 b=Ke82kaLkWjNFEtjJ4W/YyLNgokdayFvOww/N/KX85J0kjjX5+iFOAKp7tfysuC+32N6B4c
 hW8dRHMjgWGRrOyaXcvJapiYK9lBjnMAUTtHEiasace8Y0RBHbDo21fAhAwkW4diOujCnR
 /AGLwTk5KfG/9R9eDgS51ElRpiHkNWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661950097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=akIq+UuukQW32CGSntdAaYsawtz5x4nSp7Y8MyxEjTY=;
 b=XzcP+dHGY0owzr3Z0Lg4F3XNkPBHGN/KYoPs9dVQeYJ1O6Xa2/tlgqZE5sxchmrgtIYPN2
 tbdEwOBGy2xcZdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93D4B13A7C;
 Wed, 31 Aug 2022 12:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +s89I5FYD2PCJAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 31 Aug 2022 12:48:17 +0000
Date: Wed, 31 Aug 2022 14:50:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yw9ZCTP0l7FjRtLg@yuki>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-4-mdoucha@suse.cz> <Yw4jYgDzNj9BAqOf@yuki>
 <45d76082-49f3-74bb-fd3c-6f5fd2d6136f@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45d76082-49f3-74bb-fd3c-6f5fd2d6136f@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/10] ksm: Add max_runtime to tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I wonder if we can do better.
> > 
> > I guess that the actual runtime does depends on the size of the RAM
> > because we wait for at least two finished full scans for ksmd. I guess
> > that for large enough machines we would end up with minutes of runtime.
> > 
> > So I guess that it would make more sense to treat the max_runtime as a
> > upper bound and set it to large enough number as we do for AIO testcases
> > (30 minutes) and then make the wait_ksmd_full_scan() runtime avare so
> > that it exits when the runtime is exhausted. With that we would get a
> > clear message that we timed-out in the loop that waited for the ksmd
> > scan.
> 
> Alternatively, we could measure 1 full ksmd scan in setup() and then set 
> max_runtime dynamically. Each call of create_same_memory() would need 
> roughly 16 scan times. Time spent in ksm_child_memset() is included in 
> that estimate.

That sounds good as well, but I would still set the .max_runtime to
rough guess in tst_test structure and then adjusted it in the test
setup().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
