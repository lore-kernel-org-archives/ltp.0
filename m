Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0BC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751880260; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=FS92s+KG5bsf6pUGQ+K1RG7TefvOl+gKwJS3WMgzX64=;
 b=a2eO63kK8XGssOp4oMGeYbSy9PrY+KlIok2gf/nwyPBbNYdyvkN/zQQtcX8QQrF0FuPzN
 MDIjVk8DSqB46hyiw8qz7Gng7UW53nuAAr62LE2WR1GfAeiHd1Guv3QtwDWGmnTqAtE3ZCH
 SnKpYVe0OsmyiZmau7/NtvK62hpNBmI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD6443C9ABB
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:24:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA50F3C659B
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:24:00 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F336F600181
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:23:59 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso5547933a12.2
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751880239; x=1752485039; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ILjEnkjWeBbJ8H/8Izj6q02IqNzU65bSl7o90lJkOPQ=;
 b=WkDXi3qXdwVdjOV8EWhqJJoOX+ibNHpxPMb0dlQw9VgViKsziQD9WSp0M8cALD4PVy
 J2hu22VWWpN0rkF2nqjJd8+GX5Rhf+ErzSRoqHXxaOvB1Vg9s/S7a5HNR/3RdjcbyTD8
 uK7ik1foFjFs5Wi/WzH1JtuCgpFZhreA0tjVougHcJyzVmfQh4eWlZhQrbWBDTIVfAgr
 hcTa9fVNH99vo/dilmUXQP3CA1Qiiz+9SDHxLxUVkQCJo917vN1FFgoJPiKYor2LXxUS
 P+7w5NDLZBdrF94rQjov26aBy0FETLceofk9LDdWSX9iXA5lcv9rJXr9jmX0PMNiaN+6
 4NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751880239; x=1752485039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILjEnkjWeBbJ8H/8Izj6q02IqNzU65bSl7o90lJkOPQ=;
 b=dG7mByRb2IjSlzrIxNyiwWM/Iu51m0GdOaEU5zIAyLRVH6jd0Q0fCgXP6xV+8Dtbwe
 lM/d8jcCQsHFTLEvFnS3VPd1dK/8jVYbyF5tijE7TIo8Xyw71LbPJ9y0ivoFB0wOQXIc
 dK6EQvEhW9tvF6nfbsxvRu6Ft2uTLuWyuHPqdIS+v8Z3SJgLe5wk3YnH44DBEMYHLGyq
 EHAzDu686nfrRy+VAuHQO24Zt38sAHKuhJASfabrRGM6ykL1H2uGPzTXSWDBvgYuHruB
 ZK2t+kXmvE04wrNKd8qeTtL4A28EHnHeAZQjJbUD48y3WKeOyYFJ2KNoPxU/xjSfIqT5
 Je1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX74fCQw9TSirMUD4C6L8/MnXn2g15/Uw4WPsAMP3XI24YnCptLpOz8pZWg8SZ9JEX9i4M=@lists.linux.it
X-Gm-Message-State: AOJu0YwiOonMxbcmuI5Hw37BXMSxhvoLStRFNwhj+aY8pXHZ0hEEwQBx
 j2E6SDppf5l2KEwl1Zh0HKlmonkFq5rG62P2fS/dIIGyHw+UPIjOBlQvHmipwYOVYcM=
X-Gm-Gg: ASbGncvwMlrrHOCebPoGpXYHewd6WxmTBoJjEIyX1CNiyr6GtX0tVP8hqNSl9Fz8KGE
 AcTmob24HAXJzbQKSu2RdmPJToH34xPOGK5+HXuDgpLcFUDsPmKU+y1GiJM7eS+3GHM+0iwV25j
 V6vfU0RWS5a1xpEVU1G2dhqLg7Qu0MYi77HaNgHLcElmT/97/rbFLMNBjRDOsk3ePGEmuQQM0ZV
 st5TVk+hKuYqCFrKvkIsJnJROf0mHwOQ1PYwDSbHNdcbqtiUzElYWHM6GID30Gdos6sjtltajS2
 Acvkuc6/ZrXcObKJ56j6ywK6yu+KOcxXQ7sj4HFe8xb3RngqTulRRsqs1YWrcSJA5bFlSKpm
X-Google-Smtp-Source: AGHT+IFv6QHeVUSHzKoAyOC4aofiY1mGorxbThlCBTwKN/C0T4ahob1rZuou+RiWt+1KQbKwHV19kA==
X-Received: by 2002:a17:907:2da7:b0:ae0:a245:d940 with SMTP id
 a640c23a62f3a-ae4109009e7mr752120466b.51.1751880239249; 
 Mon, 07 Jul 2025 02:23:59 -0700 (PDT)
Received: from [192.168.0.223] ([83.1.218.186])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b5fbfbsm668243166b.152.2025.07.07.02.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 02:23:58 -0700 (PDT)
Message-ID: <9fe4918b-431b-4ce0-9094-710385d5dd89@suse.com>
Date: Mon, 7 Jul 2025 11:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250620154346.19864-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250620154346.19864-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Two more metadata parser fixes
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

Feel free to merge, I will fix kirk later on.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

- Andrea

On 6/20/25 5:43 PM, Cyril Hrubis wrote:
> This series fixes a metadata parser for the ".filesystems" entry of the
> tst_test structure. First patch fixes the data storage to JSON
> serialization and second patch changes the parser to convert structure
> intialization with only designated initializers into a hash (object)
> rather than an arrray.
>
> @Andrea I suppose that the documentation generator needs a fix after
>          this is applied.
>
> Cyril Hrubis (2):
>    metadata: data_storage: Fix hash to json object serialization
>    metaparse: Map arrays with designated initializers to JSON objects
>
>   metadata/data_storage.h |  28 +++++++--
>   metadata/metaparse.c    | 134 +++++++++++++++++++++++++++++++++-------
>   2 files changed, 135 insertions(+), 27 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
