Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLaE1-0000zn-1N
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 10:06:05 +0000
Received: from [32.97.110.152] (helo=e34.co.us.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLaDz-0007Kh-Lt
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 10:06:04 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UA1vKq024600
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 04:01:57 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UA5CdN220212
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 04:05:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UA5CGp009271
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 04:05:12 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906300250o6ee16e3bv672ad77018d34a81@mail.gmail.com>
References: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
	<1246015980.6196.20.camel@subratamodak.linux.ibm.com>
	<1246347680.4819.31.camel@subratamodak.linux.ibm.com>
	<f5a7b3810906300250o6ee16e3bv672ad77018d34a81@mail.gmail.com>
Date: Tue, 30 Jun 2009 15:34:14 +0530
Message-Id: <1246356254.4819.39.camel@subratamodak.linux.ibm.com>
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

On Tue, 2009-06-30 at 15:20 +0530, naresh kamboju wrote:
> On Tue, Jun 30, 2009 at 1:11 PM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
> > On Fri, 2009-06-26 at 17:03 +0530, Subrata Modak wrote:
> >> > >+#ifdef __NR_personality
> >> >
> >> > Instead of using
> >> > #ifdef __NR_personality
> >> >  in test code, Better we will add these this syscall numbers in the
> >> > ltp/testcases/kernel/include/ARCHXXX.in files.
> >> > This can be Multi ARCH support.
> >> Great. Send me a patch to update them all ;-)
> >>
> >
> > Naresh ??
> 
> Hi Subrata,
> 
> I have noticed some issue with personality01.c and personality02.c
> test cases in design.

Great. And what design reviews for the newly ported tests in LTP ?

Regards--
Subrata

> Currently I am investigating and get back to in short.
> 
> Best Regards
> Naresh Kamboju
> 
> >
> >> Regards--
> >> Subrata
> >>
> >> > Jiri,
> >> > I think you are doing Multi ARCH support right?
> >> >
> >> > Your suggestions are welcome :)
> >> >
> >> > Best regards
> >> > Naresh Kamboju
> 
> >> ------------------------------------------------------------------------------
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
> >


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
