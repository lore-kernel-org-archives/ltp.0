Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqCK-0007LO-IQ
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:36 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqCJ-0000Ic-9W
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:36 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07AsGNp006841
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 05:54:16 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07B6Tfq107468
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:06:29 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o07B6Tg6016954
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:06:29 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <000601ca8de1$64d04810$2e70d830$@co.jp>
References: <000601ca8de1$64d04810$2e70d830$@co.jp>
Date: Thu, 07 Jan 2010 16:36:18 +0530
Message-Id: <1262862378.12213.22.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] quotactl01 testcases problem
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Hello Mitani-San,

Did this get resolved for you ?

Regards--
Subrata

On Tue, 2010-01-05 at 17:30 +0900, Mitani wrote: 
> Hi,
> 
> I tried "quotactl01" testcases, and found two problems.
> Second one occurred after first one's revise.
> 
> 1) In the result of "quotactl01", "Success" are displayed in spite of
>    failing in the test:
> 
> ------------
> quotactl01    1  TFAIL  :  cmd=0x800002: TEST_ERRNO=???(0): Success
> quotactl01    2  TFAIL  :  cmd=0x800003: TEST_ERRNO=???(0): Success
> quotactl01    3  TFAIL  :  cmd=0x800007: TEST_ERRNO=???(0): Success
> quotactl01    4  TFAIL  :  cmd=0x800008: TEST_ERRNO=???(0): Success
> quotactl01    5  TFAIL  :  cmd=0x800005: TEST_ERRNO=???(0): Success
> quotactl01    6  TFAIL  :  cmd=0x800006: TEST_ERRNO=???(0): Success
> quotactl01    7  TFAIL  :  cmd=0x800004: TEST_ERRNO=???(0): Success
> quotactl01    8  TFAIL  :  cmd=0x800001: TEST_ERRNO=???(0): Success
> ------------
> 
> This problem occurred because the return value of system-call 
> "(syscall(__NR_quotactl, cmd[i], ...))" is not judged correctly 
> in "${LTPROOT}/testcases/kernel/syscalls/quotactl/quotactl01.c".
> Above errors are caused by TFAIL and messages are printed by TTERRNO.
> And there is only one place (Line 206) which uses TFAIL in "quotactl01.c"
> 
> The following patch can fix this problem:
> 
> ============
> --- quotactl01.c	2009-12-20 09:36:35.000000000 +0900
> +++ quotactl01.c.new	2010-01-04 17:11:17.000000000 +0900
> @@ -177,7 +177,6 @@
>  	int id = getuid();
>  	int newtid = -1;
>  	int result;
> -	int ret;
>  	int i;
>  	int lc;				 /* loop counter */
>  	char *msg;			  /* message returned from
> parse_opts */
> @@ -199,10 +198,10 @@
> 
>  			for (i = 0; i <= 7; i++){
> 
> -				ret = syscall(__NR_quotactl, cmd[i],
> +				TEST(syscall(__NR_quotactl, cmd[i],
>  						(const char *)NULL, id,
> -						(caddr_t)NULL);
> -				if (ret != 0) {
> +						(caddr_t)NULL));
> +				if (TEST_RETURN != 0) {
>  					tst_resm(TFAIL|TTERRNO, "cmd=0x%x",
> cmd[i]);
>  				} else {
>  					tst_resm(TPASS, "quotactl call
> succeeded");
> ============
> 
> 
> However, new problem occurred after applying above patch.
> 
> 2) The test failed with the following error in my system:
> 
> ------------
> quotactl01    1  TFAIL  :  cmd=0x800002: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    2  TFAIL  :  cmd=0x800003: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    3  TFAIL  :  cmd=0x800007: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    4  TFAIL  :  cmd=0x800008: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    5  TFAIL  :  cmd=0x800005: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    6  TFAIL  :  cmd=0x800006: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    7  TFAIL  :  cmd=0x800004: TEST_ERRNO=EFAULT(14): Bad address
> quotactl01    8  TFAIL  :  cmd=0x800001: TEST_ERRNO=EFAULT(14): Bad address
> ------------
> 
> "EFAULT" means that there is an error in "addr".
> The format of "quotactl" is following:
> ------------
> int quotactl(int cmd, const char *special, int id, caddr_t addr);
> ------------
> 
> Therefore, "EFAULT" means that 4th argument of "quotactl()" has problem.
> 
> In "${LTPROOT}/testcases/kernel/syscalls/quotactl/quotactl01.c", 4th 
> argument of "quotactl()" is "NULL":
> Is it right?
> 
> 
> I'm glad if I get your help.
> 
> 
> Regards--
> 
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
