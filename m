Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1ACC77B7A
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 14:08:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25C4A3CEFBB
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 16:08:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C8593CB678
 for <ltp@lists.linux.it>; Wed, 24 May 2023 16:08:05 +0200 (CEST)
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C859210009F8
 for <ltp@lists.linux.it>; Wed, 24 May 2023 16:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZElh3inBw5eGIDiW0Pg939ijd8l5AaxQuiOExPhpig8=; b=DwZ91V1Uj89ekLj6Qt3Bw1SBxL
 TZke4gSQ4aXmJJWwjcaWvAIGp+ugDcjDa5uBv2q099VRvS7P5agmTBMa6mchNYa+lmIcxUnrth/FY
 e3j6thONzYPJOWWO67qYCp3w5bpIsj9CQgtVI8vlQ8lmjFGFTIuxgopwKfQibfKU9IGQwpbLuZniI
 QDXkfgC2BFDY8xrXTygcUMGIzTwr/qlIEBXpKdskBo4ltbov7LHV/9UMVjYuCXIh4KjrVNnAM+DLe
 vNYPnG52fcj7Ur4whekePkJESXeFztjwDPw/qWBLExhPhu9PgzFmKyj7pgaA+D14YldT44hRjfro6
 VbldiJww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1q1p9X-004zv2-1q; Wed, 24 May 2023 14:07:47 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB1233006B1;
 Wed, 24 May 2023 16:07:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8C01820A99305; Wed, 24 May 2023 16:07:44 +0200 (CEST)
Date: Wed, 24 May 2023 16:07:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20230524140744.GK4253@hirez.programming.kicks-ass.net>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] qemu-x86_64 compat: LTP: controllers: RIP:
 0010:__alloc_pages
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 X86 ML <x86@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, lkft-triage@lists.linaro.org,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, May 24, 2023 at 02:32:20PM +0530, Naresh Kamboju wrote:
> While running LTP controllers following kernel crash noticed on qemu-x86_64
> compat mode with stable-rc 6.3.4-rc2.

Both your reports are stable-rc 6.3.4-rc2; can I assume that stable
6.3.3 is good?

Either way, could you please:

 1) try linus/master
 2) bisect stable-rc

I don't immediately see a patch in that tree that would cause either of
these things.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
