Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY2o-0000fR-7w
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:46:22 +0000
Received: from [32.97.110.149] (helo=e31.co.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY2n-0003wT-Ez
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:46:22 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7fMdt030652
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:41:22 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7k0cW221504
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:46:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7k0u5026217
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:46:00 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1246015980.6196.20.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
	<1246015980.6196.20.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 13:11:20 +0530
Message-Id: <1246347680.4819.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Re::personality test case build fails
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: Jiri Palecek <jpalecek@web.de>, Pradeep K Surisetty <pradeepkumars@in.ibm.com>, ltp-list@lists.sourceforge.net

On Fri, 2009-06-26 at 17:03 +0530, Subrata Modak wrote: 
> On Thu, 2009-06-25 at 17:47 +0530, naresh kamboju wrote: 
> > Hi,
> > 
> > >+#ifdef __NR_personality
> >  >int main(int ac, char **av)
> >  >{
> > 
> > >+#else
> > >+int main(int ac, char **av)
> > >+{
> > >+       tst_resm(TCONF, "personality() not defined in your system");
> > >+       tst_exit();
> > >+}
> > >+#endif
> > 
> > 
> > Instead of using
> > #ifdef __NR_personality
> >  in test code, Better we will add these this syscall numbers in the
> > ltp/testcases/kernel/include/ARCHXXX.in files.
> > This can be Multi ARCH support.
> 
> Great. Send me a patch to update them all ;-)
> 

Naresh ??

> Regards--
> Subrata
> 
> > 
> > Jiri,
> > I think you are doing Multi ARCH support right?
> > 
> > Your suggestions are welcome :)
> > 
> > Best regards
> > Naresh Kamboju
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
