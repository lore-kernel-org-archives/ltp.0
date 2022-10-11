Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F91C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:52:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B82F3CAEA9
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:52:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D8E3C7319
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:51:57 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B07820014C
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:51:56 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmwXG3cW7zHtv1;
 Tue, 11 Oct 2022 20:46:54 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 20:51:53 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Tue, 11 Oct 2022 20:51:53 +0800
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] syscalls/add_key05: Add userdel and groupdel
 before useradd
Thread-Index: AdjdcAHYZidrlID61ESWKSYzfPhpDw==
Date: Tue, 11 Oct 2022 12:51:53 +0000
Message-ID: <28fcfa13996f4f9fa9157f78c3163427@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/add_key05: Add userdel and groupdel
 before useradd
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
Cc: zhangerying <zhangerying@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Thanks for your review! I have resubmit the patch as your suggestions. Please see: https://patchwork.ozlabs.org/project/ltp/patch/20221011124630.62647-1-zhaogongyi@huawei.com/

Regards,
Gongyi

> 
> Hi Zhao
> 
> > If the test exit abnormal, some user/group will be left, and the next
> > running of the test will fail and report:
> >
> >    tst_buffers.c:55: TINFO: Test is using guarded buffers
> >    tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> >    useradd: group ltp_add_key05_0 exists - if you want to add this user
> to that group, use -g.
> >    add_key05.c:41: TBROK: useradd failed (9)
> >    userdel: user 'ltp_add_key05_0' does not exist
> >    add_key05.c:56: TWARN: 'userdel -r ltp_add_key05_0' failed:
> ENOENT
> > (2)
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >   testcases/kernel/syscalls/add_key/add_key05.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/add_key/add_key05.c
> > b/testcases/kernel/syscalls/add_key/add_key05.c
> > index 71a88d1a8..42ad04eec 100644
> > --- a/testcases/kernel/syscalls/add_key/add_key05.c
> > +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> > @@ -34,8 +34,13 @@ static void add_user(char n)
> >   {
> >   	char username[] = "ltp_add_key05_n";
> >   	const char *const cmd_useradd[] = {"useradd", username,
> NULL};
> > +	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
> > +	const char *const cmd_groupdel[] = {"groupdel", username, NULL};
> >   	struct passwd *pw;
> >
> > +	tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL);
> > +	tst_cmd(cmd_groupdel, NULL, NULL, TST_CMD_PASS_RETVAL);
> If so, it always uses ltp_add_key05_n instead of ltp_add_key05_0 or 1.
> 
> tst_buffers.c:55: TINFO: Test is using guarded buffers
> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> userdel: user 'ltp_add_key05_n' does not exist
> groupdel: group 'ltp_add_key05_n' does not exist
> add_key05.c:49: TINFO: Created user ltp_add_key05_0
> add_key05.c:190: TINFO: User: 0, UID: 1005
> add_key05.c:87: TINFO: test max bytes under unprivileged user
> add_key05.c:112: TPASS: add_key(test_inv) failed as expected: EDQUOT
> (122)
> add_key05.c:135: TPASS: add_key(test_max) succeeded as expected
> add_key05.c:138: TPASS: allow reaching the max bytes exactly
> userdel: user 'ltp_add_key05_n' does not exist
> groupdel: group 'ltp_add_key05_n' does not exist
> add_key05.c:49: TINFO: Created user ltp_add_key05_1
> add_key05.c:190: TINFO: User: 1, UID: 1006
> add_key05.c:148: TINFO: test max keys under unprivileged user
> add_key05.c:166: TPASS: add_key(test_invalid_key) failed as expected:
> EDQUOT (122)
> add_key05.c:173: TPASS: allow reaching the max key(200) exactly
> 
> 
> Also, I think we should ignore this "userdel: user 'ltp_add_key05_n'
> does not exist" noise on those system that doesn't hit this problem.
> 
> So  we can use  tst_cmd(cmd_userdel, NULL, "/dev/null",
> TST_CMD_PASS_RETVAL).
> 
> Best Regards
> Yang Xu
> > +
> >   	username[sizeof(username) - 2] = '0' + n;
> >
> >   	SAFE_CMD(cmd_useradd, NULL, NULL);
> > --
> > 2.17.1
> >
> >

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
