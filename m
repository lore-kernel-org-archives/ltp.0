Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A51CCA47E
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 02:59:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16AD93C8D6D
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 04:59:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7C073C08DA
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 04:58:57 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8DD0C6007B1
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 04:58:56 +0200 (CEST)
Received: from canpemm100006.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LHFRb2hJhzpW31
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 10:58:35 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100006.china.huawei.com (7.192.104.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 10:58:52 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Tue, 7 Jun 2022 10:58:52 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] futex_waitv04: Add test for futex_waitv syscall
Thread-Index: Adh6GjzT0w198cEtQCSZC/G4mQVHUQ==
Date: Tue, 7 Jun 2022 02:58:52 +0000
Message-ID: <1c109d458aec4d82b065d015b42016a7@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv04: Add test for futex_waitv syscall
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

I have resubmit the patch that move the test code to futex_waitv01.c as your suggestion, please see: https://patchwork.ozlabs.org/project/ltp/patch/20220607025435.184105-1-zhaogongyi@huawei.com/

Best wishes,
Gongyi

> 
> Hi!
> > I also wondered whether to add these two testcases into
> > futex_waitv01.c, there is a consideration that there are alse two
> 
> Will you send a patch that adds these cases to the futext_waitv01.c then?
> 
> > other testcases need to be added according to linux manual:
> > 1. A signal was sent to the sleeping task, returning -ERESTARTSYS.
> > 2. Some futex at the list was woken, returning the index of some waked
> futex.
> 
> Feel free to send more patches, adding more test coverage is always
> welcomed.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
