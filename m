Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A2EC433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 19:41:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC00F3CA0FF
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 20:41:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7F253C978E
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 20:40:56 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12ED81000DEC
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 20:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GrbBLAbtvC4chaYdzgUK1w1hf9+xtC4k6cVzY/iVx3U=; b=pUaNsZxVGnEHGlDh9Mk+nY4Puc
 WDK2PKuOlt4p0TsbO6ETD2kRFFIDMPq93CdkJa9Iab0H00mjKKQLei1dPnXOHapqa58yCw72eYM4E
 jlgrtc0l94HKpO/qSd6rRHBtIBI62VoEfbYdqDPC3hfIVl7cAWxyarEfP5GMPxxrivrWd2tj/QTtX
 vMrA9PdF5ZHtwmXXUbcDoAk3PZumDSG6NW/yIway8XVyvJu28V5/hlFS4SmLWB4bDAglam6GIOtPg
 EIakVt52CXxk2k40RN34UYCk8ko1gF5NiN2m5ieGbD1Qldb3mOTj2Ip+6w3fCOaQJD8L54/o+c8zk
 OLAW9wCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nNJyt-0054y2-Hj; Thu, 24 Feb 2022 19:40:51 +0000
Date: Thu, 24 Feb 2022 19:40:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <YhffQ6XStJycOmK1@casper.infradead.org>
References: <CA+G9fYs_8ww=Mi4o4XXjQxL2XJiTiAUbMd1WF08zL+FoiA7GRw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYs_8ww=Mi4o4XXjQxL2XJiTiAUbMd1WF08zL+FoiA7GRw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [next] LTP: readahead02.c:295: TFAIL: readahead failed to
 save any I/O
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, regressions@lists.linux.dev,
 David Hildenbrand <david@redhat.com>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Luis Chamberlain <mcgrof@kernel.org>,
 Peter Xu <peterx@redhat.com>, Muchun Song <songmuchun@bytedance.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, LTP List <ltp@lists.linux.it>,
 Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 24, 2022 at 02:57:59PM +0530, Naresh Kamboju wrote:
> On Linux next 20220222 tag LTP syscalls test case readahead02 failed.
> Please find detail test output on below link [1]
> 
> test failed log:
> --------------------
> readahead02.c:181: TPASS: offset is still at 0 as expected
> readahead02.c:285: TINFO: read_testfile(0) took: 37567 usec
> readahead02.c:286: TINFO: read_testfile(1) took: 37263 usec
> readahead02.c:288: TINFO: read_testfile(0) read: 0 bytes
> readahead02.c:290: TINFO: read_testfile(1) read: 0 bytes
> readahead02.c:295: TFAIL: readahead failed to save any I/O

Confirmed, I can reproduce this with the folio tree.  Will work on
this once I've disposed of the other bug I'm looking at right now.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
