Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B0CC2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:07:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1100F3D0FAA
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:07:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7ED43CFE8B
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 21:31:25 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 055DE6022DA
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 21:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718911883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G45UoON6v+it5Xc8gJfipBY0/k2jsQBfWJWN4FYkCH0=;
 b=TenbyDuUgh2cO+ibZvTMVSXuU3kiOzlJ59qt1HGvcZaLcLTDXUnsSTJJ0V9zHeeCkWjCcL
 gUbzm3UUMf821rB/OcFYL3NNSZTVbogEmA/NJLUIppRdPkf0VqqWhX8Tz7QV7sT2WG2Jvo
 y+P738UsJCtabzy0hC6DZtLjVgl6QbY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-2UJTRY3WPKqDmq1k0N-fPA-1; Thu, 20 Jun 2024 15:31:20 -0400
X-MC-Unique: 2UJTRY3WPKqDmq1k0N-fPA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-362763f8d2eso608883f8f.3
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 12:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718911879; x=1719516679;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G45UoON6v+it5Xc8gJfipBY0/k2jsQBfWJWN4FYkCH0=;
 b=GpoM3ho20VpCgd1W9k0YIbdj+KXXl/UFOS1DMAMTy7yCZN1KLS0osW3pMVHFXXmUlV
 ++T/yjReNtWyyzk8n1E0M2Gj310pStAe4G/cWYHrZRHk8PNREW5fPYTUlkD8GIOd/dhz
 mCO3MtDXpGsIIpf4ubjC9Wx07SWgW2OvD0gPpOaeJ8lbZtHVlqEz67YPWV+Qy1ohIBpq
 33oTXqqwOx1e8hI3/J9KEOnKef9kLid1NTory5psnK3PWimJV6yuT+Y8uimYVZy2/WBD
 SgjuHckYfCJ6IPfoiOMPXOxMH6xFg4BX9F6f6LT8OtszNmJ6cpt2xY7R7KPlJj8dAeLm
 n+YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMYCYcygOO7QMZcYJT6gfAaIuRUee9UM0yepW14MGP5YZe/gTFxESBm3Pj3Xd7V93+onSZXMeSCbc9KgubKYE035Y=
X-Gm-Message-State: AOJu0YxXOMABCOeyUA59f46Tdm9qUzzv3YwT2Wrm5b25w88RA1RVXn6a
 xlkbNKAziMc1mWrp4/lfSF6U1JS/uySfhdzEQ1qKrIyUYo56yyQ7Uo/2JsUDMjNB7Ul7BwSjA0S
 Okb4ZoGlJa3sRLKL2RQD2ehcC5Ecy3xwaMFwZP4xO7wZ2UWpx
X-Received: by 2002:a05:6000:459e:b0:35f:f90:f383 with SMTP id
 ffacd0b85a97d-363195b1a17mr3954398f8f.56.1718911879368; 
 Thu, 20 Jun 2024 12:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFPX9p5DHYoAnqSxI/KYGBLxNvxCKZJ9fr0+v5glAOA4M8Akmwl58KZHLYUyco+zkPvuXAjw==
X-Received: by 2002:a05:6000:459e:b0:35f:f90:f383 with SMTP id
 ffacd0b85a97d-363195b1a17mr3954365f8f.56.1718911878933; 
 Thu, 20 Jun 2024 12:31:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3?
 (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de.
 [2003:cb:c719:5b00:61af:900f:3aef:3af3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3615d7a1a0csm8022368f8f.23.2024.06.20.12.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:31:18 -0700 (PDT)
Message-ID: <d961070e-d261-4227-b044-dc73f9f8ca16@redhat.com>
Date: Thu, 20 Jun 2024 21:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
 <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
 <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
 <CA+G9fYutNa9ziuj7aayhukaMdxKFU9+81qKAjZbQ=dQa3fwYYg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYutNa9ziuj7aayhukaMdxKFU9+81qKAjZbQ=dQa3fwYYg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
Subject: Re: [LTP] [PATCH 6.9 000/281] 6.9.6-rc1 review
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
Cc: Miaohe Lin <linmiaohe@huawei.com>, lkft-triage@lists.linaro.org,
 patches@lists.linux.dev, linux-mm <linux-mm@kvack.org>, stable@vger.kernel.org,
 jbeulich@suse.com, shuah@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Cgroups <cgroups@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 rwarsow@gmx.de, pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


>>>>
>> Trying to connect the dots here, can you enlighten me how this is
>> related to the fork13 mainline report?
> 
> I am not sure about the relation between these two reports.
> But as a common practice I have shared that report information.

Yes, I was just briefly concerned that we are seeing the same issue as 
we saw once on 6.10-rc3 also on a 6.9 kernel -- also because the patch 
list don't contain that much MM stuff.

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
