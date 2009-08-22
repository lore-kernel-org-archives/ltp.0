Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Meug0-0002kv-K0
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:52 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Meufv-0000Ks-Hd
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:52 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1250670949.5337.492.camel@yhuang-dev.sh.intel.com>
References: <20090805105529.23399.60242.sendpatchset@subratamodak.linux.ibm.com>
	<1249494939.3623.12.camel@subratamodak.linux.ibm.com>
	<1249521485.24238.308.camel@yhuang-dev.sh.intel.com>
	<1249648896.4851.40.camel@subratamodak.linux.ibm.com>
	<1249888606.5337.158.camel@yhuang-dev.sh.intel.com>
	<2E9E6F5F5978EF44A8590E339E888CF901425402ED@irsmsx503.ger.corp.intel.com>
	<1249975494.5337.168.camel@yhuang-dev.sh.intel.com>
	<1250076050.5373.20.camel@subratamodak.linux.ibm.com>
	<1250670949.5337.492.camel@yhuang-dev.sh.intel.com>
Date: Sat, 22 Aug 2009 23:16:22 +0530
Message-Id: <1250963183.10642.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Integration of MCE test suite into LTP
Reply-To: subrata@linux.vnet.ibm.com
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
To: Huang Ying <ying.huang@intel.com>
Cc: "Kleen, Andi" <andi.kleen@intel.com>, ltp-list <ltp-list@lists.sf.net>

On Wed, 2009-08-19 at 16:35 +0800, Huang Ying wrote: 
> ***********************
> Warning: Your file, mce-test-results.tar.gz, contains more than 32 files after decompression and cannot be scanned.
> ***********************
> 
> 
> Hi, Subrata,
> 
> This is the first version of patch. Please feed back your comments. Test results are attached with the mail too.
> 
> Best Regards,
> Huang Ying
> ---------------------------------------------------------->
> Integrate MCE test suite into LTP
> 
> mce-test is a collection of tools and test scripts for testing the
> Linux kernel x86 MCE (Machine Check Exception) processing
> features. This patch integrate that into LTP.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks Huang and Andi. This has now been integrated to LTP. We will keep
testing them as new kernel releases are available. Please keep this test
suite updated as you push respective patches in the kernel.

Regards--
Subrata

> ---
> diff -urNp ltp.orig/testcases/mce-test/bin/.cvsignore ltp/testcases/mce-test/bin/.cvsignore
> --- ltp.orig/testcases/mce-test/bin/.cvsignore	1970-01-01 08:00:00.000000000 +0800
> +++ ltp/testcases/mce-test/bin/.cvsignore	2008-12-26 16:51:05.000000000 +0800
> @@ -0,0 +1 @@
> +*
> diff -urNp ltp.orig/testcases/mce-test/cases/soft-inj/non-panic/cases.sh ltp/testcases/mce-test/cases/soft-inj/non-panic/cases.sh
> --- ltp.orig/testcases/mce-test/cases/soft-inj/non-panic/cases.sh	1970-01-01 08:00:00.000000000 +0800
> +++ ltp/testcases/mce-test/cases/soft-inj/non-panic/cases.sh	2009-05-26 10:39:41.000000000 +0800
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +#



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
