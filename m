Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86165C3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744110144; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=KYS84naqFvKX8HBUaPR4AB57HsIHYfIU/b5UGLtxhjY=;
 b=moLdcbJvucrh/WvgET4oMdjqRtnWVKze6IRahlzxILEehr4+lUb9k+Phcm3B614f98D/7
 4XlzTCBEp0zU1mtO7StNjfwxelelPEtRttdtUrY9C2Rl+zD5iSAWjd3hKs87G64Akso8vHw
 20+C3PkQOT0tQmYDWouqlFwnGkHmqrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7B323CB381
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:02:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5B5F3CB36B
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:02:01 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59773200BB7
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:02:01 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3691397f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 04:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744110121; x=1744714921; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIA1uADy0dR8cQU8uYfYP5Fk1vB6+WtQSIPIqLM+3fc=;
 b=g/oRR5LqQBP1g73k/8azBrNYMFKcMo1p9S9cX6WeaBroFeOvU/iA2cFIXNx7p/lCXo
 t9ljjHNJgORkq7XDFjtShiRPgaKZTWtfLKgYRWMYgXNGFagj2FVxalFocp5/79V93utX
 KOFqEiTGXaBfx03vId0w4GiQF1yPK73mIr5fw90oZ01mcyADC6P+b3DlzpuuBCSiAkoI
 yBxdUlPyhaxTAaxiX/fiJOdgQ3m1vOOn1uvcFayK7s3pXLHshVNYrgyuTC8/zAg/FkPz
 ubZXWrnTDdFb6QzoYTtWbm7YJFS4lcVNRY+wmudDRrHdp1DVesOUOEKeshw58NZo9lrg
 3OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744110121; x=1744714921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MIA1uADy0dR8cQU8uYfYP5Fk1vB6+WtQSIPIqLM+3fc=;
 b=wWJbCThM4khmswkeb1Jb38Gt3f86PkOc8iylI0gPbzTZQwCpOJdDwbCsyEclvzLXjJ
 cLZonn6K4zvAcDNdObtNcOxRdOBJwk54OJmhBRU/a0/l+j45aVooyUpFW8pZrIUeKvo3
 K0kA7R5rPnnHhHkhiZuaiN669MaXwKpCIiWzejdwlGgd9I3Mkf1lt2ixx3C9eUjt5nLO
 iknfdkHqL70l0dJR1y9sFEPY+Ke6WNFjTTJgEw4mBdrTajJlIp2gjp+FLGEitWYqNM7G
 vcZZDEziKoYlqVyYN9IAphU9Qd3o4KlARoPDC6rPD97dv0mOdSMvJN8PVxbzblfr6Jfa
 bSOQ==
X-Gm-Message-State: AOJu0YxQIulAuLPi1qpez+kXt8ChYHNeJ80+S/2ltyI7PnPOH8wiTCdz
 rrqBxk5LbJhxJqEbyzmP1y/bT1OwtO2qvVvqLe8WU6RgOhXS6L5zo+AtMn72QDc=
X-Gm-Gg: ASbGncuM63tJJI15th2mYM/QKksJnUdfQxdoCe0dJlql2DRu5kBWHORA0udXDXUGl0T
 3Sd5AZ/ptj3AdLYQZ3ib16QHbSj1HGyq97JCHPg0V6NNkVxOnSzION3VMa1VfWkTh2I7cbboFGp
 bybt2v9xAtw3rBWL+HIJydFVBe2MECz192vpIUQw68BrTqrwb1WNkHm+ZFZFJ8drBG1zVYWZRdP
 7dt9gfU1pJh1Qx3YJ1DaVtYGwVcL6RercSCQkuaJt/9DWNTehddx7h7Nhcgf2qVUJPipFWUxiwy
 vW5B6EwNMxuqYeKIsfKxNDxbJa0DQ9jy19xnRoBp02oRfRa9ky8ZzPV89hIkH1RLUFOf9mhwbO3
 tPm6ZXrb9M1NWO4yoTIYhzNq+4xIe4fLsZWcgJ1d7TmfMbwzjWF0VcUbtXDiS68e5n6mJ8RzUoS
 mUOGNqXiM=
X-Google-Smtp-Source: AGHT+IF3xmB4NOYRzi6Fi07ODrXQ5uhZzwuedr24JXSNKScYKqG0zZW4g9kvpv0TXeQH48fRywjUQQ==
X-Received: by 2002:a05:6000:420c:b0:391:386d:5971 with SMTP id
 ffacd0b85a97d-39d820b4509mr2429414f8f.14.1744110120794; 
 Tue, 08 Apr 2025 04:02:00 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a732asm14734508f8f.30.2025.04.08.04.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 04:02:00 -0700 (PDT)
Message-ID: <fa9a3fe9-1ea4-4dfa-bc29-9897026e4122@suse.com>
Date: Tue, 8 Apr 2025 13:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250407150133.115790-1-pvorel@suse.cz>
 <20250407150133.115790-4-pvorel@suse.cz>
 <a2197905-94b2-4f84-a19a-fb26b2ff65f4@suse.com>
 <20250408101412.GA174986@pevik>
Content-Language: en-US
In-Reply-To: <20250408101412.GA174986@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] doc/Makefile: Allow to create and use .venv
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
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 4/8/25 12:14, Petr Vorel wrote:
>>> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> I hope you still agree with this ^. Or shell I wait for your ack?
Yes, I just meant that you can feel free to stick with the initial idea 
of supporting bash only, so we get rid of the more complex scenario.
>
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
