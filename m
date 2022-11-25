Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B699C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B8F63CC89F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:20:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9F873C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:20:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A433C200B9C
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669371610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srH4A7dCBjEi1vo4lYTH9O83B/2GNZ2835LzwhM8fyM=;
 b=QOqItbV6ryGphSPl9oKilIF0EeVmJvPLkklaBSLmHnGmvlES3zx5rEzUiYu+M+OABH8by6
 FtJjpfkYFijaspuE8sE+X6PqozpKFZhoimHs+AA2+Qk8T80eiyL0PiYLiXkYrrpjHNIJkB
 hpH3ew1GoJ9YjVUSmS0TnFjhHfAjFoc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-L7nGRdcSMwKkCYbjpkn7GQ-1; Fri, 25 Nov 2022 05:20:08 -0500
X-MC-Unique: L7nGRdcSMwKkCYbjpkn7GQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 m17-20020a05600c3b1100b003cf9cc47da5so2215937wms.9
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srH4A7dCBjEi1vo4lYTH9O83B/2GNZ2835LzwhM8fyM=;
 b=GLpme0G2idIQf6gXdwUopio8sFl+2h7m7IOCpPC3sJjBNQ3VpIHogXgJweE4Qd1eVg
 ZGkNdBB0lC1FQ/eHtYYwbG2M8XGR68IvazcfHNopRSeHR9JK1Mcz3vqCud/38gBg+A36
 ks3ZFGrEsY3bNKyf/IqkbFxAWU4y5vQ5zWXDtt5O2VFNLGMRx0j5SLFfmrr+u8USU7La
 0DaS8H50x4F6TqUH+NLcBR8Px8yO0WQmgvPvhY1vdtnJMUjAVU8dWSBxQvWz9ZurvjlZ
 VZ0JDWe31syG0vXq3tjjks57KcL9c/njHT1b3PAL1AKJWyn/k929bbhXpgR5RSS26Mvx
 YFww==
X-Gm-Message-State: ANoB5pn+n6y4MAbl+/SFzLNojUGpYgG/0p9v5i7rWHLhwsUwW+3shcev
 1AvecbRwbXGwiTKsn/ajJqxRpHeFBv6RMIYoTzUOQng/u1t0t4ATng5rvp9wlWtVwO37aOGxQKl
 HBTOoJK5VegQ=
X-Received: by 2002:a5d:68cd:0:b0:241:d609:9d40 with SMTP id
 p13-20020a5d68cd000000b00241d6099d40mr14696641wrw.305.1669371607497; 
 Fri, 25 Nov 2022 02:20:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53XOApsS86o4skryAnoSzcgOvlGi4BzZlc3bzuv8OAmbuPlciiezLRyZaX7XFf8jq9PtKTfg==
X-Received: by 2002:a5d:68cd:0:b0:241:d609:9d40 with SMTP id
 p13-20020a5d68cd000000b00241d6099d40mr14696627wrw.305.1669371607214; 
 Fri, 25 Nov 2022 02:20:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a05600c4e4500b003b492753826sm4623100wmq.43.2022.11.25.02.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 02:20:06 -0800 (PST)
Message-ID: <da91a3a8-4609-c128-1c73-8b35dfb2b7c9@redhat.com>
Date: Fri, 25 Nov 2022 11:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz> <Y4CTrrCb4jtQay9y@pevik>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4CTrrCb4jtQay9y@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

On 25.11.22 11:06, Petr Vorel wrote:
> Hi Martin,
> 
>> Hi,
> 
>> On 23. 11. 22 11:35, David Hildenbrand wrote:
>>> +	pid = SAFE_FORK();
>>> +	if (!pid) {
>>> +		SAFE_SETGID(nobody_gid);
>>> +		SAFE_SETUID(nobody_uid);
>>> +		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);
> 
>> Manpage says that the last argument of execlp() must be (char*)NULL,
>> including the explicit typecast.
> I was too fast here (already merged).
> 
> You're right, although we use execlp() or SAFE_EXECLP with just NULL on many
> places, including testing execlp() itself in execlp01.c. I guess we should fix
> that.

See my other mail, it's the case on all instances that pass NULL (and I 
don't really see the need to do this when working with NULL.

> 
>>> +#else /* UFFD_FEATURE_MINOR_SHMEM */
>>> +#include "tst_test.h"
>>> +TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
>>> +#endif /* UFFD_FEATURE_MINOR_SHMEM */
> 
>> When the child exits through this TST_TEST_TCONF(), the
>> TST_CHECKPOINT_WAIT() in parent will fail. The parent process should not
>> even fork() when UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.
> +1, this should be fixed. Please let us know if you don't have time to send fix
> yourself.

Let me know if I should send the fixup as an official, separate patch.

Thanks all!

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
