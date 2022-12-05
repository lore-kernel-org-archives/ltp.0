Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F740C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 09:28:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5509A3CC1F3
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 10:28:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B6473CC1ED
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 10:27:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD851100CCA5
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 10:27:54 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0DA1121BB8;
 Mon,  5 Dec 2022 09:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670232473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvuF2TOIgdvG9yWi6NJOfa/lC6a6F5EtCQOei8eAfds=;
 b=Z0yNgSlK+bLA4/UXZ2YWv+580ivxUagcogYm4gpS9OjlxrFoQUwTVbEVW0ncjV8EpaW2l8
 v32ePbQwxL1ofhj5gprY6u2U83th7c82JBTr0NpxTlMBQGAJwumG4ArxJsW1t6ssawjNsh
 js6MH3JmYj7J1y7Q1FBKp+asXT4e0vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670232473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvuF2TOIgdvG9yWi6NJOfa/lC6a6F5EtCQOei8eAfds=;
 b=CQMQ6NAoBbb0KD5hcw1gb9uLlpHWLpcyfJZBIdHGKMmcz1AtAdxvtIpctMAcN5VzkN+TJz
 MO2KZQ+rfLoGTZBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BB0362C143;
 Mon,  5 Dec 2022 09:27:52 +0000 (UTC)
References: <20221125122546.99144-1-david@redhat.com>
 <Y4DL5928NpuPI2Q6@pevik> <58d046ff-c89c-611c-0607-c2ec8f556526@redhat.com>
 <Y4SXTPBViJiqulow@pevik> <c43283e1-e969-46e0-f933-a18c2a6428f5@suse.cz>
 <87wn7dsudx.fsf@suse.de>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Mon, 05 Dec 2022 09:22:05 +0000
Organization: Linux Private Site
In-reply-to: <87wn7dsudx.fsf@suse.de>
Message-ID: <87cz8yurn1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] execl(),
 execlp() and execle() require proper termination of argument list
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
Cc: David Hildenbrand <david@redhat.com>, ltp@lists.linux.it,
 Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Martin Doucha <mdoucha@suse.cz> writes:
>
>> On 28. 11. 22 12:11, Petr Vorel wrote:
>>> Hi Michael,
>>> sorry to bother you, could you please comment our discussion about
>>> execl{,e,p}()
>>> termination of argument list being NULL vs. (char *)NULL vs. (void*)0?
>>> Martin reported [2] that man page suggests (char*)NULL, his view of
>>> reason [3]:
>>> NULL may be defined as simple integer 0. When int is 32bit and pointers
>>> 64bit, this will cause trouble in variadic functions such as execlp().
>>> Cyril pointed out [4]: NULL is required to be 0 cast to void* in
>>> POSIX. [5]
>>> Therefore what should be really used?
>>> Kind regards,
>>> Petr
>>> [2]
>>> https://lore.kernel.org/ltp/8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz/
>>> [3] https://lore.kernel.org/ltp/af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz/
>>> [4] https://lore.kernel.org/ltp/Y4DSmk7uY9zUUQsV@yuki/
>>> [5] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stddef.h.html
>>
>> Cyril is correct that we don't need this fix as long as we use C99 or
>> later with POSIX-compliant build system. The explicit type cast is
>> required only in C++ where there's no explicit conversion from void*
>> to other pointer types and therefore NULL must be defined as integer
>> instead of void* pointer constant.
>>
>> Then again, pedantically following the docs won't break anything either.
>>
>> Acked-by: Martin Doucha <mdoucha@suse.cz>
>
> I think the docs are wrong here, they should probably specify where it
> is needed to cast to (char *). We are (now) using a superset of c99 so
> we are not effected.
>
> The issue I see is that this is yet another thing to remember to enforce
> and for no apparent benefit. OTOH if there is some compiler/analyser
> flag which creates a warning then I would not be against adding that.

Setting this to Not Applicable in patchwork. This is not final, but it
will remove it from the queue.

>
> -- 
> Thank you,
> Richard.




-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
