Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF53ECAAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 08:58:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53A493CACB1
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 10:58:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E0A03CA493
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:57:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26FD0600734
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:57:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 674301FA46;
 Mon, 19 Sep 2022 08:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663577876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/yZGYKgAkZP3PLOfye23X5qIlRv+5xmwHNiW6PxFHU=;
 b=tCeEHkEHh/UKmcVPz+XcSNmAzAnQM4JMiCfNGg8Xozq7/eN+WaJRlQhd+TOL+w71YXLkZs
 Z/W5kRbR5lPNWN0xT6iVIm0RH2MgKRyquLfH3P8L5RMOO/5gymQ8PVJ5LyClOaYwjuHJvh
 L6JiIkBtGJwAvF0UvtQeHF4N+jQBCOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663577876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/yZGYKgAkZP3PLOfye23X5qIlRv+5xmwHNiW6PxFHU=;
 b=qwnVda5B+7i6TEts6mBIiNJu8HtelFB7u1eUica6jC8amxtNBFCvr50PHnKlnTU7sxtjtl
 Yu58Owf9o2HZgxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A30413A96;
 Mon, 19 Sep 2022 08:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A1TQDBQvKGOnSAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 19 Sep 2022 08:57:56 +0000
Message-ID: <207b6fed-27df-6d1d-113c-6f9c771cabe5@suse.cz>
Date: Mon, 19 Sep 2022 10:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, lkft@linaro.org
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YyfeaeMsvACB5dcf@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Cc: Martin Doucha <martin.doucha@suse.com>, lkft-triage@lists.linaro.org,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 19. 09. 22 5:13, Petr Vorel wrote:
> Hi all,
> 
>> ## Build
>> * kernel: 5.18.19
>> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
>> * git branch: linux-5.18.y
>> * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
>> * git describe: cea142b
>> * test details: https://qa-reports.linaro.org/lkft/ltp/build/cea142b
> 
>> ## Test Regressions (compared to 98140f3)
>> * qemu_i386, ltp-controllers
>>    - cpuacct_100_100
> 
>> * qemu_x86_64, ltp-cve
>>    - cve-2018-1000204
> OK, 3252ea38d ("ioctl_sg01: Add max_runtime") didn't help.
> 
> looking at the log [1] I don't see anything obvious why test timeouts:
> 
> tst_test.c:1524: TINFO: Timeout per run is 0h 00m 30s

I do. The line above is supposed to say "Timeout per run is 1h 00m 30s" 
instead. Whatever LTP version this was, it did not have the ioctl_sg01 
max_runtime patch applied.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
