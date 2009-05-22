Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M7XzQ-0004U6-T3
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 16:53:00 +0000
Received: from smtp108.biz.mail.re2.yahoo.com ([206.190.52.47])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M7XzL-00086l-Vj
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 16:53:00 +0000
Date: Sat, 23 May 2009 00:55:35 +0800 (CST)
Message-Id: <20090523.005535.226783230.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <20090522150514.24856.31171.sendpatchset@subratamodak.linux.ibm.com>
References: <20090522150514.24856.31171.sendpatchset@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] LTP Build fail on System z 64 bit machine
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
Cc: ltp-list@lists.sf.net, srinivass@in.ibm.com

From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] LTP Build fail on System z 64 bit machine
Date: Fri, 22 May 2009 20:35:14 +0530

> Hi,
> 
>>On Fri, 2009-05-22 at 09:02 -0400, Srinivasan Subramanian3 wrote:
>>Hi all,
>> 
>> When i tried to build ltp on a RHEL4.8 machine, the build failed with undefined reference on splice02.
>> 
>> Machine info
>> 
>> RHEL4.8 GA (64 bit)
>> 
>> Kernel version- 2.6.9-89.EL
>> 
>> Error Info
>> 
>> /root/ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02.c:126: undefined reference to `splice'
>> collect2: ld returned 1 exit status
>> make[4]: *** [splice02] Error 1
>> make[4]: Leaving directory `/root/ltp-intermediate-20090521/testcases/kernel/syscalls/splice'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory `/root/ltp-intermediate-20090521/testcases/kernel/syscalls'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/root/ltp-intermediate-20090521/testcases/kernel'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/root/ltp-intermediate-20090521/testcases'
>> make: *** [all] Error 2
>> 
>> Kindly help me on this issue.
> 
> Hope the following patch solves your problem:
> 
> 1) Avoids build problem on your very old kernel,
> 2) Will not run on on your old kernel but on kernel > 2.6.17,
> 
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> ---
> 
> --- ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02.c.orig	2009-05-22 18:33:41.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02.c	2009-05-22 19:10:49.000000000 +0530
> @@ -52,6 +52,15 @@ char *TCID = "splice02";  /* Test progra
>  int  testno;
>  int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
>  
> +static inline long ltp_splice(int fd_in, loff_t *off_in,
> +				int fd_out, loff_t *off_out,
> +				size_t len, unsigned int flags)
> +{
> +			return syscall(__NR_splice, fd_in, off_in, fd_out,
> +					off_out, len, flags);
> +}
> +

Well, we have so many those inconsistent situations when performing a syscall.

* use glibc version only.
* use glibc version if possible. Otherwise syscall().
* use syscall() directly.

Seiichi Ikarashi has posted a similar patch before, 

http://article.gmane.org/gmane.linux.ltp/8359

but have been pushed back to use an autoconf version,

http://article.gmane.org/gmane.linux.ltp/8360

With an autoconf, we can probably easier to manage policy -- like
glibc() version first, and then syscall() if we don't really have
another choice. In addition, it will work out well with kernels contain
backport patches.

> +
>  /* Extern Global Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -108,7 +117,15 @@ void setup() {
>  
>  int main(int ac, char **av) {
>  	int fd = 0;
> -	
> +	int results = 0;
> +
> +	/* Disable test if the version of the kernel is less than 2.6.17 */
> +	if (((results = tst_kvercmp(2, 6, 17)) < 0)) {
> +		tst_resm(TINFO, "This test can only run on kernels that are ");
> +		tst_resm(TINFO, "2.6.17 and higher");

TCONF?

CAI Qian

> +		exit(0);
> +	}
> +
>          setup();
>  
>          if (ac < 2 ) {
> @@ -123,7 +140,7 @@ int main(int ac, char **av) {
>  	}
>  			
>          do {
> -					TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
> +		TEST(ltp_splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
>  	    if (TEST_RETURN < 0) {
>              	tst_resm(TFAIL, "splice failed - errno = %d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
>  	        cleanup();
> 

 

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
