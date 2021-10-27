Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4075C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:37:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916F86103B
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 916F86103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACB343C6971
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:37:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3F513C0CEE
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:36:50 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0DE56022B6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:36:47 +0200 (CEST)
Received: from dggeml763-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HfNkW5D1lzbl2s;
 Wed, 27 Oct 2021 17:32:03 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml763-chm.china.huawei.com (10.1.199.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 27 Oct 2021 17:36:42 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.015;
 Wed, 27 Oct 2021 17:36:42 +0800
From: zhaogongyi <zhaogongyi@huawei.com>
To: Jan Stancek <jstancek@redhat.com>
Thread-Topic: [LTP] [PATCH] lapi/syscalls: Add epoll_create for aarch64.in
Thread-Index: AdfLFhvwM5VVybBTTHCDLv/mQLWULw==
Date: Wed, 27 Oct 2021 09:36:42 +0000
Message-ID: <478982ce993a4eeb9ab3d00c8967a377@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/syscalls: Add epoll_create for aarch64.in
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,



> 
> On Wed, Oct 27, 2021 at 5:28 AM zhaogongyi <zhaogongyi@huawei.com>
> wrote:
> >
> > Hi,
> >
> > >
> > > On Tue, Oct 26, 2021 at 9:49 AM Zhao Gongyi
> <zhaogongyi@huawei.com>
> > > wrote:
> > > >
> > > > Add epoll_create for aarch64.in and modify the value of epoll_ctl
> > > > for aarch64.in. Otherwise, the testcase
> > > > epoll_create01/epoll_create02 will fail.
> > > >
> > > > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > > > ---
> > > >  include/lapi/syscalls/aarch64.in | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/lapi/syscalls/aarch64.in
> > > > b/include/lapi/syscalls/aarch64.in
> > > > index a47185954..e9023a1d0 100644
> > > > --- a/include/lapi/syscalls/aarch64.in
> > > > +++ b/include/lapi/syscalls/aarch64.in
> > > > @@ -19,7 +19,6 @@ getcwd 17
> > > >  lookup_dcookie 18
> > > >  eventfd2 19
> > > >  epoll_create1 20
> > > > -epoll_ctl 21
> > > >  epoll_pwait 22
> > > >  dup 23
> > > >  dup3 24
> > > > @@ -243,6 +242,8 @@ rt_tgsigqueueinfo 240  perf_event_open
> 241
> > > >  accept4 242
> > > >  recvmmsg 243
> > > > +epoll_create 250
> > > > +epoll_ctl 251
> > >
> > > These values are for 32 bit only syscalls. Won't this break 64 bit?
> >
> > Yes, these values are for 32 bit only syscalls, the syscall epoll_create is
> not support for 64bit arm64.
> 
> Right, adding epoll_create is OK, but changing epoll_ctl would break 64bit
> if there were any users of __NR_epoll_ctl.

If we do not consider the running of 32bit program on arm64, we need to remove __NR_epoll_ctl.

And the testcase using __NR_epoll_ctl will fail, is it a problem to be resolved?

> 
> >
> > Reference to man 2 epoll_create, we can see that
> epoll_create/epoll_create1 are supported If only we include the header
> file sys/epoll.h.
> >
> > Is it better that we call epoll_create replace to syscall
> __NR_epoll_create since some plateform not support it?
> 
> I think so. We already use epoll_create() in other tests, so this looks like
> simplest solution for all arches.
> 
> >
> >
> > Thanks for you review!
> >
> > >
> > > >  wait4 260
> > > >  prlimit64 261
> > > >  fanotify_init 262
> > > > --
> > > > 2.17.1
> > > >
> > > >
> > > > --
> > > > Mailing list info: https://lists.linux.it/listinfo/ltp
> > > >
> >


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
