Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1S1zU3-0002Rv-JB
	for ltp-list@lists.sourceforge.net; Mon, 27 Feb 2012 12:15:15 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S1zTx-0005ph-RZ
	for ltp-list@lists.sourceforge.net; Mon, 27 Feb 2012 12:15:15 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1S1zTr-0007sv-9l
	for ltp-list@lists.sourceforge.net; Mon, 27 Feb 2012 13:15:03 +0100
Received: from 203.200.200.74.ill-bgl.static.vsnl.net.in
	([203.200.200.74.ill-bgl.static.vsnl.net.in])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Feb 2012 13:15:03 +0100
Received: from rejish.rajagopala by 203.200.200.74.ill-bgl.static.vsnl.net.in
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Feb 2012 13:15:03 +0100
From: rejish <rejish.rajagopala@sasken.com>
Date: Mon, 27 Feb 2012 12:11:04 +0000 (UTC)
Message-ID: <loom.20120227T131022-99@post.gmane.org>
References: <15539684.1003571191998983203.JavaMail.weblogic@ep_ml20>
Mime-Version: 1.0
Subject: Re: [LTP] runltp failing with the new LTP release
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

SARATHBABU T <sarath.babu@...> writes:

> 
> Hi Subrata, 
>                        I got your mail id from opensource list. Pls help me in
solving the issue i am facing.
> 
> I have downloaded the latest LTP test suite " ltp-full-20070930 " and tried
compiling it . As i have run it on
> arm target i gave the CROSS_COMPILER path . 
> compiling is successful . In testcases directory all the binaries are created
and the "pan" is also created
> in the "pan" directory. 
> But when i run the test , the runltp is failing causing the following error  
> 
> ./runltp: /ltp-full-20070930/pan/pan: No such file or directory   ( actually "
pan " is created during the
> compilation process , this is the error )
> INFO: pan reported some tests FAIL
> 
> Pls let me know what else i have to change apart from the crosscompiler path
in Makefile. My host environment
> is x86 and target is armv6l , OMAP2420 board. what options i need to set for
CROSS_CFLAGS . 
> 
> Also , when i try to send mails to ltp list , i am getting delivary failure
error , even though i subscribed to
> the list , pls let me know as i am new to this ltp list.
> 
> Thanks, 
> Sarath. 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> 

Hi Sarath,

While running the LTP test suite am also facing the same issue as you have
faced. Please let me know have you got the solution for the below problem if so
then please let me know.

I have ran Make install command using root only.

Thanks in advance 

Regards,
Rejish




------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
