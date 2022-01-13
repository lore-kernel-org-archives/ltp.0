Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B256EC433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 09:48:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFAD43C9524
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 10:48:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 865FE3C58A8
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:48:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6D0331A00E12
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:48:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83A78218E5;
 Thu, 13 Jan 2022 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642067290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aSXMgqtYjDAnIwN2LLnNfo1+9FlqyUjADw4smNj/EXM=;
 b=XTGQhoHMI8aoN+z0T9YAZCqrVLE/DOse/Ih33Y8xFSP64S9vrEDzif3GKbmxtTst3Yc+y1
 7MW1kzEPY/I+M/TJasrdhUMW8DDWXg2PuZqW8Bb0suxjhp2x5FWFktHCwjCK5KsfOkeHCW
 i2g142legoqWYtryytVEgLxhZCwF1I4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642067290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aSXMgqtYjDAnIwN2LLnNfo1+9FlqyUjADw4smNj/EXM=;
 b=LStkjECXIMMzkaeXFTdA+XkGy+12r86x8tifQkyqLO60+CBLVkei1qd2TES3QDPOsv97uw
 nVjv88TnQHg5IVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 651C313B83;
 Thu, 13 Jan 2022 09:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WHePF1r132ElbAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jan 2022 09:48:10 +0000
Date: Thu, 13 Jan 2022 10:49:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yd/1vJl6rLmIHrbw@yuki>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <61DE9D0F.60008@fujitsu.com> <Yd6jfBkDVWnTYQCm@yuki>
 <61DFCC2E.9040808@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61DFCC2E.9040808@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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
> >> How about this patch after this change?
> >
> > Looks reasonable.
> So do you have some comments for other two quotactl patches? or add RVB tag?
> 
> ps: I want to make them merged in ltp before this release.

I will have a look today, I had half day off yesterday and haven't
managed to get to them.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
