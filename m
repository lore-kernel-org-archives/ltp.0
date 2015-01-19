Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDBNI-0002dO-P1
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 12:24:08 +0000
Date: Mon, 19 Jan 2015 13:23:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150119122310.GA27065@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] The Linux Test Project has been released for JANUARY 2015
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
To: ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org

God news everyone,

the Linux Test Project test suite stable release for *January 2015* has
been released.

Since the last release 139 patches by 21 authors were merged.

Notable changes are:

* Fixes and enhancements of network testcases by Alexey Kodanev

* New testcases for mount, network and ipc namespaces by Matus Marhefka

* New testcase for fanotify ignore masks

* New policy and library helpers to install and access testcase datafailes

* Use of coccinelle and spatch to fix bugs and cleanup old code

* And many more smaller fixes and enhancements


If you are not familiar with LTP there is a nice article at LWN.net
https://lwn.net/Articles/625969/.

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

http://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20150119/

The project pages as well as GIT repository are hosted on GitHub for
quite some time now:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to
to our mailing list at ltp-list@lists.sourceforge.net.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
