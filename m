Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAB7C44508
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 03:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 375AE3E9A0D
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 05:05:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2547B3E2945
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 05:05:04 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B60AE1A00484
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 05:04:57 +0200 (CEST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784084696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBOeCB6lflUoSg78zbwPCMF0Kp7MMQAR18a6l7X2gn0=;
 b=tPN0Dmk4BlrdHZxXxgjvkmuTSuY3VPtADHF51tNTQuvaDjxlCGrAq1SLi/ZNEfVya8BAtu
 KCiAi/dgCFLyeFgJhZt/hzYKjyA0i+OfQT0r0/arfZlR9G6bFFDF7pfLvBb1S7en+7sInd
 GFrvvnYm9mpRCE9ndj5B8YQPjaF8oEU=
Date: Wed, 15 Jul 2026 03:04:55 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: gang.yan@linux.dev
Message-ID: <a303ea8d1d9ddd3f8dc62fe47c9498005ce2fe10@linux.dev>
TLS-Required: No
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a56189c.d419c4af.35af2f.7b5a@mx.google.com>
References: <6a56189c.d419c4af.35af2f.7b5a@mx.google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] generate_syscall.sh: add a helper named
 tst_syscall_base
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
Cc: Gang Yan <yangang@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

July 14, 2026 at 7:08 PM, "Andrea Cervesato" <andrea.cervesato@suse.com mailto:andrea.cervesato@suse.com?to=%22Andrea%20Cervesato%22%20%3Candrea.cervesato%40suse.com%3E > wrote:


> 
> Hi Gang,
> 
> > 
> > From: Gang Yan <yangang@kylinos.cn>
> >  
> >  This patch adds a helper named tst_syscall_base, it can check the
> >  syscall on older distros without tst_brk.
> >  
> >  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  include/lapi/syscalls/generate_syscalls.sh | 27 +++++++++++++---------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >  
> >  diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
> >  index 19f280dfb..95c2c9aeb 100755
> >  --- a/include/lapi/syscalls/generate_syscalls.sh
> >  +++ b/include/lapi/syscalls/generate_syscalls.sh
> >  @@ -49,18 +49,23 @@ tst_brkm(TCONF, dummy_cleanup, \
> >  })
> >  #endif
> >  
> >  +#define tst_syscall_base(NR, ...) ({ \
> >  + intptr_t tst_ret; \
> >  + if (NR == __LTP__NR_INVALID_SYSCALL) { \
> >  + errno = ENOSYS; \
> >  + tst_ret = -1; \
> >  + } else { \
> >  + tst_ret = syscall(NR, ##__VA_ARGS__); \
> >  + } \
> >  + tst_ret; \
> >  +})
> > 
Hi Andrea,

Thanks for your review.

> Do we really need this? If we don't define memfd_secret, we really want
> to get a TCONF. And the function is used in a weird way.

You are right. I've confirmed that syscall(-1) returning a positive
value is a glibc or kernel bug on loongarch64, syscall(-1) should return
-1, but return 38 (ENONSYS) in my enviroment. It is not something LTP should
work around.


> 
> If you need to add the support for memfd_secret, please just update the
> syscalls files via:
> 
> ./include/lapi/syscalls/generate_arch.sh <path to linux sources>
> 
> We don't update .in files manually since it's error prone.
>

Thanks again

Cherrs
Gang 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com mailto:andrea.cervesato@suse.com
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
