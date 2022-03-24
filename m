Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02308C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 02:28:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CDB63C9803
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 03:28:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C263C9447
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:27:55 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C24F0680E4B
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:27:54 +0100 (CET)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KP8GH4Q7hzCr4X
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 10:25:43 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (7.185.36.93) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:27:51 +0800
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:27:51 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2308.021; 
 Thu, 24 Mar 2022 10:27:51 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] accept02: Add SAFE_FORK to clean CLOSE_WAIT fds
Thread-Index: Adg/JAC4X9ZxldvtTDu8qwSueKKU0w==
Date: Thu, 24 Mar 2022 02:27:50 +0000
Message-ID: <45ad8c7bf0c040f69346499d9ef72230@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] accept02: Add SAFE_FORK to clean CLOSE_WAIT fds
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Thanks for your review! Yes, I cann't the clone_server_sockfd is not closed before, 
and I will resubmit a patch, please see: https://patchwork.ozlabs.org/project/ltp/patch/20220324022455.245300-1-zhaogongyi@huawei.com/

Best regards,

Gongyi

> 
> Hi!
> As far as I can tell we should rather close the fd returned from the
> accept() call like this:
> 
> diff --git a/testcases/kernel/syscalls/accept/accept02.c
> b/testcases/kernel/syscalls/accept/accept02.c
> index 12a1e3ca3..b2d27a260 100644
> --- a/testcases/kernel/syscalls/accept/accept02.c
> +++ b/testcases/kernel/syscalls/accept/accept02.c
> @@ -68,6 +68,8 @@ static void *server_thread(void *arg)
>         TEST(setsockopt(clone_server_sockfd, SOL_IP,
> MCAST_LEAVE_GROUP,
>                         mc_group, mc_group_len));
> 
> +       SAFE_CLOSE(clone_server_sockfd);
> +
>         if (TST_RET != -1)
>                 tst_res(TFAIL, "Multicast group was copied!");
>         else if (TST_ERR == EADDRNOTAVAIL)
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
