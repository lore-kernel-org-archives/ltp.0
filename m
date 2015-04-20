Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YkBD5-00018I-Ct
	for ltp-list@lists.sourceforge.net; Mon, 20 Apr 2015 12:53:59 +0000
Date: Mon, 20 Apr 2015 14:53:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150420125331.GA24869@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] LTP] [ANNOUNCE] The Linux Test Project has been released for
 APRIL 2015
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

Good news everyone,

the Linux Test Project test suite stable release for *April 2015* has
been released.

Since the last release 183 patches by 23 authors were merged.

Notable changes are:

* Continued effort to cleanup up old testcases and test library
  (Special thanks to Coccinelle and spatch for making this easier)

* More sleep() calls were changed into proper synchronization
  which saves a few minutes on test run time

* Cleanups, fixes and new tests in network testcases

* New testcases for futex() syscall

* New testcases for select() and poll() timeouts

* New mmap() regression testcase

* New regression test for hugepage leak

* Fixes all over the codebase


The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

http://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20150420/

The project pages as well as GIT repository are hosted on GitHub for
quite some time now:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to run LTP or write a testcase, don't miss our
developer documentation and LWN.net articles at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

https://lwn.net/Articles/625969/
https://lwn.net/Articles/630542/

Patches, new tests, bugs, comments or questions should go to
to our mailing list at ltp-list@ltp-list@lists.sourceforge.net.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
