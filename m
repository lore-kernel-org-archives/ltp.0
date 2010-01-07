Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NSh4F-0006MG-In
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 01:21:39 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSh4E-0005i3-Ek
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 01:21:39 +0000
Message-ID: <4B45371A.4030100@web.de>
Date: Thu, 07 Jan 2010 02:21:30 +0100
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <4B421480.1040400@petalogix.com>
	<20100104174925.GA1208@us.ibm.com> <4B43E1CD.2050609@web.de>
	<201001060025.45552.vapier@gentoo.org>
In-Reply-To: <201001060025.45552.vapier@gentoo.org>
Subject: Re: [LTP] clone tests fails
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Mike Frysinger napsal(a):
> On Tuesday 05 January 2010 20:05:17 Jiri Palecek wrote:
>> Michal, I suspect the failures you see are somehow related to alignment
>>   (that your architecture doesn't like odd addresses). Is that right? Under
>>   x86, the address gets aligned (so some of the space is unused).
>>
>> Perhaps both of these behaviors should be tested by LTP?
>
> i dont think such tests would be reliable or useful ?

I don't think so. The set of addresses that can be successfully passed to 
clone() and the actual space the stack will occupy with the given parameters are 
definitely part of the interface (because the user cannot use the interface 
correctly without knowing these), therefore testing them is useful, and they 
should be quite easily testable, although the test would be 
architecture-dependent, but oh well, so is the whole clone() syscall.

Regards
     Jiri Palecek

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
