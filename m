Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1SdO5L-00051B-E5
	for ltp-list@lists.sourceforge.net; Sat, 09 Jun 2012 16:00:19 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SdO5J-0007bG-2S
	for ltp-list@lists.sourceforge.net; Sat, 09 Jun 2012 16:00:19 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1SdO55-0002ja-DL
	for ltp-list@lists.sourceforge.net; Sat, 09 Jun 2012 18:00:03 +0200
Received: from 125.19.39.117 ([125.19.39.117])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Sat, 09 Jun 2012 18:00:03 +0200
Received: from v.bhav.shinde by 125.19.39.117 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Sat, 09 Jun 2012 18:00:03 +0200
From: vaibhav <v.bhav.shinde@gmail.com>
Date: Sat, 9 Jun 2012 12:38:39 +0000 (UTC)
Message-ID: <loom.20120609T143221-953@post.gmane.org>
References: <4753F3FA.3010601@suse.de> <200712032347.17105.vapier@gentoo.org>
Mime-Version: 1.0
Subject: Re: [LTP] Openposix: pthread create, testcase  1-6
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
To: ltp-list@lists.sourceforge.net



Mike Frysinger <vapier@...> writes:

> 
> On Monday 03 December 2007, Patrick Kirsch wrote:
> > I have a question on testcase pthread_create/1-1.c :
> > there is shared variable "int *ctrl = (int *) arg;" in function
> > "hp_func" which should be protected through pthread_mutex or similar,
> > right? As I understand this shared variable should always be protected?
> > So is there a reason why there are no pthread synchronisation calls?
> >
> > As you can see in the suggested temporary patch below, is it possible to
> > add volatile-statement to the shared variables?
> >
> > I'm asking, because sometimes this testcase fails on s390x.
> 
> perhaps look at the generated assembly code and see if gcc is incorrectly 
> optimizing away memory loads ?  adding volatile sounds like you're ignoring a 
> deeper problem ...
> -mike

Hi Mike

This test case is released with volatile variable usage in LTP january release. 
I tested it for MIPS target, it FAILS giving error : 

volatile int *ctrl = (int *) arg; 

Can you please point out whats could be the exact issue? 

Looking forward to your reply. 

Thanks,
Vaibhav 
> 
> 
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@...
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
