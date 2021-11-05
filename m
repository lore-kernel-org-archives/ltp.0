Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB81C433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:23:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C5A60FC2
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98C5A60FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D664C3C7378
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 03:23:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBE3C3C559D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 03:22:58 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36681100127A
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 03:22:55 +0100 (CET)
Received: from dggeml714-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HlklP1Wmqz8v7n
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:21:21 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml714-chm.china.huawei.com (10.3.17.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 5 Nov 2021 10:22:51 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.015;
 Fri, 5 Nov 2021 10:22:51 +0800
From: zhaogongyi <zhaogongyi@huawei.com>
To: Matthew Bobrowski <repnop@google.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
Thread-Index: AdfR64dkg6gbLgYfS7KVywAEcf7nnw==
Date: Fri, 5 Nov 2021 02:22:51 +0000
Message-ID: <7c11918db7c34d3aa0af98cb42b7970e@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> 
> On Thu, Nov 04, 2021 at 07:37:35PM +0100, Petr Vorel wrote:
> > Hi all,
> >
> > > Before the main process exit abnormally, we need to kill the child
> > > process.
> >
> > Amir, Matthew, could you please have a look?
> 
> If anything, I feel as though stop_children() should probably be called from
> cleanup() as that callback will be invoked if any of the
> SAFE_FANOTIFY_* macros fail anyway, right?

It seems that calling before run_children, we need not cleanup though the SAFE_FANOTIFY_* macros fail.

> 
> I don't feel like there's a need to introduce another helper here to
> explicitly handle the cleanup case, but I could also be wrong.

When we run the testcase simultaneously, and the ulimit of open files is small, the testcase will fail and remain
many while(1) tasks in system, it makes the system very stuck.

Shall we need to cleanup it?

> 
> > > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > > ---
> > >  .../kernel/syscalls/fanotify/fanotify07.c     | 35
> ++++++++++++++++++-
> > >  1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > index cc56d9019..0a0b4f1e4 100644
> > > --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > @@ -108,6 +108,39 @@ static int setup_instance(void)
> > >  	return fd;
> > >  }
> >
> > > +static int setup_another_instance(void) {
> > > +	int rval;
> > > +	int fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY);
> > > +
> > > +	if (fd == -1) {
> > > +		stop_children();
> > > +		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
> > > +	}
> > > +
> > > +	if (fd < -1) {
> > > +		stop_children();
> > > +		tst_brk(TBROK | TERRNO,
> > > +			"invalid fanotify_init() return %d", fd);
> > > +	}
> > > +
> > > +	rval = fanotify_mark(fd,
> > > +		FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
> > > +
> > > +	if (rval == -1) {
> > > +		stop_children();
> > > +		tst_brk(TBROK | TERRNO, "fanotify_mark() failed");
> > > +	}
> > > +
> > > +	if (rval < -1) {
> > > +		stop_children();
> > > +		tst_brk(TBROK | TERRNO,
> > > +			"invalid fanotify_mark() return %d", rval);
> > > +	}
> > > +
> > > +	return fd;
> > > +}
> > > +
> > >  static void loose_fanotify_events(void)  {
> > >  	int not_responded = 0;
> > > @@ -160,7 +193,7 @@ static void test_fanotify(void)
> > >  	 * Create and destroy another instance. This may hang if
> > >  	 * unanswered fanotify events block notification subsystem.
> > >  	 */
> > > -	newfd = setup_instance();
> > > +	newfd = setup_another_instance();
> >
> > >  	SAFE_CLOSE(newfd);
> 
> /M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
