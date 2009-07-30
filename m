Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MWZ3e-0000Mr-6Z
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 17:04:46 +0000
Received: from mail-fx0-f222.google.com ([209.85.220.222])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWZ3Q-0004gQ-PN
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 17:04:41 +0000
Received: by fxm22 with SMTP id 22so752329fxm.33
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 10:04:26 -0700 (PDT)
Message-ID: <4A71D296.6040905@petalogix.com>
Date: Thu, 30 Jul 2009 19:04:22 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <20090730075802.GE3058@console-pimps.org>
	<4A717D05.2070603@petalogix.com>
	<20090730154452.GG3058@console-pimps.org>
In-Reply-To: <20090730154452.GG3058@console-pimps.org>
Subject: Re: [LTP] fcntl24,25,26 fail when run on tmpfs
Reply-To: michal.simek@petalogix.com
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
To: Matt Fleming <matt@console-pimps.org>
Cc: ltp-list@lists.sourceforge.net

Matt Fleming wrote:
> On Thu, Jul 30, 2009 at 12:59:17PM +0200, Michal Simek wrote:
>   
>> Hi Matt,
>>     
>>> Attached is a patch to skip testcases fcntl24, fcntl25 and fcntl26 if
>>> the host is running on tmpfs. The reason being that, as documented here
>>> http://bugzilla.kernel.org/show_bug.cgi?id=13626, F_SETLEASE and F_WRLCK
>>> cannot work on tmpfs.
>>>   
>>>       
>> I tested it and works. The same issue is for RAMFS. But for this fs in
>> necessary to create
>> tst_is_cwd_ramfs function. Maybe worth to add together
>> tst_is_cwd_tmpfs.c and tst_cwd_has_free.c too.
>>
>>     
>
> Thanks for testing. Yes, the same issue will affect ramfs too.
>
> I'm not quite sure what sure why you're saying tst_cwd_has_free is
> needed?
>   
I meant that will be worth to create new one file instead of tree.
I don't know call it tst_cwd_tests.c and add there content of 

tst_is_cwd_tmpfs.c and tst_cwd_has_free.c + testing function for ramfs.

Cheers,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
