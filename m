Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCC2C4708E
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 15:32:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E3CE3CC1DF
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 16:32:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D52723C2B4D
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 16:31:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2010A10000C6
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 16:31:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 17E6821C31
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670340708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udQ8JHwjV3l1wpYvxEUEbUBg9fzr6r7zahbE4PyH428=;
 b=QOKEzVQ1hkIKhUAcAcGRp6SthgRpKQHAGkE9N8CmR/BevNbSRo+tEQoVUzrXYgihtNNVsq
 MtYcM2+auUw9nAcbjdXBMcHackdbAUNzXFX2I6WPR8oZQngwIiNHMdka43M40cXE0DkTbp
 k2WFQFxGCVifvZsY47a5sszFUe9Yi5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670340708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udQ8JHwjV3l1wpYvxEUEbUBg9fzr6r7zahbE4PyH428=;
 b=99/TEO8rJnuqtLpOPW7oGcuBft3tEmlkI+Fk6DBtkko4EN4gUQQpLxYyGe0RJs5wyM6J3W
 EA83ftFTZSc2EsAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E45B32C142;
 Tue,  6 Dec 2022 15:31:47 +0000 (UTC)
References: <20221206115329.17760-1-rpalethorpe@suse.com>
 <20221206115329.17760-2-rpalethorpe@suse.com> <Y49EjvZHd1npsXS7@rei>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 06 Dec 2022 15:22:27 +0000
Organization: Linux Private Site
In-reply-to: <Y49EjvZHd1npsXS7@rei>
Message-ID: <87edtctuos.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fill_fs: Ensure written data is not easily
 compressed
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
>> --- a/lib/tst_fill_fs.c
>> +++ b/lib/tst_fill_fs.c
>> @@ -16,13 +16,20 @@ void tst_fill_fs(const char *path, int verbose)
>>  {
>>  	int i = 0;
>>  	char file[PATH_MAX];
>> -	char buf[4096];
>> +	static char buf[4096];
>
> I'm not sure if caching the random data is worth here, I bet that
> reading the random data would be neglectible to the rest of the write
> operations we do.

I suppose that instead of writing random lengths we could just copy
/dev/urandom to <path> in static chunks of a reasonable size.

Furthermore we can use copy_file_range on newer kernels.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
