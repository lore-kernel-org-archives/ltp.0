Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B8C433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 08:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B1FF3C967B
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 09:17:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 963763C913B
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 09:17:16 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CDF22600ACF
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 09:17:15 +0100 (CET)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A0FEE68AA6; Thu, 20 Jan 2022 09:17:12 +0100 (CET)
Date: Thu, 20 Jan 2022 09:17:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <20220120081712.GA4980@lst.de>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
 <20211229172902.GC27693@lst.de>
 <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
 <20220105060201.GA2261405@janakin.usersys.redhat.com>
 <2b29ac47-ed8f-3b50-f47c-c080fb83cbd5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b29ac47-ed8f-3b50-f47c-c080fb83cbd5@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] make autoclear operation synchronous again
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
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>, linux-block <linux-block@vger.kernel.org>,
 ltp@lists.linux.it, Dan Schatzberg <schatzberg.dan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 05, 2022 at 03:10:23PM +0900, Tetsuo Handa wrote:
> On 2022/01/05 15:02, Jan Stancek wrote:
> > On Thu, Dec 30, 2021 at 07:52:34PM +0900, Tetsuo Handa wrote:
> >> OK. Two patches shown below. Are these look reasonable?
> >>
> >>
> >>
> >>> From 1409a49181efcc474fbae2cf4e60cbc37adf34aa Mon Sep 17 00:00:00 2001
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date: Thu, 30 Dec 2021 18:41:05 +0900
> >> Subject: [PATCH 1/2] loop: Revert "loop: make autoclear operation asynchronous"
> >>
> > 
> > Thanks, the revert fixes failures we saw recently in LTP tests,
> > which do mount/umount in close succession:
> > 
> > # for i in `seq 1 2`;do mount -t iso9660 -o loop /root/isofs.iso /mnt/isofs; umount /mnt/isofs/; done
> > mount: /mnt/isofs: WARNING: source write-protected, mounted read-only.
> > mount: /mnt/isofs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
> > umount: /mnt/isofs/: not mounted.
> > 
> 
> I'm waiting for Jens to come back to
> https://lkml.kernel.org/r/c205dcd2-db55-a35c-e2ef-20193b5ac0da@i-love.sakura.ne.jp .

So I think the version in this thread is what we should merge.

On top of that we should:

 - remove the probe mechanism (patch already sent)
 - stop taking open_mutex in del_gendisk and bdev_disk_changed (I have
   a series for that now)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
