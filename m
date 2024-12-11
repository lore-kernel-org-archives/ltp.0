Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6559E7717F
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 01:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BB7E3E94BD
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 02:17:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24FDE3E9497
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:17:11 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 895AE63198E
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733879829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENaIi2aFqpk8mSDob/8doNja9YHRMjpA6Hql7/zpAE4=;
 b=G9YvbMKbpKS0gwV3g3p4CiZq3JBNv1eiDzwEAZtOkbHsAFnjejL5+ipu9oEJ0WBWDqHMQI
 Z4JuMftChQQ4Lwk3Cg1SjFdC+KQ9JvURQQYbm25tBaXMa+5vnliZZUhxzEbVlfvSZxgzPq
 aVQ3whfXaEocEz3FBgseLGlRnJce744=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-nJLzDfz-Pby0_Vp9nkF9qQ-1; Tue, 10 Dec 2024 20:17:07 -0500
X-MC-Unique: nJLzDfz-Pby0_Vp9nkF9qQ-1
X-Mimecast-MFC-AGG-ID: nJLzDfz-Pby0_Vp9nkF9qQ
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-725dab9fe44so181570b3a.1
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 17:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733879826; x=1734484626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENaIi2aFqpk8mSDob/8doNja9YHRMjpA6Hql7/zpAE4=;
 b=jPcspJVEuEBuhQFwPgcQkqjaCIvwgXqOEzqdBPUtrq/H4x+qQzUDZ8Nm3ReKwM4AgS
 1ROwHCKwvaT4TEb6IRd0w/0TJ3XRZXHiSDODtjhILKnVOta83ImQxGqsH81xsLeMWxiE
 W0NsN5GAqWzge5n5cRmpTZw8zsC7UBqA9pLP2xP5nmNUGfOoyYCxZFwk2vXePuGmnURB
 pFPk2DKiTCTf4rBuUSDjJHxuRbA+Zz/qKMcdkiC13YaGETv7jXxbH58FlDdUIf3T4nsG
 RCaSU2iYwe8ebwco10Xab9oPwjP3zHFO5QxQyThYMG4c7VEG7bdSFpzklBdmOhS3yroc
 JiDQ==
X-Gm-Message-State: AOJu0YxRnzfT0tZdxwBgnDhXV8Z+BiU+Oz1o3bYo447j8/Nl5cFMqotZ
 56TEMl2iMZt6CIBs1N0mJ9WRElW1+UqKpynnPGEIvvduwlifB4hpfAOQiL8fCLQ0+XIpkWNM5v7
 75SyQEzsvxEcxpzk4Qqwug1E/KotUOCJZE8mLssP+30gZOZXP
X-Gm-Gg: ASbGncuQGn272OSMiVN6hOm6bCk2uW2lEhn5busYH46iSyF9CLHuKOaYULSAOxWo9hU
 pdsujidQhV9RzFoIyFJaTb8UoeuhPOZWhmflmxBOEGnewZ6wgSV5mp7zyDJRCNMc+BqHrt6jRNT
 c4lHuudPx/daB6BenSJzL6mbshQOHLkzhF2eCPwI2+1Ku2Of3gWQX19O5t8o25N+2kdRC4gUxwo
 Iw0H2tBldJzngMXSVOHvnzosYoOzQv+zOfIoUFGEnMemc1gAnmm7Is=
X-Received: by 2002:a05:6a00:9a9:b0:725:4915:c10 with SMTP id
 d2e1a72fcca58-728edbe33f4mr1266249b3a.10.1733879826396; 
 Tue, 10 Dec 2024 17:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQQWEATATIc+G64CcLLmv5kSezF2MHXxOrOZ372DLl6jWZ9fg9zcJa9bT/l2wu4GpwjZHddw==
X-Received: by 2002:a05:6a00:9a9:b0:725:4915:c10 with SMTP id
 d2e1a72fcca58-728edbe33f4mr1266212b3a.10.1733879825857; 
 Tue, 10 Dec 2024 17:17:05 -0800 (PST)
Received: from [10.72.112.22] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e438f169sm5292766b3a.168.2024.12.10.17.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 17:17:05 -0800 (PST)
Message-ID: <b690e9aa-bb40-403a-8227-4944f9dccf74@redhat.com>
Date: Wed, 11 Dec 2024 09:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan> <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
 <Z02PZRGzw5qM3z0w@yuki.lan> <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
 <Z1gw_mNXF7KIzklK@yuki.lan>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z1gw_mNXF7KIzklK@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4CSO2YM_lgv1qBD6FApLUTdE5foZjxyJRyc56WLk3UE_1733879826
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 12/10/24 20:15, Cyril Hrubis wrote:
> Hi!
>>> The top level configure script configures the open posix testsuite, but
>>> you have to pass the --with-open-posix-testsuite flag to it.
>>>
>>> Or you can run the open posix configure from the open posix directory.
>>>
>> Yeah, this looks better.
>>
>> Does it make sense to fix the doc about this ? If so I will send the V3.
> Yes please (and sorry for the delayed response).
>
Done. Thanks!


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
