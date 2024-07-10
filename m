Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC31FC3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:02:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CCF83D389A
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 21:02:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 517D83D073A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 21:02:38 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7EE12001D9
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 21:02:37 +0200 (CEST)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eea7e2b073so1140061fa.0
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720638157; x=1721242957; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mPZ60RuL6ih0QLl/o8/14hY+krd4EK1oz7htgw57d1A=;
 b=ba2CbqtAiRKjsrW/qgErdmVQyNzpw79SetX7ILFsc6j1IWTWIa3e4YCohNTylcJ9qE
 HY/gMi2/7CMHv+6/BA0KEpxhU0N8VbloY5mhoPPxyf/HaoN5RjRFflQ9wrbWoRTO/58a
 75CCNFpX/BwD6o7W9uBkTUWsJ7kgAwd5mx5A9CHHlbxEG32z5rnpyB7NRSAmI6oZ80+t
 8/FG9f7P9xIk0l6vvR8aLoCqpkLIEo1PR29OZSl3ZZTHav78SINg7hkgzAqnWxPy/r+N
 XJVq5evHuYu0I11g32ArgfaZJwEgctnzSvtqy5fphpsToECsuSfKW+jQXC0PSfK27cst
 WWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720638157; x=1721242957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mPZ60RuL6ih0QLl/o8/14hY+krd4EK1oz7htgw57d1A=;
 b=O0VOpy1d4c4Sl0l8+Df6Z4f/5ExZJ2nFs1ak0IRpZmGqnnrxyARNMq/idp5RQpGfXz
 MtG1X/zfQVQRYR/D3Z3h7xhhBO2uIJzFTrqEuzmazyerZNd+qYIxu0D9EvdSbdfqBBWT
 PuVugcfOvNVUoCPV2jUMWAxdQ4ed3Yh/2qvKhD9swEYEBVx2njGC1MfSisaBX0SbeABI
 2y0ASIXwSIWbHWQlMnbWsP7mK78jHY/E8vH2hgiNvzSPpkawg5mse5NESpy2FJxq85O4
 tEZ52J97rcLTt3OBvNcTstVcy8tEa1l4FtQOZOZlFWJyNKljc+ucNf9dLbtBeIbqkkjL
 /f0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxpd0ZERXyHa6PGqEuulMFBh8QSjKGb/BuX026q+6vZMMtnx/PDUkYnbGadvvIG2o4QEoCivC78MsEExsXmm9lLiI=
X-Gm-Message-State: AOJu0YwkrL3S30aYtEEeWrbCuLrDIxPvfkBF+H5Y0Z5DKIzYtiznf6lh
 XxUF8TSbcXmM4WhEKnnnIIxFZoZwxPKRj8vx3F3bIoeuvKYkhi60
X-Google-Smtp-Source: AGHT+IG1L8BlhXFrRo5w/hZ2v8OTkzJw0dc162nd8YCUmtKMgy4icMkIxWKQCufiuhXBIwUNvFBW+Q==
X-Received: by 2002:a2e:80cd:0:b0:2ee:974c:596f with SMTP id
 38308e7fff4ca-2eeb30feba0mr38435041fa.28.1720638156546; 
 Wed, 10 Jul 2024 12:02:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:b211:ad00:1490:6cc2:4d06:940f?
 ([2a01:4b00:b211:ad00:1490:6cc2:4d06:940f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426615876bbsm178014455e9.6.2024.07.10.12.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 12:02:36 -0700 (PDT)
Message-ID: <2fe63ea9-613a-4904-8b68-134442c43261@gmail.com>
Date: Wed, 10 Jul 2024 20:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hugh Dickins <hughd@google.com>
References: <202407101031.c6c3c651-lkp@intel.com>
 <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
 <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
 <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
 <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
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
Cc: Andi Kleen <ak@linux.intel.com>, Nhat Pham <nphamcs@gmail.com>,
 lkp@intel.com, David Hildenbrand <david@redhat.com>, "Huang,
 Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kernel test robot <oliver.sang@intel.com>, ltp@lists.linux.it,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 10/07/2024 21:49, Hugh Dickins wrote:
> It's a long time since I was active hereabouts, but the bot report
> and your flurry of updates make me think that you should step back,
> slow down, and look more carefully at the precedents here.
> 
> IIRC, the main problem is that parts of the swap_info_struct can
> still be in use from before while you're wanting to set up new values.
> Observe how alloc_swap_info() may return a fresh or an old allocation.
> Observe how enable_swap_info() is called after getting swapon_mutex
> late in swapon(), once past all possiblities of error.
> 
> I expect that your new zeromap needs to be taking the same care as is
> taken with swap_map and cluster_info: to be safe, follow their example
> in both swapon() and swapoff().
> 
> Hugh

Thanks, yeah sent too many in quick succession :). Will be more careful next time.

Both the 2nd and 3rd version are careful to solve the problem of using old allocation
which you described.

The 2nd one takes care of it in the same way as swap_map.

But I believe its unnecessary to do all that change in the 2nd version, when you can just
set it to NULL after kvfree, which is a much smaller change and takes care of reusing old
allocation equally well.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
