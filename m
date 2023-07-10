Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45038EB64D9
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 11:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C27763CB9B0
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 13:14:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 638B03C2FB1
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 13:13:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 47C25600040
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 13:13:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67F4221D62;
 Mon, 10 Jul 2023 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688987630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQLiQNIMEs/7HhFQVbPRaciMEivBLSOQCpcWE9EG/Hs=;
 b=OR4f2AwaR813S37nc03jUo6U1aUyNdl2cgZL/XcmtzSDivoalwV0rYNImfG9szYhvA5vq8
 rXE5gCvoXladaZwZQv+FiF8fCZbIdDDEXYaBFZuZz334h8u4rKM6Le+y05X44LJwdxcqss
 ZK+DkVRAkKkuLTLW88fP+4jtbuRIELA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688987630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQLiQNIMEs/7HhFQVbPRaciMEivBLSOQCpcWE9EG/Hs=;
 b=a4KvEEKqMsY3FIXZtsK/03TVeT6NparE10ZQoOiWkGWrARld9tnOdfMlxU+wdtcDDqHqTg
 zhsKdb+o1RlsDkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D33B1361C;
 Mon, 10 Jul 2023 11:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EOAZEu7nq2SQWwAAMHmgww
 (envelope-from <vbabka@suse.cz>); Mon, 10 Jul 2023 11:13:50 +0000
Message-ID: <b62ecf41-e35d-35f2-9b01-dca1fdf4d611@suse.cz>
Date: Mon, 10 Jul 2023 13:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20230703194904.445661-1-pvorel@suse.cz> <ZKPbSn2qQzxJGxR3@yuki>
 <20230704114658.GC507064@pevik>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230704114658.GC507064@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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
Cc: Fabian Vogt <fvogt@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/4/23 13:46, Petr Vorel wrote:
> Hi Cyril,
> 
>> > +#define PAGE_SIZE 4096
> 
>> This wouldn't work on 64k page size.
> 
>> > +#define MMAP_SIZE ((ARRAY_SIZE(tcases)+1)*PAGE_SIZE)
>> > +#define MREMAP_SIZE (ARRAY_SIZE(tcases)*PAGE_SIZE)
> 
>> These have to be variables initialized on the fly with getpagesize()
>> instead of PAGE_SIZE.
> 
> Yep, I thought about getpagesize().

Agreed.

Also IMHO it's awkward to have the number of pages and the iterations
expressed using ARRAY_SIZE(tcases). I'd say it's just an accident that the
number of pages involved in the merging and the number of testcases is both
3. I'd rather separate those.

> ...
>> > +static int check_pages(void)
>> > +{
>> > +	int fail = 0, i;
>> > +	char val;
>> > +
>> > +	for (i = 0; i < (int)ARRAY_SIZE(tcases); i++) {
>> > +		val = buf[i * PAGE_SIZE];
>> > +		if (val != 0x30 + i) {
>> > +			tst_res(TFAIL, "page %d wrong value %d (0x%x)", i, val - 0x30, val);
> 
>> Woudn't this generate too many FAILURE messages? Maybe we should just
>> break the for cycle here.
> 
> It could be. I wasn't sure if it's important to know which pages were wrong.

There's just 3 pages to print so it won't be that many messages, I'd just
print them all.

> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
