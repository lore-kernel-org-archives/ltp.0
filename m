Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MUZ88-0000Il-B7
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 04:45:08 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUZ80-00031g-CP
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 04:45:08 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 24 Jul 2009 21:38:02 -0700
Message-ID: <8368651DACC1964480F951191B94A078E49F0A@svexch01.mvista.com>
In-Reply-To: <200907242113.36309.vapier@gentoo.org>
References: <OFE8FAC2C8.7B8ECD5A-ON852575FD.0081EDEC-852575FD.00837054@us.ibm.com>
	<200907242113.36309.vapier@gentoo.org>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] hardware requirements
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net
Cc: Mark Ver <markver@us.ibm.com>

Several tests are also sensitive to the size of the filesystem. While most systems shouldn't have a problem, we have hit these limitations when testing flash filesytems, etc. 

-----Original Message-----
From: Mike Frysinger [mailto:vapier@gentoo.org] 
Sent: Friday, July 24, 2009 6:14 PM
To: ltp-list@lists.sourceforge.net
Cc: Mark Ver
Subject: Re: [LTP] hardware requirements

On Friday 24 July 2009 19:55:39 Mark Ver wrote:
> Is there an agreed upon set of hardware requirements (memory, disk 
> space,
> etc.) for running, if not all tests, at least the default testcases 
> executed by runltp?

not really

> Also, if not very knowledgeable of hardware, is there an easy way to 
> tell if a particular test will run on a target platform or not?  For 
> example, I suspect the DMA_THREAD_DIOTEST7 tests are not expected to 
> run on all architectures.  Is there a way to find out what platforms it does support?

many of test cases dont care at all about resources.  might be useful to have an embedded doc format so tests that do care about resources can declare them and then a script can run periodically to collect all of them in a summary format.

i'm pretty sure that in the vast majority of cases, the memory size is the only thing that a test may play with.
-mike
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
