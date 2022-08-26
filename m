Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90CCECAAD2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 07:41:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91043CA49A
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 09:41:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB48E3CA070
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 09:41:36 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA53460012A
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 09:41:32 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 27Q7fIQt064488;
 Fri, 26 Aug 2022 15:41:18 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atcsi01 (10.0.15.167) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Aug 2022 15:41:15 +0800
Date: Fri, 26 Aug 2022 15:41:15 +0800
From: Dylan Jhong <dylan@andestech.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Message-ID: <Ywh5G6RQi+zitagg@atcsi01>
References: <20220825105204.953388-1-dylan@andestech.com>
 <87k06v1pwp.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k06v1pwp.fsf@suse.de>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 27Q7fIQt064488
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

Hi Richard,

Thanks for your reply.
My opinion is the same as yours, libc should do more checking and protection for incoming parameters

In semctl03.c, the two tv->semctl() implementation functions, which are libc_semctl() and sys_semctl(),
do not pass the 4th argument ".buf" to the next level system call.
At present, the 4th argument of semctl() implemented in semctl03.c is hard-coded,
I think passing parameters instead of hardcoding should be more better for this testcase.
Should we pass all parameters to the next level semctl() system call?

Partial code of semctl03.c:
--------------------------------------------------------
TST_EXP_FAIL(tv->semctl(*(tc->sem_id), 0, tc->ipc_cmd, *(tc->buf)),    <--- Pass *(tc->buf) to tv->semctl()
        tc->error, "semctl() with %s", tc->message);


static union semun arg = {0};
static int libc_semctl(int semid, int semnum, int cmd, ...)  
{
    return semctl(semid, semnum, cmd, arg);        <----- Ignore the 4th parameter and use the hard-coded "arg" directly  
}
--------------------------------------------------------

ref:
    https://lists.linux.it/pipermail/ltp/2021-June/023116.html

Best,
Dylan

On Fri, Aug 26, 2022 at 02:12:19PM +0800, Richard Palethorpe wrote:
> Hello,
> 
> Dylan Jhong <dylan@andestech.com> writes:
> 
> > When using semctl() through glibc and __IPC_TIME64 is defined, glibc will
> > call a converted semun64_to_ksemun64() function[*1]. If the parameter of
> > this function is NULL, it will cause a NULL pointer dereference kernel
> > panic.
> 
> This is a kernel bug. Generally speaking, we shouldn't be able to create
> kernel panics from user land. The kernel should return EFAULT if we pass
> an invalid pointer.
> 
> If this test causes a kernel panic then it should be kept as-is. If it
> is not testing what it was originally intended to, then another test can
> be created to do that.
> 
> >
> > In semctl03.c, we need to ensure the element "struct semid_ds *buf" in 4th
> > parameter "union semun" in semctl() is not NULL. But the 4th parameters of
> > libc_semctl() and sys_semctl() are hard-coded[*2] and the element
> > "struct semid_ds *buf" is not given an initial value. Using va_list to pass
> > the correct parameters can solve the problem.
> >
> > ref:
> >   [*1]: https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L172
> >   [*2]: https://github.com/linux-test-project/ltp/blob/58caa8cca507133ea92bd0ea277b91add96e72af/testcases/kernel/syscalls/ipc/semctl/semctl03.c#L45
> >
> > Co-developed-by: Randolph <randolph@andestech.com>
> > Signed-off-by: Dylan Jhong <dylan@andestech.com>
> > ---
> >  testcases/kernel/syscalls/ipc/semctl/semctl03.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> > index a1a4c81ce..bb25053e2 100644
> > --- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> > +++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> > @@ -28,11 +28,21 @@ static union semun arg = {0};
> >  
> >  static int libc_semctl(int semid, int semnum, int cmd, ...)
> >  {
> > +	va_list ap;
> > +
> > +	va_start(ap, cmd);
> > +	arg = va_arg(ap, union semun);
> > +	va_end(ap);
> >  	return semctl(semid, semnum, cmd, arg);
> >  }
> >  
> >  static int sys_semctl(int semid, int semnum, int cmd, ...)
> >  {
> > +	va_list ap;
> > +
> > +	va_start(ap, cmd);
> > +	arg = va_arg(ap, union semun);
> > +	va_end(ap);
> >  	return tst_syscall(__NR_semctl, semid, semnum, cmd, arg);
> >  }
> >  
> > -- 
> > 2.34.1
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
