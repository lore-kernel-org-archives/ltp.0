From: Travis CI <builds@travis-ci.org>
Date: Wed, 14 Feb 2018 10:10:46 +0000
Subject: [LTP] Passed: linux-test-project/ltp#661 (master - 11510e8)
In-Reply-To: <linux-test-project/ltp+340989778+passed@travis-ci.org>
Message-ID: <5a8304b73577d_43f982ed50c0411379ed@585e993b-983a-4e3f-b270-9220289d668f.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #661
Status: Passed

Duration: 18 minutes and 13 seconds
Commit: 11510e8 (master)
Author: Jan Stancek
Message: dynamic_debug01: fix cleanup on older kernels

setup() hits TCONF, but cleanup() still runs and tries
to umount non-existend directory, which eventually
reports a failure:
 1 TCONF: Dynamic debug is available since version 2.6.30
 awk: cmd. line:1: fatal: cannot open file `./debug_statements' for reading (No such file or directory)
 Cannot umount ""
 1 TINFO: umount() failed, try 1 ...
 1 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
 Cannot umount ""
 ...

Signed-off-by: Jan Stancek <jstancek@redhat.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/79b720d24f63...11510e85ebeb

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/340989778?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180214/183031b9/attachment-0001.html>
