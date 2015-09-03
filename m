Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZXUrX-00075H-6H
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 13:47:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZXUrU-0005QZ-N4
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 13:47:35 +0000
Date: Thu, 3 Sep 2015 15:46:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150903134650.GB25522@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2015
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

the Linux Test Project test suite stable release for *September 2015*
has been released.

Since the last release 272 patches by 27 authors were merged.

Notable changes are:

* Network namespace testcases were rewritten from scratch

* New user namespaces testcases

* New testcases for various virtual network interfaces

* New umount2() testcases (for UMOUNT_NOFOLLOW, MNT_EXPIRE and MNT_DETACH flags)

* New open() testcase (for O_PATH flag)

* New getrandom() testcases

* New inotify, cpuset, futex_wake() and recvmsg() regression tests

+ The usual number of fixes and enhancements

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20150903

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
(continuously updated) developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our
mailing list at ltp-list@lists.sourceforge.net.


PS: We had numerous troubles with mailing list on sourceforge, if you are aware
    of good and free mailing list hosting service please let us know.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
