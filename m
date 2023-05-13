Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06CCC77B75
	for <ltp@archiver.kernel.org>; Sat, 13 May 2023 00:29:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EABD93CDF91
	for <ltp@archiver.kernel.org>; Sat, 13 May 2023 02:29:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABE2E3CB482
 for <ltp@lists.linux.it>; Sat, 13 May 2023 02:29:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B91CD1400066
 for <ltp@lists.linux.it>; Sat, 13 May 2023 02:29:00 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EDC5F6115C;
 Sat, 13 May 2023 00:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DA3C433EF;
 Sat, 13 May 2023 00:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683937737;
 bh=8nte3X1QEso1Yx1OCznxFxCeKYd/lSLObSH8cspvq50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oC1vn93Qbmxa2Q6s6vPp4asWSTFdkuprnryMUxBubP69S61FWvPAdgtc29mqCG+QG
 FdfC8v0bq1nb+bZkQhqTI2X3l7WHdRt5F+Hk+8K9el8xlBuWpI/hQo4JPFz6VBUMwL
 mOKHA7fy+hYGchpljGAN0j3jrib6rR4Ww6ATo+s6Swepgq+yhxlcTXA9ioWjHyKvC6
 v/YGjzm0P9ckiRHcsO9JHO1tJu9uiKnaRkG+liPM4NsbkGk9104SdJ9gotYFyfJN45
 YyoUlu3QLRXlqN55+8ZiTvE28ScKZDwLXJgL/7ue3qZUZeq+/xHhvBP1n/X23K1XpA
 MS1cAfJrjEe9w==
Date: Fri, 12 May 2023 17:28:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230513002854.GA3033@quark.localdomain>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1683623648-22778-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1683623648-22778-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] syscalls/statx01: Relax mnt_id test
 condition
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang,

On Tue, May 09, 2023 at 05:14:05PM +0800, Yang Xu wrote:
> Before this patch, we test stx_mnt_id only when glibc's statx struct has
> this member. Now, if glibc miss this filed, we will use __spare2[0], see
> url[1]. If glibc miss statx struct, we will use ltp owner definition.

I don't think this is the right approach either.  Actually, this new proposal is
arguably worse than leaving the problem unsolved.  The problem with this new
proposal is that the fields in struct statx whose names are prefixed with
"__spare" were never intended to be used directly.  Their names can change from
one kernel version to the next, and they can change to a different offset and/or
size while keeping the same name.  That can result in breakages that only
reproduce on very specific versions of <sys/stat.h>.

As I've said several times, the proper way to ensure that the tests can be built
even when the system struct statx doesn't contain all the needed fields is to
use the LTP struct statx whenever the system one does not fully suffice.

One way to do that would be to make the tests use the struct via a different
name, such as struct ltp_statx, and define that to either the system statx or
the LTP statx depending on which one has the right definition.

It might also be possible to #define statx to achieve the same effect (though
maybe that would cause a collision with the function statx()...)

Anyway, I don't want to derail the STATX_DIOALIGN test too much, so if you're
having a lot of trouble solving this problem properly, I'm okay with just
adding the STATX_DIOALIGN test without it solved for now...

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
