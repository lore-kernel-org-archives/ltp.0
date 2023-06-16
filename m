Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333D4EB64DA
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 09:31:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08F4E3CC522
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 11:31:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BB3B3CB0C9
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 11:31:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A56361400323
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 11:31:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B20191FDEB;
 Fri, 16 Jun 2023 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1686907899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMD3aBe7euzXrJTvXeyLyAt2rW+RuXrIrJ77w0JK9dg=;
 b=ZFzwfMy7g5BiN4dQPEZyMDwSrk5HCwZJ8DV3AauQdsYVgCOzKJbQNZfygPA2mc5oLhPCO5
 KDCgrB2pVvsiZalSx6uc4ISlOHek7jF4ok4GK0dKxu+3Vm1alyy94Im6pS1500zuY5nTlf
 mX0k3VBGOabzxQiNvJk/R5WEKh2N3uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1686907899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMD3aBe7euzXrJTvXeyLyAt2rW+RuXrIrJ77w0JK9dg=;
 b=QzsbZRaufxZdf7qNDPHYng+XePgkGgaSr+dqx7yAi1Of3PsqF8+/ZEY6OL3IA0UQXi8mjI
 bWzsS91mAcmT3VDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 983C3138E8;
 Fri, 16 Jun 2023 09:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bTpPJPsrjGQXTgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 16 Jun 2023 09:31:39 +0000
Message-ID: <a4057bbd-1ff0-5bd4-8573-7872b23f20ce@suse.cz>
Date: Fri, 16 Jun 2023 11:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Hongchen Zhang <zhanghongchen@loongson.cn>, Cyril Hrubis
 <chrubis@suse.cz>, Petr Vorel <petr.vorel@gmail.com>
References: <20230609012740.19097-1-zhanghongchen@loongson.cn>
 <f847e7db-f894-4ce8-6ea5-95817531ea89@suse.cz>
 <5b76add3-4bdf-a1e3-d09c-734f2bdeb9f5@loongson.cn>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <5b76add3-4bdf-a1e3-d09c-734f2bdeb9f5@loongson.cn>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory_spread: change lowerlimit to 5000kb
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

On 16. 06. 23 4:10, Hongchen Zhang wrote:
> Hi Martin,
> 
> On 2023/6/15 pm 10:27, Martin Doucha wrote:
>> Hi,
>>
>> On 09. 06. 23 3:27, Hongchen Zhang wrote:
>>> When I test the cpuset_memory_spread case,this case FAIL too often.
>>> After dig into the code, I find out that the fowlloing things trigger
>>> the FAIL:
>>> 1) random events,the probability is very small and can be ignored
>>> 2) get_meminfo which before send signal to test_pid
>>> 3) account_memsinfo before result_check
>>>
>>> About 2) and 3), we can increase the value of lowerlimit to keep
>>> the result as SUCCESS.After my testing, 5000kb is a reasonable value.
>>
>> we're also seeing these failures but only on architectures like 
>> PowerPC with pagesize higher than the usual 4KB. On which 
>> architectures do you see failures and what's the pagesize there?
> I test on 3C5000+7A2000 machine, the architecture is LoongArch.The 
> pagesize we used is 16KB.

So the underlying cause is the same - higher pagesize. That means the 
upperlimit, lowerlimit and DATAFILE size should be calculated from 
pagesize instead.

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
