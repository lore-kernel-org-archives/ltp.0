Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi.kleen@intel.com>) id 1MaPuC-0007pN-1y
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:06:56 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MaPu3-0001rJ-L1
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:06:56 +0000
From: "Kleen, Andi" <andi.kleen@intel.com>
Date: Mon, 10 Aug 2009 09:05:59 +0100
Message-ID: <2E9E6F5F5978EF44A8590E339E888CF901425402ED@irsmsx503.ger.corp.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
	<1249648896.4851.40.camel@subratamodak.linux.ibm.com>
	<1249888606.5337.158.camel@yhuang-dev.sh.intel.com>
In-Reply-To: <1249888606.5337.158.camel@yhuang-dev.sh.intel.com>
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


>I will check the coding style with checkpatch.pl. Do you have other
>comments about the code?

I would prefer no wide scale reformattings for now, that will
impact any out of tree patches other people have and the benefits
would seem to be small.

The code is probably not fully compliant, but should be close enough to
kernel style (after all it was written by experienced kernel developers)

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
