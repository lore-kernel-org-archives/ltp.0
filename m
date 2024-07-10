Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775A0C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720637384; h=date : to :
 in-reply-to : message-id : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sgOy1xfiHOEezrOaZYVVcEnnJLI4lCr8hL3HLVkn/SQ=;
 b=lGrBSYHyDAkN2bPHSOVZ4dgaiQqfvvUy4742lojItr9Y5VsqeuYBN9mh056HC8J41t8BO
 eda/uPDefuFOn/b4wfhC0dtwbWsoV05QsWN7VXhIgAkFKHfewxxKCKUBDf5Zn+664hgjSt8
 pmlkq3i2GNdcIfXFPZBUalvb6S9vBkE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 362CC3D386D
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:49:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6FD73D3860
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:49:22 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 086FD609A45
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:49:22 +0200 (CEST)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25e04a7d9f1so66302fac.2
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720637360; x=1721242160; darn=lists.linux.it;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CDzDoDBPrI9O45fu4nDGF7EewD4QPEbaHsgpGnRS9bA=;
 b=INotPuDo6fo5CScoiNxnOrzHJwPfgBBqqU3lSHKmorFPzYKHUXY7RUBHGidy0r4C16
 knDnp+9Orq1knXIOos7VzeNFM/0xaKrvLsUmtitf87bc0UaS8TYmT68//DNBZezLabVK
 HtoS2U4s4IQn1X1kj2VWgDtC5YKMnJzL3kB+4C08WOL7C/r7BM1pV0bGYR5MZrF+KODP
 xZq1P+phThGC/nFZI8+7d0lFsvfvVpLy/RVXTPZKN3qoTTGPoBGscZTnd43qHzVnEPMa
 gbNqMJokIqBHHpDBCt0tNkuGswK/XmCbYfrK09ulxgQEgoZH3Cxwh9MlHwuTKk4cYMcM
 bWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720637360; x=1721242160;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDzDoDBPrI9O45fu4nDGF7EewD4QPEbaHsgpGnRS9bA=;
 b=mLt1WUb2mzscP9W5SQyF8u14Q9amB5O0RcrEV7yptBwuVm3pmRPS/ZjE0PswbgFj6k
 794iFW9Zwi8XL3m5XbGUorPQqpjgcR+cgw1zamXl4vCyLkk6RiO+xKU89UyjDBZD3oLr
 A3AUU1gnUJRcxVoeToQdJttOZAt7HKBJ23HGzqro17SVwi42TzOr1F9wY0MZBSqxLl3G
 qz7yQ7d9uV3KW0nSnKyY/JOIavUuMjgCrA0W9Kbdt7c6/MUuBje4xQJc+97h//++Yq55
 yAv8KQ+fwvX7RVCfz3HQRInZMoNKmZJ4+XKnhUAS0X+V1TlNSZA6+VaHSmdAOrj16wyv
 rA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU0wDWzLxANVlKps/lp9yB/vd2DzBtDwoTVAp89zhO+B9SNJkyWDhcID66aK3SSVu9uCj1vzlue+JUHSEdebWnOX4=
X-Gm-Message-State: AOJu0Yyg0T4kpY5qnpTv3iyjnT2XK2IkWOkeYmRFehNdURAYQyD30mx5
 4U8Md26TTLmLGVLxvXmJaORSJyq+8LaqKMn/vMsJ7Ht7aiKJm0EiWt75b4pj+Q==
X-Google-Smtp-Source: AGHT+IGpNu9mEuoMmeAlVedGx8Nyw0EmBMtvokuZhBygl5S2JzWgS4Wea6kyWyOlMeLcWyY/SXZaig==
X-Received: by 2002:a05:6870:71c4:b0:254:d147:f256 with SMTP id
 586e51a60fabf-25eae749f6dmr5489335fac.8.1720637360470; 
 Wed, 10 Jul 2024 11:49:20 -0700 (PDT)
Received: from darker.attlocal.net
 (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa078407sm1336933fac.27.2024.07.10.11.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 11:49:19 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:49:09 -0700 (PDT)
To: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
Message-ID: <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
References: <202407101031.c6c3c651-lkp@intel.com>
 <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
 <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
 <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
From: Hugh Dickins via ltp <ltp@lists.linux.it>
Reply-To: Hugh Dickins <hughd@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Nhat Pham <nphamcs@gmail.com>,
 lkp@intel.com, David Hildenbrand <david@redhat.com>, "Huang,
 Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yosry Ahmed <yosryahmed@google.com>,
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

It's a long time since I was active hereabouts, but the bot report
and your flurry of updates make me think that you should step back,
slow down, and look more carefully at the precedents here.

IIRC, the main problem is that parts of the swap_info_struct can
still be in use from before while you're wanting to set up new values.
Observe how alloc_swap_info() may return a fresh or an old allocation.
Observe how enable_swap_info() is called after getting swapon_mutex
late in swapon(), once past all possiblities of error.

I expect that your new zeromap needs to be taking the same care as is
taken with swap_map and cluster_info: to be safe, follow their example
in both swapon() and swapoff().

Hugh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
