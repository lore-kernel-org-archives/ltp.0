Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1NiCGb-00025I-7s
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 19:42:29 +0000
Received: from mtagate6.de.ibm.com ([195.212.17.166])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NiCGZ-0007nu-Sf
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 19:42:29 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.1/8.13.1) with ESMTP id o1IJgKAW000311
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 19:42:20 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o1IJgKLR1380482
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 20:42:20 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o1IJgK9B030705
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 20:42:20 +0100
Message-ID: <4B7D981B.1070005@linux.vnet.ibm.com>
Date: Thu, 18 Feb 2010 20:42:19 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <EB1A7C66AD0C92419BFFC785A947865A09EAE44689@BLRINMSMBX01.bglrodc.lntinfotech.com>	<20100218101440.GA21750@rishikesh.in.ibm.com>	<EB1A7C66AD0C92419BFFC785A947865A09EAE448A4@BLRINMSMBX01.bglrodc.lntinfotech.com>
	<20100218104715.GB21750@rishikesh.in.ibm.com>
In-Reply-To: <20100218104715.GB21750@rishikesh.in.ibm.com>
Subject: Re: [LTP] not able to generate HTML output
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Pramendra Singh <Pramendra.Singh@lntinfotech.com>

If you're cross-compiling your kernel and want to run lcov on the build 
machine, you need to specify the full path to the cross-compiler gcov 
tool, otherwise lcov will attempt to use the gcov tool of the locally 
installed gcc package.

Example:

   lcov -c -d /path/to/files --gcov-tool /path/to/ppc_85xx-gcov -o x.info

Also note that lcov can do the copying of .gcda files for you if a perl 
interpreter and the lcov file is available. On the test machine, run:

   lcov -c --to-package package

Copy the package file to the build machine. On the build machine, run:

   lcov -c --from-package package --gcov-tool ...


Regards,
   Peter Oberparleiter


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
