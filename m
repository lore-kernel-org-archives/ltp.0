Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B88C433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 11:22:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E7C83C8E25
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 12:22:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEDA93C3189
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 12:21:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADFC5601321
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 12:21:51 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C178E1FD58;
 Tue, 23 Nov 2021 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637666510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k1lrD6ZQCy9P2NqIHNw82pO+EcaqONOtHUcP36X7fqY=;
 b=hCYDhJPRVjZ31I1nIpcpoucED5GCH/AUbKR49f0j7I7925pnaY4jjpN7fqjaMj0eqdrnxk
 sHh60P8m76we69fxqNvY5jQI2Psx/XRZe7q5A6q5DKLL6yOx8f8UZ05YQP8EZ90h3eOnZY
 RCG6tY3S9GIEyE4fAXNP1stSPjAnZys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637666510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k1lrD6ZQCy9P2NqIHNw82pO+EcaqONOtHUcP36X7fqY=;
 b=LqYwxKhxEqL/tUjAr5sd3Sqof0rDvv0pKxZDb3zBeOlQN0HNPg2Bhjwac0BHBiGbHGtcK7
 ZfkrnWTTsQ2RHvAg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8434BA3B81;
 Tue, 23 Nov 2021 11:21:50 +0000 (UTC)
References: <20211118112900.15757-1-rpalethorpe@suse.com>
 <619708EC.6090305@fujitsu.com> <YZubdhIyP19rhEVD@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Nov 2021 11:16:09 +0000
In-reply-to: <YZubdhIyP19rhEVD@yuki>
Message-ID: <87y25fktgx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: Re-add BTRFS version check
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Do you mean that your distribution based on older kernel ie 4.11
>> supports statx syscall but btrfs missed the btrfs patch? Also this
>> distribution doesn't update and so have no choice to backport.
>> > This is different from the
>> > other version checks which are for much newer kernels. 
>> IMO, distribution based on older kernel 4.11 still can make ext2 ext4
>> xfs supports statx because the backport looks not diffcult. So, I don't
>> think this is a difference. It depends on kernel users worked on this
>> distirbution whether have this requirement.
>> Also there could be differences in the difficulty of a backport.
>> I see xfs/btrfs code, it only fills the attributes field of stat
>> struture by parsing inode flags.
>> 
>> If you must add this check on suse distribution, I guess you just add
>> this version check for suse distribution. For centos7,8, neither of them
>> supports btrfs, but I don't know other distribution situation ie unbuntu.
>
> I just checked debian, both oldstable (4.16) and stable (5.10) have new
> enough kernels for this not to matter.
>
>> Maybe you can just add suse detection in lib/tst_kvercmp.c.
>
> I guess that this would be the cleanest solution.
>
> Actually SUSE should be detected just fine, since we parse
> /etc/os-release for ID='foo' in the test library.
>
> So this could be solved just by defining:
>
> static struct tst_kern_exv kvers[] = {
> 	{"sles", "4.13.0"}
> 	{}
> };
>
> and then doing:
>
> 	if (tst_kvercmp2(0, 0, 0, kvers) < 0)
> 		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
>
>
> Also it would be a bit cleaner to add this to the tst_test structure as
> .min_kver_ex as well, but that's a different story...

After some more internal discussions. We can just filter statx04 and use
the new test which performs the feature checks. I think it would have
been better to add the checks to statx04 and add a new test without any
checks. However it is done now.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
