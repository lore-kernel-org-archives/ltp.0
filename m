Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wcwtt-0004Xb-RA
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 13:07:45 +0000
Date: Wed, 23 Apr 2014 15:06:53 +0200
From: chrubis@suse.cz
Message-ID: <20140423130653.GA24742@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for APRIL
 2014
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
To: ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org

Good news everyone,

The Linux Test Project test suite stable release for *April 2014* has
been released.

Since the last release 210 patches by 27 authors were merged.

Notable changes are:

* Continued effort to cleanup old testcases
  (about 30 testcases were cleaned up/rewritten)

* 20 new syscall testcases
  15 existing testcases increased in coverage
  (pselect, mprotect, mknodat, fchonwat, linkat, fanotify, inotify, fcntl, ...)

* new tcp_fastopen, rcutorture and acpi_cpufreq testcases

* out-of-tree build as well as cross compilation were fixed

* bashism in runltp and few scripts was fixed
  (should work fine on Debian with dash now)

* ext4 features tests were fixed and added to default run

* few testcases were fixed not to incorrectly fail on Btrfs

* and many more smaller fixes


The latest version of the test-suite contains 3000+ tests for the Linux
OS and can be downloaded at:

http://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20140422/

The project pages as well as GIT repository are hosted on GitHub for
quite some time now:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to
ltp-list@lists.sf.net

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
