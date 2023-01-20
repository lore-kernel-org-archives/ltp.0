Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB5C05027
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 15:15:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52FC63CC817
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 16:15:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95FA3C18A6
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 16:15:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC8C6200ACD
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 16:15:18 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 426B95FADD
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674227718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+weYUcewhqPo5v2IMhF9rsi6Cm4e+CRDsev5ZNk4iAU=;
 b=xt4AMl2M7ZIp31oRSi4rwhHK1qwmUNd561lz7JGMBpmUvU+FvRzXsHBx7yL7XGIttu+XK6
 4zvJpYML9a29WdEHgyutmB24x5qHyXEyn1L+/acO1q8uOgyZojFAALSyShfuXmsRStg+A+
 XdBWX2YzSs/Lf3Ln2ULqfKNuFHbFzqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674227718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+weYUcewhqPo5v2IMhF9rsi6Cm4e+CRDsev5ZNk4iAU=;
 b=8c725FGZcYoDGTIkSeU53HJaW+tRUrEHxLnpbDOrDfVciRc9fLnehiFbNZGgg5+S9jBPnj
 49vQ1ou0lCI/WSCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1A9EE2C141;
 Fri, 20 Jan 2023 15:15:18 +0000 (UTC)
References: <20230120135651.24816-1-rpalethorpe@suse.com>
 <Y8qtvIrfMQP9BlX4@yuki>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Jan 2023 15:11:17 +0000
Organization: Linux Private Site
In-reply-to: <Y8qtvIrfMQP9BlX4@yuki>
Message-ID: <87y1pxqltm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_assert: Fix buffer overflow in scanf
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

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> The maximum field width of a string conversion does not include the
>> null byte. So we can overflow the buffer by one byte.
>> 
>> This can be triggered in ioctl_loop01 with -fsanitize=address even if
>> the file contents are far less than the buffer size:
>> 
>> tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
>> tst_device.c:93: TINFO: Found free device 1 '/dev/loop1'
>> ioctl_loop01.c:85: TPASS: /sys/block/loop1/loop/partscan = 0
>> ioctl_loop01.c:86: TPASS: /sys/block/loop1/loop/autoclear = 0
>> =================================================================
>> ==293==ERROR: AddressSanitizer: stack-buffer-overflow on address 0xf5c03420 at pc 0xf7952bf8 bp 0xff9cf9f8 sp 0xff9cf5d0
>> WRITE of size 1025 at 0xf5c03420 thread T0
>>     #0 0xf7952bf7  (/lib/libasan.so.8+0x89bf7) (BuildId: f8d5331e88e5c1b8a8a55eda0a8e20503ea0d2b9)
>>     #1 0xf7953879 in __isoc99_vfscanf (/lib/libasan.so.8+0x8a879) (BuildId: f8d5331e88e5c1b8a8a55eda0a8e20503ea0d2b9)
>>     #2 0x8071f85 in safe_file_scanf /home/rich/qa/ltp/lib/safe_file_ops.c:139
>>     #3 0x80552ea in tst_assert_str /home/rich/qa/ltp/lib/tst_assert.c:60
>>     #4 0x804f17a in verify_ioctl_loop /home/rich/qa/ltp/testcases/kernel/syscalls/ioctl/ioctl_loop01.c:87
>>     #5 0x8061599 in run_tests /home/rich/qa/ltp/lib/tst_test.c:1380
>>     #6 0x8061599 in testrun /home/rich/qa/ltp/lib/tst_test.c:1463
>>     #7 0x8061599 in fork_testrun /home/rich/qa/ltp/lib/tst_test.c:1592
>>     #8 0x806877a in tst_run_tcases /home/rich/qa/ltp/lib/tst_test.c:1686
>>     #9 0x804e01b in main ../../../../include/tst_test.h:394
>>     #10 0xf7188294 in __libc_start_call_main (/lib/libc.so.6+0x23294) (BuildId: 87c7a50c8792985dd164f5af2d45b8e91d9f4391)
>>     #11 0xf7188357 in __libc_start_main@@GLIBC_2.34 (/lib/libc.so.6+0x23357) (BuildId: 87c7a50c8792985dd164f5af2d45b8e91d9f4391)
>>     #12 0x804e617 in _start ../sysdeps/i386/start.S:111
>> 
>> Address 0xf5c03420 is located in stack of thread T0 at offset 1056 in frame
>>     #0 0x805525f in tst_assert_str /home/rich/qa/ltp/lib/tst_assert.c:57
>> 
>>   This frame has 1 object(s):
>>     [32, 1056) 'sys_val' (line 58) <== Memory access at offset 1056 overflows this variable
>
> Uff, looking closely at the scanf manual:
>
> String input conversions store a terminating null byte ('\0') to mark
> the end of the input; the maximum field width does not include this
> terminator.
>
> So do I get it right that scanf() actually writes one byte after the
> size passed after the % character? That sounds a bit evil to me.

Yes, I suppose the root cause is null terminated strings. ;-)

>
> Anyways:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
