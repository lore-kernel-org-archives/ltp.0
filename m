From: Travis CI <builds@travis-ci.org>
Date: Wed, 30 Aug 2017 14:45:51 +0000
Subject: [LTP] Broken: linux-test-project/ltp#398 (master - 79ff360)
In-Reply-To: <linux-test-project/ltp+270019296+broken@travis-ci.org>
Message-ID: <59a6cf9f4960_43fc2581e4e201815666@02fdc155-d6b0-4e79-82af-3d7082557257.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #398
Status: Broken

Duration: 4 minutes and 11 seconds
Commit: 79ff360 (master)
Author: Veronika Kabatova
Message: - Check interface and functionality

Add a new test to verify enabling and disabling traces with supported
flags works and doesn't cause any issues.

Dynamic debug was added in kernel 2.6.30, the first version only
supported "p" flag and used "-" as indicator for no flags set. In
kernel 3.2, additional flags "flmt" were added. Finally, in kernel
3.4, the indicator for no flags was changed to "=_".

The test takes into account different kernel versions and interface
changes listed above.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/29349f864f70...79ff3609ec94

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/270019296?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170830/f965e9d0/attachment.html>
