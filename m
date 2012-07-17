Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <preeti@linux.vnet.ibm.com>) id 1Sqxfc-0002Jh-0c
	for ltp-list@lists.sourceforge.net; Tue, 17 Jul 2012 02:37:52 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sqxfa-0007aI-NQ
	for ltp-list@lists.sourceforge.net; Tue, 17 Jul 2012 02:37:51 +0000
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <preeti@linux.vnet.ibm.com>; 
	Tue, 17 Jul 2012 08:07:42 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q6H2bbVU50069722
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jul 2012 08:07:38 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	q6H879DN022909
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jul 2012 13:37:09 +0530
Message-ID: <5004D28D.8020203@linux.vnet.ibm.com>
Date: Tue, 17 Jul 2012 08:18:45 +0530
From: preeti <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <6F91E0FFDA542149961F7BDED2D2B94B568E0DED0D@EXGMBX01.sasken.com>
In-Reply-To: <6F91E0FFDA542149961F7BDED2D2B94B568E0DED0D@EXGMBX01.sasken.com>
Subject: Re: [LTP] Executing LTP one test at a time
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
To: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 07/16/2012 06:35 PM, Rejish Rajagopala wrote:
> Hi,
Hi Rajish,
> 
> Please let me know is there way to execute single test using runltp script.

Yes there is.when you run the command runltp -f cmdfile,runltp searches
for the cmdfile under runtest.Under runtest are files for each
subsystem,like fs,mm,sched etc each of which define how the test cases
beneath them should run.

> 
> That is, I know we can execute user defined test cases through the command "runltp -f pty" but  is there a way so that I can run ltp like "runltp pty01" that is the test case directly through runltp script.

 So in the example that you have quoted,pty is the subsystem whose file
is under runtest.you can edit this file by commenting out the rest of
the scripts under pty.

This might seem a bit more inconvenient than running runltp with some
command line options but if you are not using the other scripts under
pty,each time you run it,might as well comment them out.

>

> 
> 
> Regards,
> Rejish
> 
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

Regards,
Preeti
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
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
