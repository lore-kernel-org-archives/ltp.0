Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F17EE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 09:58:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AB493CCD62
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:58:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B90B3CB65C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:58:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE4DC1001F27
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 11:57:59 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 57CA421863;
 Thu,  7 Sep 2023 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694080679;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcSS+4jyLrOM1xU2cRfmtWN7bF6FyirmHNOHJ52ZoIc=;
 b=LkykX21cuMs/LpGcl5mnl/hCK4J02IYsjqx6KCf6vgpMhZbhd5xrHLBDX5j7/n3VsRvDsK
 MPx1OAWrk//y0qvQnfuTBzAiZAsOLZgB01MEjqW2g/vZsgqmhz6a3onVvatOOQez32xBxT
 vPH3rZh2J8p0zLx0zjqNPxalQPLEYg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694080679;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcSS+4jyLrOM1xU2cRfmtWN7bF6FyirmHNOHJ52ZoIc=;
 b=NlrkjAU+fHREPUZ/XauerueuqbImUBkRO1nRg0OmguN52EFkxaJXHTMrtFGBk3J4xroMUW
 doXL1ahutSCp0DCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A8D202C142;
 Thu,  7 Sep 2023 09:57:58 +0000 (UTC)
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com> <87il8xhr05.fsf@suse.de>
 <ZPlxtKUwOta4GYh2@fedora19.localdomain>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Thu, 07 Sep 2023 09:26:29 +0100
Organization: Linux Private Site
In-reply-to: <ZPlxtKUwOta4GYh2@fedora19.localdomain>
Message-ID: <87r0nae259.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Ian,

Ian Wienand <iwienand@redhat.com> writes:

> On Wed, Aug 30, 2023 at 09:20:44AM +0100, Richard Palethorpe wrote:
>> > This is visible in the occasional divide-by-zero error, but in the
>> > bigger picture means this test is not exercising the compression path
>> > as desired.
>
>> Do zram{02,03} already do something similar?
>
> Let's go backwards and try to find a path forward...
>
> In Jan 19 2011, ecd667ecb5118a6a2805caca30823f18a355bbe2 added
> testcases/kernel/mem/zram/zram01.c to test r/w compressed block
> devices.
>
> In Apr 23 2015, 433445f6beeaa38f5ffbd723a8f392a6880b7e11 created two
> more tests
>   zram01.sh creates general purpose ram disks with different filesystems
>   zram02.sh creates block device for swap
>
> In Jun 2015, af0470f65abc62090ad22583b40c27923c48b038 moved the
> original testcases/kernel/mem/zram/zram01.c ->
> kernel/device-drivers/zram/zram03.c
>
> zram02.sh creates and adds/removes swap devices; I think this is
> sufficiently different to stand alone (I mean, maybe it could be given
> some intrinsic documentation by being called something descriptive
> like 'zram-swap-test.sh' but anyway).
>
> zram03.c (the original zram test, renamed) makes a device and fills it
> with the character 'a'.  It reads it back but doens't validate any
> statistics from the stats.
>
> zram01.sh is in concept fairly similar, but instead it makes various
> file-systems on the device and (as-is) writes zeros.  It reads back
> the stats and tries to infer correct operation from that.
>
> zram01.sh has been suspect from the start, because since the original
> upstream zram commit (8e19d540d107ee897eb9a874844060c94e2376c0)
> zero-pages have been de-duplicated and not compressed.  I think the
> reason it minimally works is because there's some non-zero file-system
> metadata; but it's unreliable (hence it randomly failing, and this
> email) and not really stressing what it wants to stress, which is the
> actual compression paths.

Maybe it's not testing what was orginally intended, but filling the FS
with all zero's is an important corner case. We don't want to remove
that coverage. We at least want to check that the kernel doesn't
crash.

>
> zram03.c always filled with a non-zero value -- presumably to avoid
> the zero-page deduplication -- but I think what this missed is that
> when same-page detection was added in ~2017 (kernel
> 8e19d540d107ee897eb9a874844060c94e2376c0).  Since this time, it is
> really not stressing any of the compression paths either, since every
> page is the same.

So it is testing deduplication of non-zero pages. In general these are
testing a degenerate case.

>
>> In any case I'd prefer to see a zram04 written in C if some coverage is
>> missing.
>
> I don't think adding another test really helps.
>
> I think the best course here is to fix zram01.sh to write enough
> random data to stress the compression paths and further sync to make
> it reliable.  This is what the patch proposes.
>
> If there's some agreement that the investigation above is valid, we
> could probably remove zram03.c.  It's not really doing anything
> zram01.sh doesn't do and it is not really stressing anything either.
>
> -i

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
