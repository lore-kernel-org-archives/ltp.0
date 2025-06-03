Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B15C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748958323; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=dUJXor+YN6XLxIA3/AZ6siyURMChhpHCJHqIduPQxl0=;
 b=eAlA7Ae0e6+4RMOjfEgiD8O5ZvgUakDo/a9IaSgOIa/Llq93R9QRdqkvNEbT5hE7A6qYc
 8Mf2rXhpOXCBbUb2Uv/uLRHPZK7RgcwSIJaLCsyAJwMstpoBtBD53nY1A7g/zJjGJSYyPE7
 lfXz92tQSqSOHIMRS02n7NS8ypM0VLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54FDA3CA017
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 15:45:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3065D3C67F7
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 15:45:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C8841401392
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 15:45:01 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so23050295e9.1
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748958300; x=1749563100; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ip5SnLXfzPgvjn3IuYRzyJFbLvCBtcre2fJm2w4CsKU=;
 b=Nu7blHWCxGRiCKIkN7q/FO81LWgdVDtguMXS89TGuflPCf9bVrB+8WJgYP6JAy8vGv
 KbpoZgsn5/29JnquoHbojyc+2DSHVDtjHpbYhxU6iOVAdSDDp2FD4mAV984eWiktYb7z
 jlEAQKxH7ojoIA3DFmt9OzowPVlPFuCzPgvvXL4mR2cHOUvkhXtM/cBF9D8EHG4X5uim
 XRBL/i+7Kw3phsR2LMbz9VeK0+wYPZyVzDoD8t1JE8WDIuv/cCIAtARY+uPJV48lkwmx
 cjj0QM1mOBUq7jT0B8qFQYZiZ/fy7cYgwTcig1E5R7bXrbW8bjz+306nVT5MCXaR+mlG
 JbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748958300; x=1749563100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ip5SnLXfzPgvjn3IuYRzyJFbLvCBtcre2fJm2w4CsKU=;
 b=JDvnOtWJtTXN9MI07QR0Jw5mbjEQJFTWApHAcZvtorhRRA/zBxUF6TH+kr3ePEuR6l
 An46Gpc3bediBeTMWph3MCeWyNCgXbNR24qO0F1zmPUZqRNUKU3sTKZBNa/I87obj1Pf
 XS1ye/mYgpDEKnNStb/wDof4ZF2yLZCMk9tSaJ/l1u7vfuK6r7SD42sbS9Sjm0THlk4Y
 8pmBq9/72lv8+M0rp4lr1OR5JBXs53SBKoYMqqOAxBgBALQ/P9KXLfQgVfKfasnwrZKG
 KTjDVGdFDnncWudMEKqVwk8MFVfy5tTkNHcWC1zVsn3u8lPa8kcB1KBkcla1VoGJ6ZaK
 A3JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1AnOkOWRGuYNnklq8s2ogXITYFaI6ARlSrr2/jGltkxUlJWLi2O6stPKGpWxDz7p3fys=@lists.linux.it
X-Gm-Message-State: AOJu0Yxp1xZWrnlTPWq2LFtVN3+z5QDvucdNSp90dp39EXxoa4RlhExc
 fk+myqbxa/twSQ1FBBuiniiHo3PIbf6ElQq+mX+li9p+7YReainsdPBKW8dNfOnNS/xSqFffFwG
 Bq+eA
X-Gm-Gg: ASbGncs6faV+Ork/5nxLv1QRpb2xddC3D8QqTRqTOA9uelzhMYrFRRj9nmh0TOdfxuG
 uVhJt2uISBOxIEy9FJouk2N+beb9TeAeF72x1H2ipnB+/clQvz1+US+PtFP/1AwSMbXemLDS/Qo
 UUEeU1UaQsEZ/EEDB+x3c1QoqDHjVQmVIRwobnAza/4BkJ990rgo8zTcHOBNM45fT6difSQ1CDb
 qYd5nkl+vtkrYTzNseGJOk+099gEeqvFzm9ySBJWgq28PNMduU0h4dKW1UL8DmFuBJ2vtINIUUU
 7TU5JFfDSpbqF2A0oBsnCv8VSGU4AJ5Un07nxw8JKSVeE9bK3S5tK812golLZ4qfiMzXa8DQ
X-Google-Smtp-Source: AGHT+IEEMuChdrZPJko5zBzeoAaJNkU7FyQtdW+p4gPyYG6dda6csvsm+XkWZ29oEPTDrdcZuewj3w==
X-Received: by 2002:a05:6000:1a8d:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3a4f7a1c572mr14108919f8f.14.1748958300597; 
 Tue, 03 Jun 2025 06:45:00 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd8c4bsm87170815ad.110.2025.06.03.06.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 06:45:00 -0700 (PDT)
Message-ID: <80d09119-4fbd-4149-92d4-f2e759775e09@suse.com>
Date: Tue, 3 Jun 2025 15:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
 <20250425-conversions-mknod-v4-4-222e0d2e7ef1@suse.com>
Content-Language: en-US
In-Reply-To: <20250425-conversions-mknod-v4-4-222e0d2e7ef1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/8] syscalls/mknod04: Convert to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

- andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
