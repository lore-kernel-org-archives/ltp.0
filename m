Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B67C5479D
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 11:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8040E3CCBDE
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 12:34:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D24643C1769
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 12:34:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1F8EB60057F
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 12:34:31 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2FAD93420B;
 Mon,  9 Jan 2023 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673264071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w2Jb0iSDKQWQZoE/iBK1ayM/HFe/sjsbk+XGWrIFT/w=;
 b=Kzvpn14bV1eUzTu1Uj+XDlSy89tmesO2GGn/GZfAkuC54vgMSaxrppedk0pr6lw7GKSmST
 m4lrIWSHhfu6AwIadh4anNelAICYp2vVY9f+MJBWhezYIBn00YihopoOY5TfThojJ45cTC
 JVmbyYhTzMSRCpsd63C6m7DMLoVg724=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673264071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w2Jb0iSDKQWQZoE/iBK1ayM/HFe/sjsbk+XGWrIFT/w=;
 b=F6UX03y3vBNig8bMkXhQQ1iGxH+D0HSCDbeCicWUjFDO+jd9uMdrRQ85gahGDLtTFzxKeT
 SWDcubPiiVWK82Bw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E9E7E2C141;
 Mon,  9 Jan 2023 11:34:30 +0000 (UTC)
References: <20221216115052.30511-1-pvorel@suse.cz> <Y5xt5K1HWp8lHau8@pevik>
 <Y5xvA6FvHtzrK6kU@pevik> <Y6ApXksd2r5bY6MQ@yuki> <Y6Xy82HDbgARCeQr@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 09 Jan 2023 11:19:41 +0000
Organization: Linux Private Site
In-reply-to: <Y6Xy82HDbgARCeQr@pevik>
Message-ID: <87358kj60p.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiocp.c: TCONF on O_DIRECT on tmpfs
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

>> Hi!
>> > > hm, it looks like it requires to skip tmpfs, as all tests TCONF:
>> > > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
>> > > tst_device.c:541: TINFO: Use BTRFS specific strategy
>> > > tst_device.c:559: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)
>
>> > > I check if it'd work without
>> > > e1b1ae66b2 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")
>
>> > TMPDIR=/home/foo ./aiocp -b 1k -n 1 -f DIRECT # xfs
>> > tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
>> > tst_test.c:1310: TINFO: xfs is supported by the test
>> > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
>> > tst_device.c:585: TINFO: Use uevent strategy
>> > aiocp.c:267: TINFO: Fill srcfile.bin with random data
>> > aiocp.c:84: TBROK: write(3,0x7ffeccb9da00,60274) failed: EINVAL (22)
>
>> > TMPDIR=/var/tmp ./aiocp -b 1k -n 1 -f DIRECT # ext4
>> > tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
>> > tst_test.c:1310: TINFO: ext2/ext3/ext4 is supported by the test
>> > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
>> > tst_device.c:585: TINFO: Use uevent strategy
>> > aiocp.c:267: TINFO: Fill srcfile.bin with random data
>> > aiocp.c:84: TBROK: write(3,0x7ffda9e14120,50530) failed: EINVAL (22)
>
>> Ah, I suppose that this fails because we are wrongly passing the
>> srcflags to the open() that fills the source file with random data and
>> we end up passing O_DIRECT to the function that does not aling the
>> buffers and sizes at all.
>
>> Does this fix it?
>
> Hi Cyril,
>
> unfortunately the output is the same on all 3 tested filesystems.
> Any other hint what could fix it?
>

       EINVAL fd is attached to an object which is unsuitable for writing;  or
              the  file  was opened with the O_DIRECT flag, and either the ad-
              dress specified in buf, the value specified  in  count,  or  the
              file offset is not suitably aligned.

I suppose that writes should be aligned to the block size. Which
according to the lengths written they are not. There's also no reason to
open srcfd with O_DIRECT AFAICT?

We could also change fill_with_rand_data to use tst_rand_data. I'll post
a patch

>
> Kind regards,
> Petr
>
>> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
>> index ee893ab11..a75da6a0c 100644
>> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
>> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
>> @@ -263,7 +263,7 @@ static void setup(void)
>
>>         tst_res(TINFO, "Fill %s with random data", srcname);
>
>> -       srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
>> +       srcfd = SAFE_OPEN(srcname, O_WRONLY | O_CREAT, 0666);
>>         fill_with_rand_data(srcfd, filesize);
>>         SAFE_CLOSE(srcfd);
>>  }


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
