Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A23C83F0F
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751961512; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=fU/iO+vMjfGdfH21pZKX+PsuBTIwqqOziVhIB+ubCDA=;
 b=b2F6Ch2EmWmSSqPlgp+t3eycnYrrzUR6AkFY0JNiBmgQ3NQ1i1bOcLnEsejRW0zvTx+18
 TKCCCvpvb8cvtcf7pcZOqDp8qz6mw9JoH8j51e6jrYGjaieYh3vgNw6x9LHkJNYBFNoKaL8
 739YKb6NNQlKRbj6IFBA3tPflArMoGM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A84943CA2FC
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:58:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 482403C7A4B
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 09:58:12 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB77017A72FF
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 09:58:10 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3268265f8f.2
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751961490; x=1752566290; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h+T5VY2HqqCdBkVmxazLBpW21wMXxfqZBxnx7mgfrAo=;
 b=WvKg73P6eDk3igpy1JNLN69EkzBjf4Gx1oL/wqjwgvD9fYMHIWIfP85TPCfSj0miX2
 3nWFfPnCWZktc0XWk7ssCDD0c+tzcvJLyMPm73OTtAZgDSE9VEtAKgOsfUQp+rlPfYov
 kIaFgAbYGSEKUGgYEyL3XV90DjzLxCYQcB27yU6bcQeVuX6VFySio9pJw22gFGQmVVhn
 Z+FUjh7GDiMv/+XfdAChhxK93n1JgMXCt9q/bjIr4LQ26tmPnY4k5zvJkb9lrw3QRQIx
 TDHACsdMwPrN4cBsi7W7rjUafgyxz7FZ2DtpicjbW2TMOWk4yOOF1CQ2Ztc+P4+9Y17U
 dZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751961490; x=1752566290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h+T5VY2HqqCdBkVmxazLBpW21wMXxfqZBxnx7mgfrAo=;
 b=d2CiLgDrD+pY9zmCAEFuHBT/wiNNDmkw9XwKeoZSvKjEaIL4aXTa0d+K+45PSvgQny
 cUExOAOdsblewneEUJI0VcS5C8wCvfxSknNTU3o2m+RFpoUUbQGYaDKFh8o0phYNAK+W
 H0vZeV+x2CMVF6MwVStbyiDIkpczbX7cwhlFVdUX6tI2MujXUQy5/ux3PqLThfmnJbHi
 mrrssOC6AL+B8X9Q86rjRYPc0j9q8sEI5letgzZ3tSWMjCpwKfrmSwcYouMOLCf2VJTn
 gAmbW+Ea6kBtiVabGw8W6jtUkRyKzijb1E8VxOiv2FlUca+Dz8vXbbZoJkG/PAYQsTbm
 0UMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUT/oVr5vwl0BOFpwjFr0iH4i4nVyGXr7mjrVRjXoZ5hGSUtJ7d3tGLK+QJfoxuMi0Pms=@lists.linux.it
X-Gm-Message-State: AOJu0Yx/VM6IukIUmFZHhrFeL5Gx4rwp1rWh9x+1JKCGeZx0vhpiBbqu
 j5Lql0ySLD5Rx8SXadbFJhTFHkTL18ab5GznZF6ZC7xVVIuiX6CIifRJI4XlUel8SN4=
X-Gm-Gg: ASbGncuNvAoZQRtoP9R4ywOtcnR/HNLZy5MS4tGfcLBR8ARK9SEvhg7tC21GhGO/n5Z
 xT3Y3ilQGwBpLule4dBF4I0kSX95WbL4TD2ER9nWgeX7TbLe1bbbfmlcfSaqnKjnaiuItSvQKDi
 8nuRwnRdLZVpZ0TYPLiq1nfdcGZFs5jEqWPuwg8zWrOTD7u7cUr4kDDByJyJM3abHC/+BX1Z1cX
 aDZr2+DxSuEwOELpyjuowXVfldkANzn1XpUTabGycL1heFwNLNofrx9vX6hlP3q6gpdcZeRE/Yl
 nOjvd+GOQ0pfNRUcAcDLyTUBVmbgfXgmAitXkYGsBLIztowP55Qe/9keQRXt/Kr0rFihPMJdURV
 2AcQHk3wplS4Uz35PsTXh/SsFfZc5jj3F8z3eVy3utMLjPqWVMsqAK2cLTODWNfy6MRp8J+h+nH
 GsMznMFUpj5vPD8lczI4zJJQL8NA==
X-Google-Smtp-Source: AGHT+IG2wE7uKx4NCIBagiEx5cX7cJdXu8H4cUWFXTYCQIiE403Rj1cZNvCeRgiDiOjyKTLQrZreUQ==
X-Received: by 2002:a05:6000:1a8b:b0:3a4:d994:be7d with SMTP id
 ffacd0b85a97d-3b49702067dmr11754320f8f.23.1751961490328; 
 Tue, 08 Jul 2025 00:58:10 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4a6235sm13642635e9.37.2025.07.08.00.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 00:58:10 -0700 (PDT)
Message-ID: <02d35ee7-79c5-411f-8009-193d3aacc6a1@suse.com>
Date: Tue, 8 Jul 2025 09:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>, ltp@lists.linux.it
References: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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

On 7/8/25 7:59 AM, Zorro Lang via ltp wrote:
> Hi,
>
> When I run ltp's fs_readonly command file with kirk, I always hit:
>
>    /var/lib/ltp/testcases/bin/test_robind.sh: illegal option -- W
> 	usage: /var/lib/ltp/testcases/bin/test_robind.sh -c command [ext3,ext2,jfs,xfs,reiserfs,ramfs]
>
> 	This script verifies ReadOnly-filesystem, by mounting block device and
> 	executing the filesystem tests.
>
> 	OPTIONS
> 		-h    display this message and exit
> 		-c    command to be executed
>
> Looks like kirk can't treat "..." as an entirety and give it to test_robind.sh.
> Although it can be fixed by:
>
>    -test_robind01 test_robind.sh -c "growfiles -W gf01 -b -e 1 -u -i 0 -L 5 -w -C 1 -l -I r -T 10 glseek20 glseek20.2"
>    +test_robind01 test_robind.sh -c \"growfiles -W gf01 -b -e 1 -u -i 0 -L 5 -w -C 1 -l -I r -T 10 glseek20 glseek20.2\"
>
> but old runltp fails with that. So I'm trying to ask is there a
> better way fix this issue on kirk side.
>
> Thanks,
> Zorro
>
>
Thanks for this report, I opened a issues in 
https://github.com/linux-test-project/kirk/issues/60

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
