Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi.kleen@intel.com>) id 1MamEU-0001jz-Pw
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 07:57:22 +0000
Received: from mga14.intel.com ([143.182.124.37])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MamEO-0002k3-Ip
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 07:57:22 +0000
From: "Kleen, Andi" <andi.kleen@intel.com>
Date: Tue, 11 Aug 2009 08:55:42 +0100
Message-ID: <2E9E6F5F5978EF44A8590E339E888CF901425408F6@irsmsx503.ger.corp.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
	<1249648896.4851.40.camel@subratamodak.linux.ibm.com>
	<1249975724.5337.170.camel@yhuang-dev.sh.intel.com>
In-Reply-To: <1249975724.5337.170.camel@yhuang-dev.sh.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Integration of MCE test suite into LTP
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
To: "Huang, Ying" <ying.huang@intel.com>, "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


>On Fri, 2009-08-07 at 20:41 +0800, Subrata Modak wrote:
>> I would like people to start doing some testing with your present
>> mce-test as well. As suggested by Andi, please drop in:
>> 
>>      1. a minimal patch which adds the tests(you want) to LTP, 
>
>I think we can add all current test cases in git tree into LTP, is it?

Yes I see no reason to not do a full drop.

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
