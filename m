Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MYfnG-00067H-Ng
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 12:40:34 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYfnA-0001FT-Uv
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 12:40:34 +0000
Message-Id: <20A6A037-DDDB-4673-8B04-415FC02E60CB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4A791430.2000407@linux.vnet.ibm.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Wed, 5 Aug 2009 07:40:16 -0500
References: <5D25ED72-13B4-4ED7-959C-4974F4DF2FCA@kernel.crashing.org>
	<4A791430.2000407@linux.vnet.ibm.com>
Subject: Re: [LTP] building LTP on fedora 10 or 11
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>


On Aug 5, 2009, at 12:10 AM, Rishikesh wrote:

> Kumar Gala wrote:
>> Has anyone been able to build LTP on fedora 10 or 11.
>>
>> When I try on a x86_64 fedora 10 box:
>>
>> [galak@komodo ltp]$ make autotools
>> aclocal -I m4
>> autoconf
>> configure.ac:9: error: possibly undefined macro: AC_PROG_AR
>>       If this token and others are legitimate, please use   
>> m4_pattern_allow.
>>       See the Autoconf documentation.
>> make: *** [configure] Error 1
>>
>> than if I run it again I get:
>>
>> [galak@komodo ltp]$ make autotools
>> make: *** No rule to make target `m4/Makefile.am', needed by `m4/  
>> Makefile.in'.  Stop.
>>
>> I pretty much see the same behavior on fedora 11.  Tried both  
>> x86_64  and PPC.
>>
>> - k
>>
>> ------------------------------------------------------------------------------
>> Let Crystal Reports handle the reporting - Free Crystal Reports  
>> 2008 30-Day trial. Simplify your report design, integration and  
>> deployment - and focus on what you do best, core application  
>> coding. Discover what's new with Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> Hi Kumar,
>
> Which version of LTP is producing this error ? Have you tried latest  
> LTP that is July'09  version ?
> -Rishi

I'm trying top of CVS.

- k

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
