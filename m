Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1TMes2-00072J-QF
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 13:01:42 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TMerw-0006DI-LJ
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 13:01:42 +0000
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Fri, 12 Oct 2012 09:01:30 -0400
Message-ID: <50781491.9060402@linux.vnet.ibm.com>
Date: Fri, 12 Oct 2012 15:01:05 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] LCOV 1.10 released
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
To: ltp-coverage@lists.sourceforge.net, ltp-list@lists.sourceforge.net

Version 1.10 of the LTP GCOV extension (LCOV) has been released.

LCOV is a graphical front-end for GCC's coverage testing tool gcov. It
collects gcov data for multiple source files and creates HTML pages
containing the source code annotated with coverage information. It also
adds overview pages for easy navigation within the file structure. LCOV
supports statement, function and branch coverage measurement.

Changes in version 1.10 include:
  * Support for GCC 4.7
  * Improved support for complex build environments such as libtool
  * New configuration setting to disable branch coverage for improved
    performance
  * New option to easily filter out coverage data for external files
    such as standard library headers
  * Multiple bug fixes and documentation improvements

Download instructions and a detailed list of changes included in this
release can be found on the LCOV web page at:

   http://ltp.sourceforge.net/coverage/lcov.php


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
