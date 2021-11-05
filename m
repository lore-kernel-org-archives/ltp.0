Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4452C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 03:02:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878D260EB8
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 03:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 878D260EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64AC13C7635
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 04:02:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2DC3C6218
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 04:01:59 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 994CD600A7D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 04:01:58 +0100 (CET)
Received: by mail-pj1-x102e.google.com with SMTP id
 fv9-20020a17090b0e8900b001a6a5ab1392so2415663pjb.1
 for <ltp@lists.linux.it>; Thu, 04 Nov 2021 20:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KbT/2TZ9oKVa5r+L/TPZFna64FAdTQdJ1oSFU7M7kFk=;
 b=KOcOEEP1Npo7DDiklrE/QrYvHd8YlN9K5e4/fDluzrMWGivaazCktnBnc08oHOLYw9
 7g+EeCFKzbRE9SECVMSOXgtEnHxAi1sgynXLEkOB660orqwZpbmWSxu6uKyAOsmFPBRO
 61BGbwAklF9//B1DvNEvM0z/DAzNtu8VmoXmgxXxsDAeQDpvd64k2xlWZDwjLOAU1BwG
 Lv5kwVy4mWsM281LKkd42G7pY2cxFpUQz2nYl4+pubZLd3Taf6m5tDXn44GB6bJxzIXz
 l6c5tuNC2CYjsHF/Zsv4JBApgHj7xfDQPkizrJDbVqIgW+9EtLBNeLffRx1anW0JsxDp
 yDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KbT/2TZ9oKVa5r+L/TPZFna64FAdTQdJ1oSFU7M7kFk=;
 b=27ZEzDqe926FyM6LSsWFBeBzyhKHo4t5goC+yX/LNbYu45nIyxdX8f4FO+Q9TU+2iP
 CveVy2CbuoBAHeZ9tYjs+rECiP7xAzgYdGUvrDoB7gMcyQf2JnMpnIDPGLHb0+085AcE
 EvJeVNg6INz2DaLs2RMhlbA2KHJ3fy8WkxU2tZWQo6a6yEE5jTYDdcKSDtGeif6hE3Ye
 YbRhmbYpsGuOj2m5pGq5ijQI8od/io1qQBsiBVG/AbuDCuv9il0i9Tnq488iQAcxhqIv
 eYtTnE1a2mTmpun/pY7/5Q03WJ39XIfZq3ri/8Yh6crdZu4qqTNX9laTaa5bgwm1CmPr
 6igg==
X-Gm-Message-State: AOAM533ruEvbm9uO81SCV0IzpqJZ0hP85PE1ADItgmXnajOrMrTnslO8
 n938OsWs1JAE1KcKZ55nWW4kVtyIkMw/Uw==
X-Google-Smtp-Source: ABdhPJxYrQI4T7rXsuXlSYbhKYygY+knIDR5RfWIYefPYU5ch7JKF32cRx2BtOMo4JkMXY1OS9SKZQ==
X-Received: by 2002:a17:902:f687:b0:141:cf6b:fee7 with SMTP id
 l7-20020a170902f68700b00141cf6bfee7mr34177772plg.75.1636081316739; 
 Thu, 04 Nov 2021 20:01:56 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id s2sm5793616pfe.215.2021.11.04.20.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Nov 2021 20:01:56 -0700 (PDT)
Date: Fri, 5 Nov 2021 03:01:49 +0000
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <YYSenZxvAG0Xgm71@google.com>
References: <7c11918db7c34d3aa0af98cb42b7970e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c11918db7c34d3aa0af98cb42b7970e@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 05, 2021 at 02:22:51AM +0000, zhaogongyi wrote:
> Hi,
> 
> > 
> > On Thu, Nov 04, 2021 at 07:37:35PM +0100, Petr Vorel wrote:
> > > Hi all,
> > >
> > > > Before the main process exit abnormally, we need to kill the child
> > > > process.
> > >
> > > Amir, Matthew, could you please have a look?
> > 
> > If anything, I feel as though stop_children() should probably be called from
> > cleanup() as that callback will be invoked if any of the
> > SAFE_FANOTIFY_* macros fail anyway, right?
> 
> It seems that calling before run_children, we need not cleanup though the SAFE_FANOTIFY_* macros fail.

Even if stop_children() is called prior to run_children(), maybe it would
be OK given the fact that child_pid[] is a global and pre-intialized with
zeros. Meaning, that if SAFE_KILL() was called passing a PID value of 0,
then all processes part of the calling process' process group would be sent
a SIGKILL signal, which is kind of what we want anyway when taking a
teardown path. This is just a quick thought.

Nonetheless, you could also introduce barriers into stop_children()
i.e. checking whether PID values in child_pid[] are all zero and if so
return early. That'd prevent you from taking any unnecessary cleanup path
in the event that something fails before any child processes are spawned?

Amir likely has an alternate suggestion, or he may be happy with your
initial proposal.

> > I don't feel like there's a need to introduce another helper here to
> > explicitly handle the cleanup case, but I could also be wrong.
> 
> When we run the testcase simultaneously, and the ulimit of open files is small, the testcase will fail and remain
> many while(1) tasks in system, it makes the system very stuck.
> 
> Shall we need to cleanup it?

I'm not saying that this cleanup isn't necessary, just that it could be
placed in a more appropriate location.

> > > > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > > > ---
> > > >  .../kernel/syscalls/fanotify/fanotify07.c     | 35
> > ++++++++++++++++++-
> > > >  1 file changed, 34 insertions(+), 1 deletion(-)
> > >
> > > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > > b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > > index cc56d9019..0a0b4f1e4 100644
> > > > --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > > +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > > > @@ -108,6 +108,39 @@ static int setup_instance(void)
> > > >  	return fd;
> > > >  }
> > >
> > > > +static int setup_another_instance(void) {
> > > > +	int rval;
> > > > +	int fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY);
> > > > +
> > > > +	if (fd == -1) {
> > > > +		stop_children();
> > > > +		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
> > > > +	}
> > > > +
> > > > +	if (fd < -1) {
> > > > +		stop_children();
> > > > +		tst_brk(TBROK | TERRNO,
> > > > +			"invalid fanotify_init() return %d", fd);
> > > > +	}
> > > > +
> > > > +	rval = fanotify_mark(fd,
> > > > +		FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
> > > > +
> > > > +	if (rval == -1) {
> > > > +		stop_children();
> > > > +		tst_brk(TBROK | TERRNO, "fanotify_mark() failed");
> > > > +	}
> > > > +
> > > > +	if (rval < -1) {
> > > > +		stop_children();
> > > > +		tst_brk(TBROK | TERRNO,
> > > > +			"invalid fanotify_mark() return %d", rval);
> > > > +	}
> > > > +
> > > > +	return fd;
> > > > +}
> > > > +
> > > >  static void loose_fanotify_events(void)  {
> > > >  	int not_responded = 0;
> > > > @@ -160,7 +193,7 @@ static void test_fanotify(void)
> > > >  	 * Create and destroy another instance. This may hang if
> > > >  	 * unanswered fanotify events block notification subsystem.
> > > >  	 */
> > > > -	newfd = setup_instance();
> > > > +	newfd = setup_another_instance();
> > >
> > > >  	SAFE_CLOSE(newfd);
> > 
> > /M
/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
