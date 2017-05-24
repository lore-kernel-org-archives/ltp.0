From: Travis CI <builds@travis-ci.org>
Date: Wed, 24 May 2017 11:45:56 +0000
Subject: [LTP] Still Failing: linux-test-project/ltp#213 (master - 6229357)
In-Reply-To: <linux-test-project/ltp+235604782+still failing@travis-ci.org>
Message-ID: <592572748b95d_43fe4f75200782300e5@6ccbacd3-9022-4383-904d-7d081ba4f444.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #213
Status: Still Failing

Duration: 2 minutes and 57 seconds
Commit: 6229357 (master)
Author: Xiao Yang
Message: syscalls/fanotify07.c: Fix compilation without fanotify

Compilation failed becasue main function is defined in new API.
We should use TST_TEST_TCONF instead of main function to skip
this case in new API.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/dcf361cb4f20...6229357c252a

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/235604782?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170524/14258ab3/attachment-0001.html>
