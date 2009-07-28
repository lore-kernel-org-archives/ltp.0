Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi.kleen@intel.com>) id 1MVl4W-0007Jf-LF
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 11:42:20 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MVl4S-0004eU-Bz
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 11:42:20 +0000
From: "Kleen, Andi" <andi.kleen@intel.com>
Date: Tue, 28 Jul 2009 12:42:06 +0100
Message-ID: <2E9E6F5F5978EF44A8590E339E888CF9014239FA74@irsmsx503.ger.corp.intel.com>
References: <f5a7b3810907280207v6e88cadaodbc90831d562d4cf@mail.gmail.com>
	<2E9E6F5F5978EF44A8590E339E888CF901420A78F4@irsmsx503.ger.corp.intel.com>
	<f5a7b3810907280346x6ba3fccby80e7a66888d0d646@mail.gmail.com>
In-Reply-To: <f5a7b3810907280346x6ba3fccby80e7a66888d0d646@mail.gmail.com>
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, "Huang,  Ying" <ying.huang@intel.com>

 >>
>>>Could you list out the hardware and software requirements to run this
>>>application as well test suite.
>>
>> The test suite should run on any hardware that implements
>> the standard Intel machine check architecture, which is near
>> all x86 CPUs shipped in the last decade.
>>
>> It doesn't necessarily work in virtual machines.
>>
>> -Andi
>
>Do you mean it is not compatible with other than X86 Machines?

It only tests x86 machine checks, not other architecturs. Machine
checks are very architecture dependent. But I was refering to virtual
x86 machines like KVM or Xen or Vmware. These often don't emulate
machine checks for guests and when there is no basic machine
check capability the test suite doesn't run either (that could
be probably fixed, most is already emulated in the kernel,
but not all)

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
