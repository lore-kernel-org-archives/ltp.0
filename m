Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF109C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 494D83CAEA6
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:33:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF6BD3C1769
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:32:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D480F1000A5D
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:32:58 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CC4BE22070;
 Tue, 11 Oct 2022 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665491577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubDNespzVSu5dvmI7B7XqH+8e/NXS5Yb+AB8s5vxlEE=;
 b=kXJuwYXinuAeUOamvE76rIkNP0VyfK6dYuVSRsIb7qbbm9U9YzCwLd/7KQo7/leIrq7lad
 ASUIoqvVbKmwEiyK6nscv4W9eqM/E/xLzBX0C+Mq0ZDEPKTUhnqND4scZPbThlkh7kWQwt
 ZiGCSfqwc2n5zE3qjeHWyXy3ZD+R2pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665491577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubDNespzVSu5dvmI7B7XqH+8e/NXS5Yb+AB8s5vxlEE=;
 b=2oxd4PENzGFoj2v/sWS9JyuMereQpwIRPuXM8l9AqxhPK3FGCZITNrP7afJNVgHCZs3GAb
 xhcaDIE4VfFuxIDA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 13E372C141;
 Tue, 11 Oct 2022 12:32:56 +0000 (UTC)
References: <20220816115905.29680-1-andrea.cervesato@suse.com>
 <YwNZkNhdNgAtXPAq@yuki>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Oct 2022 13:29:06 +0100
In-reply-to: <YwNZkNhdNgAtXPAq@yuki>
Message-ID: <871qre7d72.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] Refactor aiocp using new LTP API
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
>> +	while (i < size) {
>> +		if (!tst_remaining_runtime())
>> +			tst_brk(TCONF, "Out of runtime!");
>>  
>> -	if (!prefix_max) {
>> -		fprintf(stderr, "Path '%s' not found in /proc/mounts\n", path);
>> -		return 0;
>> -	}
>> -
>> -	printf("Path '%s' is on device '%s'\n", path, dev_name);
>> +		offset = rand() % (bufsize / 2);
>
> This is now length not offset, also now the size we pass to the write
> varies between 0 and bufsize/2. Shouldn't we rather go for a size
> between bufsize/2 and bufsize?
>
> 	len = rand() % (bufsize/2) + bufsize/2;
> 	towrite = MIN(len, size-i);
>

Also setting this one to "changes requested".


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
