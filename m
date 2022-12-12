Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0CDC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C1973CBE62
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 17:21:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A5F3CBE28
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:21:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D438420075E
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:21:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DB6381FDE2;
 Mon, 12 Dec 2022 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670862089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDNQVQvt+ulveJz50xmnDsBRT/7pq7Gu/UjvscVv4zg=;
 b=y1SWNVPmsppRHhCybKJAdfxJcWCIPtWsaDUmi3bYT0Zosk2jzRf/qlL45dHJ/xA3KOySwW
 Hkqz+XGPAEI6IZRqcNtsRvaYspXIJJarMCKF2R2DW6rjm4PjdrZ+Sb8+QWsHrwaRshlMTu
 ZQ61VT9gF5EJqBkbKK/208ZHdoFZ2m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670862089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDNQVQvt+ulveJz50xmnDsBRT/7pq7Gu/UjvscVv4zg=;
 b=JOemSs2YXXEI/iaHBcg/SB2tnAaXb1bIrIXj11PZMZRZeQUyq1S0/9jllzMO/sLm5cLOex
 Nm7blIWP1WgWQeCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A40442C141;
 Mon, 12 Dec 2022 16:21:29 +0000 (UTC)
References: <20221212135524.1333-1-rpalethorpe@suse.com>
 <20221212135524.1333-3-rpalethorpe@suse.com> <Y5dSLjK2MlCHMPN7@pevik>
 <Y5dTzSQcwpfyRlna@rei>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2022 16:20:23 +0000
Organization: Linux Private Site
In-reply-to: <Y5dTzSQcwpfyRlna@rei>
Message-ID: <87o7s8sid2.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] tst_fill_fs: Add alternate access pattern
 "flat"
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
>> > Depending on the workload, the way in which a file system is filled
>> > will be different. The system calls will also be different.
>> 
>> > This adds a fill mode which uses writev with uniform batches of
>> > data. This simulates when the FS is filled by a program which batches
>> > writes.
>> ...
>> 
>> FYI this broke CI on Alpine.
>> 
>> > +++ b/lib/tst_fill_fs.c
>> ...
>> > +void fill_flat_vec(const char *path, int verbose)
>> > +{
>> > +	int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
>> 
>> Alpine has problem with O_FSYNC:
>> 
>> In file included from ../include/tst_test.h:110,
>>                  from tst_fill_fs.c:13:
>> tst_fill_fs.c: In function 'fill_flat_vec':
>> tst_fill_fs.c:76:58: error: 'O_FSYNC' undeclared (first use in this function); did you mean 'O_ASYNC'?
>>    76 |         int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
>>       |                                                          ^~~~~~~
>> ../include/tst_safe_macros.h:90:58: note: in definition of macro 'SAFE_OPEN'
>>    90 |         safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
>>       |                                                          ^~~~~~
>> tst_fill_fs.c:76:58: note: each undeclared identifier is reported only once for each function it appears in
>>    76 |         int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
>>       |                                                          ^~~~~~~
>> ../include/tst_safe_macros.h:90:58: note: in definition of macro 'SAFE_OPEN'
>>    90 |         safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
>>       |                                                          ^~~~~~
>> make: *** [../include/mk/rules.mk:15: tst_fill_fs.o] Error 1
>> 
>> It actually does not have it in fcntl.h (and nowhere in the sources).
>
> O_FSYNC originates from BSD it should be O_SYNC on Linux, but given that
> this is only file descriptor passed to later openat() we can just remove
> it instead since it does not make sense at all.

Ah, that was supposed to be added to the next open. However I guess it
can just be removed.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
