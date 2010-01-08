Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NT8Ag-00087A-NQ
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 06:18:06 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NT8Af-00054O-7H
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 06:18:06 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000601ca8de1$64d04810$2e70d830$@co.jp>
	<1262862378.12213.22.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1262862378.12213.22.camel@subratamodak.linux.ibm.com>
Date: Fri, 8 Jan 2010 15:17:55 +0900
Message-ID: <000301ca902a$50f1f1e0$f2d5d5a0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] quotactl01 testcases problem
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Hello Subrata,

Not resolved yet.
I think that 4th argument of "${LTPROOT}/testcases/kernel/syscalls
/quotactl/quotactl01.c" is wrong, because the error is 
"TEST_ERRNO=EFAULT(14): Bad address".

I don't know how to revise it yet.


Regards--

-Tomonori Mitani

-----Original Message-----
From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com] 
Sent: Thursday, January 07, 2010 8:06 PM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] quotactl01 testcases problem

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
> quotactl01    1  TFAIL  :  cmd=0x800002: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    2  TFAIL  :  cmd=0x800003: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    3  TFAIL  :  cmd=0x800007: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    4  TFAIL  :  cmd=0x800008: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    5  TFAIL  :  cmd=0x800005: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    6  TFAIL  :  cmd=0x800006: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    7  TFAIL  :  cmd=0x800004: TEST_ERRNO=EFAULT(14): Bad
address
> quotactl01    8  TFAIL  :  cmd=0x800001: TEST_ERRNO=EFAULT(14): Bad
address
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
>
----------------------------------------------------------------------------
--
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and
easy
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
