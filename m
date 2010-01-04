Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NRqrS-0007cI-V1
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 17:36:58 +0000
Received: from fg-out-1718.google.com ([72.14.220.157])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRqrR-0002Lt-GS
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 17:36:58 +0000
Received: by fg-out-1718.google.com with SMTP id e12so146420fga.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 09:36:51 -0800 (PST)
Message-ID: <4B4226E9.6000309@petalogix.com>
Date: Mon, 04 Jan 2010 18:35:37 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4B421480.1040400@petalogix.com>
	<20100104164954.GB26962@us.ibm.com>
In-Reply-To: <20100104164954.GB26962@us.ibm.com>
Subject: Re: [LTP] clone tests fails
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

Serge E. Hallyn wrote:
> Quoting Michal Simek (michal.simek@petalogix.com):
>> Hi Mike,
>>
>> I have one question about one your big patch
>>
>> http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=391dc18fe3271fbf2ca1864a5299f091c31e0018
>>
>> My question is why you add -1 in lib/cloner.c:65
>>
>> +       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>> +                       clone_flags, arg);
>>
>> In previous code in clone testcases was nothing like this.
>> What reason have you had to add it?
> 
> Because the same thing was done in lots of places all over the
> testsuite (and done wrong).  This consolidates them all.


I don't have anything against consolidation. I just want to know why 
there is that -1 which weren't in any clone testcases. Nothing more 
nothing less.

Michal

> 
>> Of course the reason is that on Microblaze some tests failed.
> 
> How do they fail?  Does clone on Microblaze take the top of
> stack?
> 
> -serge


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

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
