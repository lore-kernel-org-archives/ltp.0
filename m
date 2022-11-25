Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E35C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:42:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB20A3CC87C
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:42:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4752A3CC877
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:42:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C085601364
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:42:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669372956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eotA0SzwkeP+I3tmAJ/Ptw/nnuaoG58s0lhhj9CqA+Y=;
 b=W4INhk0vBN047b8ZrN7OpNPFFP+mZbqXP6TxXJLArqrAaTAH0gPfO8bC4MJQQv7Cmh5Yy/
 ejr0+i5XQTsPbJTuHtIVl1Xky2j8qo0+71oD+lEKt73DHXyJBzy2XKycXii+LA6z3w46dP
 +iJhYvwTubYe6FNrUT5Rl/tsMTUqihc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-yBz0vVJhNwWdmo46EZIemA-1; Fri, 25 Nov 2022 05:42:34 -0500
X-MC-Unique: yBz0vVJhNwWdmo46EZIemA-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg25-20020a05600c3c9900b003cf3ed7e27bso2250014wmb.4
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eotA0SzwkeP+I3tmAJ/Ptw/nnuaoG58s0lhhj9CqA+Y=;
 b=IqLTNUL7b5+zwXBdlnCMcySSJCipk1t4sm0FYORZS1kmcfR5F60NdLR1rUSXeri78z
 hiCSbcw6GAyLixNNz+rbq3l3IXLctn0VzoKBbSjM4P/68WhVetvz15AuEc81aZZaGJP6
 TiBYaFvVlXDWsV8JisyU6h2pkrm/axwYW1eIJzgTn7+tdRKsxsQBEiuCYf1zKgncALX1
 nDYUjmxMAvmf0n6+LGS6dkGWVxx57db0DmbxAodKkDrbSZJSOYWtnVQaRzmOoZYUqcy+
 A5nPlqmWwYNw60qolHyWqPUyMX+gneGYmZhofk/FJNIX6HtUEVCWxb63IN2H23DEQ4rm
 HhaA==
X-Gm-Message-State: ANoB5plT3yNQQxEauS8MrVQcccZHh8wEntI9Cm3kd6RR2Etm8bthAOBB
 jcZTKSg0jwlWibC5wye1Y2WjaoLjbwuz1wfgiShBQHM8ddaqPjaoatD4P4xgFIf9Tzyc9EAH5kJ
 dbgNnO6tRXjw=
X-Received: by 2002:a05:600c:548b:b0:3cf:b0e4:30d9 with SMTP id
 iv11-20020a05600c548b00b003cfb0e430d9mr20260824wmb.66.1669372953430; 
 Fri, 25 Nov 2022 02:42:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5dA5g0oYLfR0t/1A//9IP7uMfqDKDH5rKSw8SnfCaO6MIZl7c5X1pl7mTSIPNxWVdla/EVcA==
X-Received: by 2002:a05:600c:548b:b0:3cf:b0e4:30d9 with SMTP id
 iv11-20020a05600c548b00b003cfb0e430d9mr20260799wmb.66.1669372953156; 
 Fri, 25 Nov 2022 02:42:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 l35-20020a05600c1d2300b003cf878c4468sm9768585wms.5.2022.11.25.02.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 02:42:32 -0800 (PST)
Message-ID: <0b5441ef-53cf-a540-cfbd-998629a6d349@redhat.com>
Date: Fri, 25 Nov 2022 11:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz> <Y4CTrrCb4jtQay9y@pevik>
 <da91a3a8-4609-c128-1c73-8b35dfb2b7c9@redhat.com>
 <af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz>
 <79125e1d-760f-432f-1814-502521347680@redhat.com> <Y4CbcQhk/UMkpfEX@pevik>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4CbcQhk/UMkpfEX@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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

On 25.11.22 11:39, Petr Vorel wrote:
>> On 25.11.22 11:25, Martin Doucha wrote:
>>> On 25. 11. 22 11:20, David Hildenbrand wrote:
>>>> See my other mail, it's the case on all instances that pass NULL (and I
>>>> don't really see the need to do this when working with NULL.
> 
>>> NULL may be defined as simple integer 0. When int is 32bit and pointers
>>> 64bit, this will cause trouble in variadic functions such as execlp().
>>> You do not need to remind us that LTP tests have lots of bugs, we know.
> 
>> I can send a fixup patch for all these instances.
> 
> Thank you!

The list of SAFE_EXEC* was fairly short, now I discovered manual execl*
usage... let me get a patch ready to fix all these :)

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
