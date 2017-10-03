From: Travis CI <builds@travis-ci.org>
Date: Tue, 03 Oct 2017 17:18:39 +0000
Subject: [LTP] Passed: linux-test-project/ltp#467 (master - d6f92b7)
In-Reply-To: <linux-test-project/ltp+282796233+passed@travis-ci.org>
Message-ID: <59d3c66f73cf7_43fb5b154f88410999e2@328b8123-a5cf-445b-b843-e1ac9f30f48e.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #467
Status: Passed

Duration: 10 minutes and 38 seconds
Commit: d6f92b7 (master)
Author: Bixuan Cui
Message: syscalls/access01: Set umask value before run case

The test will fail when the system umask is not set to the default 0022
because the directories and files created in the test setup will have
unexpected permissions. This commit fixes the test by adding
'umask(0022)' into the test setup().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/9dc07e077975...d6f92b74b514

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/282796233?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171003/40caca0d/attachment.html>
