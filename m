Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NmkoQ-0003WX-GC
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:24:14 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmkoP-0004Qd-GF
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:24:14 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o239LEso030391
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 02:21:14 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o239O5l5120650
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 02:24:06 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o232O5FV023102
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 19:24:05 -0700
Date: Wed, 3 Mar 2010 14:53:54 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303092354.GA23601@linux.vnet.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
	<B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
	<20100302173535.GA14556@us.ibm.com>
	<5EEDD2C4-6C6C-4008-81AA-65B78FA3E7C8@gmail.com>
	<20100303055619.GA19084@linux.vnet.ibm.com>
	<364299f41003030114x30e251d6x7cd7993f8f75792f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41003030114x30e251d6x7cd7993f8f75792f@mail.gmail.com>
Subject: Re: [LTP] LTP's filecaps test gives false positive results
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Iranna D Ankad <iranna.ankad@in.ibm.com>

On Wed, Mar 03, 2010 at 01:14:12AM -0800, Garrett Cooper wrote:
>     I'll update the tests this weekend, but I would like it if someone
> test the tests on an outdated distro (RHEL 4.x?) once I provide a
> patch to ensure that nothing's being regressed. Based on some really
> simple inspection it appears that these tests are compatible only with
> libcapability 2.x+, but I could be wrong...

Yes will definitely do the regression test on 4.x .

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
