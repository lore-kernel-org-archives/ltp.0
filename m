Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E3CC77B7A
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 17:55:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F152C3CEFC6
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 19:55:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1863C9957
 for <ltp@lists.linux.it>; Wed, 24 May 2023 19:55:05 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FFBE600940
 for <ltp@lists.linux.it>; Wed, 24 May 2023 19:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6T9TB36mAiDcErcLZAZRBQib3bTTYAdiNi7xQ6cd2Yw=; b=dmktSR3kFQTbKea19MR412DQze
 XLAwguRSQB5aDSh+HYVtUCdGHwro0XMJYlzSL+zcrKbuaAE3DDR9EJOB0VSg+SKGlVEdeQlrhm6s5
 VHZS7MvFYx6RVO+1Qnq0xuxltxj9rv+iBvR7DO9aqTRGVoFokykeJW8goTjQO+9zKpAzcFtwEr+YF
 opM38Q3sAbTxgsbhD/V5A8TTnUJdBBYBYH8M4ht/hGes4ParBVQzV3G1UArhuDeMq0f9byIYwM2yN
 JNSPFiNaGzFjskbBbwYCLhZ+qR5pwxECZ9+6UUSe4I2Cm4uVsijKTVSoZRTf1lTZ8cxpKKfMKbEaF
 ik/Vl7vQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1q1shC-00BPta-38; Wed, 24 May 2023 17:54:46 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 180C830013F;
 Wed, 24 May 2023 19:54:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CEC39242F81B8; Wed, 24 May 2023 19:54:42 +0200 (CEST)
Date: Wed, 24 May 2023 19:54:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20230524175442.GO4253@hirez.programming.kicks-ass.net>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net>
 <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

On Wed, May 24, 2023 at 09:39:50PM +0530, Naresh Kamboju wrote:
> FYI,
> These are running in AWS cloud as qemu-i386 and qemu-x86_64.

Are these hosted on x86 and using KVM or are they hosted on Graviton and
using TCG x86 ?

Supposedly TCG x86 is known 'funny' and if that's what you're using it
would be very good to confirm the problem on x86 hardware.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
