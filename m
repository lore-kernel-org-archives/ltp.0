Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC346C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:19:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 182BD3CC8D0
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:19:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8DAC3CC885
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:19:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D81460193F
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:19:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669378759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHk09M42JHhUpHMfNWwSd5tr18aQxvUTU2vuISBfC04=;
 b=AF3yzX7rBAfyfaj8JRfJob2JNDIjCMAZxkQipsHbQN3BcOjX4Si+1WB2dBGyL5bbLd2Mqc
 nHhveQufXHFts64WRdMuU7citXsT4pVuiV8ofk91CIKRULDxMRBakwB7wEFqnEo16+kEFm
 3+3NEfFptqPQ7VIIiI9S85mR6GfSznk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-KQdYGvRMM1uq-G9vamUS5g-1; Fri, 25 Nov 2022 07:19:18 -0500
X-MC-Unique: KQdYGvRMM1uq-G9vamUS5g-1
Received: by mail-wr1-f69.google.com with SMTP id
 j20-20020adfb314000000b002366d9f67aaso815358wrd.3
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 04:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bHk09M42JHhUpHMfNWwSd5tr18aQxvUTU2vuISBfC04=;
 b=UjUS1zPwG3ohjs3jk4+lKmumH5j079mGjuutXAfYPsIKeOAXaY8+gMyQKV6tcFt416
 gYQ9xWcWdi5rm9a4ARjMJpSRr/i9CXGCpmInkipyOZHmi+wOk6uvxYPDC+ow7OYfWgQ/
 R0AGIaoUHl0n9R0fP2f15XvJH12v1GrJejE/1hA6Nyh1dLCghDFaRI5KLauyHpiKYPN9
 eBwtNl/d2pAhpJgRmsuqtCRMMR9Kfiv9Gpf5HdDO3ftyd8E6lK0FKq/Q8m/NNUVNXMLY
 ld3Xt1BP/RgW1DKxA32d5Sd4UbZdSttxyJI9PkOR0vrU7GlIAju0GH4LYzFktePqamSs
 IfLg==
X-Gm-Message-State: ANoB5pl5d6FDZSA5Pat4qcOdC4TYX8Xg59tt+t9nQZudYVF4bsG3RBSQ
 zNVkJF1IKFXSdc+WHEmyrbEH6jMNLKDDOqwjbUL/ZClBz64SDn14JSOa2hSJMOL4SX+YPP9o+YH
 jPHNFIE/P2r8=
X-Received: by 2002:a05:600c:4fcd:b0:3cf:a11a:c775 with SMTP id
 o13-20020a05600c4fcd00b003cfa11ac775mr17439531wmq.153.1669378757079; 
 Fri, 25 Nov 2022 04:19:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6VXGrfxpsf5pnwsu/ghAKCoQFMrD1JzeDtA5Nv1ftTOi8roVE0n8mIlOE8GrAFquIgrarztw==
X-Received: by 2002:a05:600c:4fcd:b0:3cf:a11a:c775 with SMTP id
 o13-20020a05600c4fcd00b003cfa11ac775mr17439508wmq.153.1669378756734; 
 Fri, 25 Nov 2022 04:19:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c4ec900b003cfd58409desm10219695wmq.13.2022.11.25.04.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 04:19:16 -0800 (PST)
Message-ID: <59afc5db-c293-b14a-0c13-daa8f7481225@redhat.com>
Date: Fri, 25 Nov 2022 13:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20221125105201.59048-1-david@redhat.com>
 <6ce3a102-f2ec-16be-927d-a32ab46eaf0c@suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6ce3a102-f2ec-16be-927d-a32ab46eaf0c@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Fix remaining cases
 where UFFD_FEATURE_MINOR_SHMEM is absent
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 25.11.22 12:20, Martin Doucha wrote:
> Hi,
> 
> On 25. 11. 22 11:52, David Hildenbrand wrote:
>> When UFFD_FEATURE_MINOR_SHMEM is not defined, we still have to make the
>> checkpoint happy, otherwise our parent process will run into a timeout.
>> Further, we have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by
>> the UFFD_API ioctl: if the kernel knows about the feature but doesn't
>> support it, it will be masked off.
>>
>> Reported-by: Martin Doucha <mdoucha@suse.cz>
>> Cc: Petr Vorel <pvorel@suse.cz>
>> Cc: Cyril Hrubis <chrubis@suse.cz>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    .../dirtyc0w_shmem/dirtyc0w_shmem_child.c        | 16 ++++++++++++----
>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
>> index cb2e9df0c..c117c6f39 100644
>> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
>> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
>> @@ -24,12 +24,12 @@
>>    #include <linux/userfaultfd.h>
>>    #endif
>>    
>> -#ifdef UFFD_FEATURE_MINOR_SHMEM
>> -
>>    #define TST_NO_DEFAULT_MAIN
>>    #include "tst_test.h"
>>    #include "tst_safe_macros.h"
>>    #include "tst_safe_pthread.h"
>> +
>> +#ifdef UFFD_FEATURE_MINOR_SHMEM
>>    #include "lapi/syscalls.h"
>>    
>>    #define TMP_DIR "tmp_dirtyc0w_shmem"
>> @@ -162,6 +162,10 @@ retry:
>>    			"Could not create userfault file descriptor");
>>    	}
>>    
>> +	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
>> +		tst_brk(TCONF,
>> +			"System does not have userfaultfd minor fault support for shmem");
>> +
>>    	uffdio_register.range.start = (unsigned long) map;
>>    	uffdio_register.range.len = page_size;
>>    	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
>> @@ -236,6 +240,10 @@ int main(void)
>>    	return 0;
>>    }
>>    #else /* UFFD_FEATURE_MINOR_SHMEM */
>> -#include "tst_test.h"
>> -TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
>> +int main(void)
>> +{
>> +	tst_reinit();
>> +	TST_CHECKPOINT_WAKE(0);
>> +	tst_brk(TCONF, "System does not have userfaultfd minor fault support for shmem");
>> +}
>>    #endif /* UFFD_FEATURE_MINOR_SHMEM */
> 
> This would work as a workaround but I'd recommend adding the necessary
> structures and constants to include/lapi/userfaultfd.h instead. Then you
> won't need this conditional compilation at all.

That seems to work as well, although I'm still a bit unsure what to 
include in that file, what not, what to strip, ...

I'll use include/lapi/io_uring.h as an orientation but will most 
probably mess it up on the first attempt.

> 
> I also recommend looking at the fuzzy sync library we use for race
> conditions:
> https://github.com/linux-test-project/ltp/wiki/C-Test-API#133-reproducing-race-conditions
> 

I'll look into that as well.

> The original dirtyc0w test was written before this library but using it
> generally makes race condition reproducers faster, simpler and more
> reliable.

Thanks

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
