Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AEBC433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 16:32:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01F973C81D8
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 17:32:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 220743C62EE
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 17:32:12 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D0CF1A0035E
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 17:32:12 +0100 (CET)
Received: by mail-vk1-xa33.google.com with SMTP id j24so6310197vkk.0
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sHx/s7Q3dfnb6zLj9K2Rs/I0JU8Gut8NIyzYuQ/JjpU=;
 b=HIA4qsroIHfUsRSss9MWHNArCbv39+VRXEF23+eS3t3ZaBvvikMfMyzIkfGMrIE7pO
 L7x7fj4PDcYnfdAjLmqoZztvZl9Ty/RFNvu7zBd1mHEFt2j8JgVbTEkhEFW/yXnOiJPN
 aTMezwLiYoR5EKF+DeBvZ/yjX5Ceo7DKOge8NdMfBB0JBHz4S5ocYoeGeGcAyQ0NQre8
 xB23SBNns68hHPNIcA4gWVV1sTFCUV4aAuy/4AeSgpTmgqfBnIUD8sCqcrD+IymsgGzM
 GnZzZ+6XGYjr2/LuPTJs4R/xPRjHyfH5ot9GhlYrIzJblkcqSjJJStRtXMShUC0cJ+Vt
 8rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHx/s7Q3dfnb6zLj9K2Rs/I0JU8Gut8NIyzYuQ/JjpU=;
 b=ebRwWYvNV3eo1sWeNK5p1y0EGfmIkk88Hz1vZSx7gvIDa+z4husJat/l85mnW510XJ
 IeYEr1ApFPdWMyHxBr053oeJkgbZjnOz/h2QhZKFKCC5YUt9bNiTGmrMRkoEIYfJHOqn
 /YmHRG3zwdROL8v1xEswe1qr33X1PMnGaPxxqNH6iyAQ5fE7pSRFoKiEraq7JcRd7/04
 tIme2Dk7UiBvQ5Jlg/fpD4tOLPGbpsq6Dgf5I2mFhHsip7G8dq3hmSlUZ7UrqexY8Bco
 hB5epg61Hu+SO/MA35H9XsJrMCjTlYgA96qqmhjMAW6AdD609r1AKE9AuaSA70+/hhfN
 /QVg==
X-Gm-Message-State: ANoB5plUdweqKszRIUSZWZIyIKVVf5yQhOg2zJ0brrKyH71182APFxYX
 orhfQmV1//NuGOPtQKD+xDrmvMU7vgCZYuVO504=
X-Google-Smtp-Source: AA0mqf5HepG7aZvYi6i8L8mj1AWzsNOKZhyUYcer0oFvmSBxUDbXhQ7ZYGevtWzjEFG4lHkWeNkGWcuLJL40fR/hhZQ=
X-Received: by 2002:a1f:2dc1:0:b0:3b8:77f9:9757 with SMTP id
 t184-20020a1f2dc1000000b003b877f99757mr13812370vkt.3.1668616331356; Wed, 16
 Nov 2022 08:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-3-jack@suse.cz>
 <Y3RIKsBUx+KiH4lD@xpf.sh.intel.com> <20221116105814.ozfankn5qkizj2zr@quack3>
In-Reply-To: <20221116105814.ozfankn5qkizj2zr@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Nov 2022 18:32:00 +0200
Message-ID: <CAOQ4uxj7+PLuSA18s7QCdYF0x9f09gYmvgpmFHMH75vRt9swcg@mail.gmail.com>
To: Jan Kara <jack@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify10: Make evictable marks tests more
 reliable
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

On Wed, Nov 16, 2022 at 12:58 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 16-11-22 10:17:14, Pengfei Xu wrote:
> > Hi Jan Kara,
> >
> > On 2022-11-15 at 13:47:38 +0100, Jan Kara wrote:
> > > Tests verifying that evictable inode marks don't pin inodes in memory
> > > are unreliable because slab shrinking (triggered by drop_caches) does
> > > not reliably evict inodes - dentries have to take round through the LRU
> > > list and only then get reclaimed and inodes get unpinned and then inodes
> > > have to be rotated through their LRU list to get reclaimed. If there are
> > > not enough freed entries while shrinking other slab caches, drop_caches
> > > will abort attempts to reclaim slab before inodes get evicted.
> > >
> > > Tweak evictable marks tests to use more files and marks in parallel and
> > > just verify that some (at least half) of the marks got evicted. This
> > > should be more tolerant to random fluctuation in slab reclaim
> > > efficiency.
> > >
> > If possible, could you add the Tested-by tag:
> > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>
> Sure, will do. I'll just wait whether there will be some other review
> comments.

I would want to say Reviewed-by, but I could only say Eyeballed-by.
I like the change and thanks for figuring this out, but the review
was very hard, so I did not have time to do it thoroughly.

Good luck, Petr ;-)

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
