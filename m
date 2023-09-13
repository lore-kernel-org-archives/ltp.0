Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DCDCA5517
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C1593CBA73
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:09:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE173CB2A9
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:09:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DABE2140026C
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:09:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E95E8218E2;
 Wed, 13 Sep 2023 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694596163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8aXtXyU167osDlSPQvFZ9ThP1MOOP1aetre3kE6nKU=;
 b=DRHVny3HUUBEaMmrOsH2kdzAnQJ4tYB/qHh922kDbFAohoUHFDncgn0/lhM3B05j0uDqwC
 MyZvXj6145tCoQRHqu33Vy0x+AjqHJi2fOmLmjMhGvlqJbLSnFXohXboGi3T9i0SK7Ef14
 yoY6jDHIIDeu21gzmiVTbs014S8yEGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694596163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8aXtXyU167osDlSPQvFZ9ThP1MOOP1aetre3kE6nKU=;
 b=rHQIPJPlkBJPzfWqSPRzbcOJZGufJflsrFPKITe8/FD0SG+EQ50qjqCnbRztY4B/fSq6yt
 R50g0/1BtOz7qQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4C9E13582;
 Wed, 13 Sep 2023 09:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 90l2M0N8AWUJOgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Sep 2023 09:09:23 +0000
Date: Wed, 13 Sep 2023 11:10:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <ZQF8cn4k1qqdYj8x@yuki>
References: <20230906061902.591996-1-eadavis@sina.com>
 <202309121302.8864096c-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202309121302.8864096c-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mm: as the same logic with queue_pages_range
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
Cc: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com, lkp@intel.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, oe-lkp@lists.linux.dev, akpm@linux-foundation.org,
 ltp@lists.linux.it, Edward AD <eadavis@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Running tests.......
> <<<test_start>>>
> tag=vma02 stime=1694438526
> cmdline="vma02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> vma02       0  TINFO  :  pid = 3639 addr = 0x7f5202dd6000
> vma02       0  TINFO  :  start = 0x7f5202dd6000, end = 0x7f5202dd7000
> vma02       0  TINFO  :  start = 0x7f5202dd7000, end = 0x7f5202dd8000
> vma02       0  TINFO  :  start = 0x7f5202dd8000, end = 0x7f5202dd9000
> vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.
> incrementing stop

So the test is reproducer for:

commit 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4
Author: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date:   Fri Mar 5 13:41:57 2010 -0800

    mm: fix mbind vma merge problem

    Strangely, current mbind() doesn't merge vma with neighbor vma although it's possible.
    Unfortunately, many vma can reduce performance...


And what the test does is:

- map 3 continous pages
- popluate
- mbind() first page
- mbind() all three pages
- checks that there is only single VMA for the pages after second
  mbind()

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
