From: Travis CI <builds@travis-ci.org>
Date: Thu, 04 Oct 2018 14:57:35 +0000
Subject: [LTP] Errored: linux-test-project/ltp#1062 (master - a8df324)
In-Reply-To: <linux-test-project/ltp+437166307+errored@travis-ci.org>
Message-ID: <5bb62a5fc9a9_43fab08bd98e8323172@84b04dd9-9c83-4d24-b53f-330bb66985fd.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1062
Status: Errored

Duration: 25 mins and 17 secs
Commit: a8df324 (master)
Author: Xiao Yang
Message: syscalls/getxattr05: Add new regression testcase

Test POSIX Access Control Lists by getxattr(2) with/without a
user namespace.  The following issue is included by the new
testcase and has been fixed in kernel:
'82c9a927bc5d ("getxattr: use correct xattr length")'

Fix #396

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/357e95998ada...a8df324aab42

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/437166307?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181004/a194c362/attachment.html>
