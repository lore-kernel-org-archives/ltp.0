Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63F1C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 13:49:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 799913C895D
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:49:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23D9F3C257E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 15:49:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61A7E1400527
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 15:49:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB8091F38A;
 Mon, 13 Jun 2022 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655128150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVhDteopZL7E1oFymClA9NEiOGEPxjVQlQjLkKHV77A=;
 b=0CNaOSxlNRQZbAcyC7pVo0aHvarj61JlV8bjVQ6hpXsp+wS49x3JBQSxkBg+20UXDFrpQU
 dIrulDcxt28X/nnWRPQHMvhAcOptt2jwQfzlOnMJGtqZwlffZkCu0gmwOYw+PTMvZm3GNl
 bSQG01+IbH3g9q5KaCG7FuCIwM+b7ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655128150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVhDteopZL7E1oFymClA9NEiOGEPxjVQlQjLkKHV77A=;
 b=FD+kuCow9T7ox9E2r/yGR7lstw4ZrnWF7kIkqbUksZ5/xAO5z5tRCBmTtvksTGAc8G3GYU
 ZeLnsdfSBSoa1rCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88937134CF;
 Mon, 13 Jun 2022 13:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N+fRH1ZAp2JONAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 13:49:10 +0000
Date: Mon, 13 Jun 2022 15:49:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YqdAVH7VZq0IW4hV@pevik>
References: <20220610131442.5032-1-mdoucha@suse.cz> <YqNIIb/NFVBjsZdb@rei>
 <156915a0-cd2b-e6b8-1b7c-273c67911d4b@suse.cz>
 <YqbyFKN999MTr6Xf@yuki> <Yqcmuv8dwtU+tntL@pevik>
 <f527c92a-97f0-9d07-87e9-58ab3e521aaf@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f527c92a-97f0-9d07-87e9-58ab3e521aaf@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Check for KVM linker script support
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> > I thought we're using TST_TEST_TCONF() for non-x86 archs.

> We will use TST_TEST_TCONF() for KVM on unsupported archs once they have
> their own guest bootstrap code (which is currently available only for
> 32bit and 64bit x86). But it is not possible to link test binaries
> without bootstrap code so non-x86 archs are currently skipped during build.

Ah, makes sense. Thanks for info!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
