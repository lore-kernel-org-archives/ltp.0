Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MR2Nq-0007M8-Js
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 11:10:46 +0000
Received: from ey-out-1920.google.com ([74.125.78.148])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MR2Np-0006jZ-9D
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 11:10:46 +0000
Received: by ey-out-1920.google.com with SMTP id 5so711545eyb.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Jul 2009 04:10:44 -0700 (PDT)
Message-ID: <4A5DA96F.8000900@monstr.eu>
Date: Wed, 15 Jul 2009 12:03:27 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
References: <4A5C8068.6020203@monstr.eu> <200907141843.05629.arnd@arndb.de>
	<4A5CB8B4.7050108@monstr.eu> <200907141913.21240.arnd@arndb.de>
	<20090715092113.GA1863@linux-sh.org>
In-Reply-To: <20090715092113.GA1863@linux-sh.org>
Subject: Re: [LTP] access_ok macor
Reply-To: monstr@monstr.eu
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
To: Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, monstr@monstr.eu, Linux Kernel list <linux-kernel@vger.kernel.org>, LTP <ltp-list@lists.sourceforge.net>

Paul Mundt wrote:
> On Tue, Jul 14, 2009 at 07:13:20PM +0200, Arnd Bergmann wrote:
>> On Tuesday 14 July 2009, Michal Simek wrote:
>>> when the code tried to read/write from unaligned address (and in cpu
>>> is turn on unaligned exception) then is caused unaligned exception
>>> and asm code assemble/return value which is on that unaligned
>>> address. (Assemble it that read/write every byte separately). That
>>> will be harder to prevent all this cases because unaligned exception
>>> is in generic code.  What do you mean add __range_ok? Range checking
>>> is ok. The problem is when in case get_user kernel try to load
>>> unaligned addr - unaligned exception is perform and try to load that
>>> value separately.  If that page is not there, page fault handler is
>>> called and not find it, it is performed search from exception table
>>> and that address is not there of course - because address in pc is
>>> generic unaligned code. I think that handling this needs more code.
>>> Maybe if the address with from unaligned exception handler (there are
>>> some address which can caused it) and find out which aligned address
>>> is there and find out proper fixup for it.  I think that this could
>>> work.
>>>
>>> What do you think?
>> I think the key point is that the kernel should never try an unaligned
>> access. Other architectures already rely on this, so you can too.
> 
> No, other architectures used to rely on this, until it was no longer
> possible to do so. See for example, nfs. Unaligned accesses by the kernel
> must be handled by the architecture, unaligned accesses by userspace can
> be optionally fixed up.

Can you please look at John's email in this thread. How does SH handle this case?
I mean when for get/put user address is added unaligned address. How does your kernel handle it?

Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
