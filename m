From: Travis CI <builds@travis-ci.org>
Date: Thu, 13 Dec 2018 16:32:25 +0000
Subject: [LTP] Passed: linux-test-project/ltp#1232 (master - 00a83eb)
In-Reply-To: <linux-test-project/ltp+467586694+passed@travis-ci.org>
Message-ID: <5c128998ea420_43fc0b9a3c578216185@0f0454a5-7e6c-4f65-9630-adc625b727e7.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1232
Status: Passed

Duration: 17 mins and 28 secs
Commit: 00a83eb (master)
Author: Li Wang
Message: cgroup: fix mount errors in cgroup subsys test 3 and 7

It is very easy to get failures when running these cgroup regression
tests on the newer kernel.

Errors:
  cgroup_regression_test    3  TFAIL  :  ltpapicmd.c:190: Failed to mount cpu subsys
  cgroup_regression_test    7  TFAIL  :  ltpapicmd.c:190: failed to mount net_prio

Signed-off-by: Li Wang <liwang@redhat.com>
[ pvorel: removed fix for test 5, which has been fixed by 877c1228d; fixed bashisms ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/310c9eb6e6af...00a83ebb71a0

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/467586694?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181213/0b531c42/attachment-0001.html>
