Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F99BC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:58:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D10C3CB18B
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:58:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 452A03CB0B9
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 13:58:28 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78CF0600155
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 13:58:18 +0200 (CEST)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtQwN1KT0zVhx1
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 19:53:24 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 19:58:02 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 20 Oct 2022 19:58:02 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] lib: Move setup_ipc() to the beginning of
 do_setup()
Thread-Index: AdjkeyIXuSu6k2PVMkKOYCaqhDmG6Q==
Date: Thu, 20 Oct 2022 11:58:02 +0000
Message-ID: <c165da5269a643e3a737feb498fa683a@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Move setup_ipc() to the beginning of
 do_setup()
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

Hi,

> 
> Hello,
> 
> Zhao Gongyi via ltp <ltp@lists.linux.it> writes:
> 
> > Move setup_ipc() to the beginning of do_setup() since we would use the
> > 'results' immediately in do_setup(), otherwise,there is no Results
> > statistics when calling the tst_brk in do_setup().
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  lib/tst_test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/tst_test.c b/lib/tst_test.c index
> > 8ccde1629..02fc6a06e 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1096,6 +1096,8 @@ static void do_cgroup_requires(void)
> >
> >  static void do_setup(int argc, char *argv[])  {
> > +	setup_ipc();
> > +
> 
> We can't move it to before checking if tst_test is null.

Actrually, tst_test is not null for ever since we have a definition at lint 375 in tst_test.h:

  static struct tst_test test;

So, is there any problem exist that I did not see?


Regards,
Gongyi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
