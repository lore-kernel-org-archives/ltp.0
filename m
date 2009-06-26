Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MK9hS-00031h-GR
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:34:34 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MK9hO-00050e-P2
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:34:34 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5QBTJRs008083
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 07:29:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5QBYSBd227114
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 07:34:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5QBW5lh005126
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 07:32:05 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
References: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
Date: Fri, 26 Jun 2009 17:03:00 +0530
Message-Id: <1246015980.6196.20.camel@subratamodak.linux.ibm.com>
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

On Thu, 2009-06-25 at 17:47 +0530, naresh kamboju wrote: 
> Hi,
> 
> >+#ifdef __NR_personality
>  >int main(int ac, char **av)
>  >{
> 
> >+#else
> >+int main(int ac, char **av)
> >+{
> >+       tst_resm(TCONF, "personality() not defined in your system");
> >+       tst_exit();
> >+}
> >+#endif
> 
> 
> Instead of using
> #ifdef __NR_personality
>  in test code, Better we will add these this syscall numbers in the
> ltp/testcases/kernel/include/ARCHXXX.in files.
> This can be Multi ARCH support.

Great. Send me a patch to update them all ;-)

Regards--
Subrata

> 
> Jiri,
> I think you are doing Multi ARCH support right?
> 
> Your suggestions are welcome :)
> 
> Best regards
> Naresh Kamboju


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
