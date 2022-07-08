Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0856CC433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 06:18:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E14A3CA3D7
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 08:18:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9DF3C051B
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 08:18:38 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 56EAA1400E52
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 08:18:36 +0200 (CEST)
Received: from canpemm100008.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LfNM76yTyzhZKV;
 Fri,  8 Jul 2022 14:16:03 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100008.china.huawei.com (7.192.104.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 14:18:32 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Fri, 8 Jul 2022 14:18:32 +0800
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Thread-Topic: [LTP] [PATCH] syscalls/creat09: Add umask(0) to setup
Thread-Index: AdiSfpfPHOhtinRARVqVHuUi3WEtKA==
Date: Fri, 8 Jul 2022 06:18:32 +0000
Message-ID: <4739766d7e9841eba1af74ac93878d40@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/creat09: Add umask(0) to setup
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
Cc: Zhao Gongyi via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

Shall we also need to add umask(0) in setup() though the setgid strip logic is affected by acl operations?

Best wishes,
Gongyi 

> 
> Hi Zhao
> 
> I don't this fix is meaningful because it only for "fix" this failure
> 
> so do you look into why umask(0077) lead this case fail?
> 
> I have rejected a similar patch[1] from petr yesterday because it has bug
> exists on kernel fs sgid strip logic.
> 
> [1]https://lists.linux.it/pipermail/ltp/2022-July/029495.html
> 
> Best Regards
> Yang Xu
> > The bit S_ISGID of st_mode is also affected by umask, if umask is
> > 0077, the test will fail.
> >
> > Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> > ---
> >   testcases/kernel/syscalls/creat/creat09.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/creat/creat09.c
> > b/testcases/kernel/syscalls/creat/creat09.c
> > index bed7bddb0..6edd5dbb9 100644
> > --- a/testcases/kernel/syscalls/creat/creat09.c
> > +++ b/testcases/kernel/syscalls/creat/creat09.c
> > @@ -52,6 +52,8 @@ static void setup(void)
> >   	struct stat buf;
> >   	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
> >
> > +	umask(0);
> > +
> >   	tst_res(TINFO, "User nobody: uid = %d, gid = %d",
> (int)ltpuser->pw_uid,
> >   		(int)ltpuser->pw_gid);
> >   	free_gid = tst_get_free_gid(ltpuser->pw_gid);
> > --
> > 2.17.1
> >
> >

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
