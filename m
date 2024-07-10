Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5D5C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:18:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BEF73D3874
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 21:18:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BF3E3D3860
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 21:18:08 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E1F02081B9
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 21:18:07 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 42D1CCE12C7;
 Wed, 10 Jul 2024 19:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0509CC32781;
 Wed, 10 Jul 2024 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1720639083;
 bh=0ihz+DlqmEqKVS2DD/pDgRVbl8B31X8U8rySSkNJDMc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=O7z3T8A3B4GolCybuptbj0cLCJONrz5UiiL1xZtL6EPax5CBzOyux7F3adKZtBxS3
 /03+1jmomwoyqNbAB0nT677cKCtcgKIy0+OKzxu6YsjhGHprpUrFNK26wr1hLzCVpC
 rTLXpJ6r0XxJTzpfur+kEr50SDe70f+lMmesTQHg=
Date: Wed, 10 Jul 2024 12:18:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Message-Id: <20240710121802.e1445448d94b3f6ea16fdd12@linux-foundation.org>
In-Reply-To: <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
References: <202407101031.c6c3c651-lkp@intel.com>
 <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
 <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
 <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
 <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: Usama Arif <usamaarif642@gmail.com>, Andi Kleen <ak@linux.intel.com>,
 Nhat Pham <nphamcs@gmail.com>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kernel test robot <oliver.sang@intel.com>, ltp@lists.linux.it,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 10 Jul 2024 11:49:09 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

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

Thanks.  I've dropped the series "mm: store zero pages to be swapped
out in a bitmap" from mm-stable.  Let's revisit in the next -rc cycle.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
