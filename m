Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MZ7NT-0007ZP-5D
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 18:07:47 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZ7NS-0004bO-AC
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 18:07:47 +0000
Message-Id: <2E55F490-102A-4179-B0F2-ED7F5C0D1A12@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D4B24F3A-3BF2-41BA-9626-2D13AC12B515@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 6 Aug 2009 13:07:35 -0500
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<1249494775.13131.18.camel@lucio-laptop>
	<3E7F2B7B-6BA8-4179-B973-5DA7F4D7618A@kernel.crashing.org>
	<364299f40908061024l42cd1200n99e6e762a77c91d2@mail.gmail.com>
	<D4B24F3A-3BF2-41BA-9626-2D13AC12B515@kernel.crashing.org>
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>


On Aug 6, 2009, at 12:43 PM, Kumar Gala wrote:

>>   Ok. I have the time now so I'll install F11 amd64 and see what
>> happens. Something leads me to think that the build toolchain is
>> fubared, but that's just a hunch, as my copy of F10 (the last time I
>> ran the build) worked.
>> Thanks,
>> -Garrett
>
> interesting since I saw the same issues w/F10 amd64.
>
> - k

I also just tried installing clean versions of automake, autoconf, m4  
to match the versions in the INSTALL file and got:

autoconf-2.61
automake-1.10.2
m4-1.4.12

and still get the same issue:

touch config.mk
aclocal -I m4
autoconf
configure.ac:9: error: possibly undefined macro: AC_PROG_AR
      If this token and others are legitimate, please use  
m4_pattern_allow.
      See the Autoconf documentation.
make: *** [configure] Error 1

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
