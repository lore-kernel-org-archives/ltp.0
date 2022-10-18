Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DD5C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:30:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62EE53CB051
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:30:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766B73C93EF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:30:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCB061400268
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:30:08 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 46D0F33708;
 Tue, 18 Oct 2022 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666081808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xT9SCFafqCqd5TBhMXJPHm+C4U+DY569wfKV8bnVNE=;
 b=pfnu2e1jYPVEmu+V455+xBKqRJVmMxDPDyo+rLV5AgrIusv6mU5KRmszcmyCLKlRueu8xf
 WjbxRcvA9uepNTYDlWtXoxCuH70SCAE1sDQE2Djx6e7amUkRwLfh4BIuH90IF+3tnUAtlt
 MmT+dwFJMlRYwbZuX4G8fgpAOpBmm6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666081808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xT9SCFafqCqd5TBhMXJPHm+C4U+DY569wfKV8bnVNE=;
 b=BNdtoVwhYlCbm+FztMdk0XI1zDjLGXDSW0WJo4qOk6Sx2BkUmLi6w/7O7rGI1spKkXAM6P
 mIMmL//lARv6zqAQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3BFC22C141;
 Tue, 18 Oct 2022 08:30:07 +0000 (UTC)
References: <20221004090810.9023-1-pvorel@suse.cz> <87sfjmmswf.fsf@suse.de>
 <Y01wmJ0ZT+G+N5IE@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Oct 2022 09:19:28 +0100
In-reply-to: <Y01wmJ0ZT+G+N5IE@pevik>
Message-ID: <87k04xmt4i.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] df01.sh: Use own fsfreeze implementation for
 XFS
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
Reply-To: rpalethorpe@suse.de
Cc: linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
 ltp@lists.linux.it, "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Hello,
>
>> Petr Vorel <pvorel@suse.cz> writes:
>
>> > df01.sh started to fail on XFS on certain configuration since mkfs.xfs
>> > and kernel 5.19. Implement fsfreeze instead of introducing external
>> > dependency. NOTE: implementation could fail on other filesystems
>> > (EOPNOTSUPP on exfat, ntfs, vfat).
>
>> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
>> > Suggested-by: Eric Sandeen <sandeen@redhat.com>
>> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> > ---
>> > Hi,
>
>> > FYI the background of this issue:
>> > https://lore.kernel.org/ltp/Yv5oaxsX6z2qxxF3@magnolia/
>> > https://lore.kernel.org/ltp/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/
>
>> > @LTP developers: not sure if the consensus is to avoid LTP API
>> > completely (even use it just with TST_NO_DEFAULT_MAIN), if required I
>
>> Why would that be the consensus? :-)
>
> $ ls testcases/lib/*.c |wc -l
> 19
>
> $ git grep -l TST_NO_DEFAULT_MAIN testcases/lib/*.c |wc -l
> 9
>
> => 10 tests not use tst_test.h at all.
> => none is *not* defining TST_NO_DEFAULT_MAIN (not a big surprise),
> but 2 of them (testcases/lib/tst_device.c, testcases/lib/tst_get_free_pids.c)
> implement workaround to force messages to be printed from the new library
> (tst_test.c).

Possibly the reason for this is that it's not clear whether some core
library functions will work as expected if we create an executable with
TST_NO_DEFAULT_MAIN.

However most stuff works fine.

>
> static struct tst_test test = {
> };
> tst_test = &test;
>
> My opinion also was based on Cyril's comments on nfs05_make_tree.c patch, but he
> probably meant to just use TST_NO_DEFAULT_MAIN instead of struct tst_test test:
> https://lore.kernel.org/ltp/YqxFo1iFzHatNRIl@yuki/

Certainly we shouldn't put a test struct in anything which is not a
test. Possibly we could create a util struct

>
>> > can rewrite to use it just to get SAFE_*() macros (like
>> > testcases/lib/tst_checkpoint.c) or even with tst_test workarounds
>> > (testcases/lib/tst_get_free_pids.c).
>
>> Yes, it should work fine with TST_NO_DEFAULT_MAIN
> Both versions IMHO work well, the question what we prefer more.
> Do you vote for rewriting?

Yes, avoiding the LTP library caused a number of problems in sparse-ltp
and the ltx prototype. Then I found linking in the LTP libs with
TST_NO_DEFAULT_MAIN to ltx and using tst_res(TBROK, ...) etc. worked
fine.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
