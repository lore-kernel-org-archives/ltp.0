Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B56C83F17
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752149019; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lmBoodlzEWOOk6g9SrlLv2lDQmV7FIWLOtGlmooVyCo=;
 b=Bq4ojKrJMaGa1W2QWnR2NrKhYYr+eXszdOcJxlFWEcdYBn9zS6JtVYe2hWBEcA7xlEYeF
 l+wfcHumox/kUtk7Vb1JDWToqr5+OqYA6eMOluiSrGxqn0b6aQb5aaS3oozEoB7FQpg00UK
 6/owmfZNrEVmgprGY8k5mWoRaC+uXWg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 130573CAFAA
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 14:03:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D64023C647F
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 14:03:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF3366005FC
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 14:03:14 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 079F8469BF;
 Thu, 10 Jul 2025 12:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C38C4CEE3;
 Thu, 10 Jul 2025 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752148991;
 bh=nNuCjhsowYZ2SHuy8Ny1SbnsiGlGf5snyfLqhxn2Y70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rp0OuMT39W/H3+xYP3yeAlYFYNHp6/AF3JW+ePVoPW0RXpVi9ONwDZZgClcj3qcWf
 6fXkHh44kAF8RJhdwqGQIdcpr0gw2/7TSqXv/BaYQXipLJHK53wWl4IC9pHMnX135m
 9/hTN+1JwHm/ySfW16d6Olxdxk2P/JMaIEY5aQO6n03RE1ZTHd1A3lRR+VL87FJgo/
 Uqemk6OZPkG85s+nzJLZoF4hV0tTA+60bzEp/GyL3zvMKUVnTHfPsQHG9/94I3j8J2
 DZvToVcsvLBHhUtUqAGSL7Y/6fVciRGbZ0n6LERKZD1Rym2d3RyLjgPW1ulzrw40Pl
 hiu+vJG2zeQ3g==
Date: Thu, 10 Jul 2025 14:03:05 +0200
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20250710-geber-keimen-40cdd4bf17f7@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <d2e1d4a9-d475-43e3-824b-579e5084aaf3@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2e1d4a9-d475-43e3-824b-579e5084aaf3@app.fastmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
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
From: Christian Brauner via ltp <ltp@lists.linux.it>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Eric Biggers <ebiggers@google.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 rbm@suse.com, linux-fsdevel@vger.kernel.org,
 Benjamin Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025 at 12:11:12PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 10, 2025, at 10:00, Christian Brauner wrote:
> > On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:
> 
> >> +	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
> >> +	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
> >> +	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
> >> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
> >> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
> >
> > This part is wrong as we handle larger sizes just fine via
> > copy_struct_{from,to}_user().
> 
> I feel that is still an open question. As I understand it,
> you want to make it slightly easier for userspace callers
> to use future versions of an ioctl command by allowing them in
> old kernels as well, by moving that complexity into the kernel.
> 
> Checking against _IOC_SIZE(FS_IOC_GETLBMD_CAP) would keep the
> behavior consistent with the traditional model where userspace
> needs to have a fallback to previous ABI versions.
> 
> > Arnd, objections to writing it as follows?:
> 
> > +       /* extensible ioctls */
> > +       switch (_IOC_NR(cmd)) {
> > +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
> > +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
> > +                       break;
> > +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
> > +                       break;
> > +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
> > +                       break;
> > +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> > +                       break;
> > +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
> > +                       break;
> > +               return blk_get_meta_cap(bdev, cmd, argp);
> 
> The 'PAGE_SIZE' seems arbitrary here, especially since that is often

I used that as an illustration since we're capping nearly all (regular)
uapi structures at that as a somewhat reasonable upper bound. If that's
smaller that's fine.

> larger than the maximum size that can be encoded in an ioctl command
> number (8KB or 16KB depending on the architecture). If we do need
> an upper bound larger than _IOC_SIZE(FS_IOC_GETLBMD_CAP), I think it
> should be a fixed number rather than a configuration dependent
> one, and I would prefer a smaller one over a larger one. Anything

Sure, fine by me.

> over a few dozen bytes is certainly suspicious, and once it gets
> to thousands of bytes, you need a dynamic allocation to avoid stack
> overflow in the kernel.

Sure, we do that already in some cases because we have use-cases for
that.

> 
> I had already updated my patch to move the checks into
> blk_get_meta_cap() itself and keep the caller simpler:

Ok.

> Regardless of what upper bound we pick, that at least limits
> the complexity to the one function that actually wants it.

Ok.

> 
> > And can I ask you to please take a look at fs/pidfs.c:pidfd_ioctl() and
> 
> PIDFD_GET_INFO has part of the same problem, as it still fails to
> check the _IOC_DIR() bits. I see you added a check for _IOC_TYPE()
> in commit 091ee63e36e8 ("pidfs: improve ioctl handling"), but
> the comment you added describes an unrelated issue and the fix
> was incomplete.
> 
> > fs/nsfs.c:ns_ioctl()?
> 
> You tried to add a similar validation in commit 7fd511f8c911
> ("nsfs: validate ioctls"), but it seems you got that wrong
> both by missing the _IOC_DIR check and by having a typo in the
> '_IOC_TYPE(cmd) == _IOC_TYPE(cmd)' line that means this is
> always true rather than comparing against 'NSIO'.
> 
> Overall my feeling is similar to Christoph's, that the added
> complexity in any of these three cases was a mistake, as it's
> too easy to mess it up.

For pidfs and nsfs it will definitely be the way we're doing it.
Especially with structures we definitely want to grow. I have zero
interest in spamming userspace with either a fragmented set of 100
ioctls that never give consistent information because they need to be
called in sequence nor constantly revised V2-100 ioctl commands that all
use a new structure with a fixed layout.

The fact that the ioctl api currently lacks validation is more testament
to how unspecified the requirements for ioctls and their encoding are
and we better fix that in general because like it or not we already have
quite a few size-versioned ioctls anyway. This is nothing we cannot fix.

Tell me what work you need and we'll do it.

The alternative I see is that I will start being very liberal in adding
extensible system calls for stuff such as pidfd_info() and ns_info()
instead of making them ioctls on the file where they belong.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
