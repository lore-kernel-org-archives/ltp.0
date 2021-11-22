Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B62C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8553C8D0D
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:24:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DFA13C8C57
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 09:23:54 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8AA061A009A3
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 09:23:51 +0100 (CET)
Received: from dggeml758-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HyKt06QXBzbj0c
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 16:18:48 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml758-chm.china.huawei.com (10.1.199.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:23:47 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.020;
 Mon, 22 Nov 2021 16:23:47 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] syscalls/fanotify07: add stop_children() to
 cleanup()
Thread-Index: Adffedr18YbnRLGTQROoKSXW2mejag==
Date: Mon, 22 Nov 2021 08:23:47 +0000
Message-ID: <78f3c93ecb8c4232a8c2ceb87cbb172e@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/fanotify07: add stop_children() to
 cleanup()
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
Cc: Matthew Bobrowski <repnop@google.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I have resubmit a new version patch as your review, please see https://patchwork.ozlabs.org/project/ltp/patch/20211122082146.59895-1-zhaogongyi@huawei.com/

Thanks so much!

Gongyi

> 
> Hi all,
> 
> > When we run the testcase simultaneously, and the ulimit of open files
> > is small, the testcase will fail and remain many while(1) tasks in
> > system, it makes the system very stuck.
> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> > v1->v2: add stop_children() to cleanup(),suggested by Amir and
> Matthew.
> 
> >  testcases/kernel/syscalls/fanotify/fanotify07.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > index cc56d9019..40d1b96ce 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > @@ -86,15 +86,21 @@ static int stop_children(void)
> >  	int child_ret;
> >  	int i, ret = 0;
> 
> > -	for (i = 0; i < MAX_CHILDREN; i++)
> > +	for (i = 0; i < MAX_CHILDREN; i++) {
> > +		if (!child_pid[i])
> > +			continue;
> >  		SAFE_KILL(child_pid[i], SIGKILL);
> > +	}
> 
> >  	for (i = 0; i < MAX_CHILDREN; i++) {
> > +		if (!child_pid[i])
> > +			continue;
> >  		SAFE_WAITPID(child_pid[i], &child_ret, 0);
> >  		if (!WIFSIGNALED(child_ret))
> >  			ret = 1;
> I slightly prefer instead of using memset code which Amir suggested:
> 		child_pid[i] = 0;
> >  	}
> 
> Otherwise LGTM.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> NOTE: patch was corrupted, please take care next time
> (error: corrupt patch at line 131)
> Also
> 
> Kind regards,
> Petr
> 
> > +	memset(child_pid, 0, sizeof(pid_t) * MAX_CHILDREN);
> >  	return ret;
> >  }
> 
> > @@ -190,6 +196,8 @@ static void setup(void)
> 
> >  static void cleanup(void)
> >  {
> > +	stop_children();
> > +
> >  	if (fd_notify > 0)
> >  		SAFE_CLOSE(fd_notify);
> >  }
> > @@ -201,6 +209,7 @@ static struct tst_test test = {
> >  	.needs_tmpdir = 1,
> >  	.forks_child = 1,
> >  	.needs_root = 1,
> >  };
> 
> >  #else

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
