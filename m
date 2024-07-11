Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9998AC3DA47
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720689513; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=eGhNZDc+xxFtPDSrawKuqinzRESuFqcLlaCnK+gLsP0=;
 b=Rj141MuarIcdYLpfQTqyXx7Y5Gy2AF/Ynyw7EC4z4pkRFWriWXHKTRLfbuko6WApzDACQ
 0bf5KjlFIKxmhyIfN339hWQPcL0601MDRPM3T3tkWLnFg3RMxVe74R5GiAPrQlNFuXTSJCy
 e5kqqGkkWhZBQwPI6eqOqyp3sNpQ4+Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABBB13CDE62
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:18:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39F533C2220
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 11:18:10 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4445B1A0BC3E
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 11:18:10 +0200 (CEST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso7593191fa.0
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720689489; x=1721294289; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPXP1K1xJ+R3INVXkg6XgwXw4dZdCHx6KyBzcjSMGKs=;
 b=fsTA5OOnPBpvGZ+qvhJmdnStY8dDmcFurdrpegJZdzHrx/WIq9GmsSQR/0O/PVd9Bn
 AuLFzLcNLoc6zHkNb3AbGmZktwLmXrJp5cyD56RURvOK/NMnts48kCz3ruOKe6nP7T+M
 GoTjNHiUVMa0G1GE7yXWjfEA257jYIW+VYxw7wy3xPniercwb3h36C7r14WJ7UipEl0p
 go1/nTU7TAaOU7yT9CuA7tvMRvaFuAY8ZisXQDfJTSrPOuYa/PQfVdVnElXQumrBk+kc
 kMm9go8KwpWXF3deNFrrIWiffjFQY42wLmoDh93Ry/pg6Ac5FT1WikNkJyr1XOlxDbOk
 FFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720689489; x=1721294289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPXP1K1xJ+R3INVXkg6XgwXw4dZdCHx6KyBzcjSMGKs=;
 b=aUv/GsAetIjGmQuJpuMSXpD9gnoRPGesekUPUyiuUUON0LnOK71VGjVhMhxddM/9xD
 Zm6SUg0JeqyID8cY74WJm9gaE/mRuMZebp58dheBYXSDY/XyjqK0QFmgbDd2xOtL8+Hr
 BdzCjSOivyuY8BdZGoTknPryiqHTz91Aowy0eeg0x2pC4wLgeALzIpnZ2u0x7MCuy8/s
 Zb9Qs0/NGnQKRi93CJ7EYAKuyJHwEKvNNp96fG+kQnUqtdNmjftCLnkkeCk+t5s+WrcT
 7HSKqqEPhejBpJ57/8uxBxEkfpPFi+WoVJ9ypRS6XGD0/oh2ePhxVda7xJpcMVteYDt5
 QnAQ==
X-Gm-Message-State: AOJu0YwlFKwKc9qr8z3mhXz+3/4NtaZRlXMAYkbHs/o9sREzTar9YDke
 zTFpSNNjYwR0CqQtk2XLQlyEA3Xpy9Bc/SwjVQJHHLC87jKQ1zRlyJ17FWsutrc=
X-Google-Smtp-Source: AGHT+IEruY6GalUdTYUDHqDAOkZd9sGt2gfkfBPvQ9Ty8gl0HuY5bKVL12IiKzoFx6WUYPW7LihBZA==
X-Received: by 2002:a2e:2245:0:b0:2ec:5467:dcb6 with SMTP id
 38308e7fff4ca-2eeb3198b41mr46884171fa.52.1720689489068; 
 Thu, 11 Jul 2024 02:18:09 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.11])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d60117c34sm4080268a12.23.2024.07.11.02.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 02:18:07 -0700 (PDT)
Message-ID: <a5441aa0-9102-480d-8a55-5fcad2c22903@suse.com>
Date: Thu, 11 Jul 2024 11:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240711-stat04-v4-0-d30c26fdaf5a@suse.com>
 <20240711-stat04-v4-3-d30c26fdaf5a@suse.com> <Zo-bHDncYLGJZph9@rei>
Content-Language: en-US
In-Reply-To: <Zo-bHDncYLGJZph9@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] Add chmod08 test
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

On 7/11/24 10:43, Cyril Hrubis wrote:
> Hi!
>> +#define PERMS 01777
>> +#define TESTFILE "myobject"
>> +#define	SYMBNAME "my_symlink0"
>             ^
> 	   There is stil tab instead of a space.
>
> Otherwise:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
This seems like it has been merged already. Maybe I messed up the rebase.
Feel free to merge the remaining patches.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
