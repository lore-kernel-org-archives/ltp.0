Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973DEEB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 11:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 989943CDE6A
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 13:47:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32A073C036A
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:47:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 80EFC601071
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:47:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82E561F86B;
 Fri, 14 Jul 2023 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689335241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=49+/Qjn0IoQoU4X0/tfiEPo6hLmZVw2kXPmKkl1m8jw=;
 b=zUUVXNrh/lfqDQleZB2Yi/AQWi3gO8N2cyozHYW3UBK/qVnl0aaIMQ+ufellmhKnAGp9WS
 YA7bwLxXtqcibiQxf41Wd6W6jWEDK8Utwu/7C53ZGtEEZX6xIuPXn64fojOwQKD06HBY+l
 0SQZXSiUU1ID1Bi9iv9/zdvGaW3wXq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689335241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=49+/Qjn0IoQoU4X0/tfiEPo6hLmZVw2kXPmKkl1m8jw=;
 b=zZ9lUA/zhgGvQiES0ukhq+od7bUWtG9ltXuPoaLtQ+UrDD3OHfMxQgbjLse2WJiMMAmS8C
 tvt+jK4MNOLmqRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A550138F8;
 Fri, 14 Jul 2023 11:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CEvQFMk1sWTVPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jul 2023 11:47:21 +0000
Date: Fri, 14 Jul 2023 13:47:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20230714114719.GB958548@pevik>
References: <20230713132901.28660-1-mdoucha@suse.cz>
 <20230714034048.GA913@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230714034048.GA913@sol.localdomain>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx09: Reduce fs-verity blocksize to 1024
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

Hi Eric, Martin,

Eric, thanks for your input, Martin, thanks for working on this.

> Hi Martin,

> On Thu, Jul 13, 2023 at 03:28:52PM +0200, Martin Doucha wrote:
> > The kernel requires that fs-verity blocksize must be at most equal
> > to the filesystem blocksize. Testing on small loop device means that
> > mkfs.ext4 will very likely default to blocksize of 1024. Set fs-verity
> > blocksize to the minimum possible value (1024) to avoid blocksize
> > mismatch.

Yes kernels < 6.3 TCONF on current master:
statx09.c:124: TCONF: fs-verity not supported on loopdev

And 6.3 fails:
statx09.c:109: TBROK: ioctl(3, FS_IOC_ENABLE_VERITY) failed: EINVAL (22)

> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > ---

> > Alternatively, we could add "-b 4096" to .dev_fs_opts.

> >  testcases/kernel/syscalls/statx/statx09.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> > index c03d2c91e..dc9786c76 100644
> > --- a/testcases/kernel/syscalls/statx/statx09.c
> > +++ b/testcases/kernel/syscalls/statx/statx09.c
> > @@ -94,7 +94,7 @@ static void flag_setup(void)
> >  	memset(&enable, 0, sizeof(enable));
> >  	enable.version = 1;
> >  	enable.hash_algorithm = hash_algorithms[0];
> > -	enable.block_size = 4096;
> > +	enable.block_size = 1024;
> >  	enable.salt_size = 0;
> >  	enable.salt_ptr = (intptr_t)NULL;
> >  	enable.sig_size = 0;
> > -- 

> Support for Merkle tree block sizes less than the page size didn't exist until
> kernel version 6.3.  Please see the documentation for FS_IOC_ENABLE_VERITY
> (https://www.kernel.org/doc/html/latest/filesystems/fsverity.html#fs-ioc-enable-verity):

>     "block_size is the Merkle tree block size, in bytes. In Linux v6.3 and
>     later, this can be any power of 2 between (inclusively) 1024 and the minimum
>     of the system page size and the filesystem block size. In earlier versions,
>     the page size was the only allowed value."

> There are a few different approaches you could take.  One would be the one you
> mentioned: just add "-b 4096".  Though, note that systems with non-4K pages and
> kernel older than v6.3 can't mount an "-O verity -b 4096" filesystem.

I suppose the problem would be with e.g. ppc64le. Because otherwise
it works with this setup (untested on ppc64le, I believe it'd fail):
.dev_fs_opts = (const char *const []){"-O verity", "-b 4096", NULL},
and kept enable.block_size = 4096
the test passes on older kernels 6.2.12-1-default (openSUSE), 5.10.0-8-amd64
(Debian) as well as on 6.3 kernel.

> Or you could query the filesystem block size (that resulted from mkfs.ext4 with
> unspecified block size) and use that as the Merkle tree block size.

Unless it's not too complicated, it looks to me the best, as it'd support both
 >= 6.3 and older kernels.

> Or you could simply make the test depend on kernel v6.3, I suppose.

If possible I'd prefer to keep functionality also for older kernels.

Another (IMHO not really good option) would be to acquire device big enough via
.dev_min_size (it'd probably have to be too big device).

Kind regards,
Petr

> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
