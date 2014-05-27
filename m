Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1WpJ3L-0003Rl-Eq
	for ltp-list@lists.sourceforge.net; Tue, 27 May 2014 15:12:35 +0000
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WpJ3K-0004UU-Fp
	for ltp-list@lists.sourceforge.net; Tue, 27 May 2014 15:12:35 +0000
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Tue, 27 May 2014 16:12:28 +0100
Message-ID: <5384AB59.7010306@linux.vnet.ibm.com>
Date: Tue, 27 May 2014 17:12:25 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] LCOV 1.11 released
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
To: "ltp-coverage@lists.sourceforge.net" <ltp-coverage@lists.sourceforge.net>, ltp-list <ltp-list@lists.sourceforge.net>

Version 1.11 of the LTP GCOV extension (LCOV) has been released.

LCOV is a graphical front-end for GCC's coverage testing tool gcov. It
collects gcov data for multiple source files and creates HTML pages
containing the source code annotated with coverage information. It also
adds overview pages for easy navigation within the file structure. LCOV
supports statement, function and branch coverage measurement.

Changes in version 1.11 include:
  * Improved support for GCC 4.7
  * Improved performance for specific functions
  * Compatibility support for LLVM's gcov
  * Multiple bug fixes and documentation improvements

Download instructions and a detailed list of changes included in this
release can be found on the LCOV web page at:

   http://ltp.sourceforge.net/coverage/lcov.php


------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
