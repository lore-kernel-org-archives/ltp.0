Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81AAECAAD4
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:22:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82C843CA5BD
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 13:22:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA8A43C81E1
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:22:40 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FE3F600850
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:22:37 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 27TBMSp4073999;
 Mon, 29 Aug 2022 19:22:28 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atcsi01 (10.0.15.167) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Aug 2022 19:22:26 +0800
Date: Mon, 29 Aug 2022 19:22:26 +0800
From: Dylan Jhong <dylan@andestech.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Message-ID: <YwyhcokJoLLXTvvr@atcsi01>
References: <20220825105204.953388-1-dylan@andestech.com>
 <87k06v1pwp.fsf@suse.de> <Ywh5G6RQi+zitagg@atcsi01>
 <877d2v1kot.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877d2v1kot.fsf@suse.de>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 27TBMSp4073999
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/semctl03: Solve kernel panic in semctl03
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
Cc: "Randolph Sheng-Kai Lin\(\(\(\(\(\(\(\(\(\(\)" <randolph@andestech.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>, "Alan
 Quey-Liang Kao\(\(\(\(\(\(\(\(\(\(\)" <alankao@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 26, 2022 at 03:53:22PM +0800, Richard Palethorpe wrote:
> Hello,
> 
> Dylan Jhong <dylan@andestech.com> writes:
> 
> > Hi Richard,
> >
> > Thanks for your reply.
> > My opinion is the same as yours, libc should do more checking and
> > protection for incoming parameters
> 
> This is not my opinion.
> 
> Are you saying that libc segfaults? This is an acceptable outcome for
> the LTP. To stop the test failing we can fork the test and check if the
> child segfaults. However it seems the EFAULT test is already skipped if
> we use libc, which is also acceptable.
> 
> However the patch title says that this resulted in a kernel panic due to
> a null pointer dereference? This is a serious kernel bug that may be
> exploitable.
> 

>>>>> Are you saying that libc segfaults? This is an acceptable outcome for the LTP. To stop the test failing we can fork the test and check if the child segfaults. However it seems the EFAULT test is already skipped if we use libc, which is also acceptable.

It's segmentation fault from glibc. Sorry for the confusion.
If there is a V2 version, I will modify the title.

The failure case comes from the code below,
which expect EINVAL as the return value.

tests[] = {
	{&sem_id, -1, &semds_ptr, EINVAL, "invalid IPC command"},
	{&bad_id, IPC_STAT, &semds_ptr, EINVAL, "invalid sem id"},  <-- Segfault occurs on this testcase
	{&sem_id, GETALL, &bad_ptr, EFAULT, "invalid union arg"},
	{&sem_id, IPC_SET, &bad_ptr, EFAULT, "invalid union arg"}
};

This is correct in some architechures. But on other architectures where 
__IPC_TIME64 is defined, this segmentation fault will occur in glibc.

When those architectures that define __IPC_TIME64 call semctl(), glibc will 
additionally enter a conversion function named semun64_to_ksemun64()[*1].
Then the 4th parameter, "semun64.buf" from semctl() will be passed to the 
next function[*2]. Finally a segmentation fault occurs in the 
semid64_to_ksemid64() function[*3].

The purpose of this test case should be to detect if glibc returns EINVAL 
when we pass bad_id to semctl(), but not every architecture can get this
result. The segmentation fault caused by semun64.buf is NULL is obviously 
not the expected result of this testcase, so I think it should be the
correct way to modify the 4th argument pass to semctl().

[*1] https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L172
[*2] https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L107
[*3] https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L68

Best regards,
Dylan Jhong

> >
> > In semctl03.c, the two tv->semctl() implementation functions, which are libc_semctl() and sys_semctl(),
> > do not pass the 4th argument ".buf" to the next level system call.
> > At present, the 4th argument of semctl() implemented in semctl03.c is hard-coded,
> > I think passing parameters instead of hardcoding should be more better for this testcase.
> > Should we pass all parameters to the next level semctl() system call?
> 
> A 4th arg is never passed, if you remove the vararg the test compiles
> and runs fine. So the vararg should be removed, but this is relatively
> minor compared to a kernel null pointer dereference.
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
