From: Travis CI <builds@travis-ci.org>
Date: Thu, 02 Feb 2017 09:52:57 +0000
Subject: [LTP] Passed: pevik-travis/ltp#55 (master - 121dba5)
In-Reply-To: <pevik-travis/ltp+197584686+passed@travis-ci.org>
Message-ID: <58930179aa29d_43fc5a34d84805099c2@b3bc1a9c-58dc-45a1-b3f8-b5d657cbdffa.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for pevik-travis/ltp
-------------------------------------

Build: #55
Status: Passed

Duration: 13 minutes and 19 seconds
Commit: 121dba5 (master)
Author: Cyril Hrubis
Message: madvise01: Fix MADV_FREE

Currently MADV_FREE works only on anonymous pages.

Also the test was passing a file descriptor to the MAP_ANONYMOUS mmap(),
which is not wrong since the fd argument is ignored in that case, but it
was mildly confusing. So now we pass -1 and the pointer variable is
called amem instead of pfile which was confusing as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/pevik-travis/ltp/compare/a002136ee3d0...121dba50c4bd

View the full build log and details: https://travis-ci.org/pevik-travis/ltp/builds/197584686

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170202/27ae7f49/attachment.html>
