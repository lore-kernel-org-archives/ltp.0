Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@linux.vnet.ibm.com>) id 1QrdFN-000645-MC
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 21:57:01 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QrdFM-0000an-V8
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 21:57:01 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7BLn13o021290
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:49:01 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7BLtZrL208030
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:55:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7BFtYD9008869
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 09:55:34 -0600
Received: from taco.beaverton.ibm.com ([9.47.29.114])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p7BFtYAj008856
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 09:55:34 -0600
Date: Thu, 11 Aug 2011 14:55:40 -0700
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Message-ID: <20110811215540.GA9414@us.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 0/7] Pounder Overhaul
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
To: ltp-list@lists.sourceforge.net

Hi!

Some of you might have noticed a directory called pounder21 sitting at
ltp-full-xxxxxxxx/tools/pounder21 and are probably wondering what it's
used for. In short, pounder is a test suite originally developed by IBM
that provides a framework for building, scheduling, running, and logging
results for user-defined sets of tests.  Almost any test or test suite
may be run as a subtest from within this framework, including the LTP test
suite. Unfortunately, it has been neglected for a good while, rendering it
out of date and basically unusable for quite some time. However, the
following patches will make the necessary updates to pounder that will make
it work again.

Pounder is currently used by IBM to test its systems, but we would really
like to get pounder out to the public and make more usable by everyone.
The new version of pounder comes with more comphrehensive pieces of
documentation that describe how pounder works and how to use it as well as
provides additional functionality that will make building, running, and
customizing pounder by users much easier.

A bulk of the old build problems, issues with compatibility, file dependencies,
outdated packages, etc. should also be fixed in the new version. These
patches are lengthy, but they'll be well worth it to get pounder up and
running again. The patches only apply to files in the tools/pounder21/
directory, so LTP will remain untouched.

(warning: Patch 6 contains binary info that seems like only git understands,
so should use something like git-apply rather than normal patch for applying
patch 6)

Lucy Liang

------------------------------------------------------------------------------
FREE DOWNLOAD - uberSVN with Social Coding for Subversion.
Subversion made easy with a complete admin console. Easy 
to use, easy to manage, easy to install, easy to extend. 
Get a Free download of the new open ALM Subversion platform now.
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
