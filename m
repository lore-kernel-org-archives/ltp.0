Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D0C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 15:45:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2C43CC681
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 16:45:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEF283C010E
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:44:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7BD9214002CE
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:44:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669650289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0O7VVh7FbjUvgm/CYPfFHHZUR0pm3SxXOXQrDSKrP/Y=;
 b=TAf+75TqKrBhY4wHHXkho3335YwP0UH4u1MzukXfYpeL1ITTNAtZrXMt/ZZp1Oyak/mVnt
 nTPWlXTwsENxXXP397kMbewHj4NhbptwVN//YHCjHcmUGBNiwFzUEEA3110iMbXvJi/R/0
 TyleLyh4SmsF8J+PLFRw0QZtf4JCmI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-5bhLW-qPOFKvufVl3rUFPQ-1; Mon, 28 Nov 2022 10:44:45 -0500
X-MC-Unique: 5bhLW-qPOFKvufVl3rUFPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 l42-20020a05600c1d2a00b003cf8e70c1ecso8756694wms.4
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 07:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0O7VVh7FbjUvgm/CYPfFHHZUR0pm3SxXOXQrDSKrP/Y=;
 b=oozU4esqahboVSDYPhhcCR1akrzmxCsiQtsExKkFqM8zPB79IQF6I52HA8vQ6XCVN5
 QAM6UBLmoYx1bS8HcxWfm0HbP1MlGPcDfeWnYBaDUmfX6FLJbgXT4iOofM5vX+m4KHRt
 LG4JWXw4kuhpZtDM6eLh9dKau9V0MFgA04z0Xf0psQukOUangmI63mfjGYYpuvrwqvsq
 nqfyQrCUEI75uHT7fraX4WNfQdnir5nIFEh3AOcTCkfTn02eZY0BoDwZDUOrygcpl9gq
 67gRFeHmsejaTKwwh96J0YycLJh/HRGvLKBZ8paYoVt6GdzbY/o8i9FwBg+AexlzVjzP
 bBTw==
X-Gm-Message-State: ANoB5pnUzchy8LKBM6p5ohqSgUXwUTdQKHLJRxP2nl19oBPNL+ekHaXZ
 p6jEsDaVApipUefSWbuxpERMXIkC0XHT5Ry7hwy9iGRZnAE78RRg1NZx8ds3B53U1i5dQH1aU0y
 Y+/2gnP+fBZM=
X-Received: by 2002:adf:e34c:0:b0:242:19db:9d0b with SMTP id
 n12-20020adfe34c000000b0024219db9d0bmr2573221wrj.559.1669650284749; 
 Mon, 28 Nov 2022 07:44:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wyNlhCjNhBXhVGYRoq8HAbMb0uFNRQjyKOyCQFMKKXjPQUC+NWrMCT6vv6cWgBdhH+CRgAQ==
X-Received: by 2002:adf:e34c:0:b0:242:19db:9d0b with SMTP id
 n12-20020adfe34c000000b0024219db9d0bmr2573209wrj.559.1669650284508; 
 Mon, 28 Nov 2022 07:44:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf?
 (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de.
 [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b003cfaae07f68sm16983563wmo.17.2022.11.28.07.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Nov 2022 07:44:43 -0800 (PST)
Message-ID: <abd991c4-e6eb-349e-807c-71e7283ee83e@redhat.com>
Date: Mon, 28 Nov 2022 16:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20221128111833.98937-1-david@redhat.com> <Y4SiDZXCSqMafjIb@pevik>
 <7f71a2c3-a66b-b442-3785-3e251ce2f781@suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7f71a2c3-a66b-b442-3785-3e251ce2f781@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time
 TCONF handling
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

On 28.11.22 13:29, Martin Doucha wrote:
> On 28. 11. 22 12:57, Petr Vorel wrote:
>> Hi David,
>>
>> If I remember correctly the reason for runtime check was ppc64le
>> missing userfaultfd minor fault support which needs to be check in runtime,
>> right? [1]. At least this is how I understand Martin's suggestion [2] to replace
>> compile time check with lapi. I'd state this reason at first commit message as
>> it's not obvious.
> 
> The reason for runtime check is that the presence of the header file
> does not guarantee that the kernel supports UFFD API. The reason for
> LAPI is that we only care about actual kernel support, not build-time
> header files.
> 

Right. Petr, do you still want a commit message state?

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
