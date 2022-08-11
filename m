Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3117BC19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 10:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3B213C95CF
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 12:24:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4EC83C0204
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 12:23:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D0FA3600329
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 12:23:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B98E238993;
 Thu, 11 Aug 2022 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660213430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=biUx2n92pV2E0+68K7DCWlqnFbDo+84Gn4V5yleWb8M=;
 b=W8pigswD4wMIZfqXY4fsRNjq8+4GYl7vI6R/n57Z9JeMxjJ2wBmTG+FLU8PFbUehDj4fiP
 aKdYhJTXXGoFHFT+3T7l2oKLfFRyjjkkmn9F8oQuh/syPL6P/anaxlWB+UlyETenciN0aa
 9TkFSfaFgk/+w16nq2VX/bJEN0ndnf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660213430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=biUx2n92pV2E0+68K7DCWlqnFbDo+84Gn4V5yleWb8M=;
 b=+FQLfl/VfaPwjg3keAO6oUF1mqR1xown70LvaOhYnXS+SJcK5Yx3HSmVfa613QJyhUC1NJ
 hOJSZtwaiuO7UyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9868213A9B;
 Thu, 11 Aug 2022 10:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OL/PI7bY9GJPCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 11 Aug 2022 10:23:50 +0000
Date: Thu, 11 Aug 2022 12:25:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YvTZA/l8FyDghGH4@rei>
References: <20220810092804.5771-1-andrea.cervesato@suse.com>
 <YvOKbt1urOeVwQ57@yuki>
 <ade189ba-4211-99a8-d5e6-c99b1950e21b@suse.com>
 <YvOmiXBO1njKMzUM@yuki> <YvTPEoDUp4AKu/0V@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvTPEoDUp4AKu/0V@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor aiocp using new LTP API
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
> > I guess that we can do a little trick such as making the buffer with
> > random data slightly bigger and choosing a random start offset in that
> > etc.
> 
> I tested Andreas patches from v2 to v6 and aiocp with -f DIRECT works only on
> btrfs. Running on $TMPDIR being on ext4, xfs, tmpfs endup with EINVAL:
> 
> # ./aiocp -b 1k -n 1 -f DIRECT
> aiocp.c:240: TINFO: Maximum AIO blocks: 65536
> aiocp.c:265: TINFO: Fill srcfile.bin with random data
> aiocp.c:267: TBROK: open(srcfile.bin,16450,0666) failed: EINVAL (22)
> 
> Any idea what could be wrong?

There are couple of things wrong in there actually. First of all when
the file is prepared in the test setup the flags passed on the
commandline shouldn't be used at all, since the buffer in the function
that fills the file with random data is not aligned at all.

Secondly looking at the flags in the failing open we seem to pass O_RDWR
so my guess would be that O_DIRECT is supported only for O_RDONLY or
O_WRONLY file descriptors.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
