Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01739C001DE
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 04:31:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2C273CAB42
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 06:31:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36C783CA860
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 06:31:35 +0200 (CEST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D81060070D
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 06:31:32 +0200 (CEST)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net
 [173.48.116.181]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36H4VBcW032431
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jul 2023 00:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1689568277; bh=DX2FGsc/zuGqEoYRVwpitWL4pzdwOUkjpH+YNkuzp2Y=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=RCVa30gNl9kM4D6VozHZDx8G+qwpIjmtX8cKPRiR6JHO3z3W3J0EtDhaj2LLCrDRD
 oWyiYVWAcW2y5/laImvSaxU87lBLs8X0tfgmKxOnAje0UwHB2eJc8NVxYKhgnG/WXL
 zPQ5Nu5zqPTRqYKwmxgMedqTYfbbEQL4BopvEyhmNT8LabWSYXc1u2F41Z3cZA9WmR
 U6wHj/lr5VHsJy4zJUO6UdYB2PdHGdSOHDZ7JNhExI1tYt0bCBrF8Xnd2InF34l2GJ
 4iM+9XdU88C45cRmSogzUJKXy+SSptbk25t4okb7dXiUNuB1dzMlOjwWTNTMm6vlQm
 9ubmeTTdfvQxg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 7CB0315C0280; Mon, 17 Jul 2023 00:31:11 -0400 (EDT)
Date: Mon, 17 Jul 2023 00:31:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20230717043111.GA3842864@mit.edu>
References: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
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
Cc: Arnd Bergmann <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Jul 16, 2023 at 11:32:51AM +0530, Naresh Kamboju wrote:
> Following kernel BUG noticed while testing LTP fs testing on x86_64
> arch x86_64 on the Linux next-20230716 built with clang toolchain.

Hmm, I'm not seeing the next-20230716 tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

or

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/

I see a tag for next-20230717 and for next-20230714, but not
next-20230716.  Was this a typo?  Does it reproduce on the
next-20230717 tree?

Also, since I don't use LTP, can you give me a trimmed-down
reproducer, to save me some time?

Thanks!!

					- Ted

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
