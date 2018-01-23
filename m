From: Travis CI <builds@travis-ci.org>
Date: Tue, 23 Jan 2018 10:14:40 +0000
Subject: [LTP] Passed: linux-test-project/ltp#621 (master - 67af7db)
In-Reply-To: <linux-test-project/ltp+332220397+passed@travis-ci.org>
Message-ID: <5a670b10cec77_43fccf4eda9947696c2@54bfdc4e-b786-4b1f-9d60-807f376ed3a8.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #621
Status: Passed

Duration: 17 minutes and 12 seconds
Commit: 67af7db (master)
Author: Li Wang
Message: safe_macros: make is_fuse() return zero if fs_type is NULL

This commmit 28507e514c(safe_mount: Do not try mount() syscall for FUSE fs)
involves FUSE fs check in safe_mount(), but we'd better guarantee the "fs_type"
is legal to check in is_fuse() function otherwise system will kill the program.

  cmdline="fanotify06"
  contacts=""
  analysis=exit
  <<<test_output>>>
  tst_test.c:980: INFO: Timeout per run is 0h 10m 00s
  tst_test.c:1025: BROK: Test killed by SIGSEGV!

Signed-off-by: Li Wang <liwang@redhat.com>
Acked-by: Jan Stancek <jstancek@redhat.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/83d247d08509...67af7dbe8bdf

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/332220397?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180123/44f38062/attachment-0001.html>
