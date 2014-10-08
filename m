Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XblbW-0003nq-E3
	for ltp-list@lists.sourceforge.net; Wed, 08 Oct 2014 07:24:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XblbV-0007jB-Ad
	for ltp-list@lists.sourceforge.net; Wed, 08 Oct 2014 07:24:10 +0000
Message-ID: <1412753001.28284.9.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 8 Oct 2014 15:23:21 +0800
In-Reply-To: <237697509.31082624.1411735385050.JavaMail.zimbra@redhat.com>
References: <1407402404.1347.29.camel@G08JYZSD130126>
	<179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
	<1411718817.9511.9.camel@G08JYZSD130126>
	<237697509.31082624.1411735385050.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] securebits: some cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi, Jan
On Fri, 2014-09-26 at 08:43 -0400, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
> > From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> > Sent: Friday, 26 September, 2014 10:06:57 AM
> > Subject: [PATCH v2] securebits: some cleanup
> > 
> > * Remove .sh and divide into three seperate tests.
> > 
> > * Check the header <linux/securebits.h>.
> > 
> > * Use tst_brkm instead of tst_exit() that follows tst_resm.
> > 
> > * Some cleanup
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> 
> Is the modified testcase working for you?
> 

I am so sorry for that I made a stupid mistake.
My intention is to print pass and exit the test, but I use
tst_brkm(TPASS, ..) that make us get a segmentation fault.
I will fix it.
Thank you very much.

Best regards,
Zeng

> I'm getting segmentation fault:
> 
> (gdb) bt
> #0  __GI__IO_fputs (str=str@entry=0x7fffffffa980 "keepcaps    0  TWARN  :  tst_brk_: Invalid Type: 0. Using TBROK\n", fp=0x0)
>     at iofputs.c:39
> #1  0x00000000004015ee in tst_print (tcid=0x4029ba "keepcaps", tnum=tnum@entry=0, ttype=ttype@entry=4, 
>     tmesg=tmesg@entry=0x605240 <Warn_mesg> "tst_brk_: Invalid Type: 0. Using TBROK") at tst_res.c:479
> #2  0x00000000004021f5 in tst_brk_ (file=file@entry=0x4028fe "check_keepcaps.c", lineno=lineno@entry=88, ttype=ttype@entry=0, 
>     fname=fname@entry=0x0, func=func@entry=0x0, arg_fmt=arg_fmt@entry=0x402ac6 "%s") at tst_res.c:656
> #3  0x00000000004026a8 in tst_brkm_ (file=file@entry=0x4028fe "check_keepcaps.c", lineno=lineno@entry=88, ttype=ttype@entry=0, 
>     func=func@entry=0x0, arg_fmt=arg_fmt@entry=0x402926 "dropped privs as expected") at tst_res.c:769
> #4  0x0000000000401460 in do_setuid (expect_privs=expect_privs@entry=0) at check_keepcaps.c:88
> #5  0x000000000040124f in main (argc=2, argv=0x7fffffffe528) at check_keepcaps.c:113
> 
> and when I fix the crash (T_out is uninitialized) I get:
> 
> # ./check_keepcaps 1
> keepcaps    0  TWARN  :  tst_brk_: Invalid Type: 0. Using TBROK
> keepcaps    1  TBROK  :  check_keepcaps.c:88: dropped privs as expected
> 
> from lib/tst_res.c:
>         /*
>          * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
>          */
> 
> Regards,
> Jan


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
