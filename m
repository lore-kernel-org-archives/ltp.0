Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14674C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 12:59:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C51C03CA086
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:59:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CB973C9563
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:59:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73CBD1A0043C
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:59:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B719A1F37D;
 Wed, 16 Feb 2022 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645016360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w09V34xMteXcnp1NySwJ66kKHOeF00ifs3H9Pu7y0KQ=;
 b=LkX6ee7756+DeRLkKcrCQeLPFDtqan+VLYo2gDH+PvObWDzoPtTKgQTSzHrvELYjjV+iDK
 DeayFzQ6FWCwlhWGUmrqoLyAJSYy+G66ncfcm7sCFCAR30fjQio6SeNEvWrMrGK0pkQufp
 WnQdcLjVXzZi8BEG+t+tLr3u6bH7bsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645016360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w09V34xMteXcnp1NySwJ66kKHOeF00ifs3H9Pu7y0KQ=;
 b=1Q4RJGABy1dsWzbD4HtKsiChCxIBTgw6X44e8gwhE3e3FM9b3mGNT/mYbwdWPtzYG0iaWl
 4mK39EiYS4eusECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F60013B0A;
 Wed, 16 Feb 2022 12:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XNF8JSj1DGJWXwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Feb 2022 12:59:20 +0000
Date: Wed, 16 Feb 2022 13:59:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Ygz1Hla+cE5tI7HK@rei>
References: <1643349071-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YfPGDmF0UFFjeABu@yuki> <61F5F724.9020700@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61F5F724.9020700@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sysctl/sysctl03: Test whether return EINVAL when
 passing negative value
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I'm just wondering if this wouldn't be actually easier as a C test. I
> > bet that simple write() to the sys_file would work exactly the same and
> > we wouldn't depend on sysctl being present on the system.
> If using C program, it seems not have a suitable place to put this test 
> case. Do you have some advise?

We do have testcases/kernel/fs/proc/ so I guess that we can as well add
testcases/kernel/fs/sys/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
