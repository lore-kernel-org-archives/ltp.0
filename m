Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC721C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:16:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFD793CC89F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:16:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C59B3C00D1
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:16:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9260F1401145
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:16:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669374999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxAMmT0R8Ui26sGoJHIC5JYoL6cLOZC9QAM7h/hMM28=;
 b=gKPgO+m55ZaxRQN6fu+6/Y/1D8uJ/MS3mYPixb54+jiwJTMGPcv7ib2PXEn2nRI+DAYjKi
 oUVpNkf9hP/ukuStAfUSGdYYcz38bjKdmExuScCsyKutRKWJQ/DKnR7/D972cXb+nwUHsg
 uNnOSUU9UpQL9EWW8nrr+7EI7Xlx778=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-H9ceGyqOPFiiuIdr9unJBQ-1; Fri, 25 Nov 2022 06:16:32 -0500
X-MC-Unique: H9ceGyqOPFiiuIdr9unJBQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 206-20020a1c02d7000000b003d02dc20735so2312307wmc.0
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxAMmT0R8Ui26sGoJHIC5JYoL6cLOZC9QAM7h/hMM28=;
 b=DNTvDp6VexKeFBk5DbbH/eFzVbbBHNrwyTaDhKybjlCYuWQsSayP0+dz8EN1w+gR39
 7/GX3em/hda5ytL9pdiBHM9IGbzQvbph5ZOuerI4qCVhU4g5kaxQGcrmQ5cd9Vewy6H7
 pRr6pUOxmCjfA5rAnXwp+fnP7+fcOBQqZCBw8wuJzaq3JjkDeUJlGBkZ7FklSR8Qotxp
 xId6Udx9N0EpWZ01PloDs5f/Jsm8t00yiDE9y3F5FYs5O+5MUoAFxasmPhoCWK8b8e8K
 B/ZeDWwQY3ZxR4NCmNRhsAkscDxTt0iWKyXX9r6Ty8IXFvA0Uwb+yrWTyN4IyMTj0lLp
 Gakg==
X-Gm-Message-State: ANoB5pkREnY0STGeGJaZ6B3JdzRmYreSycdQozq107qPA3aItZaMw4y7
 WYQkoROAGENgFYZIvwi5NzG+BePaMfb1ruQcJauODKqLRrYWp3kCKmW3isDNDNTgtankdFkj83h
 cEMM7IVYqDhE=
X-Received: by 2002:a05:6000:5c6:b0:241:cb36:9dbf with SMTP id
 bh6-20020a05600005c600b00241cb369dbfmr16272418wrb.504.1669374991546; 
 Fri, 25 Nov 2022 03:16:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4m/u72jtZuRDyDU6b9kkwFdSTpb3kvhyLCjB93NCYkC+L4gkMPuyhViHKYJDvmJN45R7z2pQ==
X-Received: by 2002:a05:6000:5c6:b0:241:cb36:9dbf with SMTP id
 bh6-20020a05600005c600b00241cb369dbfmr16272402wrb.504.1669374991261; 
 Fri, 25 Nov 2022 03:16:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c445100b003c64c186206sm5341234wmn.16.2022.11.25.03.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 03:16:30 -0800 (PST)
Message-ID: <6184eaf7-aee4-669c-aa20-0485c1474e47@redhat.com>
Date: Fri, 25 Nov 2022 12:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>
References: <20221125105201.59048-1-david@redhat.com> <Y4CjI7S/MHnQa7ex@pevik>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4CjI7S/MHnQa7ex@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 25.11.22 12:12, Petr Vorel wrote:
> Hi David,
> 
>> When UFFD_FEATURE_MINOR_SHMEM is not defined, we still have to make the
>> checkpoint happy, otherwise our parent process will run into a timeout.
>> Further, we have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by
>> the UFFD_API ioctl: if the kernel knows about the feature but doesn't
>> support it, it will be masked off.
> 
>> Reported-by: Martin Doucha <mdoucha@suse.cz>
>> Cc: Petr Vorel <pvorel@suse.cz>
>> Cc: Cyril Hrubis <chrubis@suse.cz>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   .../dirtyc0w_shmem/dirtyc0w_shmem_child.c        | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
>> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
>> index cb2e9df0c..c117c6f39 100644
>> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
>> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
>> @@ -24,12 +24,12 @@
>>   #include <linux/userfaultfd.h>
>>   #endif
> 
>> -#ifdef UFFD_FEATURE_MINOR_SHMEM
> Shouldn't be the check and TST_TEST_TCONF() actually be in dirtyc0w_shmem.c?
> I overlooked that, but IMHO test does not make sense at all if
> UFFD_FEATURE_MINOR_SHMEM not defined, right?
> 
> Also Martin noted that ("The parent process should not even fork() when
> UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.").
> 

I tried that first, but then we can still run into the runtime absence 
of UFFD_FEATURE_MINOR_SHMEM. Checking that also in the parent resulted 
in some IMHO unpleasant code while I worked on that.

This is certainly the easiest approach, because we still have to make 
the child program compile either way.

Anyhow, I'll do whatever you decide, because I want to cross this off my 
list. So any guidance on how to complete this would be appreciated.

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
