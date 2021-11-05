Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45406C433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:03:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4486125F
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A4486125F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC6E3C7634
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:03:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 585A23C136D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:03:28 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9F7F60106B
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:03:27 +0100 (CET)
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlvYn5Q2Bzcb3Q
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 16:58:37 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 5 Nov 2021 17:03:23 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.015;
 Fri, 5 Nov 2021 17:03:22 +0800
From: zhaogongyi <zhaogongyi@huawei.com>
To: Petr Vorel <pvorel@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Thread-Topic: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
Thread-Index: AdfSI+ORg6gbLgYfS7KVywAEcf7nnw==
Date: Fri, 5 Nov 2021 09:03:22 +0000
Message-ID: <8db5b877820f47b8be4c6706af42ab56@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
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
Cc: Matthew Bobrowski <repnop@google.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I have resubmit a patch as your review. Please see: https://patchwork.ozlabs.org/project/ltp/patch/20211105090200.103485-1-zhaogongyi@huawei.com/

Thanks so much!
Gongyi

> 
> Hi all,
> 
> ...
> > This would be the obvious solution.
> > But simpler to skip zero values then stop the iterator.
> +1
> > This makes the cleanup helper reenetrant:
> 
> > static int stop_children(void)
> > {
> >         int child_ret;
> >         int i, ret = 0;
> 
> >         for (i = 0; i < MAX_CHILDREN; i++) {
> >                 if (!child_pid[i]) continue;
> >                 SAFE_KILL(child_pid[i], SIGKILL);
> >         }
> >         for (i = 0; i < MAX_CHILDREN; i++) {
> >                 if (!child_pid[i]) continue;
> >                 SAFE_WAITPID(child_pid[i], &child_ret, 0);
> >                 if (!WIFSIGNALED(child_ret))
> >                         ret = 1;
> >                 child_pid[i] = 0;
> >        }
> 
> >         return ret;
> > }
> 
> Amir, thanks! Zhao, could you please test this in your setup?
> (+ please be verbose about your setup, it helps to decide in the future that
> fix is still needed).
> 
> Kind regards,
> Petr
> 
> > Thanks,
> > Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
