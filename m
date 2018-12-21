From: Travis CI <builds@travis-ci.org>
Date: Fri, 21 Dec 2018 11:00:37 +0000
Subject: [LTP] Passed: linux-test-project/ltp#1256 (master - e36643e)
In-Reply-To: <linux-test-project/ltp+470920918+passed@travis-ci.org>
Message-ID: <5c1cc7d4d917c_43f89c2f7e7f893899@6bb8627b-fe73-4ec2-90fb-a70c0fff3e22.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1256
Status: Passed

Duration: 14 mins and 33 secs
Commit: e36643e (master)
Author: Alexey Kodanev
Message: lib/tst_net.sh: fix checking ping6 command availability

* Fix the previous patch with tst_ping(), move setting $cmd before
  tst_test_cmds().

* Avoid misleading 'iface' in the info messages, rename 'iface' to
  'iface/saddr' since we can pass a source address instead of an
  interface name.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/db9eace87950...e36643ed895d

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/470920918?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181221/59116682/attachment.html>
