Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC2C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 07:10:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE6153C8DD2
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 08:10:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA1153C8D12
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 08:09:55 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 755761A00981
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 08:09:52 +0100 (CET)
Received: from dggeml708-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HywFp0fVCz8vZR
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:07:58 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml708-chm.china.huawei.com (10.3.17.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 23 Nov 2021 15:09:47 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.020;
 Tue, 23 Nov 2021 15:09:47 +0800
To: Matthew Bobrowski <repnop@google.com>
Thread-Topic: [LTP] [PATCH v3] syscalls/fanotify07: Add stop_children() to
 cleanup()
Thread-Index: AdfgNII42FpgcP7NQSeybfZMbjh7vQ==
Date: Tue, 23 Nov 2021 07:09:47 +0000
Message-ID: <e58da01199ac4995805b2053f5e44a56@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/fanotify07: Add stop_children() to
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I have test the patch through setting "ulimit -n 20" and while true;do ./fanotify07 &;echo "";done 

Or just add a tst_brk as follow:

        /*
         * Create and destroy another instance. This may hang if
         * unanswered fanotify events block notification subsystem.
         */
        newfd = setup_instance();

        SAFE_CLOSE(newfd);
        
		/* inject */
		tst_brk(TBROK, "exit abnormally");

        tst_res(TPASS, "second instance destroyed successfully");

For email CC, I have CC to you and Amir yesterday, please check.


Thanks very much!

Gongyi


> 
> On Mon, Nov 22, 2021 at 04:21:46PM +0800, Zhao Gongyi wrote:
> > When we run the testcase simultaneously, and the ulimit of open files
> > is small, the testcase will fail and remain many while(1) tasks in
> > system, it makes the system very stuck.
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> 
> This patch looks OK to me. Have you taken the time to verify whether this
> fix addresses the issue you've outlined in the patch description?
> 
> FTR, please remember to also explicitly CC those who you'd like to get
> feedback from. Most of us are exceptionally busy and miss things that are
> flying around in the many mailing lists.
> 
> > ---
> > v2->v3: replace memset() with assignment statement in loop
> >
> >  testcases/kernel/syscalls/fanotify/fanotify07.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > --
> > 2.17.1
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > index cc56d9019..8220213b1 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > @@ -86,13 +86,19 @@ static int stop_children(void)
> >  	int child_ret;
> >  	int i, ret = 0;
> >
> > -	for (i = 0; i < MAX_CHILDREN; i++)
> > +	for (i = 0; i < MAX_CHILDREN; i++) {
> > +		if (!child_pid[i])
> > +			continue;
> >  		SAFE_KILL(child_pid[i], SIGKILL);
> > +	}
> >
> >  	for (i = 0; i < MAX_CHILDREN; i++) {
> > +		if (!child_pid[i])
> > +			continue;
> >  		SAFE_WAITPID(child_pid[i], &child_ret, 0);
> >  		if (!WIFSIGNALED(child_ret))
> >  			ret = 1;
> > +		child_pid[i] = 0;
> >  	}
> >
> >  	return ret;
> > @@ -190,6 +196,8 @@ static void setup(void)
> >
> >  static void cleanup(void)
> >  {
> > +	stop_children();
> > +
> >  	if (fd_notify > 0)
> >  		SAFE_CLOSE(fd_notify);
> >  }
> 
> /M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
