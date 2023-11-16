Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B433C54FB9
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 13:24:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA873CE3C9
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 14:24:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F122B3C1C76
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 14:24:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F7B61009BF2
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 14:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700141066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0ETiNWXJBxpvD29RfGNQ4XmSbcHJy2tuafezJwCrPT0=;
 b=Nmsibv3wOSlmynHhEOgMXsY8lfjdHWXpQfcU/cnt/LOqOjHc+NKlfuZ5Mu83DpH/qrvKSh
 cfbvSCQRip+7cBAnk8vQKEPAYcbNPVwQE/RI3xBDCpinKMHpJcecRjiwBIOh6f1JMvwsmU
 Ni+4gBNDsm4Ksi1G/heQRjH+qEPkm2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-z3CroA4AOpCTGRQahobiwQ-1; Thu, 16 Nov 2023 08:24:25 -0500
X-MC-Unique: z3CroA4AOpCTGRQahobiwQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40a5290e259so4708455e9.2
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 05:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700141064; x=1700745864;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ETiNWXJBxpvD29RfGNQ4XmSbcHJy2tuafezJwCrPT0=;
 b=Il3ec++0qBT5MErBGfPHwzrHsG8MjPCRFzUTXu2C20gGox+VdbY8bPv54fwkcIFYLD
 84YMJB+xaVvpVtUrHLdB5HD2F8sFUAstME+3I+Ii2xlNK1iDaZbiVPuAWGiUvEPK6Xri
 8Dw+Li6Sr+r5G1vI7FXdUmDc5U3pbCeqmrB6t6Su3lAltKSagzxMHWR84XuUv2IpZRIU
 qLShxRX9TAWEjT4GFzLDLWGcSLpuGWzc3GrDGYIZY1gZn/zI7EcBwX2wQwTUPu/Xs2i/
 5+HjP7xuxOGdSe9AZA0vJGgU+e20maXlZKRQepELflIQ251KYVDEQsTPiiChefQ3zR4p
 tsOw==
X-Gm-Message-State: AOJu0YztiRSgrTcY56bpnV78WGV6jQfAOlBUSu0KKAs/hWgouUpQkVK9
 2ongKd4FOQ9xdav0zMY/lAAXo1qkZ11ciVRSSkBGVg5bhqkc/up3A+4SEs7D6TwKi4EJb41ZMGM
 5qBf4Awe4m/I=
X-Received: by 2002:a05:600c:3b9b:b0:405:367d:4656 with SMTP id
 n27-20020a05600c3b9b00b00405367d4656mr13781663wms.29.1700141064212; 
 Thu, 16 Nov 2023 05:24:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4twjK2Pv0NgjRJx2vOG/Iz9OvKyfWpLYt4qzxzN7UZXh42J82FrwkKtv4orb/w6g3wfqB7w==
X-Received: by 2002:a05:600c:3b9b:b0:405:367d:4656 with SMTP id
 n27-20020a05600c3b9b00b00405367d4656mr13781645wms.29.1700141063737; 
 Thu, 16 Nov 2023 05:24:23 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a1c4c11000000b0040a44179a88sm3518712wmf.42.2023.11.16.05.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:24:23 -0800 (PST)
Message-ID: <3540fd3e-88dd-462b-88ce-df28b7b5b148@redhat.com>
Date: Thu, 16 Nov 2023 14:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel test robot <oliver.sang@intel.com>, Stefan Roesch <shr@devkernel.io>
References: <202311161132.13d8ce5a-oliver.sang@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202311161132.13d8ce5a-oliver.sang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [mm/ksm] 5e924ff54d: ltp.ksm01.fail
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
Cc: lkp@intel.com, Rik van Riel <riel@surriel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 16.11.23 05:39, kernel test robot wrote:
> 
> hi, Stefan Roesch,
> 
> we reported
> "[linux-next:master] [mm/ksm]  5e924ff54d: ltp.ksm01_1.fail"
> in
> https://lore.kernel.org/all/202311031548.66780ff5-oliver.sang@intel.com/
> when this commit is in linux-next/master.
> 
> now we noticed this commit is merged in mainline, and we still observed
> same issue. just FYI.
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.ksm01.fail" on:
> 
> commit: 5e924ff54d088828794d9f1a4d5bf17808f7270e ("mm/ksm: add "smart" page scanning mode")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 3ca112b71f35dd5d99fc4571a56b5fc6f0c15814]
> [test failed on linux-next/master 8728c14129df7a6e29188a2e737b4774fb200953]
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230715
> with following parameters:
> 
> 	disk: 1HDD
> 	test: mm-00/ksm01
> 
> 
> 
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
> 
> 
> 
> Running tests.......
> <<<test_start>>>
> tag=ksm01 stime=1699563923
> cmdline="ksm01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
> mem.c:422: TINFO: wait for all children to stop.
> mem.c:388: TINFO: child 0 stops.
> mem.c:388: TINFO: child 1 stops.
> mem.c:388: TINFO: child 2 stops.
> mem.c:495: TINFO: KSM merging...
> mem.c:434: TINFO: resume all children.
> mem.c:422: TINFO: wait for all children to stop.
> mem.c:344: TINFO: child 1 continues...
> mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
> mem.c:344: TINFO: child 2 continues...
> mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
> mem.c:344: TINFO: child 0 continues...
> mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
> mem.c:400: TINFO: child 1 stops.
> mem.c:400: TINFO: child 0 stops.
> mem.c:400: TINFO: child 2 stops.
> ksm_helper.c:36: TINFO: ksm daemon takes 2s to run two full scans
> mem.c:264: TINFO: check!
> mem.c:255: TPASS: run is 1.
> mem.c:255: TPASS: pages_shared is 2.
> 
> ....
> 
> mem.c:255: TPASS: pages_shared is 1.
> mem.c:255: TPASS: pages_sharing is 98302.
> mem.c:252: TFAIL: pages_volatile is not 0 but 1.     <-----
> mem.c:252: TFAIL: pages_unshared is not 1 but 0.     <-----

@Stefan, is this simply related to the new scanning optimization (skip 
and eventually not merge a pages within the "2 scans" windows, whereby 
previously, they would have gotten merged)?

If so, we might just want to disable that optimization for that test case?

Alternatively, maybe we have to wait for "more" scan cycles instead of 
only 2?

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
