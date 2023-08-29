Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2E9C6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 10:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA3AF3CC114
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 12:09:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66D423CA99A
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:09:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BC74600C77
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:09:06 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9E92121860;
 Tue, 29 Aug 2023 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693303744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PybdnII3DMKg363B4w2KxvzvisnF9W0sY69klzUth4A=;
 b=y7t0nQl9SucRXQo4Fyz5d2cyK3CTdBBPRWkRFwXt4hIlINGupYsChJEM0uSgsgfMUSU/kq
 iEvqHAslO9MdPYy20Dn7omSaaE4gybiVVk99JDfJzDP7ZyTnNfuShwvk8L212lFphu6IbE
 xfHOf0uvlRZNk+J90OdzaUJ9/EgKT/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693303744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PybdnII3DMKg363B4w2KxvzvisnF9W0sY69klzUth4A=;
 b=r6t/FV/w7tl8k9R0bADIa87S9sp/VjLumvEom2n14UayJtiqyYnZMiTTTTFSDYkqM8Louh
 l/ZIvl4DmnnvqnAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 087462C143;
 Tue, 29 Aug 2023 10:09:02 +0000 (UTC)
References: <20230609012740.19097-1-zhanghongchen@loongson.cn>
 <f847e7db-f894-4ce8-6ea5-95817531ea89@suse.cz>
 <5b76add3-4bdf-a1e3-d09c-734f2bdeb9f5@loongson.cn>
 <a4057bbd-1ff0-5bd4-8573-7872b23f20ce@suse.cz>
 <8d553b8e-88ba-79c5-2dfe-893a82be1046@loongson.cn>
 <14c9865f-9300-b1af-1594-a95a98cd85ba@loongson.cn>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Date: Tue, 29 Aug 2023 10:25:57 +0100
Organization: Linux Private Site
In-reply-to: <14c9865f-9300-b1af-1594-a95a98cd85ba@loongson.cn>
Message-ID: <87zg2ai2is.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Hongchen Zhang <zhanghongchen@loongson.cn> writes:

> Hi Chril,
> Any suggestion about this patch?
>
> On 2023/6/16 pm 6:13, Hongchen Zhang wrote:
>> Hi Martin,
>> On 2023/6/16 pm 5:31, Martin Doucha wrote:
>>> On 16. 06. 23 4:10, Hongchen Zhang wrote:
>>>> Hi Martin,
>>>>
>>>> On 2023/6/15 pm 10:27, Martin Doucha wrote:
>>>>> Hi,
>>>>>
>>>>> On 09. 06. 23 3:27, Hongchen Zhang wrote:
>>>>>> When I test the cpuset_memory_spread case,this case FAIL too often.
>>>>>> After dig into the code, I find out that the fowlloing things trigger
>>>>>> the FAIL:
>>>>>> 1) random events,the probability is very small and can be ignored
>>>>>> 2) get_meminfo which before send signal to test_pid
>>>>>> 3) account_memsinfo before result_check
>>>>>>
>>>>>> About 2) and 3), we can increase the value of lowerlimit to keep
>>>>>> the result as SUCCESS.After my testing, 5000kb is a reasonable value.
>>>>>
>>>>> we're also seeing these failures but only on architectures like
>>>>> PowerPC with pagesize higher than the usual 4KB. On which
>>>>> architectures do you see failures and what's the pagesize there?
>>>> I test on 3C5000+7A2000 machine, the architecture is LoongArch.The
>>>> pagesize we used is 16KB.
>>>
>>> So the underlying cause is the same - higher pagesize. That means
>>> the upperlimit, lowerlimit and DATAFILE size should be calculated
>>> from pagesize instead.IMO,upperlimit and DATAFILE size will not
>>> affect the result.
>> Change the lowerlimit like following?
>> lowerlimit = 2000kb*get_pagesize()/SIZE_4K;

This formula looks ok, but you need to scale the other values by the
page size as well.

Also I would recommend ensuring all values are multiples of the page
size because the kernel will round up to the nearest page
size.

So lowerlimit = 4096 * 5 = 2048Kb
or lowerlimit = 16384 * 5 = 8192Kb

Maybe the upperlimit should be 5 * lowerlimit? Because we want the
gap/spread to get bigger too. I don't know if the DATAFILE needs to
change in size it is already 500MB.

Alternatively you could just create a lookup table with values for each
page size we have tested. e.g.

switch (get_pagesize()) {
       case 4096: 2048Kb
       case 16384: 8192Kb
       default: ...
}

This may be better if the values to do not scale linearly. Which is
totally possible because the page size effects most things and there
could be feedback loops.

Please submit another patch if you are still interested.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
