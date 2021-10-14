Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B0C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 06:47:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1877A61029
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 06:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1877A61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AADD83C1313
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 08:47:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6363C0B90
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 08:47:29 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B63E61A00A44
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 08:47:26 +0200 (CEST)
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HVKg90WC6z8tZj
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 14:46:13 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml756-chm.china.huawei.com (10.1.199.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 14 Oct 2021 14:47:20 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.008;
 Thu, 14 Oct 2021 14:47:20 +0800
From: zhaogongyi <zhaogongyi@huawei.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v3 1/1] setgroups03: Fix running more iterations (-i 2)
Thread-Index: AdfApGI6yl2rx6VzSyiXFO9EZmFl5wAIHtow
Date: Thu, 14 Oct 2021 06:47:20 +0000
Message-ID: <7d80cd81052d4530a717957965e958fc@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] setgroups03: Fix running more iterations
 (-i 2)
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

For the testcase setgroup3:

	* Test Description:
 	*  Verify that,
 	*   1. setgroups() fails with -1 and sets errno to EINVAL if the size
 	*      argument value is > NGROUPS
 	*   2. setgroups() fails with -1 and sets errno to EPERM if the
 	*      calling process is not super-user.

At the first checkpoint, set errno to EINVAL if the size argument value is > NGROUPS, it seems that has no matter with the value of group_list. Meticulously, we can set group_list to a normal value.

Same situation for the second checkpoint.

So can we reserve the group_list that set a normal value?


Thanks so much!


> 
> Hi,
> 
> Yes, in this testcase, the groups_list is redundant and can be removed.
> 
> I am sorry for my late reply.
> 
> Thanks so much!
> 
> 
> 
> > > > -int setup1(void)
> > > > +void setup1(const char *uid, uid_t euid)
> > > >  {
> > > > -	struct passwd *user_info;	/* struct. to hold test user info */
> > > > -
> > > > -/* Switch to nobody user for correct error code collection */
> > > > -	ltpuser = getpwnam(nobody_uid);
> > > > -	if (seteuid(ltpuser->pw_uid) == -1) {
> > > > -		tst_resm(TINFO, "setreuid failed to "
> > > > -			 "to set the effective uid to %d", ltpuser->pw_uid);
> > > > -		perror("setreuid");
> > > > -	}
> > > > +	struct passwd *user_info;
> >
> > > > -	if ((user_info = getpwnam(TESTUSER)) == NULL) {
> > > > -		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed",
> > TESTUSER);
> > > > -	}
> > > > +	SAFE_SETEUID(cleanup, euid);
> > > > +
> > > > +	user_info = SAFE_GETPWNAM(cleanup, uid);
> >
> > > I still do not get why we call SAFE_GETPWNAM() here. We should do
> > > that in the setup and prepare two different group_list[] lists, if
> > > that is really needed.
> >
> > > But I guess that all we need in this test is:
> >
> > > * Run the EINVAL test as a root
> >
> > > * Run the EPERM test as a nobody
> >
> > > The content of the list should not matter, as a matter of a fact we
> > > pass unitialized data in the EINVAL case. What matters is the size
> > > argument, it should be 1 for the EPERM test and max+1 for the EINVAL
> > case.
> >
> > Good point, thank you!
> >
> > @Zhao feel free to let me know you're doing to implement it.
> > Otherwise I'll have look on Monday.
> >
> > Kind regards,
> > Petr
> >
> > > >  	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
> > > >  		tst_brkm(TBROK,
> > > >  			 cleanup,
> > > >  			 "gid returned from getpwnam is too large for testing
> > setgroups16");
> > > >  	}
> > > > +
> > > >  	groups_list[0] = user_info->pw_gid;
> > > > -	return 0;
> > > >  }
> >
> > > >  /*
> > > > --
> > > > 2.33.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
