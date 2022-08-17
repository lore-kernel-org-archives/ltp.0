Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5345C32771
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 14:07:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F8A83C9DDE
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 16:07:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09E73C88EB
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:07:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 968EB1A009B7
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:07:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F7B0200B0;
 Wed, 17 Aug 2022 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660745232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Q7fVJygqo6XQYqS2d743bQysPz4xLTXHvyqrecRFBU=;
 b=F8YSdOYsSXJpZqAnO6itLpoTFWxwW0notxsTNAKiw9a+JHbW6/cXHO0bj98NszU64HQFtt
 Ap+1yMwF7y49+tErON37MR4itRcpi5RJEdnKAHDvFFT51T9Zur75og5SnjR5+2MvwMUjLN
 sleVccezG4ixOClQ1tOq7J+O3MWZYjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660745232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Q7fVJygqo6XQYqS2d743bQysPz4xLTXHvyqrecRFBU=;
 b=ou7/jlxFMgxXmjtteNQn80fzore2dFyYdia0j1kbT/ixAEDe0ZYS2wS39Z2YZRDuU/PFbR
 QXkBt8tregCo84AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A3CF13A8E;
 Wed, 17 Aug 2022 14:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F3D6BBD2/GLLawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 17 Aug 2022 14:07:12 +0000
Date: Wed, 17 Aug 2022 16:09:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <Yvz2hT0VGNZrcArJ@yuki>
References: <20220817133929.234873-1-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220817133929.234873-1-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] utils/compat_16: Allow build.sh to disable
 the compat_16 tests
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
> The option that allows disabling the compat_16 tests has been erroneously
> removed in a previous change, so re-add it. Also, enable build.sh to use
> make options such as TST_NEWER_64_SYSCALL or TST_COMPAT_16_SYSCALL.

It does not seem to be removed erroneously. What problem are you trying
to solve?

Generally we rather produce tests that then return with TCONF (skipped)
status than disable them from compilation.

If you want to skip them at runtime you can filter them out from the
rutnest files.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
