Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A97C43334
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 09:39:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 723183CA745
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 11:39:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 839EE3CA441
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 16:37:37 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97565600F71
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 16:37:35 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 257196284F;
 Fri,  8 Jul 2022 14:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20034C341C0;
 Fri,  8 Jul 2022 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657291052;
 bh=2fwrfox9jxoAeMKWLfE0qMqSrSazGxh4BTWQMIfBbig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d6L8EtnXjxW0DNuTALwslO/6JsmPOAsXjncyJCVsN8UsQB6qcZVzryJ0Mu/97XDTa
 kTzIWYffQmbqR5wVyW09u4wtXhvliDCI437w92wfN3bYGmjgvFNBMUSx+uaSS9qFHl
 5XN9L7bR5wvw8LGNL7oSDaOy+TlAz5QpBpBpdTgywpoZ0p0zRxffXM57APr51GTymI
 kPsZA3x5Vh0Dy9ZqCv3h/W9kObZf3F4eqhe6WMbKcuEzqm89buMTpTp0XvG5UcmQza
 jOF5izmsYR37gFzxqSjGcZ2M4PFPGC2WGWhN4RNWkSL3l+sz0JrtVwAEkdWXb5VyOu
 EngcoO1iWdWJg==
Date: Fri, 8 Jul 2022 16:37:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20220708143728.r655waixwr3x7xtg@wittgenstein>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62C5663C.2060009@fujitsu.com> <YscgIvZauxbArm7i@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YscgIvZauxbArm7i@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Jul 2022 11:38:55 +0200
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 07, 2022 at 08:04:18PM +0200, Petr Vorel wrote:
> Hi Xu,
> 
> > Hi Petr
> 
> > Share some process with you...
> 
> > I have rejected this patch and a kernel patchset[1] is plan to fix this 
> > but doesn't merged to upstream kernel due to none continue to review 
> > this(It is about one month since v9...)
> 
> > TBH, this case only tests simple creat file with open but miss
> > open with O_TMPFILE[2]
> > mknodat[3]
> 
> > setgid strip logic is not only affected by umask but also include acl 
> > operations[4].
> 
> Thanks a lot for an update.
> Al, Christian, Amir, could you please have look on v9?

Afaict, I reviewed v9 and left comments and had pointed out things that
needed to be changed. So I'd wait for v10 (I'm on vacation next week
though.).

Christian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
