Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2E2C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:38:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9EC3CC8A6
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:38:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 539CF3CC87D
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:37:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A802D1401159
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669376270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWoMVW7PWrRm24IYn9IWBVbEiW2PRTP6juGDdLg0sGY=;
 b=hiRxZmSIpM1O1bxByu7fESn+KOQu8lyCH7955iOQOzv5fA2kezX5AAVvG7hnBjID9vdDnZ
 Nph8hL+cCUB9xtjiLCf/lvzOkmSf5f5gsqfIF+cTaWyUqeHfPEgXL40Xo4MDgwQXQSFGPj
 zvAIWaDcVaeScNl8PtyOoTGBC/+uTMA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-4Eu2ag3nOCiI8FTpwxQTag-1; Fri, 25 Nov 2022 06:37:49 -0500
X-MC-Unique: 4Eu2ag3nOCiI8FTpwxQTag-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay40-20020a05600c1e2800b003cf8aa16377so2310480wmb.7
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fWoMVW7PWrRm24IYn9IWBVbEiW2PRTP6juGDdLg0sGY=;
 b=vEwnACOS7NH8NXb8hl934LRNjCeR/6CIMbjWS6qE0rlSXmbqQwqDM4ChlajKD1c3qz
 hdZO+vwCt/PboueKbWYWaNvh4XGKJhEYLYLUdjcqpeQvuPuI2avvDUsg+Wj8BIhxHBw7
 DHaPE39FD0vDxOsyxmx1qTJlXPWDkLcRqa6oq/xlwIsa3mNRgkw7bQUKMqItnZ03gkY8
 URLRKtNgC16GCE2X38tOGZa7QzehDVAmjDcCysvJq7oh0ETJUtEXdW1tilnh9jDQOA2W
 4vbDeQP0lGjHS6/oX5nHqGB9Y0YF13ECiJ8nG/XC863gxf0QkG7Yv87an5R6sf20emaE
 tpcw==
X-Gm-Message-State: ANoB5pnWPVt2oFl9bln8sEPoa+PbRgH6CTX+pPaXVxWHaMg+OE3QtnVl
 4ywLGQA+QVy9HumMRX1M5puaopwPoHP+8+0JEvFOhtdbyAhcSmGyHOKwkoJag25/IFig8IjKdAn
 zSwLMY2uCd1M=
X-Received: by 2002:adf:dd4c:0:b0:241:c075:30db with SMTP id
 u12-20020adfdd4c000000b00241c07530dbmr13119907wrm.159.1669376268409; 
 Fri, 25 Nov 2022 03:37:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7WNHiwk3D/FKEcUz7miA89dAYtynBFtysT9r2Hm+CgzqTm41mowpEIeVXKRKWiIOfgcRQnJw==
X-Received: by 2002:adf:dd4c:0:b0:241:c075:30db with SMTP id
 u12-20020adfdd4c000000b00241c07530dbmr13119891wrm.159.1669376268106; 
 Fri, 25 Nov 2022 03:37:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 o7-20020adfeac7000000b00236883f2f5csm3534180wrn.94.2022.11.25.03.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 03:37:47 -0800 (PST)
Message-ID: <70e7f5af-d0a8-6f08-0b18-36f71e44443f@redhat.com>
Date: Fri, 25 Nov 2022 12:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221117121409.179210-1-david@redhat.com> <Y3eI0Q5BTE12+4zO@yuki>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3eI0Q5BTE12+4zO@yuki>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Add new test for
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

>> +static void cleanup(void)
>> +{
>> +	SAFE_UMOUNT(TMP_DIR);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_checkpoints = 1,
>> +	.forks_child = 1,
>> +	.needs_root = 1,
> 
> We are missing .needs_tmpdir flag here, otherwise the test will create
> the the TMPDIR in PWD which may fail in certain setups.

I just noticed that compilation now says:

testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c: useless tag: 
needs_tmpdir

So is "needs_tmpdir" indeed usless or are we missing something else?

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
