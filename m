Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75462C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744733426; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=9fZzkesIluJ2rpxoC93qWGZSpP2lrgcdNyBy970BrrU=;
 b=eCyaH7dmjQHwoYO61tpnixwtN3ORoJcrk+xUaQvlpyWxGdYMaLILfd0XiW/bcZxfSFY6c
 aAd7Z5skUscrFAsZF67eZitqq3WCI0nokNJELp+4ctG053js5bWzQMk/hx8nXdqPXXKEZyO
 t7Ixw7Oemg569zxlF/C4du0bjfMXrIU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD9483CB923
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:10:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2E173CABE1
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:10:04 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 969001A010DD
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:10:03 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso44759595e9.2
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744733403; x=1745338203; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsMl+dEiZVmGUWV5wXkaBAyBAVz58lGhdZe6zUZoWIs=;
 b=anSXdCDYWAEr1DTS11ShO5EJ9IKElCfzkGLDrz4vhQ6y14rc8GQJdQint6v/VW3nn5
 mHACinZhjenp03/iD6FOKuBdCWRd3GmDHQDh+TDryatBycsFFDMAJC06QqLkpcWwITwB
 uRmUz0hpadriW2udqQFIOxIPbah4B56z/MypBGh519EVzZ4geQInj47u/yeF2SvsTVbC
 NNOxW+M5Ug6grVnBBj2fQ3vTP6hMblBBG4Q909IakAeMu5P6blTfRMSITkZCTfqpxc+H
 OZseG+c2GVZYJopUt75o/sCPifiAXS1sxlYLKo35+46pF6bPuQTufNa7vm8oP0Wh0cu7
 1pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744733403; x=1745338203;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jsMl+dEiZVmGUWV5wXkaBAyBAVz58lGhdZe6zUZoWIs=;
 b=Phc3BvzDPeadQkTN0xN35DJYesK0aTtcQ4HjkOmO8mpdvREeJczcfYPFXBWSNS7ABH
 Go/3XeNe6XVxiP4iv3X5BnoMuiOeLILF69/15zMREwUbyROPj/qxju6WRJPSWbCM15G+
 odQtuCkONRifMK7Utun9lIhPx6WoHfFTrXYRNie6MZ68Ct3kt8+NuDR/ISCA17x137MC
 Cp6ZVw7o9ndJuY5lwrA80YHnV0COQLjshHrvQvbTFx4ngJEQCMdN9o+CyWwEH5DSdBKM
 RqPGUbm2+p4V0g/fDXHnNG7IFMw2eIDFfvJNE2TzTFd/4CWiLAJ9TcUd3UqOUwVu6SUh
 nxvQ==
X-Gm-Message-State: AOJu0YzcQFGhZuLRRfzk9O9X0WAelbhqvmZardzv0eAZKyS0N+bl1gaP
 9Y/iUow641mXq2lOOCVo3gauSl22gISrYwgxMV+ns+4naJ1wUJGcvG1W7tU3kzywwvShPRqwW3g
 k
X-Gm-Gg: ASbGnctkwX4iucTxgSB1n1j+k/u6fKkuNB4LjnpP6Guy6ol6lmfSPxAaJwQnHnx5ScG
 mVLQHVxQmbK4Ln6ayWJJe1IELA9H7lr5wlS0LXOwI5HiaYMkk+VWRGGTDUouXHvaCeih/+PSHAB
 VFgIAfHvN0bRm/w9jeDZwrmMrxbL7GDfs4x7NCrnPpXj1lJ1WdZJv8fU5jpqkSDQDEmlrwTKe/y
 VDuMd5Nm7i9iC6bgwfrwQLSJ30o6+QersocmvxOIWHjqTj0YMA0f6zrEd/Tl7ZJ/t6uqPJZG5jS
 SOK3h+TCmJ0ND1ec7DF1/wa8TyxLGPCTnVESKiq3j/etAw6GQ2HCZZhyp6cjVsUQwQ5rMDAuygC
 kltV7dd4ke1MkAJ+F48KTpKeMDOLggJ/rsDOWJe2SlPEBXEg2xeeEAxJdQpZ9UdTI0Ojxtg9uYy
 sweTk=
X-Google-Smtp-Source: AGHT+IEoOvJH8+FXxNkTK2+vuTwmhwxGr/v5Ge5X9pubJXtBUzxyV3Sex+5aAysuVkhtXaifBpKcZg==
X-Received: by 2002:a05:600c:1e1c:b0:43c:f8fc:f687 with SMTP id
 5b1f17b1804b1-43f3a9adc61mr172894325e9.27.1744733402833; 
 Tue, 15 Apr 2025 09:10:02 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c824bsm212344705e9.24.2025.04.15.09.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 09:10:02 -0700 (PDT)
Message-ID: <f3fb764f-2b51-4cae-a47f-bb2b859a37d9@suse.com>
Date: Tue, 15 Apr 2025 18:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-3-81e6d4184af5@suse.com>
 <Z_53eNAcp0piNyuO@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z_53eNAcp0piNyuO@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v6 3/4] ci: add ci-patchwork-trigger workflow
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

Hi Cyril,

On 4/15/25 17:12, Cyril Hrubis wrote:
>> +name: "Patchwork checker"
>> +on:
>> +  push:
> Does it make sense to run the script both on schedulle and push?
It makes sense if you develop the pipeline. I can disable it tho, but 
then we need to remember that for each new feature on the pipeline we 
need to add "push:" as well.
>> +  schedule:
>> +    - cron: '*/15 * * * 1-5'
>> +    - cron: '*/45 * * * 6,0'
> So we run this less on weekends, I suppose that may make some sense.

Yes, it makes sense if we receive patches in the weekend. Just in case, 
it will take a few seconds to complete the workflow anyway.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
