Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671A5C7618E
	for <ltp@archiver.kernel.org>; Sun, 23 Apr 2023 03:05:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D210C3CBEF1
	for <ltp@archiver.kernel.org>; Sun, 23 Apr 2023 05:05:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3024E3CB318
 for <ltp@lists.linux.it>; Sun, 23 Apr 2023 05:04:53 +0200 (CEST)
Received: from m133.mail.163.com (m133.mail.163.com [220.181.13.3])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id EB73E600126
 for <ltp@lists.linux.it>; Sun, 23 Apr 2023 05:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=Q4N77wtG7I7GtdXb86/56pRZHGaddZQedYiDeWdFYsE=; b=L
 m41C9rjNZ+FurCKIyTMbeaY2tVrFSn71OX4DJU+46wfS6CGp3xO8oQz+nGIe76Yr
 r77+6qgi6zDZZqBKB0vQrrDsuAggOPXviS4X/ZN9KT2CQhjETRGy2OFHonKJc/bk
 pxwUfbbbbeP4nghiepdrdmNNWXDqYHpr4ZngRkyxvw=
Received: from crawler2015$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr3 (Coremail) ; Sun, 23 Apr 2023 11:04:47 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date: Sun, 23 Apr 2023 11:04:47 +0800 (CST)
From: zenghao  <crawler2015@163.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZEJyud8Yxb1QdZbh@yuki>
References: <3620f7c2.2af5.18768f7ce86.Coremail.crawler2015@163.com>
 <ZEJyud8Yxb1QdZbh@yuki>
X-NTES-SC: AL_QuyTAP6atkgj4SefYOkXnkoTj+Y3WsW5uPQh349XP5k0tindxj4eeG9sHljd3ey1IQKIoAi8SjFczehlVLR0Tr5NmpAflpf8l/FoVs0/BanE
MIME-Version: 1.0
Message-ID: <6ccc9b47.2708.187ac1237a2.Coremail.crawler2015@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: A8GowAB3jq5PoERkwuwTAA--.55164W
X-CM-SenderInfo: pfud4zthusiiqv6rljoofrz/xtbBdQ9aAlaEENciMAAAsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Subject: [PATCH] fs/doio:Use the snprintf function to
 prevent buffer overflow
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

Hi Cyril, Thanks very much for your review!

I have changed my email address to zenghao@kylinos.cn and provided V2.
Thank you again for the correction, I will learn and correct it


Best regards
-- Hao
At 2023-04-21 19:25:45, "Cyril Hrubis" <chrubis@suse.cz> wrote:
>Hi!
>> From 044a942863dc0ac84701bc14d78f4d7fc0bb8dcb Mon Sep 17 00:00:00 2001
>> From: Hao Zeng <zenghao@kylinos.cn>
>> Date: Mon, 10 Apr 2023 09:17:34 +0800
>> Subject: [PATCH] fs/doio:Use the snprintf function to prevent buffer overflow
>>  Use the snprintf function instead of sprintf in the write_log.c file
>>  Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
>
>The actual change looks good, however the patch is corrupted, looks like
>your email client replaced spaces 0x20 with unicode non-breakable spaces
>0xc2a0.
>
>See: https://www.kernel.org/doc/html/v4.10/process/email-clients.html
>
>> ---
>>  testcases/kernel/fs/doio/write_log.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> 
>> diff --git a/testcases/kernel/fs/doio/write_log.c b/testcases/kernel/fs/doio/write_log.c
>> index e8ef9c7cb..86297b01d 100644
>> --- a/testcases/kernel/fs/doio/write_log.c
>> +++ b/testcases/kernel/fs/doio/write_log.c
>> @@ -129,7 +129,7 @@ int wlog_open(struct wlog_file *wfile, int trunc, int mode)
>>  	umask(omask);
>>  
>>  	if (wfile->w_afd == -1) {
>> -		sprintf(Wlog_Error_String,
>> +		snprintf(Wlog_Error_String,sizeof(Wlog_Error_String),
>                                           ^
>					   There should be space after
>					   comma.
>
>-- 
>Cyril Hrubis
>chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
