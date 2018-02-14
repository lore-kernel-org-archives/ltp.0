From: Travis CI <builds@travis-ci.org>
Date: Wed, 14 Feb 2018 10:12:01 +0000
Subject: [LTP] Errored: linux-test-project/ltp#660 (master - 79b720d)
In-Reply-To: <linux-test-project/ltp+340936853+errored@travis-ci.org>
Message-ID: <5a82e5cebdb15_43f982ed508e49319d8@585e993b-983a-4e3f-b270-9220289d668f.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #660
Status: Errored

Duration: 15 minutes and 29 seconds
Commit: 79b720d (master)
Author: Xiao Yang
Message: syscalls/mremap03: Do not pass MAP_FAILED into mremap()

Running mremap03 -i n got the following errors:
-----------------------------------------------
mremap03    1  TPASS  :  mremap() Fails, 'old region not mapped', errno 14
mremap03    1  TFAIL  :  mremap03.c:137: mremap() Fails, 'Unexpected errno 22
...
-----------------------------------------------

When running mremap03 in loops, we passed MAP_FAILED instead of bad
address into mremap().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/b745b0053c05...79b720d24f63

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/340936853?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180214/2fc21cd8/attachment.html>
