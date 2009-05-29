Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MA1eR-0003IO-4G
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:57:35 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA1eN-0002FB-Fs
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:57:35 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1243268052.6752.22.camel@subratamodak.linux.ibm.com>
References: <20090522150514.24856.31171.sendpatchset@subratamodak.linux.ibm.com>
	<20090523.005535.226783230.caiqian@cclom.cn>
	<1243268052.6752.22.camel@subratamodak.linux.ibm.com>
Date: Fri, 29 May 2009 18:27:26 +0530
Message-Id: <1243601846.5188.56.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] LTP Build fail on System z 64 bit machine
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sf.net, srinivass@in.ibm.com

On Mon, 2009-05-25 at 21:44 +0530, Subrata Modak wrote: 
> On Sat, 2009-05-23 at 00:55 +0800, CAI Qian wrote: 
> > From: Subrata Modak <subrata@linux.vnet.ibm.com>
> > Subject: Re: [LTP] [PATCH] LTP Build fail on System z 64 bit machine
> > Date: Fri, 22 May 2009 20:35:14 +0530
> > 
> > > Hi,
> > > 
> > >>On Fri, 2009-05-22 at 09:02 -0400, Srinivasan Subramanian3 wrote:
> > >>Hi all,
> > >> 
> > >> When i tried to build ltp on a RHEL4.8 machine, the build failed with undefined reference on splice02.
> > >> 
> > >> Machine info
> > >> 
> > >> RHEL4.8 GA (64 bit)
> > >> 
> > >> Kernel version- 2.6.9-89.EL
> > >> 
> > >> Error Info
> > >> 
> > >> /root/ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02.c:126: undefined reference to `splice'
> > >> collect2: ld returned 1 exit status
> > >> make[4]: *** [splice02] Error 1
> > >> make[4]: Leaving directory `/root/ltp-intermediate-20090521/testcases/kernel/syscalls/splice'
> > >> make[3]: *** [all] Error 2
> > >> make[3]: Leaving directory `/root/ltp-intermediate-20090521/testcases/kernel/syscalls'
> > >> make[2]: *** [all] Error 2
> > >> make[2]: Leaving directory `/root/ltp-intermediate-20090521/testcases/kernel'
> > >> make[1]: *** [all] Error 2
> > >> make[1]: Leaving directory `/root/ltp-intermediate-20090521/testcases'
> > >> make: *** [all] Error 2
> > >> 
> > >> Kindly help me on this issue.
> > > 
> > > Hope the following patch solves your problem:
> > > 
> > > 1) Avoids build problem on your very old kernel,
> > > 2) Will not run on on your old kernel but on kernel > 2.6.17,
> > > 
> > > Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> > > ---
> > > 
> > > --- ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02.c.orig	2009-05-22 18:33:41.000000000 +0530
> > > +++ ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02.c	2009-05-22 19:10:49.000000000 +0530
> > > @@ -52,6 +52,15 @@ char *TCID = "splice02";  /* Test progra
> > >  int  testno;
> > >  int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
> > >  
> > > +static inline long ltp_splice(int fd_in, loff_t *off_in,
> > > +				int fd_out, loff_t *off_out,
> > > +				size_t len, unsigned int flags)
> > > +{
> > > +			return syscall(__NR_splice, fd_in, off_in, fd_out,
> > > +					off_out, len, flags);
> > > +}
> > > +
> > 
> > Well, we have so many those inconsistent situations when performing a syscall.
> > 
> > * use glibc version only.
> > * use glibc version if possible. Otherwise syscall().
> > * use syscall() directly.
> > 
> > Seiichi Ikarashi has posted a similar patch before, 
> > 
> > http://article.gmane.org/gmane.linux.ltp/8359
> > 
> > but have been pushed back to use an autoconf version,
> > 
> > http://article.gmane.org/gmane.linux.ltp/8360
> > 
> > With an autoconf, we can probably easier to manage policy -- like
> > glibc() version first, and then syscall() if we don't really have
> > another choice. In addition, it will work out well with kernels contain
> > backport patches.
> > 
> 
> True. I would wait if somebody is submitting some autoconf related
> patch(s).
> 

However i needed to push this for an immediate fix. Need to work on the
autoconf part later.

Regards--
Subrata

> Regards--
> Subrata
> 
> > > +
> > >  /* Extern Global Functions */
> > >  /******************************************************************************/
> > >  /*                                                                            */
> > > @@ -108,7 +117,15 @@ void setup() {
> > >  
> > >  int main(int ac, char **av) {
> > >  	int fd = 0;
> > > -	
> > > +	int results = 0;
> > > +
> > > +	/* Disable test if the version of the kernel is less than 2.6.17 */
> > > +	if (((results = tst_kvercmp(2, 6, 17)) < 0)) {
> > > +		tst_resm(TINFO, "This test can only run on kernels that are ");
> > > +		tst_resm(TINFO, "2.6.17 and higher");
> > 
> > TCONF?
> > 
> > CAI Qian
> > 
> > > +		exit(0);
> > > +	}
> > > +
> > >          setup();
> > >  
> > >          if (ac < 2 ) {
> > > @@ -123,7 +140,7 @@ int main(int ac, char **av) {
> > >  	}
> > >  			
> > >          do {
> > > -					TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
> > > +		TEST(ltp_splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
> > >  	    if (TEST_RETURN < 0) {
> > >              	tst_resm(TFAIL, "splice failed - errno = %d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
> > >  	        cleanup();
> > > 
> > 
> > 
> 
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
