Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NSh8T-0006V0-W7
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 01:26:01 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSh8S-0000MC-Dn
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 01:26:01 +0000
Message-ID: <4B453820.6020505@web.de>
Date: Thu, 07 Jan 2010 02:25:52 +0100
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <4B421480.1040400@petalogix.com> <4B43E1CD.2050609@web.de>
	<20100106032644.GB8157@us.ibm.com>
	<201001060025.11076.vapier@gentoo.org>
In-Reply-To: <201001060025.11076.vapier@gentoo.org>
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
Cc: Nathan T Lynch <natlynch@us.ibm.com>, ltp-list@lists.sourceforge.net

Mike Frysinger napsal(a):
> On Tuesday 05 January 2010 22:26:44 Serge E. Hallyn wrote:
>> Quoting Jiri Palecek (jpalecek@web.de):
>>> Michal, I suspect the failures you see are somehow related to
>>> alignment (that your architecture doesn't like odd addresses). Is
>>> that right? Under x86, the address gets aligned (so some of the
>>> space is unused).
>>>
>>> Perhaps both of these behaviors should be tested by LTP?
>>
>> Gah, yes, Nathan had mentioned arches where this matters (including
>> some power?).  Nathan, did you have a generic fix for this in
>> userspace?  Should always be safe to do
>> 	(stack + stack_size - 1)&  ~0xf
>> ?
>
> (sizeof(long double)-1) would probably be better than 0xf

sizeof(long double) is not a power of 2 (at least on 386), so this wouldn't 
probably work. glibc hardcodes the alignment (to 16 on most arches).

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
