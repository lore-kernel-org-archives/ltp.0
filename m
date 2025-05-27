Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1155C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748342533; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=OWPyMX0/RK+SMzmKg2QPDvvgNcgtP6YQSsPyxqj0GUQ=;
 b=bPKiILL3Nls5iGg8FmdJvtgyuqM3FDXabECwMmWKhV1AcxBiZ5iAU7QBUjLEHR9U2y+E7
 vb1JCCFslCc2hVtsFBOIIZiMZPvm6OIPOl8r0gDoL7WSJCYt7naXDSqm7ZX+W58LReRFhH9
 3ytbC5kEZaXfRCb05EX3yiTgTLgYRs4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C8593C5584
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:42:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5970F3C023C
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:41:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 27D21600636
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:41:50 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so44200035e9.1
 for <ltp@lists.linux.it>; Tue, 27 May 2025 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748342509; x=1748947309; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfFwb8bvMZ5XohczyaS6pljtxzsLDwfjCiF79cCF/1g=;
 b=PB1/w5IFC502LZRIxsbeWrDP3GVB2p8fVeeHce3mPsX03knPzRX9pmDzrMRItdJMrd
 5Rb2PSQ8CbxbBsN1LAXwCabXYQ69RgATYbghd94KMd55R3YMXPAzbZSZ2oWYBXjXiDtx
 oxHgrxVu/eNbFe4feWpypWk2aRaWJiOKXCMWZfJusuO7jlMuav9R6ZyO6Gt2CUMs7C0v
 0ZEI82mK0PwLOLwPShxV2KgcVI2UfIUbSYJXl6Yx9aexgZCjOyWldAXmEEyqnW8FkTdo
 Ug2D4gqjIDHM6jjoCAfo7za8GQ9hiIirUX6+PBfH4HCmwFckmzWPMt+SP5nFvehh8hOY
 0p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748342509; x=1748947309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfFwb8bvMZ5XohczyaS6pljtxzsLDwfjCiF79cCF/1g=;
 b=YI3lSf9mGCcHzAOYIp/ZD2oCqTE1g6Bl35+nssDi5SB1JNdHfGWhKZtMXkUHjxjloC
 /BzXZr8Yprqa2Y9/7LobpDpP/gL62xOutDorAFooqH3xnvzrn+gVLsJz0fSfcakSd1Wf
 RorvmHshWvQgZZtKfgC8ipQ2HObRXr1Agh4h6K1Q/7nvidK/IpUxo8J3JbJ8NX+VfsBv
 pMfRm3qYk7JXtEtqUonrpHoJ0I0Hc19eV3AXucSKkIQcul3k5l76Q/aQBPgRkHw3A52C
 +eeRLm6Qd9kcVy6/c6OsIdCVwrkyxxD2Bg5MNKHD5182QE7oRcCuHKR07KfjYKmCuOpz
 OXXw==
X-Gm-Message-State: AOJu0Yyy+Y3Si2xeVwBsJ5NxuyFE+FUjzQ2OFtvuYfU8rra3lHIvxr2M
 ji+0cNY4aijr2CCUVasQIuP/3CYMUbP1kjra9oJaMzWH83Ipo+PlZDqJFETMCpotMbA7DdIdkx8
 yhzaKBYk=
X-Gm-Gg: ASbGnctTGz7BqwqoqqIU5xIINKXFQn+U1Wq0sBoxKZU4wPgdZy4Fksfj8bOke2nkGGB
 3I8yMxYEJ88tqSPtU+1px8iRr7aia1FWQYtGUbxtPYcwHOCBcJXC+cMZWEiOT+zkKyv+mglWmTe
 bXnAFBE4oQYAs/+gh/VCZzYH8ywRBevXgTqj3MR8eYoZ2LPrXa+kS628WFzEju6Neiz4ic9p3nc
 yQXWz1YAf1Y4TPHyopQdZOJwUPAsAIFbGQ4Y28DFD/VwIzmDgNdr9Aowe2t0VAZVtihiG2gXihU
 AHOxkDF8lqRGPf/oxV9bkiRlqXn9QJ42v/4febG9oKpiQK4skEBFOaJLcPRZzQ==
X-Google-Smtp-Source: AGHT+IFudSgknykVTepl8Y6b3RlBiRgWi+IHAAnb/KIJ9Hh/x6xLt42fiYhRKReE1ZYibCTAtAP/1A==
X-Received: by 2002:a05:600c:8411:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-44c91fbb039mr136262635e9.15.1748342509434; 
 Tue, 27 May 2025 03:41:49 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd9c21sm270996985e9.38.2025.05.27.03.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 03:41:49 -0700 (PDT)
Message-ID: <81a131e7-acef-4aa4-b1f2-97dc30c45983@suse.com>
Date: Tue, 27 May 2025 12:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250527094415.4760-1-andrea.cervesato@suse.de>
 <CAEemH2eGQP6k1cSDH42c=ZXLHtXdekDh5H_nWSr0o1_=j1i8ug@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2eGQP6k1cSDH42c=ZXLHtXdekDh5H_nWSr0o1_=j1i8ug@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk: version 2.1
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

thanks! I guess we can add it to the kirk project under "tools" folder.
Feel free to send a PR in the kirk project.

- Andrea

On 5/27/25 12:07, Li Wang wrote:
> Reviewed-by: Li Wang <liwang@redhat.com>
>
> RBT is to this patch. Thanks!
>
> If you feel json2logs (to compatible old log format) can be widely used,
> I can send it as a separate patch. Otherwise, I will only keep it as our
> internal patch.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
