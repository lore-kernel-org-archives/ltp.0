Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF5AC04A94
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 10:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F2BA3CD68B
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 12:59:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A50DA3C8952
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:59:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F20E6603443
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:59:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF662198F;
 Thu,  3 Aug 2023 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691060366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMeCgsW7iAgqA3F++rPsRpBC0qNMOezni7hi/NuvIMM=;
 b=hXFYhCif14rRWJDNWQn10rk8rPTIox18W0HJFj6osVLeq2O5aQDp/z6xyUScKdx6uS9q6r
 dv/E3XkjTh9zEHUv70YR2CDfB4ZJbdtGU7WYCOz7MFoDqIyTRne5bIP2z/IheRvSXugSu2
 ZT1I9lVS35DrleQ48q0LqBivwN10S4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691060366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMeCgsW7iAgqA3F++rPsRpBC0qNMOezni7hi/NuvIMM=;
 b=z2lCfugGyXiMe+0jPRBZ8Yrhrv3LtjH6ot/yHyzDA40/UYKC2rM1nIu+VsxNl/tA+Y+/JI
 EOv7hmBwX1KNpSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35E38134B0;
 Thu,  3 Aug 2023 10:59:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YJ86DI6Iy2QJIwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 03 Aug 2023 10:59:26 +0000
Message-ID: <66019516-fc86-9fe7-1cc2-76494fa2dd32@suse.cz>
Date: Thu, 3 Aug 2023 12:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Cyril Hrubis <chrubis@suse.cz>, Ian Wienand <iwienand@redhat.com>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <ZMuG5iOmeLH_OhxV@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZMuG5iOmeLH_OhxV@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/device-drivers/zram/zram01.sh : add a sync
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 03. 08. 23 12:52, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
>> index 58d233f91..5f3964f6c 100755
>> --- a/testcases/kernel/device-drivers/zram/zram01.sh
>> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
>> @@ -119,6 +119,9 @@ zram_fill_fs()
>>   				>/dev/null 2>err.txt || break
>>   			b=$(($b + 1))
>>   		done
>> +                # Give the system time to catch up, otherwise the mm_stat
>> +                # checking below can give a false negative
>> +		sync
> 
> I guess that the files written by the dd above end up in page cache and
> are not written out until much later. Does it fix the problem if you add
> fdatasync to the dd commandline? That should be faster than using the
> big hammer and sysncing the whole system.

This is actually a kernel bug reported upstream:
https://lore.kernel.org/linux-block/20221107191136.18048-1-pvorel@suse.cz/

Not only the test files stay in page cache, but the whole VFAT 
superblock seems to disappear from the device as well until sync.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
