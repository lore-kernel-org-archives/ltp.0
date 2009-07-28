Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi.kleen@intel.com>) id 1MVirc-0001j4-GR
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 09:20:52 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MVirY-0000Qm-8m
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 09:20:52 +0000
From: "Kleen, Andi" <andi.kleen@intel.com>
Date: Tue, 28 Jul 2009 10:18:51 +0100
Message-ID: <2E9E6F5F5978EF44A8590E339E888CF901420A78F4@irsmsx503.ger.corp.intel.com>
References: <f5a7b3810907280207v6e88cadaodbc90831d562d4cf@mail.gmail.com>
In-Reply-To: <f5a7b3810907280207v6e88cadaodbc90831d562d4cf@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Integration of MCE test suite into LTP
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
To: naresh kamboju <naresh.kernel@gmail.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

 

>With reference to Linux MCE
>
>http://kernel.org/pub/scm/utils/cpu/mce/
>
>Are you discussing about this?

This is about machine check exception/event, aka hardware errors,

It has nothing to do with "LinuxMCE"

>Could you list out the hardware and software requirements to run this
>application as well test suite.

The test suite should run on any hardware that implements
the standard Intel machine check architecture, which is near
all x86 CPUs shipped in the last decade.

It doesn't necessarily work in virtual machines.

-Andi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
